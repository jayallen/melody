# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

# An interface for any MT::Object that wishes to utilize versioning

package MT::Revisable;

use strict;

# sub install_properties {
#     my $pkg = shift;
#     my ($class) = @_;
#     
#     my $props = $class->properties;
#     # unless($props->{revision_installed}) {
#         $class->install_revisioning();
#         die if $class->class_type eq 'page';
#         # $props->{revision_installed} = 1;
#     # }
# }

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

1;