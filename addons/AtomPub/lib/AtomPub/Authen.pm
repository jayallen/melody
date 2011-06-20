# Movable Type (r) Open Source (C) 2001-2011 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package AtomPub::Authen;
use strict;

sub authenticate;


1;
__END__

=head1 NAME

AtomPub::Authen

=head1 SYNOPSIS

An abstract interface for authenticating AtomPub servers.

=head1 METHODS

=head2 $class->authenticate($app)

Authenticates the remote user.

Override this method to implement your own AtomPub authenticator. Your
implementation should (probably) look at headers provided to C<$app> to
determine what C<MT::Author> is authenticating to use the service. To
authenticate a user, set the C<$app->{user}> member to that C<MT::Author>
instance and return C<1>.

If no user can be authenticated, use C<$app->error($http_status, $message)> to
report an error and return C<undef>. When appropriate, you should also use
C<$app->set_header($header, $value)> to report a C<WWW-Authenticate> challenge
to the client.

=cut
