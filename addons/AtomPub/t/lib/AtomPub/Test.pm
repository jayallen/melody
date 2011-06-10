package AtomPub::Test;
use strict;
use warnings;

use Digest::SHA1 qw( sha1 );
use HTTP::Response 5;
use LWP::Authen::Wsse;
use MT::Test qw( _run_app );
use MIME::Base64 qw( encode_base64 );
use Test::More;
use XML::LibXML;

our @ISA = qw( Exporter );
our @EXPORT_OK = qw( basic_auth wsse_auth run_app );


sub basic_auth {
    return (
        Authorization => "Basic " . encode_base64(join q{:}, "Chuck D", "seecret"),
    );
}

sub wsse_auth {
    my $username = "Chuck D";
    my $password = "seecret";
    my $nonce_raw = LWP::Authen::Wsse->make_nonce();
    my $created = LWP::Authen::Wsse->now_w3cdtf();

    my $digest = encode_base64(sha1($nonce_raw . $created . $password), q{});
    my $nonce = encode_base64($nonce_raw, q{});

    return (
        Authorization => q{WSSE profile="UsernameToken"},
        'X-WSSE' => qq{UsernameToken Username="$username", PasswordDigest="$digest", Nonce="$nonce", Created="$created"},
    );
}

sub run_app {
    my ($url, $method, $headers, $body) = @_;
    if ($url !~ m{ \A \w+:// ([^/]+) (/.* mt-atom\.cgi ) (.*)? \z }xms) {
        die "Couldn't parse AtomPub url parts out of URL '$url'";
    }
    my ($host, $path, $extra) = ($1, $2, $3);

    local %ENV = %ENV;
    $ENV{HTTP_HOST} = $host;
    $ENV{REQUEST_URI} = $path;
    if ($body) {
        $ENV{CONTENT_LENGTH} = length $body;
        $ENV{CONTENT_TYPE} = $headers->{'Content-Type'}
            or die "No Content-Type header specified";
    }

    $headers ||= {};
    HEADER: while (my ($header, $value) = each %$headers) {
        next HEADER if $header eq 'Content-Type';
        my $env_header = uc $header;
        $env_header =~ tr/-/_/;
        $ENV{"HTTP_$env_header"} = $value;
    }

    #local $SIG{__DIE__} = sub { diag(Carp::longmess(@_)) };
    my $app = _run_app('AtomPub::Server', {
        __test_path_info => $extra,
        __request_method => $method,
        ($body ? ( __request_content => $body ) : ()),
    });
    my $out = delete $app->{__test_output};

    my $resp = HTTP::Response->parse($out);
    return $resp;
}


1;
