# Movable Type (r) Open Source (C) 2001-2009 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::PublishOption;

use strict;

# build type
sub DISABLED ()  { 0 }
sub ONDEMAND ()  { 1 }
sub MANUALLY ()  { 2 }
sub DYNAMIC ()   { 3 }
sub ASYNC ()     { 4 }
sub SCHEDULED () { 5 }

sub get_throttle {
    my $finfo = shift;
    require MT::Template;
    require MT::TemplateMap;
    my $throttle = { type => DISABLED, interval => 0, };
    my $obj;
    if ( $finfo->templatemap_id ) {
        $obj = MT::TemplateMap->load( $finfo->templatemap_id );
    }
    else {
        $obj = MT::Template->load( $finfo->template_id );
    }
    return $throttle unless $obj;
    $throttle->{type}     = $obj->build_type;
    $throttle->{interval} = $obj->build_interval;
    $throttle;
}

sub archive_build_type {
    my ( $blog_id, $at ) = @_;
    require MT::TemplateMap;
    my $map = MT::TemplateMap->load(
        { blog_id => $blog_id, archive_type => $at }
    );
    $map && $map->build_type;
}

1;

__END__

=head1 NAME

MT::PublishOption

=head1 METHODS

=head2 ASYNC

=head2 DISABLED

=head2 DYNAMIC

=head2 MANUALLY

=head2 ONDEMAND

=head2 SCHEDULED

=head2 archive_build_type

=head2 get_throttle

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
