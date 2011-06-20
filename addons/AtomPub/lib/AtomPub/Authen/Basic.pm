# Movable Type (r) Open Source (C) 2001-2011 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package AtomPub::Authen::Basic;
use strict;

use base qw( AtomPub::Authen );

use MIME::Base64 qw( decode_base64 );
use MT::Author;


sub authenticate {
    my $class = shift;
    my ($app) = shift;

    my $header = $app->get_header('Authorization')
        or return $class->auth_failure($app, 401, 'Basic authentication required');
    $header =~ s{ \A Basic \s }{}xms;

    my ($username, $password) = split q{:}, decode_base64($header), 2;

    my $user = MT::Author->load({ name => $username, type => 1 })
        or return $class->auth_failure($app, 403, 'Invalid login');
    return $class->auth_failure($app, 403, 'Invalid login')
        unless $user->is_active;
    my $expected_password = $user->api_password
        or return $class->auth_failure($app, 403, 'Invalid login');
    
    return $class->auth_failure($app, 403, 'Invalid login')
        if $expected_password ne $password;

    $app->{user} = $user;
    return 1;
}

sub auth_failure {
    my $class = shift;
    my $app = shift;
    $app->set_header('WWW-Authenticate', 'Basic realm="AtomPub"');
    return $app->error(@_);
}


1;
__END__

=head1 NAME

AtomPub::Authen::Basic

=head1 SYNOPSIS

An AtomPub server authenticator for HTTP Basic authentication.

=head1 METHODS

=head2 $class->authenticate($app)

Authenticates the remote user according to HTTP Basic authentication. See RFC
2617 "HTTP Authentication: Basic and Digest Access Authentication" for more
information about Basic authentication.

=cut
