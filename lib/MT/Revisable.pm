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
    my $datasource = $class->datasource;
    
    MT->add_callback('api_post_save.' . $datasource, 1, undef, \&mt_save_revision);
    MT->add_callback('cms_post_save.' . $datasource, 1, undef, \&mt_save_revision);
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
            changed => 'string(255) not null'
        },
        indexes => {
            $obj_id => 1
        },
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
    
    return $defs->{$col} && exists $defs->{$col}{revisioned};
}

sub changed_columns {
    my ($obj, $orig) = @_;
    my @changed_cols;
    my $revisioned_cols = $obj->revisioned_columns;
    
    foreach my $col (@$revisioned_cols) {
        push @changed_cols, $col
            if $obj->$col ne $orig->$col;
    }    
    
    return \@changed_cols;
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

sub mt_save_revision {
    my ($cb, $mt, $obj, $orig) = @_;
    
    $obj->save_revision($orig);
}

sub save_revision {
    my $obj = shift;
    my ($orig) = @_;
    return 1 unless $orig->id;
    
    my $datasource = $obj->datasource;    
    my $obj_id = $datasource . '_id';
    my $packed_obj = $orig->pack_revision();
    my $changed_cols = $obj->changed_columns($orig);    
    
    require MT::Serialize;
    my $rev_class = MT->model($datasource . ':revision');
    my $revision = $rev_class->new;
    $revision->set_values({
        $obj_id     => $orig->id,
        $datasource => MT::Serialize->serialize(\$packed_obj),
        changed     => join ',', @$changed_cols
    });
    $revision->save or return;
    
    return 1;
}

sub object_from_revision {
    my $obj = shift;
    my ($rev) = @_;
    my $datasource = $obj->datasource;
    
    my $serialized_obj = $rev->$datasource;
    require MT::Serialize;
    my $packed_obj = MT::Serialize->unserialize($serialized_obj);
    $obj->unpack_revision($$packed_obj);
    
    my @changed = split ',', $rev->changed;
    
    return [ $obj, \@changed];
}

sub load_revision {
    my $obj = shift;
    my ($rev_id) = @_;
    my $datasource = $obj->datasource;
    
    my $rev_class = MT->model($datasource . ':revision');
    
    my $terms = {
        $datasource . '_id' => $obj->id,
        $rev_id ? ( id => $rev_id ) : ()
    };
    my $args;
    if(!$rev_id && !wantarray) {
        $args = {
            sort => 'id',
            direction => 'descend',
            limit => 1
        }; 
    }
    
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

    my $orig = $obj->clone; # Reverting is a revision
    my $rev = $obj->load_revision( $rev_id )
        or return $obj->error(
            MT->translate('Revision (ID: [_1]) not found.', $rev_id));
    my $rev_object = $rev->[0];
    $rev_object->save
        or return $obj->error($rev_object->errstr);

    $rev_object->save_revision($orig);
    return $rev_object;
}

1;