# Melody (C) 2010 Open Melody Software Group.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$
# 
# TODO: Junkable installs properties and has a dependency upon the
#       visible property. But visible is not defined by this class.
# 

package MT::Junkable;

sub JUNK ()     { -1 }
sub NOT_JUNK () { 1 }

sub install_properties {
    my $pkg = shift;
    my ($class) = @_;

    my $props = $class->properties;
    $props->{column_defs}{junk_status} = {
        type  => 'smallint'
    };
    $class->install_column('junk_status');
    $props->{defaults}{junk_status} = NOT_JUNK;

    $props->{column_defs}{junk_score} = {
        type  => 'float'
    };
    $class->install_column('junk_score');

    $props->{column_defs}{junk_log} = {
        type  => 'text'
    };
    $class->install_column('junk_log');

    $props->{column_defs}{visible} = {
        type  => 'boolean'
    };
    $class->install_column('visible');

    $props->{column_defs}{last_moved_on} = {
        type  => 'datetime',
        not_null => 1
    };
    $class->install_column('last_moved_on');
    $props->{defaults}{last_moved_on} = '20000101000000';

    $props->{indexes}{last_moved_on} = 1;
    $props->{indexes}{blog_stat} = {
        columns => [ 'blog_id', 'junk_status', 'created_on' ]
    };
    $props->{indexes}{junk_date} = {
        columns => [ 'junk_status', 'created_on' ]
    };
    
    $class->add_callback( 'pre_save', 0, MT->component('core'), \&mt_presave_obj );
}

sub mt_presave_object {
    my ( $cb, $obj, $original ) = @_;
    $obj->junk_log(join "\n", @{$obj->{__junk_log}})
        if ref $obj->{__junk_log} eq 'ARRAY';
}

sub is_junk {
    $_[0]->junk_status == JUNK;
}

sub is_not_junk {
    $_[0]->junk_status != JUNK;
}

sub can_be_junked_by {
    my $obj = shift;
    my ($user) = @_;
    die MT->translate("Junkable objects must implement the 'can_junk' subroutine. [_1] did not.",
                      ref($obj));
}

sub junk {
    my ($obj) = @_;
    if (($obj->junk_status || 0) != JUNK) {
        require MT::Util;
        my @ts = MT::Util::offset_time_list(time, $obj->blog_id);
        my $ts = sprintf("%04d%02d%02d%02d%02d%02d",
                         $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0]);
        $obj->last_moved_on($ts);
    }
    $obj->junk_status(JUNK);
    $obj->visible(0);
}

sub log {
    # TBD: pre-load __junk_log when loading the object
    my $obj = shift;
    push @{$obj->{__junk_log}}, @_;
}

1;
__END__
=head1 NAME

MT::Junkable - An abstract class for any MT::Object that wishes to be made "junkable."

=head1 SUBCLASS INHERITANCE

Objects that pass through junk filters must be junkable. To be junkable means that
certain fields are associated with the object in order for the system to track
and assign an object's junk status properly. Here is how a developer would declare 
an object as junkable:

    package MT::Foo;
    use base qw( MT::Object MT::Junkable );
    
=head1 PROPERTIES

=over

=item junk_status

A boolean value indicating whether the object is junk or not.

=item junk_score

A floating point number ranging between -1 (junk) and 1 (not junk)
representing how "junky" an object is. 

=item junk_log

A string value holding a record of all the ways in which an object
is scored or rated as junk.

=back

=head1 METHODS

=head2 $class->is_junk

This method returns true if the object is junk, and false otherwise.

=head2 $class->is_not_junk

This method returns true if the object is NOT junk, and false otherwise.

=head2 $class->can_be_junked_by($user)

This is an abstract method. All Objects that inherit from MT::Junkable must 
implement this method. This method returns true if the MT::Author record
passed to it has permission to junk the current object. This is necessary as
permission to junk an object is often not directly associated with the object
itself. For example, permission to junk a comment depends upon the comment's
author.

=head2 $class->junk

This method marks an object as junk.

=head2 $class->log

=cut
