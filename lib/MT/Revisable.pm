# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

# An interface for any MT::Object that wishes to utilize versioning

package MT::Revisable;

use strict;

sub install_properties {
    my $pkg = shift;
    my ($class) = @_;
    my $props = $class->properties;
    
    $props->{column_defs}{current_revision} = {
        label => 'Revision Number',
        type  => 'integer',
        not_null => 1        
    };
    $class->install_column('current_revision');
    $props->{defaults}{current_revision} = 0;
    
    MT->add_callback( 'api_pre_save.entry', 1, undef,
               \&mt_remove_unchanged_cols );
    MT->add_callback( 'cms_pre_save.entry', 1, undef,
               \&mt_remove_unchanged_cols );
               
    $class->add_trigger( pre_save => \&increment_revision );           
    $class->add_trigger( post_save => \&save_revision );
}

sub revision_pkg {
    my $class = shift;
    my $props = $class->properties;

    return $props->{revision_pkg} if $props->{revision_pkg};

    my $rev = ref $class || $class;
    $rev .= '::Revision';
    
    return $props->{revision_pkg} = $rev;
}

sub revision_props {
    my $class = shift;
    my $obj_ds = $class->datasource;
    my $obj_id = $obj_ds . '_id';
    return {
        key         => $class->datasource,
        column_defs => {
            id      => 'integer not null auto_increment',
            $obj_id => 'integer not null',
            $obj_ds => 'blob not null',
            rev_number => 'integer not null',
            changed => 'string(255) not null'
        },
        indexes => {
            $obj_id => 1
        },
        defaults => {
            rev_number => 0
        },
        audit => 1,
        primary_key => 'id',
        datasource  => $class->datasource . '_rev'
    };
}

sub install_revisioning {
    my $class = shift;
    my $datasource = $class->datasource;
    
    my $subclass = $class->revision_pkg;
    return unless $subclass;
    
    my $rev_props = $class->revision_props;
    
    no strict 'refs'; ## no critic
    return if defined ${"${subclass}::VERSION"};
    
    ## Try to use this subclass first to see if it exists
    my $subclass_file = $subclass . '.pm';
    $subclass_file =~ s{::}{/}g;
    eval "# line " . __LINE__ . " " . __FILE__ . "\nno warnings 'all';require '$subclass_file';$subclass->import();";
    if ($@) {
        ## Die if we get an unexpected error
        die $@ unless $@ =~ /Can't locate /;
    } else {
        ## This class exists.  We don't need to do anything.
        return 1;
    }

    my $base_class = 'MT::Object';

    my $subclass_src = "
        # line " . __LINE__ . " " . __FILE__ . "
        package $subclass;
        our \$VERSION = 1.0;
        use base qw($base_class);
        
        1;
    ";

    ## no critic ProhibitStringyEval 
    eval $subclass_src or print STDERR "Could not create package $subclass!\n";

    $subclass->install_properties($rev_props);    
}

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

sub mt_remove_unchanged_cols {
    my ($cb, $app, $obj, $orig) = @_;
    remove_unchanged_cols($obj, $orig);
}

sub remove_unchanged_cols {
    my ($obj, $orig) = @_;

    return 1 unless defined $orig;
    return 1 unless $obj->id;

    my %date_cols = map { $_ => 1 }
        @{$obj->columns_of_type('datetime', 'timestamp')};

    if ( my @changed_cols = $obj->changed_cols ) {
        for my $col ( @changed_cols ) {
            unless($obj->is_revisioned_column($col)) {        
                delete $obj->{changed_cols}->{$col};
            }
            if ( $obj->$col eq $orig->$col ) {
                delete $obj->{changed_cols}->{$col};
            }
            elsif ( exists $date_cols{$col} ) {
                delete $obj->{changed_cols}->{$col}
                    if $orig->$col eq MT::Object::_db2ts($obj->$col);
            }
        }
    }
    1;
}

sub pack_revision {
    my $obj = shift;
    my $values;
    my $cols = $obj->revisioned_columns;
    
    foreach my $col (@$cols) {
        $values->{$col} = $obj->$col
    }

    my $meta_values = $obj->meta;
    foreach my $key (%$meta_values) {
        $values->{$key} = $meta_values->{$key};
    }
    
    return $values;
}

sub unpack_revision {
    my $obj = shift;
    my ($packed_obj) = @_;
    
    $obj->set_values($packed_obj);
}

sub increment_revision {
    my $obj = shift;
    my ($orig) = @_;
    
    # We default current_revision to 0 so we can always increment
    # Initial save = rev 1
    my $current_revision = $obj->current_revision;
    $obj->current_revision(++$current_revision);
}

sub save_revision {
    my $obj = shift;
    my ($orig) = @_;
    return 1 unless $orig->id;
    
    my $datasource = $obj->datasource;    
    my $obj_id = $datasource . '_id';
    my $packed_obj = $orig->pack_revision(); 
    
    require MT::Serialize;
    my $rev_class = MT->model($datasource . ':revision');
    my $revision = $rev_class->new;
    $revision->set_values({
        $obj_id     => $orig->id,
        $datasource => MT::Serialize->serialize(\$packed_obj),
        changed     => join ',', $obj->changed_cols
    });
    $revision->rev_number($obj->current_revision);
    $revision->save or return;
    
    return 1;
}

sub object_from_revision {
    my $obj = shift;
    my ($rev) = @_;
    my $datasource = $obj->datasource;

    my $rev_obj = $obj->clone;
    my $serialized_obj = $rev->$datasource;
    require MT::Serialize;
    my $packed_obj = MT::Serialize->unserialize($serialized_obj);
    $rev_obj->unpack_revision($$packed_obj);
    
    # Here we cheat since audit columns aren't revisioned
    $rev_obj->modified_by($rev->created_by);
    $rev_obj->modified_on($rev->modified_on);    
    
    my @changed = split ',', $rev->changed;
    
    return [ $rev_obj, \@changed, $rev->rev_number];
}

sub load_revision {
    my $obj = shift;
    my ($terms, $args) = @_;
    my $datasource = $obj->datasource;    
    my $rev_class = MT->model($datasource . ':revision');

    # Only specified a rev_number
    if(defined $terms && ref $terms ne 'HASH') { 
        $terms = { rev_number => $_[0] };         
    }    
    $terms->{$datasource . '_id'} ||= $obj->id;    
    
    if ( wantarray ) {
        my @rev = map { $obj->object_from_revision($_); }
            $rev_class->load( $terms, $args );
        unless (@rev) {
            return $obj->error( $rev_class->errstr );
        }
        return @rev;
    }
    else {
        my $rev = $rev_class->load( $terms, $args )
            or return $obj->error( $rev_class->errstr );
        my $o = $obj->object_from_revision($rev);
        return $o;
    }    
}

sub apply_revision {
    my $obj = shift;
    my ( $rev_id ) = @_;

    my $rev = $obj->load_revision( $rev_id )
        or return $obj->error(
            MT->translate('Revision (ID: [_1]) not found.', $rev_id));
    my $rev_object = $rev->[0];
    $obj->set_values($rev_object->column_values);
    $obj->save
        or return $obj->error($obj->errstr);
    return $obj;
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
    my $diff_result = eval "HTML::Diff::$diff_method(\$str_a, \$str_b)";
    my @result;
    foreach my $diff (@$diff_result) {        
        unless($diff->[0] eq 'c') { # changed has adds and removes
            push @result, {
                flag => $diff->[0],
                value => ($diff->[0] eq '+') ? $diff->[2] : $diff->[1]
            };
        } else {
            push @result, {
                flag => '-',
                value => $diff->[1]
            };
            push @result, {
                flag => '+',
                value => $diff->[2]
            };
        }
    }
    return \@result;
}

1;