# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

# An interface for any MT::Object that wishes to utilize versioning

package MT::Revisable;

use strict;

our $MAX_REVISIONS = 20;

{
my $driver;
sub _driver {
    my $driver_name = 'MT::Revisable::' . MT->config->RevisioningDriver;
    eval 'require ' . $driver_name;
    if (my $err = $@) {
        die (MT->translate("Bad RevisioningDriver config '[_1]': [_2]", $driver_name, $err));
    }
    my $driver = $driver_name->new;
    die $driver_name->errstr
        if (!$driver || (ref(\$driver) eq 'SCALAR'));
    return $driver;
}

sub _handle {
    return 1 unless MT->config->TrackRevisions; 
    
    my $method = ( caller(1) )[3];
    $method =~ s/.*:://;
    my $driver = $driver ||= _driver();
    return undef unless $driver->can($method);
    $driver->$method(@_);
}

sub release {
    undef $driver;
}
}

sub install_properties {
    my $pkg = shift;
    my ($class) = @_;
    my $props = $class->properties;
    my $datasource = $class->datasource;
    
    return 1 unless MT->config->TrackRevisions;
    
    $props->{column_defs}{current_revision} = {
        label => 'Revision Number',
        type  => 'integer',
        not_null => 1        
    };
    $class->install_column('current_revision');
    $props->{defaults}{current_revision} = 0;
    
    # To track how many revisions to store for each object, add
    # a meta column in MT::Blog
    # my $blog_class = MT->model('blog');
    # $blog_class->install_meta({ column_defs => {
    #     "max_${datasource}_revision" => 'integer'
    # }});
    
    # Callbacks: clean list of changed columns to only
    # include versioned columns
    MT->add_callback( 'api_pre_save.' . $datasource, 1, undef, \&mt_presave_obj );
    MT->add_callback( 'cms_pre_save.' . $datasource, 1, undef, \&mt_presave_obj );
               
    # Callbacks: object-level callbacks could not be 
    # prioritized and thus caused problems with plugins
    # registering a post_save and saving     
    MT->add_callback( 'api_post_save.' . $datasource, 9, undef, \&mt_postsave_obj );
    MT->add_callback( 'cms_post_save.' . $datasource, 9, undef, \&mt_postsave_obj );               
}

sub revision_pkg { _handle(@_); }
sub revision_props { _handle(@_); }
sub init_revisioning { _handle(@_); }

sub revisioned_columns {
    my $obj = shift;
    my $defs = $obj->column_defs;
    
    my @cols;
    foreach my $col (keys %$defs) {
        push @cols, $col
            if $defs->{$col} && exists $defs->{$col}{revisioned};
    }
    
    return \@cols;
}

sub is_revisioned_column {
    my $obj = shift;
    my ($col) = @_;
    my $defs = $obj->column_defs;
    
    return 1 if $defs->{$col} && exists $defs->{$col}{revisioned};
}

sub mt_presave_obj {
    my ($cb, $app, $obj, $orig) = @_;
    
    $obj->gather_changed_cols($orig);
    
    # Collision Checking
    my $changed_cols = $obj->{changed_revisioned_cols};
    my $modified_by = $obj->author;
    
    if(scalar @$changed_cols) {
        if($app->isa('MT::App::CMS') 
                && $app->param('current_revision') # not submitted if a user saves again on collision
                    && $app->param('current_revision') != $obj->current_revision) {
            my %param = (
                collision   => 1,
                return_args => $app->param('return_args'),
                modified_by_nickname => $modified_by->nickname
            );
            return $app->forward( "view", \%param );
        }
    }
    
    return 1;
}

sub mt_postsave_obj {
    my ($cb, $app, $obj, $orig) = @_;
    
    my $current_revision = $obj->save_revision();
    
    $obj->current_revision($current_revision);
    $obj->save or return $obj->error($obj->errstr);
    
    return 1;
}

sub gather_changed_cols {
    my $obj = shift;
    my ($orig) = @_;
    
    my @changed_cols;
    my $revisioned_cols = $obj->revisioned_columns;
    
    my %date_cols = map { $_ => 1 }
        @{$obj->columns_of_type('datetime', 'timestamp')};
    
    foreach my $col (@$revisioned_cols) {
        next if $orig && $obj->$col eq $orig->$col;
        next if $orig && exists $date_cols{$col} 
                        && $orig->$col eq MT::Object::_db2ts($obj->$col);
        
        push @changed_cols, $col;
    }    
    
    $obj->{changed_revisioned_cols} = \@changed_cols;
    1;
}

sub pack_revision {
    my $obj = shift;
    my $values = $obj->column_values;

    my $meta_values = $obj->meta;
    foreach my $key (keys %$meta_values) {
        $values->{$key} = $meta_values->{$key};
    }
    
    return $values;
}

sub unpack_revision {
    my $obj = shift;
    my ($packed_obj) = @_;
    
    $obj->set_values($packed_obj);
}

sub save_revision { _handle(@_); }
sub object_from_revision { _handle(@_); }
sub load_revision { _handle(@_); }

sub apply_revision {
    my $obj = shift;
    my ($terms, $args) = @_;

    my $rev = $obj->load_revision($terms, $args)
        or return $obj->error(
            MT->translate('Revision not found: [_1]', $obj->errstr));
    my $rev_object = $rev->[0];
    $obj->set_values($rev_object->column_values);
    $obj->save
        or return $obj->error($obj->errstr);
    return $obj;
}

sub diff_object {
    my $obj_a = shift;
    my ($obj_b, $diff_args) = @_;
    
    return $obj_a->error(MT->translate("There aren't the same types of objects, expecting two [_1]",
                                            lc $obj_a->class_label_plural))
        if ref $obj_a ne ref $obj_b;
        
    my %diff;    
    my $cols = $obj_a->revisioned_columns();
    foreach my $col (@$cols) {
        $diff{$col} = _diff_string($obj_a->$col, $obj_b->$col, $diff_args);
    }    

    return \%diff;    
}

sub diff_revision {
    my $obj = shift;
    my ($terms, $diff_args) = @_;
    # Only specified a rev_number so diff with current
    if(defined $terms && ref $terms ne 'HASH') { 
        $terms = { rev_number => [$_[0], $obj->current_revision] };         
    }
    my $args = {
        limit => 2,
        sort_by => 'created_on',
        direction => 'ascend'
    };
    
    my @revisions = $obj->load_revision($terms, $args);
    my $obj_a = $revisions[0]->[0];
    my $obj_b = $revisions[1]->[0];
    
    return $obj->error(MT->translate("Did not get two [_1]", lc $obj->class_label_plural))
        if ref $obj_a ne ref $obj || ref $obj_b ne ref $obj;
    
    my %diff;    
    my $cols = $obj->revisioned_columns();
    foreach my $col (@$cols) {
        $diff{$col} = _diff_string($obj_a->$col, $obj_b->$col, $diff_args);
    }    
    
    return \%diff;
}

sub _diff_string {
    my ($str_a, $str_b, $diff_args) = @_;
    $diff_args ||= {};
    my $diff_method = $diff_args->{method} || 'html_word_diff';
    my $limit_unchanged = $diff_args->{limit_unchanged};

    require HTML::Diff;
    Carp::croak(MT->translate("Unknown method [_1]", 'HTML::Diff::' . $diff_method))
        unless HTML::Diff->can($diff_method);

    my $diff_result = eval "HTML::Diff::$diff_method(\$str_a, \$str_b)";
    my @result;
    foreach my $diff (@$diff_result) {        
        unless($diff->[0] eq 'c') { # changed has adds and removes
            push @result, {
                flag => $diff->[0],
                text => ($diff->[0] eq '+') ? $diff->[2] : $diff->[1]
            };
        } else {
            push @result, {
                flag => '-',
                text => $diff->[1]
            };
            push @result, {
                flag => '+',
                text => $diff->[2]
            };
        }
    }
    return \@result;
}

1;