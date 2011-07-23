use lib qw( t/lib lib extlib plugins/AtomPub/lib plugins/AtomPub/t/lib );

use strict;
use warnings;

BEGIN {
    $ENV{MT_APP} = 'AtomPub::Server';
}

use MT;
use Test::More;
plan skip_all => "The Commercial Pack is required to test Custom Fields"
    if !eval { require CustomFields::Field; 1 };

require MT::Test;
MT::Test->import(qw( :app :db :data ));
plan tests => 10;

use AtomPub::Test qw( basic_auth run_app );
use XML::LibXML;


# Set up the test fields.
{
    my $field = MT->model('field')->new;
    $field->set_values({
        blog_id => 1,
        name => 'foo',
        obj_type => 'entry',
        type => 'text',
        tag => 'CustomFoo',
        basename => 'foo',
    });
    $field->save or die $field->errstr;

    ok(MT->model('entry')->has_meta('field.foo'), "Field was properly installed as meta source");
}

{
    my $body = <<'EOF';
<?xml version="1.0" encoding="utf-8"?>
<entry xmlns="http://www.w3.org/2005/Atom">
    <title>Super Nice Nice Custom Field Post</title>
    <content type="html">&lt;p&gt;This is the post that has a custom field on it.&lt;/p&gt;</content>
    <foo xmlns="http://sixapart.com/atom/typepad#">homina homina</foo>
</entry>
EOF
    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1', 'POST',
        { 'Content-Type' => 'application/atom+xml', basic_auth() }, $body);
    is($resp->code, 201, "Post with custom fields created successfully");
    is($resp->header('Location'), 'http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1/entry_id=24',
        "Created post went to expected entry ID");

    my $entry = MT::Entry->load(24);
    my $meta = CustomFields::Util::get_meta($entry);
    is($meta->{foo}, 'homina homina', "Entry's custom field was set");

    my $doc = XML::LibXML->load_xml( string => $resp->decoded_content );
    my $root = $doc->documentElement;
    my $xpath = XML::LibXML::XPathContext->new;
    $xpath->registerNs('app', 'http://www.w3.org/2007/app');
    $xpath->registerNs('atom', 'http://www.w3.org/2005/Atom');
    $xpath->registerNs('cf', 'http://sixapart.com/atom/typepad#');

    my @foos = $xpath->findnodes('./cf:foo', $root);
    is(scalar @foos, 1, "Response repeated our one foo element");
    my ($foo) = @foos;
    is($foo->textContent, 'homina homina', "Response's foo element had expected content");
}

{
    my $body = <<'EOF';
<?xml version="1.0" encoding="utf-8"?>
<entry xmlns="http://www.w3.org/2005/Atom">
    <title>Super Nice Nice Custom Field Post</title>
    <content type="html">&lt;p&gt;This is the post that has a custom field on it.&lt;/p&gt;</content>
    <foo xmlns="http://sixapart.com/atom/typepad#">bar baz woozlebat</foo>
</entry>
EOF
    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1/entry_id=24', 'PUT',
        { 'Content-Type' => 'application/atom+xml', basic_auth() }, $body);
    is($resp->code, 200, "Post with custom field altered successfully");

    my $entry = MT::Entry->load(24);
    my $meta = CustomFields::Util::get_meta($entry);
    is($meta->{foo}, 'bar baz woozlebat', "Entry's custom field was updated");

    my $doc = XML::LibXML->load_xml( string => $resp->decoded_content );
    my $root = $doc->documentElement;
    my $xpath = XML::LibXML::XPathContext->new;
    $xpath->registerNs('app', 'http://www.w3.org/2007/app');
    $xpath->registerNs('atom', 'http://www.w3.org/2005/Atom');
    $xpath->registerNs('cf', 'http://sixapart.com/atom/typepad#');

    my @foos = $xpath->findnodes('./cf:foo', $root);
    is(scalar @foos, 1, "Edited response repeated our one foo element");
    my ($foo) = @foos;
    is($foo->textContent, 'bar baz woozlebat', "Edited response's foo element had expected content");
}


1;
