# Movable Type (r) Open Source (C) 2001-2011 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package AtomPub::Server;
use strict;

use base qw( MT::App );

use MT::I18N qw( encode_text );
use XML::Atom;
use XML::Atom::Util qw( first textValue );
use MIME::Base64 ();
use Digest::SHA1 ();
use AtomPub::Atom;
use MT::Util qw( encode_xml );
use MT::Author;


sub init {
    my $app = shift;
    $app->{no_read_body} = 1
        if $app->request_method eq 'POST' || $app->request_method eq 'PUT';
    $app->SUPER::init(@_) or return $app->error("Initialization failed");
    $app->request_content
        if $app->request_method eq 'POST' || $app->request_method eq 'PUT';
    $app->add_methods(
        handle => \&handle,
    );
    $app->{default_mode} = 'handle';
    $app->{is_admin} = 0;
    $app->{warning_trace} = 0;
    $app;
}

sub handle {
    my $app = shift;

    my $out = eval {
        (my $pi = $app->path_info) =~ s!^/!!;
        my($subapp, @args) = split /\//, $pi;
        $app->{param} = {};
        for my $arg (@args) {
            my($k, $v) = split /=/, $arg, 2;
            $app->{param}{$k} = $v;
        }

        my $apps = $app->config->AtomApp;

        if (my $class = $apps->{$subapp}) {
            eval "require $class;";
            bless $app, $class;
        }
        my $out = $app->handle_request;
        return unless defined $out;
        return $out;
    };
    if (my $e = $@) {
        $app->error(500, $e);
        $app->show_error("Internal Error");
    }
    return $out;
}

sub handle_request {
    1;
}

sub error {
    my $app = shift;
    my($code, $msg) = @_;
    return unless ref($app);
    if ($code && $msg) {
        chomp($msg = encode_xml($msg)); 
        $app->response_code($code);
        $app->response_message($msg);
        $app->response_content_type('text/xml'); 
        $app->response_content("<error>$msg</error>"); 
    }
    elsif ($code) {
        return $app->SUPER::error($code);
    }
    return undef;
}

sub show_error {
    my $app = shift;
    my($err) = @_;
    chomp($err = encode_xml($err));
    return <<ERR;
<error>$err</error>
ERR
}

sub authenticate {
    my $app = shift;
    my $auth_module = $app->config->AtomAppAuthentication;
    eval "require $auth_module;";

    $auth_module->authenticate($app)
        or return;

    ## update session so the user will be counted as active
    require MT::Session;
    my $user = $app->{user};
    my $sess_active = MT::Session->load( { kind => 'UA', name => $user->id } );
    if (!$sess_active) {
        $sess_active = MT::Session->new;
        $sess_active->id($app->make_magic_token());
        $sess_active->kind('UA'); # UA == User Activation
        $sess_active->name($user->id);
    }
    $sess_active->start(time);
    $sess_active->save;
    return 1;
}

sub xml_body {
    my $app = shift;
    unless (exists $app->{xml_body}) {
        if (LIBXML) {
            my $parser = XML::LibXML->new;
            $app->{xml_body} = $parser->parse_string($app->request_content);
        } else {
            my $xp = XML::XPath->new(xml => $app->request_content);
            $app->{xml_body} = ($xp->find('/')->get_nodelist)[0];
        }
    }
    $app->{xml_body};
}

sub atom_body {
    my $app = shift;
    return AtomPub::Atom::Entry->new(Stream => \$app->request_content)
        or $app->error(500, AtomPub::Atom::Entry->errstr);
}

# $target_zone is expected to be a number of hours from GMT
sub iso2ts {
    my $app = shift;
    my($ts, $target_zone) = @_;
    return unless $ts =~ /^(\d{4})(?:-?(\d{2})(?:-?(\d\d?)(?:T(\d{2}):(\d{2}):(\d{2})(?:\.\d+)?(?:Z|([+-]\d{2}:\d{2}))?)?)?)?/;
    my($y, $mo, $d, $h, $m, $s, $zone) =
        ($1, $2 || 1, $3 || 1, $4 || 0, $5 || 0, $6 || 0, $7);
    if ($zone) {
        my ($zh, $zm) = $zone =~ /([+-]\d\d):(\d\d)/;
        use Time::Local qw( timegm );
        my $ts = timegm( $s, $m, $h, $d, $mo - 1, $y - 1900 );
        if ($zone ne 'Z') {
            require MT::DateTime;
            my $tz_secs = MT::DateTime->tz_offset_as_seconds($zone);
            $ts -= $tz_secs;
        }
        if ($target_zone) {
            my $tz_secs = (3600 * int($target_zone) + 
                           60 * abs($target_zone - int($target_zone)));
            $ts += $tz_secs;
        }
        ($s, $m, $h, $d, $mo, $y) = gmtime( $ts );
        $y += 1900; $mo++;
    }
    sprintf("%04d%02d%02d%02d%02d%02d", $y, $mo, $d, $h, $m, $s);
}

sub iso2epoch {
    my $app = shift;
    my($ts) = @_;
    return unless $ts =~ /^(\d{4})(?:-?(\d{2})(?:-?(\d\d?)(?:T(\d{2}):(\d{2}):(\d{2})(?:\.\d+)?(?:Z|([+-]\d{2}:\d{2}))?)?)?)?/;
    my($y, $mo, $d, $h, $m, $s, $zone) =
        ($1, $2 || 1, $3 || 1, $4 || 0, $5 || 0, $6 || 0, $7);

    use Time::Local;
    my $dt = timegm($s, $m, $h, $d, $mo-1, $y);
    if ($zone && $zone ne 'Z') {
        require MT::DateTime;
        my $tz_secs = MT::DateTime->tz_offset_as_seconds($zone);
        $dt -= $tz_secs;
    }
    $dt;
}


1;
__END__

=head1 NAME

AtomPub::Server

=head1 SYNOPSIS

An Atom Publishing API interface for communicating with Movable Type.

=head1 METHODS

=head2 $app->init()

Initializes the application.

=head2 $app->handle()

Processes the remote user's request before invoking C<handle_request()> to
perform the requested action.

=head2 $app->handle_request()

Performs the requested method on the requested resource.

Override this method in your subclass to perform the remote user's request
(either in the method itself or by dispatching to another method).

=head2 $app->iso2epoch($iso_ts)

Converts C<$iso_ts> in the format of an ISO timestamp into a unix timestamp
(seconds since the epoch).

=head2 $app->iso2ts($iso_ts, $target_zone)

Converts C<$iso_ts> in the format of an ISO timestamp into a MT-compatible
timestamp (YYYYMMDDHHMMSS) for the specified timezone C<$target_zone>.

=head2 $app->atom_body()

Processes the request as Atom content and returns a corresponding C<XML::Atom>
object.

=head2 $app->xml_body()

Takes the content posted to the server and parses it into an XML document.
Uses either XML::LibXML or XML::XPath depending on which is available.

=head2 $app->error($code, $message)

Sends the HTTP headers necessary to relay an error.

=head2 $app->authenticate()

Authenticates the remote user using the credentials provided in the HTTP
request, and verifies that the authenticated author is authorized to the
requested resource. Use the C<AtomAppAuthentication> directive to select the
authenticator to use (default: C<AtomPub::Authen::Basic> for HTTP Basic auth).

Subclass implementations should override this method to authorize the
authenticated user per the subclass's authorization rules.

=head2 $app->show_error($message)

Returns an XML wrapper for the error response.

=head1 CALLBACKS

=over 4

=item api_pre_save.entry

    callback($eh, $app, $entry, $original_entry)

Called before saving a new or existing entry. If saving a new entry, the
$original_entry will have an unassigned 'id'. This callback is executed
as a filter, so your handler must return 1 to allow the entry to be saved.

=item api_post_save.entry

    callback($eh, $app, $entry, $original_entry)

Called after saving a new or existing entry. If saving a new entry, the
$original_entry will have an unassigned 'id'.

=item get_posts

    callback($eh, $app, $feed, $blog)

Called right before get_posts method returns atom feed response.
I<$feed> is a reference to XML::Atom::Feed object.
I<$blog> is a reference to the requested MT::Blog object.

=item get_post

    callback($eh, $app, $atom_entry, $entry)

Called right before get_post method returns atom entry response.
I<$atom_entry> is a reference to XML::Atom::Entry object.
I<$entry> is a reference to the requested MT::Entry object.

=item get_blog_comments

    callback($eh, $app, $feed, $blog)

Called right before get_blog_comments method returns atom feed response.
I<$feed> is a reference to XML::Atom::Feed object.
I<$blog> is a reference to the requested MT::Blog object.

=item get_comments

    callback($eh, $app, $feed, $entry)

Called right before get_comments method returns atom feed response. 
I<$feed> is a reference to XML::Atom::Feed object.
I<$entry> is a reference to the requested MT::Entry object.

=item get_comment

    callback($eh, $app, $atom_entry, $comment)

Called right before get_comment method returns atom entry response.
I<$atom_entry> is a reference to XML::Atom::Entry object.
I<$comment> is a reference to the requested MT::Comment object.

=back

=cut
