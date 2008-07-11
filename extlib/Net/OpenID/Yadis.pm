package Net::OpenID::Yadis;

use strict;
use warnings;
use vars qw($VERSION @EXPORT);
$VERSION = "0.05";

use base qw(Exporter);
use Carp ();
use URI::Fetch 0.02;
use XML::Simple;
use Net::OpenID::Yadis::Service;

@EXPORT = qw(YR_HEAD YR_GET YR_XRDS);

use constant {
    YR_HEAD => 0,
    YR_GET => 1,
    YR_XRDS => 2,
};

use fields (
            'cache',           # the Cache object sent to URI::Fetch
            '_ua',             # Custom LWP::UserAgent instance to use
            'last_errcode',    # last error code we got
            'last_errtext',    # last error code we got
            'debug',           # debug flag or codeblock
            'identity_url',    # URL to be identified
            'xrd_url',         # URL of XRD file
            'xrd_objects',     # Yadis XRD decoded objects
            );

sub new {
    my $self = shift;
    $self = fields::new( $self ) unless ref $self;
    my %opts = @_;

    $self->ua              ( delete $opts{ua}              );
    $self->cache           ( delete $opts{cache}           );

    $self->{debug} = delete $opts{debug};

    Carp::croak("Unknown options: " . join(", ", keys %opts)) if %opts;

    return $self;
}

sub cache   { &_getset; }
sub identity_url { &_getset; }
sub xrd_url { &_getset; }
sub xrd_objects { _pack_array(&_getset); }
sub _ua { &_getset; }
sub _getset {
    my $self = shift;
    my $param = (caller(1))[3];
    $param =~ s/.+:://;

    if (@_) {
        my $val = shift;
        Carp::croak("Too many parameters") if @_;
        $self->{$param} = $val;
    }
    return $self->{$param};
}

sub _debug {
    my $self = shift;
    return unless $self->{debug};

    if (ref $self->{debug} eq "CODE") {
        $self->{debug}->($_[0]);
    } else {
        print STDERR "[DEBUG Net::OpenID::Yadis] $_[0]\n";
    }
}

sub _fail {
    my $self = shift;
    my ($code, $text) = @_;

    $text ||= {
        'xrd_parse_error' => "Error occured since parsing yadis document.",
        'xrd_format_error' => "This is not yadis document (not xrds format).",
        'too_many_hops' => 'Too many hops by X-XRDS-Location.',
        'empty_url' => 'Empty URL',
        'no_yadis_document' => 'Cannot find yadis Document',
        'url_gone' => 'URL is no longer available',
    }->{$code};

    $self->{last_errcode} = $code;
    $self->{last_errtext} = $text;

    $self->_debug("fail($code) $text");
    wantarray ? () : undef;
}
sub err {
    my $self = shift;
    $self->{last_errcode} . ": " . $self->{last_errtext};
}
sub errcode {
    my $self = shift;
    $self->{last_errcode};
}
sub errtext {
    my $self = shift;
    $self->{last_errtext};
}
sub _clear_err {
    my $self = shift;
    $self->{last_errtext} = '';
    $self->{last_errcode} = '';
}

sub ua {
    my $self = shift;
    my $ua = shift if @_;
    Carp::croak("Too many parameters") if @_;

    if (($ua) || (!$self->{_ua})) {
        $self->{_ua} = Net::OpenID::Yadis::UA->new($ua);
    }

    $self->{_ua}->{'ua'};
}

sub _get_contents {
    my $self = shift;

    my  ($url, $final_url_ref, $content_ref, $headers_ref) = @_;
    $final_url_ref ||= do { my $dummy; \$dummy; };

    my $ures = URI::Fetch->fetch($url,
                                 UserAgent        => $self->_ua,
                                 Cache            => $self->_ua->force_head ? undef : $self->cache,
                                 ContentAlterHook =>  sub {my $htmlref = shift;$$htmlref =~ s/<body\b.*//is;},
                                 )
        or return $self->_fail("url_fetch_error", "Error fetching URL: " . URI::Fetch->errstr);

    if ($ures->status == URI::Fetch::URI_GONE()) {
        return $self->_fail("url_gone");
    }

    my $res = $ures->http_response;

    $$final_url_ref = $res->request->uri->as_string;
    $res->headers->scan(sub{$headers_ref->{lc($_[0])} ||= $_[1];});
    $$content_ref = $ures->content;

    return 1;
}

sub discover {
    my $self = shift;
    my $url = shift or return $self->_fail("empty_url");
    my $count = shift || YR_HEAD;                              # $count = YR_HEAD:HEAD request YR_GET:GET request YR_XRDS:XRDS request
    Carp::croak("Too many parameters") if @_;

    # trim whitespace
    $url =~ s/^\s+//;
    $url =~ s/\s+$//;
    return $self->_fail("empty_url") unless $url;

    my $final_url;
    my %headers;

    $self->_ua->force_head(1) if ($count == YR_HEAD);

    my $xrd;
    $self->_get_contents($url, \$final_url, \$xrd, \%headers) or return;

    $self->identity_url($final_url) if ($count < YR_XRDS);

    my $doc_url;
    if (($doc_url = $headers{'x-yadis-location'} || $headers{'x-xrds-location'}) && ($count < YR_XRDS)) {
        return $self->discover($doc_url,YR_XRDS);
    } elsif ($headers{'content-type'} eq 'application/xrds+xml') {
        return $self->discover($final_url,YR_XRDS) if ((!$xrd) && ($count == YR_HEAD));
        $self->xrd_url($final_url);
        return $self->parse_xrd($xrd);
    }

    return $count == YR_HEAD ? $self->discover($final_url,YR_GET) : $self->_fail($count == YR_GET ? "no_yadis_document" :"too_many_hops");
}

sub parse_xrd {
    my $self = shift;
    my $xrd = shift;
    Carp::croak("Too many parameters") if @_;

    my $xs_hash = XMLin($xrd) or return $self->_fail("xrd_parse_error");
    ($xs_hash->{'xmlns'} and $xs_hash->{'xmlns'} eq 'xri://$xrd*($v*2.0)') or $self->_fail("xrd_format_error");
    my %xmlns;
    foreach (map { /^(xmlns:(.+))$/ and [$1,$2] } keys %$xs_hash) {
        next unless ($_);
        $xmlns{$_->[1]} = $xs_hash->{$_->[0]};
    }
    my @priority;
    my @nopriority;
    foreach my $service (_pack_array($xs_hash->{'XRD'}{'Service'})) {
        bless $service, "Net::OpenID::Yadis::Service";
        $service->{'Type'} or next;
        $service->{'URI'} ||= $self->identity_url;

        foreach my $sname (keys %$service) {
            foreach my $ns (keys %xmlns) {
                $service->{"{$xmlns{$ns}}$1"} = delete $service->{$sname} if ($sname =~ /^${ns}:(.+)$/);
            }
        }
        defined($service->{'priority'}) ? push(@priority,$service) : push(@nopriority,$service);
        # Services without priority fields are lowest priority
    }
    my @service = sort {$a->{'priority'} <=> $b->{'priority'}} @priority;
    push (@service,@nopriority);
    foreach (grep {/^_protocol/} keys %$self) { delete $self->{$_} }

    $self->xrd_objects(\@service);
}

sub _pack_array { wantarray ? ref($_[0]) eq 'ARRAY' ? @{$_[0]} : ($_[0]) : $_[0] }

sub services {
    my $self = shift;
    my %protocols;
    my @protocols;
    my $code_ref;
    my $protocol = undef;
    
    Carp::croak("You haven't called the discover method yet") unless $self->xrd_objects;

    foreach my $option (@_) {
        Carp::croak("No further arguments allowed after code reference argument") if $code_ref;
        my $ref = ref($option);
        if ($ref eq 'CODE') {
            $code_ref = $option;
        } else {
            my $default = {versionarray => []};

            $protocols{$option} = $default;
            $protocol = $option;
            push @protocols, $option;
        }
    }

    my @servers;
    @servers = $self->xrd_objects if (keys %protocols == 0);
    foreach my $key (@protocols) {
        my $regex = $protocols{$key}->{urlregex} || $key; 
        my @ver = @{$protocols{$key}->{versionarray}};
        my $ver_regex = @ver ? '('.join('|',map { $_ =~ s/\./\\./g; $_ } @ver).')' : '.+' ;
        $regex =~ s/\\ver/$ver_regex/;

        push (@servers,map { $protocols{$key}->{objectclass} ? bless($_ , $protocols{$key}->{objectclass}) : $_ } grep {join(",",$_->Type) =~ /$regex/} $self->xrd_objects);
    }

    @servers = $code_ref->(@servers) if ($code_ref);

    wantarray ? @servers : \@servers;
}

package Net::OpenID::Yadis::UA;

# This module is decolation module to LWP::UserAgent.
# This add application/xrds+xml HTTP header and GET method to request object used in URI::Fetch.

use strict;
use warnings;
use LWP::UserAgent;
use vars qw($AUTOLOAD $lwpclass);

BEGIN {
    eval "use LWPx::ParanoidAgent;";
    $lwpclass = $@ ? "LWP::UserAgent" : "LWPx::ParanoidAgent";
}

sub new {
    my $class = shift;
    my $ua = shift;
    unless ($ua) {
        $ua = $lwpclass->new;
        $ua->timeout(10);
    }
    bless {ua => $ua,force_head => 0},$class;
}

sub request {
    my $self = shift;
    my $req = shift;
    $req->header('Accept' => 'application/xrds+xml');
    $req->method($self->force_head ? "HEAD" : "GET");
    $self->force_head(0);
    $self->{'ua'}->request($req);
}

sub force_head {
    $_[0]->{'force_head'} = $_[1] if defined($_[1]);
    $_[0]->{'force_head'};
}

sub AUTOLOAD {
    my $self = shift;
    return if $AUTOLOAD =~ /::DESTROY$/;
    $AUTOLOAD =~ s/.*:://;
    $self->{'ua'}->$AUTOLOAD(@_);
}

1;
__END__

=head1 NAME

Net::OpenID::Yadis - Perform Yadis discovery on URLs

=head1 SYNOPSIS

  use Net::OpenID::Yadis;
  
  my $disc = Net::OpenID::Yadis->new(
                                         ua => $ua,       # LWP::UserAgent (or similar) object
                                         cache => $cache  # Cache object
                                     );

  my $xrd = $disc->discover("http://id.example.com/") or Carp::croak($disc->err);

  print $disc->identity_url;       # Yadis URL (Final URL if redirected)
  print $disc->xrd_url;            # Yadis Resourse Descriptor URL

  foreach my $srv (@$xrd) {        # Loop for Each Service in Yadis Resourse Descriptor
    print $srv->priority;          # Service priority (sorted)
    print $srv->Type;              # Identifier of some version of some service (scalar, array or array ref)
    print $srv->URI;               # URI that resolves to a resource providing the service (scalar, array or array ref)
    print $srv->extra_field("Delegate","http://openid.net/xmlns/1.0");
                                   # Extra field of some service
  }

  # If you are interested only in OpenID. (either 1.1 or 2.0)
  my $xrd = $self->services(
    'http://specs.openid.net/auth/2.0/signon',
    'http://specs.openid.net/auth/2.0/server',
    'http://openid.net/signon/1.1',
  );

  # If you want to choose random server by code-ref.
  my $xrd = $self->services(sub{($_[int(rand(@_))])});

=head1 DESCRIPTION

This module provides an implementation of the Yadis protocol, which does
XRDS-based service discovery on URLs.

This module was originally developed by OHTSUKA Ko-hei as L<Net::Yadis::Discovery>,
but was forked and simplified for inclusion in the core OpenID Consumer package.

=head1 CONSTRUCTOR

=over 4

=item C<new>

my $disc = Net::OpenID::Yadis->new([ %opts ]);

You can set the C<ua> and C<cache> in the constructor.  See the corresponding 
method descriptions below.

=back

=head1 EXPORT

This module exports three constant values to use with discover method.

=over 4

=item C<YR_HEAD>

If you set this value to option argument of discover method, module check Yadis 
URL start from HTTP HEAD request.

=item C<YR_GET>

If you set this, module check Yadis URL start from HTTP GET request.

=item C<YR_XRDS>

If you set this, this module consider Yadis URL as Yadis Resource Descriptor 
URL.
If not so, error returns.

=back

=head1 METHODS

=over 4

=item $disc->B<ua>($user_agent)

=item $disc->B<ua>

Getter/setter for the LWP::UserAgent (or subclass) instance which will
be used when web donwloads are needed.  It's highly recommended that
you use LWPx::ParanoidAgent, or at least read its documentation so
you're aware of why you should care.

=item $disc->B<cache>($cache)

=item $disc->B<cache>

Getter/setter for the optional (but recommended!) cache instance you
want to use for storing fetched parts of pages.

The $cache object can be anything that has a -E<gt>get($key) and
-E<gt>set($key,$value) methods.  See L<URI::Fetch> for more
information.  This cache object is just passed to L<URI::Fetch>
directly.

=item $disc->B<discover>($url,[$request_method])

Given a user-entered $url (which could be missing http://, or have
extra whitespace, etc), returns either array/array ref of Net::OpenID::Yadis::Service
objects, or undef on failure.

$request_method is optional, and if set this, you can change the HTTP 
request method of fetching Yadis URL.
See EXPORT to know the value you can set, and default is YR_HEAD.

If this method returns undef, you can rely on the following errors
codes (from $csr->B<errcode>) to decide what to present to the user:

=over 8

=item xrd_parse_error

=item xrd_format_error

=item too_many_hops

=item no_yadis_document

=item url_fetch_err

=item empty_url

=item url_gone

=back

=item $disc->B<xrd_objects>

Returns array/array ref of Net::OpenID::Yadis objects.
It is same what could be got by discover method.

=item $disc->B<identity_url>

Returns Yadis URL.
If not redirected, it is same with the argument of discover method.

=item $disc->B<xrd_url>

Returns Yadis Resource Descriptor URL.

=item $disc->B<servers>($protocol,$protocol,...)

=item $disc->B<servers>($protocol=>[$version1,$version2],...)

=item $disc->B<servers>($protocol,....,$code_ref);

Filter method of xrd_objects.

If no opton is defined, returns same result with xrd_objects method.

protocol names or Type URLs are given, filter only given protocol.
Two or more protocols are given, return and results of filtering.

Sample:
  $disc->servers("openid","http://lid.netmesh.org/sso/1.0");

If reference of version numbers array is given after protocol names,
filter only given version of protocol.

Sample:
  $disc->servers("openid"=>['1.0','1.1'],"lid"=>['1.0']);

If you want to use version numbers limitation with type URL, you can use 
\ver as place holder of version number.

Sample:
  $disc->servers("http://lid.netmesh.org/sso/\ver"=>['1.0','2.0']);

If code reference is given as argument , you can make your own filter rule.
code reference is executed at the last of filtering logic, like this:

  @results = $code_ref->(@temporary_results)

Sample: If you want to filter OpenID server and get only first one:
  ($openid_server) = $disc->servers("openid",sub{$_[0]});

=item $disc->B<err>

Returns the last error, in form "errcode: errtext"

=item $disc->B<errcode>

Returns the last error code.

=item $disc->B<errtext>

Returns the last error text.

=back

=head1 COPYRIGHT

This module is Copyright (c) 2006 OHTSUKA Ko-hei.
All rights reserved.

You may distribute under the terms of either the GNU General Public
License or the Artistic License, as specified in the Perl README file.

=head1 WARRANTY

This is free software. IT COMES WITHOUT WARRANTY OF ANY KIND.

=head1 SEE ALSO

Yadis website:  L<http://yadis.org/>

L<Net::OpenID::Yadis::Service>

=head1 AUTHORS

Based on L<Net::Yadis::Discovery> by OHTSUKA Ko-hei <nene@kokogiko.net>

Martin Atkins <mart@degeneration.co.uk>

=cut
