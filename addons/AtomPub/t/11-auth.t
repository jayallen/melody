use lib qw( t/lib lib extlib plugins/AtomPub/lib plugins/AtomPub/t/lib );

use strict;
use warnings;

BEGIN {
    $ENV{MT_APP} = 'AtomPub::Server';
}

use MT::Test qw( :app :db :data );
use Test::More tests => 16;

use AtomPub::Test qw( basic_auth wsse_auth run_app );
use XML::LibXML;


{
    local MT->instance->{cfg}->{__var}->{atomappauthentication} = 'AtomPub::Authen::WSSE';

    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0', 'GET');
    is($resp->code, 401, "Weblogs URL with no auth returns Unauthorized");
    my @chals = sort $resp->header('WWW-Authenticate');
    is(scalar @chals, 1, "Unauthorized response included one challenge");
    like($chals[0], qr{ \A WSSE }xms, "Unauthorized response includes a WSSE challenge");
    like($resp->decoded_content, qr{ X-WSSE }xms, "Unauthorized error message mentions X-WSSE header");
}

{
    local MT->instance->{cfg}->{__var}->{atomappauthentication} = 'AtomPub::Authen::WSSE';

    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0', 'GET', {
        Authorization => q{Derp herp="derp"},
    });
    is($resp->code, 401, "Weblogs URL with made-up auth returns Unauthorized");
    my @chals = sort $resp->header('WWW-Authenticate');
    is(scalar @chals, 1, "Unauthorized response included one challenge");
    like($chals[0], qr{ \A WSSE \b }xms, "Unauthorized response includes a WSSE challenge");
    like($resp->decoded_content, qr{ X-WSSE }xms, "Unauthorized error message mentions X-WSSE header");
}

{
    local MT->instance->{cfg}->{__var}->{atomappauthentication} = 'AtomPub::Authen::WSSE';

    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0', 'GET', { wsse_auth() });
    is($resp->code, 200, "WSSE authorized weblogs request succeeded");
    ok(!$resp->header('WWW-Authenticate'), "Successful response has no WWW-Authenticate challenge header");
    like($resp->header('Content-Type'), qr{ \A application/atomsvc\+xml }xms, "Authorized weblogs response is a service document");
}

{
    local MT->instance->{cfg}->{__var}->{atomappauthentication} = 'AtomPub::Authen::Basic';

    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0', 'GET');
    is($resp->code, 401, "Weblogs URL with no auth returns Unauthorized");
    my @chals = sort $resp->header('WWW-Authenticate');
    is(scalar @chals, 1, "Unauthorized response included one challenge");
    like($chals[0], qr{ \A Basic \b }xms, "Unauthorized response includes a Basic challenge");
    like($resp->decoded_content, qr{ Basic }xms, "Unauthorized error message mentions Basic header");
}

{
    local MT->instance->{cfg}->{__var}->{atomappauthentication} = 'AtomPub::Authen::Basic';

    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0', 'GET', { basic_auth() });
    is($resp->code, 200, "Basic auth request succeeded");
}


1;
