# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id: AtomServer.pm 5144 2010-01-06 05:49:46Z takayama $

package AtomPub::Server::Weblog;
use strict;

use base qw( AtomPub::Server );

use File::Basename;
use File::Spec;
use HTML::LinkExtor;
use MT::Blog;
use MT::Entry;
use MT::I18N qw( encode_text );
use MT::Permission;
use MT::Util qw( encode_xml format_ts );
use XML::Atom;
use XML::Atom::Feed;

use constant NS_APP => 'http://www.w3.org/2007/app';
use constant NS_DC => 'http://purl.org/dc/elements/1.1/';
use constant NS_TYPEPAD => 'http://sixapart.com/atom/typepad#';

sub script { $_[0]->{cfg}->AtomScript . '/1.0' }

sub atom_content_type   { 'application/atom+xml' }
sub atom_x_content_type { 'application/atom+xml' }

sub edit_link_rel { 'edit' }
sub get_posts_order_field { 'modified_on' }

sub new_feed {
    my $app = shift;
    XML::Atom::Feed->new( Version => 1.0 );
}

sub new_with_entry {
    my $app = shift;
    my ($entry) = @_;
    my $atom = AtomPub::Atom::Entry->new_with_entry( $entry, Version => 1.0 );

    my $mo = AtomPub::Atom::Entry::_create_issued($entry->modified_on, $entry->blog);
    $atom->set(NS_APP(), 'edited', $mo);

    my $objectasset_iter = MT::ObjectAsset->load_iter({
        blog_id => $entry->blog_id,
        object_ds => 'entry',
        object_id => $entry->id,
    });
    while (my $objectasset = $objectasset_iter->()) {
        $atom->add_link({
            rel => 'related',
            type => $app->atom_content_type,
            href => join(q{}, $app->base, $app->uri, '/blog_id=', $entry->blog_id, '/asset_id=',
                $objectasset->asset_id),
        });
    }

    if (eval { require CustomFields::Util; 1 }) {
        my $meta = CustomFields::Util::get_meta($entry);
        while (my ($k, $v) = each %$meta) {
            $atom->set(NS_TYPEPAD(), $k, $v);
        }
    }

    return $atom;
}

sub new_with_asset {
    my $app = shift;
    my ($asset) = @_;
    my $atom = AtomPub::Atom::Entry->new_with_asset( $asset, Version => 1.0 );

    my $mo = AtomPub::Atom::Entry::_create_issued($asset->modified_on, $asset->blog);
    $atom->set(NS_APP(), 'edited', $mo);

    return $atom;
}

sub apply_custom_fields {
    my $app = shift;
    my ($obj, $atom) = @_;

    return if !eval {
        require CustomFields::Field;
        require CustomFields::Util;
        1
    };

    my %meta;
    my $field_iter = CustomFields::Field->load_iter({
        blog_id => [$obj->blog_id, 0],
        obj_type => $obj->datasource,
    });
    while (my $field = $field_iter->()) {
        my $value = $atom->get(NS_TYPEPAD(), $field->basename);
        $meta{$field->basename} = $field->type eq 'checkbox' ? $value || q{0}
                                : $field->type eq 'datetime' ? ($value ne '' ? $value : undef)
                                :                              $value
                                ;
    }

    CustomFields::Util::save_meta($obj, \%meta) if %meta;
}

sub apply_basename {
    my $app = shift;
    my ($entry, $atom) = @_;

    if (my $basename = $app->get_header('Slug')) {
        my $entry_class = ref $entry;
        my $basename_uses = $entry_class->exist({
            blog_id  => $entry->blog_id,
            basename => $basename,
            ($entry->id ? ( id => { op => '!=', value => $entry->id } ) : ()),
        });
        if ($basename_uses) {
            $basename = MT::Util::make_unique_basename($entry);
        }

        $entry->basename($basename);
    }

    $entry;
}

sub associate_assets {
    my $app = shift;
    my ($entry, $atom) = @_;

    my @asset_ids;

    LINK: for my $link ($atom->link) {
        next LINK unless $link->rel eq 'related';

        my $asset_id;
        if ($link->href =~ /asset\-(\d+)$/) {
            $asset_id = $1;
        }
        elsif ($link->href =~ m{ asset_id=(\d+) }xms) {
            $asset_id = $1;
        }

        next LINK if !$asset_id;
        require MT::Asset;
        my $a = MT::Asset->load($asset_id)
            or next LINK;
        push @asset_ids, $asset_id;
    }

    my $blog = $entry->blog;
    my $site_url = $blog->site_url;
    my $extor = HTML::LinkExtor->new(undef, $entry->permalink);
    $extor->parse($entry->text);
    TAG: for my $tag ($extor->links) {
        use Data::Dumper;
        my ($tagname, %tagattr) = @$tag;
        my $url = $tagname eq 'img' ? $tagattr{src} : $tagattr{href};
        if ($url !~ s{ \A \Q$site_url\E }{}xms) {
            next TAG;
        }

        my $local = File::Spec->catfile('%r', $url);
        my $asset_pkg = MT::Asset->handler_for_file($local);
        my $asset = $asset_pkg->load({
            blog_id => $blog->id,
            file_path => $local,
        });
        next TAG if !$asset;

        push @asset_ids, $asset->id;
    }

    return @asset_ids;
}

sub handle_request {
    my $app = shift;
    $app->authenticate or return;

    if (my $svc = $app->{param}{svc}) {
        if ($svc eq 'upload') {
            return $app->handle_upload;
        } elsif ($svc eq 'categories') {
            return $app->get_categories;
        }
    }

    my $method = $app->request_method;

    return $app->new_post if $method eq 'POST';
    return $app->edit_post if $method eq 'PUT';
    return $app->delete_post if $method eq 'DELETE';

    return $app->get_post if $app->{param}{entry_id};
    return $app->get_posts if $app->{param}{blog_id};
    return $app->get_weblogs;
}

sub authenticate {
    my $app = shift;

    $app->SUPER::authenticate or return;
    if (my $blog_id = $app->{param}{blog_id}) {
        $app->{blog} = MT::Blog->load($blog_id)
            or return $app->error(400, "Invalid blog ID '$blog_id'");
        $app->{user}
            or return $app->error(403, "Authenticate");
        if ($app->{user}->is_superuser()) {
            $app->{perms} = new MT::Permission;
            $app->{perms}->blog_id($blog_id);
            $app->{perms}->author_id($app->{user}->id);
            $app->{perms}->can_administer_blog(1);
            return 1;
        }
        my $perms = $app->{perms} = MT::Permission->load({
                    author_id => $app->{user}->id,
                    blog_id => $app->{blog}->id });
        return $app->error(403, "Permission denied.") unless $perms && $perms->can_create_post;
    }
    1;
}

sub publish {
    my $app = shift;
    my($entry, $no_ping) = @_;
    my $blog = MT::Blog->load($entry->blog_id)
        or return;
    $app->rebuild_entry( Entry => $entry, Blog => $blog,
                         BuildDependencies => 1 ) or return;
    unless ($no_ping) {
        $app->ping_and_save( Entry => $entry, Blog => $blog )
            or return;
    }
    1;
}

sub get_weblogs {
    my $app = shift;
    my $user = $app->{user};
    my $iter = $user->is_superuser
        ? MT::Blog->load_iter()
        : MT::Permission->load_iter({ author_id => $user->id });
    my $base = $app->base . $app->uri;
    my $enc = $app->config->PublishCharset;

    # TODO: libxml support? XPath should always be available...
    require XML::XPath;
    require XML::XPath::Node::Element;
    require XML::XPath::Node::Namespace;
    require XML::XPath::Node::Text;

    my $doc = XML::XPath::Node::Element->new('service');
    my $app_ns = XML::XPath::Node::Namespace->new('#default' => NS_APP());
    $doc->appendNamespace($app_ns);
    my $atom_ns = XML::XPath::Node::Namespace->new('atom' => 'http://www.w3.org/2005/Atom');
    $doc->appendNamespace($atom_ns);

    while (my $thing = $iter->()) {
        # TODO: provide media collection if author can upload to this blog.
        if ($thing->isa('MT::Permission')) {
            next if !$thing->can_create_post;
        }

        my $blog = $thing->isa('MT::Blog') ? $thing
            : MT::Blog->load($thing->blog_id);
        next unless $blog;
        my $uri = $base . '/blog_id=' . $blog->id;

        my $workspace = XML::XPath::Node::Element->new('workspace');
        $doc->appendChild($workspace);

        my $title = XML::XPath::Node::Element->new('atom:title', 'atom');
        my $blogname = encode_text($blog->name, $enc, 'utf-8');
        $title->appendChild(XML::XPath::Node::Text->new($blogname));
        $workspace->appendChild($title);

        my $entries = XML::XPath::Node::Element->new('collection');
        $entries->appendAttribute(XML::XPath::Node::Attribute->new('href', $uri));
        $workspace->appendChild($entries);

        my $e_title = XML::XPath::Node::Element->new('atom:title', 'atom');
        my $feed_title = encode_text(MT->translate('[_1]: Entries', $blog->name), $enc, 'utf-8');
        $e_title->appendChild(XML::XPath::Node::Text->new($feed_title));
        $entries->appendChild($e_title);

        my $cats = XML::XPath::Node::Element->new('categories');
        $cats->appendAttribute(XML::XPath::Node::Attribute->new('href', $uri . '/svc=categories'));
        $entries->appendChild($cats);

        my $media = XML::XPath::Node::Element->new('collection');
        $media->appendAttribute(XML::XPath::Node::Attribute->new('href', $uri));
        $workspace->appendChild($media);

        my $m_title = XML::XPath::Node::Element->new('atom:title', 'atom');
        $feed_title = encode_text(MT->translate('[_1]: Media', $blog->name), $enc, 'utf-8');
        $m_title->appendChild(XML::XPath::Node::Text->new($feed_title));
        $media->appendChild($m_title);

        for my $media_type (qw( image/png image/jpeg image/gif */* )) {
            my $accept = XML::XPath::Node::Element->new('accept');
            $accept->appendChild(XML::XPath::Node::Text->new($media_type));
            $media->appendChild($accept);
        }
    }
    $app->response_code(200);
    $app->response_content_type('application/atomsvc+xml');
    '<?xml version="1.0" encoding="utf-8"?>' . "\n" .
        $doc->toString;
}

sub get_categories {
    my $app = shift;
    my $blog = $app->{blog};

    # TODO: libxml support? XPath should always be available...
    require XML::XPath;
    require XML::XPath::Node::Element;
    require XML::XPath::Node::Namespace;
    require XML::XPath::Node::Text;

    my $doc = XML::XPath::Node::Element->new('categories');
    my $app_ns = XML::XPath::Node::Namespace->new('#default' => NS_APP());
    $doc->appendNamespace($app_ns);
    my $atom_ns = XML::XPath::Node::Namespace->new('atom' => 'http://www.w3.org/2005/Atom');
    $doc->appendNamespace($atom_ns);
    $doc->appendAttribute(XML::XPath::Node::Attribute->new('fixed', 'yes'));

    my $iter = MT::Category->load_iter({ blog_id => $blog->id });
    while (my $cat = $iter->()) {
        my $cat_node = XML::XPath::Node::Element->new('atom:category', 'atom');
        $cat_node->appendAttribute(XML::XPath::Node::Attribute->new('term', $cat->label));
        $doc->appendChild($cat_node);
    }

    $app->response_code(200);
    $app->response_content_type('application/atomcat+xml');
    '<?xml version="1.0" encoding="utf-8"?>' . "\n" .
        $doc->toString;
}

sub new_post {
    my $app = shift;

    my $content_type = $app->param->content_type();
    if ($content_type !~ m{ \A application/atom\+xml \b }xms) {
        return $app->new_asset(@_);
    }

    my $atom = eval { $app->atom_body }
        or return $app->error(400, "Error decoding Atom entry: $@");
    my $content_type = $atom->content->type || 'text';
    if ($content_type =~ m{ \A (?: text | html | xhtml ) \z }xmsi) {
        return $app->new_entry(@_);
    }

    return $app->new_asset_inline(@_);
}

sub new_entry {
    my $app = shift;

    my $atom = eval { $app->atom_body }
        or return $app->error(400, "Error decoding Atom entry: $@");
    my $blog = $app->{blog};
    my $user = $app->{user};
    my $perms = $app->{perms};

    my $entry = MT::Entry->new;
    my $orig_entry = $entry->clone;
    $entry->set_values({
        blog_id => $blog->id,
        author_id => $user->id,
        created_by => $user->id,
        # TODO: support post publishing instruction?
        status => $perms->can_publish_post ? MT::Entry::RELEASE() : MT::Entry::HOLD(),
        allow_comments => $blog->allow_comments_default,
        allow_pings => $blog->allow_pings_default,
        convert_breaks => $blog->convert_paras,
    });

    $app->update_entry_from_atom($entry, $orig_entry, $atom)
        or return;

    $app->publish($entry);

    $app->response_code(201);
    $app->response_content_type('application/atom+xml');
    my $edit_uri = $app->base . $app->uri . '/blog_id=' . $entry->blog_id . '/entry_id=' . $entry->id;
    $app->set_header('Location', $edit_uri);
    $atom = $app->new_with_entry($entry);
    $atom->add_link({ rel => $app->edit_link_rel,
                      href => $edit_uri,
                      type => 'application/atom+xml',  # even in Legacy
                      title => $entry->title });
    return $atom->as_xml;
}

sub update_entry_from_atom {
    my $app = shift;
    my ($entry, $orig_entry, $atom) = @_;

    my $blog = $app->{blog};
    my $user = $app->{user};
    my $enc = $app->config('PublishCharset');

    ## Check for category in dc:subject. We will save it later if
    ## it's present, but we want to give an error now if necessary.
    my($cat);
    if (my $label = $atom->get(NS_DC, 'subject')) {
        my $label_enc = encode_text($label,'utf-8',$enc);
        $cat = MT::Category->load({ blog_id => $blog->id, label => $label_enc })
            or return $app->error(400, "Invalid category '$label'");
    }

    # TODO: not all fields are required on update, so we shouldn't set these if they're not present.
    $entry->title(encode_text($atom->title, 'utf-8', $enc));
    my $body = encode_text(MT::I18N::utf8_off($atom->content->body),'utf-8',$enc);
    $entry->text($body);
    $entry->excerpt(encode_text($atom->summary, 'utf-8', $enc));
    if (my $iso = $atom->issued) {
        my $pub_ts = MT::Util::iso2ts($blog, $iso);
        $entry->authored_on($pub_ts);
        require MT::DateTime;
        if ( 0 < MT::DateTime->compare( blog => $blog,
                a => $pub_ts,
                b => { value => time(), type => 'epoch' } )
           )
        {
            $entry->status(MT::Entry::FUTURE())
        }
    }

    $entry->modified_by($user->id);
    $app->apply_basename($entry, $atom);
    $entry->discover_tb_from_entry();

    my @asset_ids = $app->associate_assets($entry, $atom);

    MT->run_callbacks('api_pre_save.entry', $app, $entry, $orig_entry)
        or return $app->error(500, MT->translate("PreSave failed [_1]", MT->errstr));

    $entry->save or return $app->error(500, $entry->errstr);

    my @message_params = ($user->name, $user->id, $entry->id, $entry->class_label);
    my $message = $orig_entry->id ? $app->translate("User '[_1]' (user #[_2]) added [lc,_4] #[_3]", @message_params)
                :                   $app->translate("User '[_1]' (user #[_2]) edited [lc,_4] #[_3]", @message_params)
                ;
    require MT::Log;
    $app->log({
        message => $message,
        level => MT::Log::INFO(),
        class => 'entry',
        category => 'new',
        metadata => $entry->id
    });

    if ($cat) {
        my $place = MT::Placement->new;
        $place->is_primary(1);
        $place->entry_id($entry->id);
        $place->blog_id($blog->id);
        $place->category_id($cat->id);
        $place->save or return $app->error(500, $place->errstr);
    }

    $app->apply_custom_fields($entry, $atom);

    # Add any ObjectAssets for assets that don't have them (but don't remove any).
    if (@asset_ids) {
        my %objectassets;
        my @objectassets = MT::ObjectAsset->load({
            blog_id => $entry->blog_id,
            asset_id => \@asset_ids,
            object_id => $entry->id,
            object_ds => 'entry',
        });
        for my $oa (@objectassets) {
            $objectassets{$oa->asset_id} = 1;
        }

        ASSET_ID: for my $asset_id (@asset_ids) {
            next ASSET_ID if $objectassets{$asset_id};

            my $oa = MT::ObjectAsset->new;
            $oa->set_values({
                asset_id => $asset_id,
                blog_id => $entry->blog_id,
                object_id => $entry->id,
                object_ds => 'entry',
            });
            $oa->save();
        }
    }

    MT->run_callbacks('api_post_save.entry', $app, $entry, $orig_entry);

    return 1;
}

sub new_asset {
    my $app = shift;
    my $filename = $app->get_header('Slug') || 'file';
    my $content_type = $app->param->content_type;
    $content_type =~ s{ \s*; .* }{}xms;
    my $asset = $app->upload_asset(
        filename => $filename,
        content_type => $content_type,
        data => $app->request_content,
    ) or return;  # error

    # derp
    $app->response_code(201);
    $app->response_content_type('application/atom+xml');
    my $edit_url = $app->base . $app->uri . '/blog_id=' . $asset->blog_id . '/asset_id=' . $asset->id;
    $app->set_header('Location', $edit_url);
    my $atom = $app->new_with_asset($asset);
    $atom->add_link({ rel => $app->edit_link_rel,
                      href => $edit_url,
                      type => 'application/atom+xml',
                      title => $asset->label });
    return $atom->as_xml();
}

sub new_asset_inline {
    Carp::confess("Can't new_asset_inline yet");
}

sub edit_post {
    my $app = shift;
    my $atom = $app->atom_body or return;
    my $blog = $app->{blog};
    my $enc = $app->config('PublishCharset');
    my $entry_id = $app->{param}{entry_id}
        or return $app->error(400, "No entry_id");
    my $entry = MT::Entry->load($entry_id)
        or return $app->error(400, "Invalid entry_id");
    return $app->error(403, "Access denied")
        unless $app->{perms}->can_edit_entry($entry, $app->{user});

    $app->update_entry_from_atom($entry, $entry->clone, $atom)
        or return;

    if ($entry->status == MT::Entry::RELEASE()) {
        $app->publish($entry) or return $app->error(500, "Entry not published");
    }
    $app->response_code(200);
    $app->response_content_type($app->atom_content_type);
    $atom = $app->new_with_entry($entry);
    return $atom->as_xml;
}

sub get_posts {
    my $app = shift;
    my $blog = $app->{blog};
    my %terms = (blog_id => $blog->id);
    my %arg = (sort => $app->get_posts_order_field, direction => 'descend');
    $arg{limit}  = $app->{param}{limit}  || 21;
    $arg{offset} = $app->{param}{offset} || 0;
    my $iter = MT::Entry->load_iter(\%terms, \%arg);
    my $feed = $app->new_feed();
    my $uri = $app->base . $app->uri . '/blog_id=' . $blog->id;
    my $blogname = encode_text($blog->name, undef, 'utf-8');
    $feed->add_link({ rel => 'alternate', type => 'text/html',
                      href => $blog->site_url });
    $feed->add_link({ rel => 'self', type => $app->atom_x_content_type,
                      href => $uri });
    $feed->title($blogname);
    # FIXME: move the line to the Legacy class
    if ( !$feed->version || ( $feed->version < 1.0 ) ) {
        $feed->add_link({ rel => 'service.post', type => $app->atom_x_content_type,
                          href => $uri, title => $blogname });
    }
    require URI;
    my $site_uri = URI->new($blog->site_url);
    if ( $site_uri ) {
        my $blog_created = format_ts('%Y-%m-%d', $blog->created_on, $blog, 'en', 0);
        my $id = 'tag:'.$site_uri->host.','.$blog_created.':'.$site_uri->path.'/'.$blog->id;
        $feed->id($id);
    }
    my $latest_date = 0;
    $uri .= '/entry_id=';
    my @entries;
    while (my $entry = $iter->()) {
        my $e = $app->new_with_entry($entry);
        $e->add_link({ rel => $app->edit_link_rel, type => $app->atom_x_content_type,
                       href => ($uri . $entry->id), title => encode_text($entry->title, undef,'utf-8') });
        $e->add_link({ rel => 'replies', type => $app->atom_x_content_type,
                href => $app->base . $app->app_path . $app->config->AtomScript . '/comments/blog_id=' . $blog->id . '/entry_id=' . $entry->id });

        # feed/updated should be added before entries
        # so we postpone adding them until later
        push @entries, $e;
        my $date = $entry->modified_on || $entry->authored_on;
        if ( $latest_date < $date ) {
            $latest_date = $date;
            $feed->updated( $e->updated );
        }
    }
    $feed->add_entry($_) foreach @entries;
    ## xxx add next/prev links
    $app->run_callbacks( 'get_posts', $feed, $blog );
    $app->response_content_type($app->atom_content_type);
    $feed->as_xml;
}

sub get_post {
    my $app = shift;
    my $blog = $app->{blog};
    my $entry_id = $app->{param}{entry_id}
        or return $app->error(400, "No entry_id");
    my $entry = MT::Entry->load($entry_id)
        or return $app->error(400, "Invalid entry_id");
    return $app->error(403, "Access denied")
        unless $app->{perms}->can_edit_entry($entry, $app->{user});
    $app->response_content_type($app->atom_content_type);
    my $atom = $app->new_with_entry($entry);
    my $uri = $app->base . $app->uri . '/blog_id=' . $blog->id;
    $uri .= '/entry_id=';
    $atom->add_link({ rel => $app->edit_link_rel, type => $app->atom_x_content_type,
        href => ($uri . $entry->id), title => encode_text($entry->title, undef,'utf-8') });
    $atom->add_link({ rel => 'replies', type => $app->atom_x_content_type,
        href => $app->base
            . $app->app_path
            . $app->config->AtomScript
            . '/comments/blog_id=' . $blog->id
            . '/entry_id=' . $entry->id
    });
    $app->run_callbacks( 'get_post', $atom, $entry );
    $app->response_content_type($app->atom_content_type);
    $atom->as_xml;
}

sub delete_post {
    my $app = shift;
    my $blog = $app->{blog};
    my $entry_id = $app->{param}{entry_id}
        or return $app->error(400, "No entry_id");
    my $entry = MT::Entry->load($entry_id)
        or return $app->error(400, "Invalid entry_id");
    return $app->error(403, "Access denied")
        unless $app->{perms}->can_edit_entry($entry, $app->{user});

    # Delete archive file
    $blog = MT::Blog->load($entry->blog_id);
    my %recip = $app->publisher->rebuild_deleted_entry(
        Entry => $entry,
        Blog  => $blog);

    # Rebuild archives
    $app->rebuild_archives(
        Blog             => $blog,
        Recip            => \%recip,
    ) or die $app->error($app->errstr);

    # Remove object
    $entry->remove
        or return $app->error(500, $entry->errstr);
    '';
}

sub contains_html {
    # Evaluates the first 1k of content in an image file to see if it contains
    # HTML or JavaScript content in the body. Image files that contain embedded
    # HTML or JavaScript should be prohibited in order to prevent a known IE 6
    # and 7 content-sniffing vulnerability.
    my $data_ref = shift;
    my $html_test_string = substr $$data_ref, 0, 1024;
    return 1 if
        ( $html_test_string =~ m/^\s*<[!?]/ ) ||
        ( $html_test_string =~ m/<(HTML|SCRIPT|TITLE|BODY|HEAD|PLAINTEXT|TABLE|IMG|PRE|A)/i ) ||
        ( $html_test_string =~ m/text\/html/i ) ||
        ( $html_test_string =~ m/^\s*<(FRAMESET|IFRAME|LINK|BASE|STYLE|DIV|P|FONT|APPLET)/i ) ||
        ( $html_test_string =~ m/^\s*<(APPLET|META|CENTER|FORM|ISINDEX|H[123456]|B|BR)/i )
        ;
}

sub _upload_to_asset {
    my $app = shift;
    my $atom = $app->atom_body or return;

    return $app->error(403, "Access denied") unless $app->{perms}->can_upload;
    my $content = $atom->content;
    my $type = $content->type
        or return $app->error(400, "content \@type is required");
    my $fname = $atom->title or return $app->error(400, "title is required");
    my $data = $content->body;

    return $app->upload_asset(
        filename => $fname,
        content_type => $type,
        data => $data,
    );
}

sub upload_asset {
    my $app = shift;
    my %param = @_;
    my ($fname, $type, $data) = @param{qw( filename content_type data )};
    my %MIME2EXT = (
        'text/plain'         => '.txt',
        'image/jpeg'         => '.jpg',
        'video/3gpp'         => '.3gp',
        'application/x-mpeg' => '.mpg',
        'video/mp4'          => '.mp4',
        'video/quicktime'    => '.mov',
        'audio/mpeg'         => '.mp3',
        'audio/x-wav'        => '.wav',
        'audio/ogg'          => '.ogg',
        'audio/ogg-vorbis'   => '.ogg',
    );

    my $blog = $app->{blog};
    my $user = $app->{user};
    $fname = basename($fname);
    return $app->error(400, "Invalid or empty filename")
        if $fname =~ m!/|\.\.|\0|\|!;

    # Copy the filename and extract the extension.

    my $ext = $fname;
    $ext =~ m!.*\.(.*)$!;       ## Extract the characters to the right of the last dot delimiter / period
    $ext = $1;                  ## Those characters are the file extension

    ###
    #
    # Look at new Movable Type configuration parameter AssetFileExtensions to
    # see if the file that is being uploaded has a filename extension that is
    # explicitly permitted.
    #
    # This code is very similar to the AssetFileExtensions check in XMLRPCServer.pm.
    #
    ###

    if ( my $allow_exts = $app->config('AssetFileExtensions') ) {

        # Split the parameters of the AssetFileExtensions configuration directive into items in an array
        my @allowed = map { if ( $_ =~ m/^\./ ) { qr/$_/i } else { qr/\.$_/i } } split '\s?,\s?', $allow_exts;

        # Find the extension in the array
        my @found = grep(/\b$ext\b/, @allowed);

        # If there is no extension or the extension wasn't found in the array
        if ((length($ext) == 0) || ( !@found )) {
            return $app->error(500, $app->translate('The file ([_1]) you uploaded is not allowed.', $fname));
        }
    }

    my $local_relative = File::Spec->catfile('%r', $fname);
    my $local = File::Spec->catfile($blog->site_path, $fname);
    my $fmgr = $blog->file_mgr;

    ###
    #
    # Had to extract the declaration of $base and $path from the succeeding line
    # because $ext is now declared in the code section above this comment.
    #
    ###

    my ($base, $path);
    ($base, $path, $ext) = File::Basename::fileparse($local, '\.[^\.]*');
    $ext = $MIME2EXT{$type} unless $ext;
    my $base_copy = $base;
    my $ext_copy = $ext;
    $ext_copy =~ s/\.//;
    my $i = 1;
    while ($fmgr->exists($path . $base . $ext)) {
        $base = $base_copy . '_' . $i++;
    }

    $local = $path . $base . $ext;
    my $local_basename = $base . $ext;

    # TODO: some authors should probably be allowed to upload HTML documents,
    # so shouldn't we only check this if we're uploading an image?
    return $app->error(500, MT->translate("Saving [_1] failed: [_2]", $local_basename, "Invalid image file format.")) if
        contains_html(\$data);

    defined(my $bytes = $fmgr->put_data($data, $local, 'upload'))
        or return $app->error(500, "Error writing uploaded file");

    eval { require Image::Size; };
    return $app->error(500, MT->translate("Perl module Image::Size is required to determine width and height of uploaded images.")) if $@;
    my ( $w, $h, $id ) = Image::Size::imgsize($local);

    require MT::Asset;
    my $asset_pkg = MT::Asset->handler_for_file($local);
    my $is_image = 0;
    if ( defined($w) && defined($h) ) {
        $is_image = 1
            if $asset_pkg->isa('MT::Asset::Image');
    }
    else {
        # rebless to file type
        $asset_pkg = 'MT::Asset';
    }
    my $asset;
    if (!($asset = $asset_pkg->load(
                { file_path => $local, blog_id => $blog->id })))
    {
        $asset = $asset_pkg->new();
        $asset->file_path($local_relative);
        $asset->file_name($base.$ext);
        $asset->file_ext($ext_copy);
        $asset->blog_id($blog->id);
        $asset->created_by( $user->id );
    }
    else {
        $asset->modified_by( $user->id );
    }
    my $original = $asset->clone;
    my $url = '%r/' . $base . $ext;
    $asset->url($url);
    if ($is_image) {
        $asset->image_width($w);
        $asset->image_height($h);
    }
    $asset->mime_type($type);
    $asset->save;

    MT->run_callbacks(
        'api_upload_file.' . $asset->class,
        File => $local, file => $local,
        Url => $url, url => $url,
        Size => $bytes, size => $bytes,
        Asset => $asset, asset => $asset,
        Type => $asset->class, type => $asset->class,
        Blog => $blog, blog => $blog);
    if ($is_image) {
        MT->run_callbacks(
            'api_upload_image',
            File => $local, file => $local,
            Url => $url, url => $url,
            Size => $bytes, size => $bytes,
            Asset => $asset, asset => $asset,
            Height => $h, height => $h,
            Width => $w, width => $w,
            Type => 'image', type => 'image',
            ImageType => $id, image_type => $id,
            Blog => $blog, blog => $blog);
    }

    return $asset;
}

sub handle_upload {
    my $app = shift;
    my $blog = $app->{blog};

    my $asset = $app->_upload_to_asset or return;

    my $link = XML::Atom::Link->new;
    $link->type($asset->mime_type);
    $link->rel('alternate');
    $link->href($asset->url);
    my $atom = XML::Atom::Entry->new;
    $atom->title($asset->file_name);
    $atom->add_link($link);
    $app->response_code(201);
    $app->response_content_type('application/x.atom+xml');
    $atom->as_xml;
}


1;
