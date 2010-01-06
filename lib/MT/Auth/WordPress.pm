# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Auth::WordPress;

use strict;
use base qw( MT::Auth::OpenID );

sub url_for_userid {
    my $class = shift;
    my ($uid) = @_;
    return "http://$uid.wordpress.com/";
}

sub get_nickname {
    my $class = shift;
    my ($vident) = @_;

    my $url = $vident->url;
    if ( $url =~ m(^https?://([^\.]+)\.wordpress\.com\/$) ) {
        return $1;
    }
    return $class->SUPER::get_nickname(@_);
}

1;

__END__

=head1 NAME

MT::Auth::WordPress

=head1 METHODS

=head2 url_for_userid

=head2 get_nickname

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
