# Movable Type (r) Open Source (C) 2001-2011 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package AtomPub::Authen::WSSE;
use strict;

use base qw( AtomPub::Authen );

use MT::I18N qw( encode_text );
use MIME::Base64 ();
use Digest::SHA1 ();
use MT::Author;


sub get_auth_info {
    my $class = shift;
    my ($app) = shift;

    my %param;
    my $req = $app->get_header('X-WSSE')
        or return $class->auth_failure($app, 401, 'X-WSSE authentication required');
    $req =~ s/^WSSE //;
    my ($profile);
    ($profile, $req) = $req =~ /(\S+),?\s+(.*)/;
    return $app->error(400, "Unsupported WSSE authentication profile") 
        if $profile !~ /\bUsernameToken\b/i;
    for my $i (split /,\s*/, $req) {
        my($k, $v) = split /=/, $i, 2;
        $v =~ s/^"//;
        $v =~ s/"$//;
        $param{$k} = $v;
    }
    \%param;
}

sub authenticate {
    my $class = shift;
    my ($app) = shift;

    my $auth = $class->get_auth_info($app)
        or return;
    for my $f (qw( Username PasswordDigest Nonce Created )) {
        return $class->auth_failure($app, 400, "X-WSSE requires $f")
            unless $auth->{$f};
    }
    require MT::Session;
    my $nonce_record = MT::Session->load($auth->{Nonce});

    if ($nonce_record && $nonce_record->id eq $auth->{Nonce}) {
        return $class->auth_failure($app, 403, "Nonce already used");
    }
    $nonce_record = new MT::Session();
    $nonce_record->set_values({
        id => $auth->{Nonce},
        start => time,
        kind => 'AN'
    });
    $nonce_record->save();
# xxx Expire sessions on shorter timeout?
    my $enc = $app->config('PublishCharset');
    my $username = encode_text($auth->{Username},undef,$enc);
    my $user = MT::Author->load({ name => $username, type => 1 })
        or return $class->auth_failure($app, 403, 'Invalid login');
    return $class->auth_failure($app, 403, 'Invalid login')
        unless $user->api_password;
    return $class->auth_failure($app, 403, 'Invalid login')
        unless $user->is_active;
    my $created_on_epoch = $app->iso2epoch($auth->{Created});
    if (abs(time - $created_on_epoch) > $app->config('WSSETimeout')) {
        return $class->auth_failure($app, 403, 'X-WSSE UsernameToken timed out');
    }
    $auth->{Nonce} = MIME::Base64::decode_base64($auth->{Nonce});
    my $expected = Digest::SHA1::sha1_base64(
         $auth->{Nonce} . $auth->{Created} . $user->api_password);
    # Some base64 implementors do it wrong and don't put the =
    # padding on the end. This should protect us against that without
    # creating any holes.
    $expected =~ s/=*$//;
    $auth->{PasswordDigest} =~ s/=*$//;
    #print STDERR "expected $expected and got " . $auth->{PasswordDigest} . "\n";
    return $class->auth_failure($app, 403, 'X-WSSE PasswordDigest is incorrect')
        unless $expected eq $auth->{PasswordDigest};
    $app->{user} = $user;

    return 1;
}

sub auth_failure {
    my $class = shift;
    my $app = shift;
    $app->set_header('WWW-Authenticate', 'WSSE profile="UsernameToken"');
    return $app->error(@_);
}


1;
__END__

=head1 NAME

AtomPub::Authen::WSSE

=head1 SYNOPSIS

An AtomPub server authenticator for WSSE authentication.

=head1 METHODS

=head2 $class->authenticate($app)

Authenticates the remote user according to WSSE authentication.

As use of WSSE authentication for HTTP requests has not been specified, this
module is provided for backward compatibility with Movable Type's Atom
Publishing Protocol implementation of WSSE.

=cut
