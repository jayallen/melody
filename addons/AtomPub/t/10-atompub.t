use lib qw( t/lib lib extlib plugins/AtomPub/lib plugins/AtomPub/t/lib );

use strict;
use warnings;

BEGIN {
    $ENV{MT_APP} = 'AtomPub::Server';
}

use MT::Test qw( :app :db :data );
use Test::More tests => 30;

use AtomPub::Test qw( basic_auth run_app );
use XML::LibXML;


out_like(
    'AtomPub::Server',
    {},
    qr{ Status:\s200 \b .* \b 1 \z }xms,
    "Just a 1 on the root URL",
);

{
    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0', 'GET', { basic_auth() });
    is($resp->code, 200, "Authorized weblogs request succeeded");
    like($resp->header('Content-Type'), qr{ \A application/atomsvc\+xml }xms, "Authorized weblogs response is a service document");

    my $doc = XML::LibXML->load_xml(string => $resp->decoded_content);
    my $root = $doc->documentElement;
    is($root->nodeName, 'service', "Service document starts with a service tag");

    my $xpath = XML::LibXML::XPathContext->new;
    $xpath->registerNs('app', 'http://www.w3.org/2007/app');
    my @collections = $xpath->findnodes('//app:collection', $root);
    is(scalar @collections, 1, "Service document lists two collections");
    my ($coll) = @collections;
    is($coll->getAttribute('href'), q{http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1}, "Collection has blog 1's AtomPub endpoint");
}

{
    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1', 'GET', { basic_auth() });
    is($resp->code, 200, "Posts list request succeeded");
    like($resp->header('Content-Type'), qr{ \A application/atom\+xml }xms, "Posts list is an Atom document");

    my $doc = XML::LibXML->load_xml(string => $resp->decoded_content);
    my $root = $doc->documentElement;
    is($root->nodeName, 'feed', "Posts list is an Atom feed");

    my $xpath = XML::LibXML::XPathContext->new;
    $xpath->registerNs('app', 'http://www.w3.org/2007/app');
    $xpath->registerNs('atom', 'http://www.w3.org/2005/Atom');
    my @entries = $xpath->findnodes('./atom:entry', $root);
    is(scalar @entries, 8, "Posts list has fixture's eight entries");

    my ($entry) = grep { $xpath->findvalue('./atom:id', $_) eq 'tag:narnia.na,1978:/nana//1.1' } @entries;
    is($xpath->findvalue('./atom:title', $entry), 'A Rainy Day', "Posts list has fixture post #1");
}

{
    my $body = <<'EOF';
<?xml version="1.0" encoding="utf-8"?>
<entry xmlns="http://www.w3.org/2005/Atom">
    <title>New AtomPub Post</title>
    <content type="html">&lt;p&gt;my nice post&lt;/p&gt;</content>
</entry>
EOF
    my $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1', 'POST',
        { 'Content-Type' => 'application/atom+xml;type=entry', basic_auth() }, $body);
    is($resp->code, 201, "New post request succeeded (HTTP Created)");
    like($resp->header('Content-Type'), qr{ \A application/atom\+xml }xms, "Response creating entry is some Atom document");
    # The existing fixture data means this post will be #24.
    is($resp->header('Location'), "http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1/entry_id=24",
        "Response creating entry includes API URL of new entry");

    my $doc = XML::LibXML->load_xml(string => $resp->decoded_content);
    my $root = $doc->documentElement;
    is($root->nodeName, 'entry', "Response from new entry is an Atom entry");

    my $xpath = XML::LibXML::XPathContext->new;
    $xpath->registerNs('app', 'http://www.w3.org/2007/app');
    $xpath->registerNs('atom', 'http://www.w3.org/2005/Atom');
    my $id = $xpath->findvalue('./atom:id', $root);
    ok($id, "Response post has an Atom ID");
    my $title = $xpath->findvalue('./atom:title', $root);
    is($title, "New AtomPub Post", "Response post has correct title");
    my $updated = $xpath->findvalue('./atom:updated', $root);
    diag($updated);
    ok($updated, "Response post has an updated timestamp");
    my @contents = $xpath->findnodes('./atom:content', $root);
    is(scalar @contents, 1, "Response post included one content node");
    my ($content) = @contents;
    is($content->getAttribute('type'), 'html', "Response post has HTML content node");
    is($content->textContent, "<p>my nice post</p>", "Response post has correct HTML content");

    $resp = run_app('http://www.example.com/plugins/AtomPub/mt-atom.cgi/1.0/blog_id=1/entry_id=24',
        'GET', { basic_auth() });
    is($resp->code, 200, "Refetching new post succeeded");
    like($resp->header('Content-Type'), qr{ \A application/atom\+xml }xms, "Refetching post returned some Atom document");

    $doc = XML::LibXML->load_xml(string => $resp->decoded_content);
    $root = $doc->documentElement;
    is($root->nodeName, 'entry', "Refetching post returned an Atom entry");

    is($xpath->findvalue('./atom:id', $root), $id, "Refetched post has same Atom ID as creation response");
    is($xpath->findvalue('./atom:updated', $root), $updated, "Refetched post has same updated timestamp as creation response");
    is($xpath->findvalue('./atom:title', $root), $title, "Refetched post has correct title");
    my @new_contents = $xpath->findnodes('./atom:content', $root);
    is(scalar @new_contents, 1, "Refetched post has one content node");
    my ($new_content) = @new_contents;
    is($new_content->getAttribute('type'), 'html', "Refetched post has HTML content");
    is($new_content->textContent, "<p>my nice post</p>", "Refetched post has correct HTML content");
}


1;
