# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id: AtomServer.pm 5144 2010-01-06 05:49:46Z takayama $

package AtomPub::Server::Legacy;
use strict;

use base qw( AtomPub::Server::Weblog );

use MT::I18N qw( encode_text );
use XML::Atom;  # for LIBXML
use XML::Atom::Feed;
use MT::Blog;
use MT::Permission;

use constant NS_CATEGORY => 'http://sixapart.com/atom/category#';
use constant NS_DC => AtomPub::Server::Weblog->NS_DC();
use constant NS_SOAP => 'http://schemas.xmlsoap.org/soap/envelope/';
use constant NS_WSSE => 'http://schemas.xmlsoap.org/ws/2002/07/secext';
use constant NS_WSU => 'http://schemas.xmlsoap.org/ws/2002/07/utility';

sub script { $_[0]->{cfg}->AtomScript . '/weblog' }

sub atom_content_type   { 'application/xml' }
sub atom_x_content_type { 'application/x.atom+xml' }

sub edit_link_rel { 'service.edit' }
sub get_posts_order_field { 'authored_on' }

sub atom_body {
    my $app = shift;
    return $app->SUPER::atom_body(@_) if !$app->{is_soap};

    my $xml = $app->xml_body;
    return AtomPub::Atom::Entry->new(Elem => first($xml, NS_SOAP, 'Body'))
        or $app->error(500, AtomPub::Atom::Entry->errstr);
}

sub get_auth_info {
    my $app = shift;
    return $app->SUPER::get_auth_info(@_) if !$app->{is_soap};

    my %param;
    my $xml = $app->xml_body;
    my $auth = first($xml, NS_WSSE, 'UsernameToken');
    $param{Username} = textValue($auth, NS_WSSE, 'Username');
    $param{PasswordDigest} = textValue($auth, NS_WSSE, 'Password');
    $param{Nonce} = textValue($auth, NS_WSSE, 'Nonce');
    $param{Created} = textValue($auth, NS_WSU, 'Created');
    return \%param;
}

sub handle {
    my $app = shift;

    if (my $action = $app->get_header('SOAPAction')) {
        $app->{is_soap} = 1;
        $action =~ s/"//g; # "
        my($method) = $action =~ m!/([^/]+)$!;
        $app->request_method($method);
    }

    my $out = $app->SUPER::handle(@_)
        or return;

    if ($app->{is_soap}) {
        $out =~ s!^(<\?xml.*?\?>)!!;
        $out = <<SOAP;
$1
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
<soap:Body>$out</soap:Body>
</soap:Envelope>
SOAP
    }

    return $out;
}

sub show_error {
    my $app = shift;
    return $app->SUPER::show_error(@_) if !$app->{is_soap};

    my($err) = @_;
    chomp($err = encode_xml($err));
    my $code = $app->response_code;
    if ($code >= 400) {
        $app->response_code(500);
        $app->response_message($err);
    }
    return <<FAULT;
<soap:Envelope xmlns:soap="http://schemas.xmlsoap.org/soap/envelope/">
  <soap:Body>
    <soap:Fault>
      <faultcode>$code</faultcode>
      <faultstring>$err</faultstring>
    </soap:Fault>
  </soap:Body>
</soap:Envelope>
FAULT
}

sub new_feed {
    my $app = shift;
    XML::Atom::Feed->new();
}

sub new_with_entry {
    my $app = shift;
    my ($entry) = @_;
    AtomPub::Atom::Entry->new_with_entry($entry);
}

sub apply_basename {}

sub get_weblogs {
    my $app = shift;
    my $user = $app->{user};
    my $iter = $user->is_superuser
        ? MT::Blog->load_iter()
        : MT::Permission->load_iter({ author_id => $user->id });
    my $feed = $app->new_feed();
    my $base = $app->base . $app->uri;
    require URI;
    my $uri = URI->new($base);
    if ( $uri ) {
        my $created = MT::Util::format_ts('%Y-%m-%d', $user->created_on, undef, 'en', 0);
        my $id = 'tag:'.$uri->host.','.$created.':'.$uri->path.'/weblogs-'.$user->id;
        $feed->id($id);
    }
    while (my $thing = $iter->()) {
        if ($thing->isa('MT::Permission')) {
            next unless $thing->can_create_post;
        }
        my $blog = $thing->isa('MT::Blog') ? $thing
            : MT::Blog->load($thing->blog_id);
        next unless $blog;
        my $uri = $base . '/blog_id=' . $blog->id;
        my $blogname = encode_text($blog->name . ' #' . $blog->id, undef, 'utf-8');
        $feed->add_link({ rel => 'service.post', title => $blogname,
                          href => $uri, type => 'application/x.atom+xml' });
        $feed->add_link({ rel => 'service.feed', title => $blogname,
                          href => $uri, type => 'application/x.atom+xml' });
        $feed->add_link({ rel => 'service.upload', title => $blogname,
                          href => $uri . '/svc=upload',
                          type => 'application/x.atom+xml' });
        $feed->add_link({ rel => 'service.categories', title => $blogname,
                          href => $uri . '/svc=categories',
                          type => 'application/x.atom+xml' });
        $feed->add_link({ rel => 'alternate', title => $blogname,
                          href => $blog->site_url,
                          type => 'text/html' });
    }
    $app->response_code(200);
    $app->response_content_type('application/x.atom+xml');
    $feed->as_xml;
}

sub new_asset_inline {
    my $app = shift;

    # Text content types used to mean plain posts, so still make entries out of them.
    if ($app->atom_body->content->type =~ m{ \A text/ }xms) {
        # TODO: but make sure text/plain LifeBlog Notes and SMSes are handled as assets
        #my $format = $atom->get(NS_DC, 'format');
        #if ($format && ($format eq 'Note' || $format eq 'SMS')) {
        return $app->new_entry(@_);
    }

    # TODO: if the atom:entry did not have a typepad:standalone element, make a new MT::Entry about it too.
    #if ( $atom->get(NS_TYPEPAD, 'standalone') && $asset ) {
    #    my $a = AtomPub::Atom::Entry->new_with_asset($asset);
    return $app->SUPER::new_asset_inline(@_);
}

sub get_categories {
    my $app = shift;
    my $blog = $app->{blog};
    my $iter = MT::Category->load_iter({ blog_id => $blog->id });
    my $doc;
    if (LIBXML) {
        $doc = XML::LibXML::Document->createDocument('1.0', 'utf-8');
        my $root = $doc->createElementNS(NS_CATEGORY, 'categories');
        $doc->setDocumentElement($root);
    } else {
        $doc = XML::XPath::Node::Element->new('categories');
        my $ns = XML::XPath::Node::Namespace->new('#default' => NS_CATEGORY);
        $doc->appendNamespace($ns);
    }
    while (my $cat = $iter->()) {
        my $catlabel = encode_text($cat->label, undef, 'utf-8');
        if (LIBXML) {
            my $elem = $doc->createElementNS(NS_DC, 'subject');
            $doc->getDocumentElement->appendChild($elem);
            $elem->appendChild(XML::LibXML::Text->new($catlabel));
        } else {
            my $elem = XML::XPath::Node::Element->new('subject');
            my $ns = XML::XPath::Node::Namespace->new('#default' => NS_DC);
            $elem->appendNamespace($ns);
            $doc->appendChild($elem);
            $elem->appendChild(XML::XPath::Node::Text->new($catlabel));
        }
    }
    $app->response_code(200);
    $app->response_content_type('application/x.atom+xml');
    if (LIBXML) {
        $doc->toString(1);
    } else {
        return '<?xml version="1.0" encoding="utf-8"?>' . "\n" . $doc->toString;
    }
}


1;
