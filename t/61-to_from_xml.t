#!/usr/bin/perl
# $Id$
use strict;
use warnings;

use Test::More tests => 503;

use MT;
use MT::Author;
use vars qw( $DB_DIR $T_CFG );

use lib 't';

use XML::XPath;
use Data::Dumper;

system("rm t/db/* 2>null");
require 'test-common.pl';
require 'blog-common.pl';

my @emails = ( 'fumiakiy@sixapart.jp', 'fyoshimatsu@sixapart.com' );
my $chuck = MT::Author->load({ name => 'Chuck D' });
my $bob = MT::Author->load({ name => 'Bob D' });
my $mel = MT::Author->load({ name => 'Melody' });
&setup;

my $mt = MT->new( Config => $T_CFG ) or die MT->errstr;
isa_ok($mt, 'MT');

my %objects;
my $error;

my $blog = MT::Blog->load(1);
my $xml = $blog->to_xml;

my $xp = XML::XPath->new(xml => $xml);
my $current_path = "/*[local-name()='blog']";
my $nodeset = $xp->find($current_path);

for my $index (1..$nodeset->size()) {
    my $node = $nodeset->get_node($index);
    next if !($node->isa('XML::XPath::Node::Element'));

    require MT::Blog;
    my $blog2 = MT::Blog->from_xml(
        XPath => $xp,
        XmlNode => $node, 
        Objects => \%objects, 
        Error => \$error, 
        Callback => sub { print(@_); }
    );

    ok($blog2->id != $blog->id);
    ok($blog2->name eq $blog->name);
    ok($blog2->description eq $blog->description);
    ok($blog2->archive_type eq $blog->archive_type);
    ok($blog2->archive_type_preferred eq $blog->archive_type_preferred);
    ok($blog2->site_path eq $blog->site_path);
    ok($blog2->site_url eq $blog->site_url);
    ok($blog2->days_on_index == $blog->days_on_index);
    ok($blog2->entries_on_index == $blog->entries_on_index);
    ok($blog2->file_extension eq $blog->file_extension);
    ok($blog2->email_new_comments == $blog->email_new_comments);
    ok($blog2->allow_comment_html == $blog->allow_comment_html);
    ok($blog2->autolink_urls == $blog->autolink_urls);
    ok($blog2->sort_order_posts eq $blog->sort_order_posts);
    ok($blog2->sort_order_comments eq $blog->sort_order_comments);
    ok($blog2->allow_comments_default == $blog->allow_comments_default);
    ok($blog2->server_offset == $blog->server_offset);
    ok($blog2->convert_paras eq $blog->convert_paras);
    ok($blog2->convert_paras_comments eq $blog->convert_paras_comments);
    ok($blog2->allow_pings_default == $blog->allow_pings_default);
    ok($blog2->status_default == $blog->status_default);
    ok(!defined($blog->allow_anon_comments) || ($blog2->allow_anon_comments == $blog->allow_anon_comments));
    ok($blog2->words_in_excerpt == $blog->words_in_excerpt);
    ok($blog2->moderate_unreg_comments == $blog->moderate_unreg_comments);
    ok($blog2->moderate_pings == $blog->moderate_pings);
    is($blog2->allow_unreg_comments, $blog->allow_unreg_comments);
    ok(!defined($blog->allow_reg_comments) || ($blog2->allow_reg_comments == $blog->allow_reg_comments));
    ok($blog2->allow_pings == $blog->allow_pings);
    ok(!defined($blog->manual_approve_commenters) || ($blog2->manual_approve_commenters == $blog->manual_approve_commenters));
    ok($blog2->require_comment_emails == $blog->require_comment_emails);
    ok($blog2->junk_folder_expiry == $blog->junk_folder_expiry);
    ok($blog2->ping_weblogs == $blog->ping_weblogs);
    ok(!defined($blog->mt_update_key) || ($blog2->mt_update_key eq $blog->mt_update_key));
    ok($blog2->language eq $blog->language);
    ok(!defined($blog->welcome_msg) || ($blog2->welcome_msg eq $blog->welcome_msg));
    ok($blog2->google_api_key eq $blog->google_api_key);
    ok($blog2->email_new_pings == $blog->email_new_pings);
    ok($blog2->ping_blogs == $blog->ping_blogs);
    ok($blog2->ping_technorati == $blog->ping_technorati);
    ok(!defined($blog->ping_others) || ($blog2->ping_others eq $blog->ping_others));
    ok(!defined($blog->autodiscover_links) || ($blog2->autodiscover_links == $blog->autodiscover_links));
    ok($blog2->sanitize_spec eq $blog->sanitize_spec);
    ok($blog2->cc_license eq $blog->cc_license);
    ok(!defined($blog->is_dynamic) || ($blog2->is_dynamic == $blog->is_dynamic));
    ok($blog2->remote_auth_token eq $blog->remote_auth_token);
    is($blog2->children_modified_on, $blog->children_modified_on);
    ok($blog2->custom_dynamic_templates eq $blog->custom_dynamic_templates);
    ok($blog2->junk_score_threshold == $blog->junk_score_threshold);
    ok($blog2->internal_autodiscovery == $blog->internal_autodiscovery);
    ok($blog2->basename_limit == $blog->basename_limit);
    ok($blog2->archive_url eq $blog->archive_url);
    ok($blog2->archive_path eq $blog->archive_path);
    ok(!defined($blog->old_style_archive_links) || ($blog2->old_style_archive_links == $blog->old_style_archive_links));
    ok(!defined($blog->archive_tmpl_daily) || ($blog2->archive_tmpl_daily eq $blog->archive_tmpl_daily));
    ok(!defined($blog->archive_tmpl_weekly) || ($blog2->archive_tmpl_weekly eq $blog->archive_tmpl_weekly));
    ok(!defined($blog->archive_tmpl_monthly) || ($blog2->archive_tmpl_monthly eq $blog->archive_tmpl_monthly));
    ok(!defined($blog->archive_tmpl_category) || ($blog2->archive_tmpl_category eq $blog->archive_tmpl_category));
    ok(!defined($blog->archive_tmpl_individual) || ($blog2->archive_tmpl_individual eq $blog->archive_tmpl_individual));
    ok($blog2->image_default_wrap_text == $blog->image_default_wrap_text);
    ok($blog2->image_default_align eq $blog->image_default_align);
    ok($blog2->image_default_thumb == $blog->image_default_thumb);
    ok($blog2->image_default_width == $blog->image_default_width);
    ok($blog2->image_default_wunits eq $blog->image_default_wunits);
    ok($blog2->image_default_height == $blog->image_default_height);
    ok($blog2->image_default_hunits eq $blog->image_default_hunits);
    ok($blog2->image_default_constrain == $blog->image_default_constrain);
    ok($blog2->image_default_popup == $blog->image_default_popup);
    
    is(scalar(@emails) * 2, MT::Notification->count);
    for my $email2 (@emails) {
        my $notes2 = MT::Notification->load({ blog_id => $blog2->id, email => $email2 });
        ok(defined($notes2));
    }
    
    require MT::Template;
    my @templates2 = MT::Template->load({ blog_id => $blog2->id });
    is(scalar(@templates2), MT::Template->count({ blog_id => $blog->id }));
    for my $template2 (@templates2) {
        my $template = MT::Template->load({ blog_id => $blog->id, name => $template2->name, type => $template2->type });
        ok(defined($template));
        is($template2->outfile, $template->outfile);
        is($template2->text, $template->text) if defined($template2->text);
        is($template2->linked_file, $template->linked_file);
        is($template2->linked_file_mtime, $template->linked_file_mtime);
        is($template2->linked_file_size, $template->linked_file_size);
        is($template2->rebuild_me, $template->rebuild_me);
        is($template2->build_dynamic, $template->build_dynamic);
    }

    require MT::TemplateMap;
    my @templatemaps2 = MT::TemplateMap->load({ blog_id => $blog2->id });
    is(scalar(@templatemaps2), MT::TemplateMap->count({ blog_id => $blog->id }));
    for my $templatemap2 (@templatemaps2) {
        my $template3 = MT::Template->load($templatemap2->id);
        ok(defined($template3));
    }

}

my @authors = MT::Author->load();
for my $author (@authors) {
    my $xml2 = $author->to_xml;

    my $xp2 = XML::XPath->new(xml => $xml2);
    my $current_path2 = "/*[local-name()='author']";
    my $nodeset2 = $xp2->find($current_path2);

    for my $index (1..$nodeset2->size()) {
        my $node = $nodeset2->get_node($index);
        next if !($node->isa('XML::XPath::Node::Element'));

        require MT::Author;
        my $author2 = MT::Author->from_xml(
            XPath => $xp2,
            XmlNode => $node, 
            Objects => \%objects, 
            Error => \$error, 
            Callback => sub { print(@_); }
        );
        ok($author2->id != $author->id);
        ok($author2->name eq $author->name);
        ok(!defined($author2->nickname) || ($author2->nickname eq $author->nickname));
        ok(!defined($author2->email) || ($author2->email eq $author->email));
        ok(!defined($author2->url) || $author2->url eq $author->url);
        ok($author2->type == $author->type);
        ok(!defined($author->can_create_blog) || ($author2->can_create_blog == $author->can_create_blog));
        ok(!defined($author->is_superuser) || ($author2->is_superuser == $author->is_superuser));
        ok(!defined($author2->hint) || ($author2->hint eq $author->hint));
        ok(!defined($author->can_view_log) || ($author2->can_view_log == $author->can_view_log));
        ok(!defined($author->public_key) || $author2->public_key eq $author->public_key);
        ok($author2->preferred_language eq $author->preferred_language);
        ok(!defined($author->remote_auth_username) || $author2->remote_auth_username eq $author->remote_auth_username);
        ok(!defined($author->remote_auth_token) || $author2->remote_auth_token eq $author->remote_auth_token);
        ok(!defined($author->entry_prefs) || Dumper($author2->entry_prefs) eq Dumper($author->entry_prefs));
        ok($author2->status == $author->status);

        # this can be ok because the blog the permission is related has already been restored.
        my $perm2 = $author2->permissions;
        my $perm = $author->permissions;
        is($perm2->author_id, $author2->id);
        is($perm2->role_mask, $perm->role_mask);
        is($perm2->role_mask2, $perm->role_mask2);
        is($perm2->role_mask3, $perm->role_mask3);
        is($perm2->role_mask4, $perm->role_mask4);
        is($perm2->blog_prefs, $perm->blog_prefs);
        is($perm2->entry_prefs, $perm->entry_prefs);
        is($perm2->template_prefs, $perm->template_prefs);
        ok(((0 == $perm2->blog_id) && (0 == $perm->blog_id)) || ($perm2->blog_id != $perm->blog_id));
    }
}

my $role = MT::Role->load({ name => 'Weblog Administrator' });
my $xml3 = $role->to_xml;
my $xp3 = XML::XPath->new(xml => $xml3);
my $current_path3 = "/*[local-name()='role']";
my $nodeset3 = $xp3->find($current_path3);

for my $index3 (1..$nodeset3->size()) {
    my $node = $nodeset3->get_node($index3);
    next if !($node->isa('XML::XPath::Node::Element'));

    require MT::Role;
    my $role2 = MT::Role->from_xml(
        XPath => $xp3,
        XmlNode => $node, 
        Objects => \%objects, 
        Error => \$error, 
        Callback => sub { print(@_); }
    );
    isnt($role2->id, $role->id);
    is($role2->name, $role->name);
    is($role2->description, $role->description);
    is($role2->is_system, $role->is_system);
    is($role2->role_mask, $role->role_mask);
    is($role2->role_mask2, $role->role_mask2);
    is($role2->role_mask3, $role->role_mask3);
    is($role2->role_mask4, $role->role_mask4);

}

my @categories = MT::Category->load({ blog_id => $blog->id, author_id => $chuck->id });
for my $category (@categories) {
    my $xml4 = $category->to_xml;
    my $xp4 = XML::XPath->new(xml => $xml4);
    my $nodeset4 = $xp4->find("/*[local-name()='category']");

    for my $index4 (1..$nodeset4->size()) {
        my $node = $nodeset4->get_node($index4);
        next if !($node->isa('XML::XPath::Node::Element'));

        require MT::Category;
        my $category2 = MT::Category->from_xml(
            XPath => $xp4,
            XmlNode => $node, 
            Objects => \%objects, 
            Error => \$error, 
            Callback => sub { print(@_); }
        );
        isnt($category2->id, $category->id);
        is($category2->label, $category->label);
        is($category2->ping_urls, $category->ping_urls);
        is($category2->description, $category->description);
        is($category2->allow_pings, $category->allow_pings);
        is($category2->basename, $category->basename);
        if (my @children = $category->children_categories) {
            for my $child (@children) {
                my $path = $child->category_label_path;
                my @child2 = MT::Category->load({ label => $child->label });
                my $child2;
                for my $child3 (@child2) {
                    last if (($child3->id != $child->id) && ($child3->category_label_path eq $path));
                    $child2 = $child3;
                }
                ok(defined($child2));
                is($child2->description, $child->description);
                is($child2->ping_urls, $child->ping_urls);
                is($child2->allow_pings, $child->allow_pings);
                is($child2->basename, $child->basename);
            }
        }
    }
}

my @entries = MT::Entry->load({ blog_id => $blog->id, author_id => [ $chuck->id, $bob->id ] });
for my $entry (@entries) {
    my $xml5 = $entry->to_xml;
    my $xp5 = XML::XPath->new(xml => $xml5);
    my $nodeset5 = $xp5->find("/*[local-name()='entry']");

    for my $index5 (1..$nodeset5->size()) {
        my $node = $nodeset5->get_node($index5);
        next if !($node->isa('XML::XPath::Node::Element'));

        require MT::Entry;
        my $entry2 = MT::Entry->from_xml(
            XPath => $xp5,
            XmlNode => $node, 
            Objects => \%objects, 
            Error => \$error, 
            Callback => sub { print(@_); }
        );
        isnt($entry2->id, $entry->id);
        is($entry2->status, $entry->status);
        is($entry2->allow_comments, $entry->allow_comments);
        is($entry2->title, $entry->title);
        is($entry2->excerpt, $entry->excerpt);
        is($entry2->text, $entry->text);
        is($entry2->text_more, $entry->text_more);
        is($entry2->convert_breaks, $entry->convert_breaks);
        is($entry2->to_ping_urls, $entry->to_ping_urls);
        is($entry2->pinged_urls, $entry->pinged_urls);
        is($entry2->allow_pings, $entry->allow_pings);
        is($entry2->keywords, $entry->keywords);
        is($entry2->tangent_cache, $entry->tangent_cache);
        is($entry2->basename, $entry->basename);
        is($entry2->atom_id, $entry->atom_id);
        is($entry2->week_number, $entry->week_number);
        is($entry2->category_id, $entry->category_id);
    }
}


my @tags = MT::Tag->load();
for my $tag (@tags) {
    my $xml6 = $tag->to_xml;
    my $xp6 = XML::XPath->new(xml => $xml6);
    my $nodeset6 = $xp6->find("/*[local-name()='tag']");

    for my $index6 (1..$nodeset6->size()) {
        my $node = $nodeset6->get_node($index6);
        next if !($node->isa('XML::XPath::Node::Element'));

        require MT::Tag;
        my $tag2 = MT::Tag->from_xml(
            XPath => $xp6,
            XmlNode => $node, 
            Objects => \%objects, 
            Error => \$error, 
            Callback => sub { print(@_); }
        );
        isnt($tag2->id, $tag->id);
        is($tag2->name, $tag->name);
        is($tag2->n8d_id, $tag->n8d_id);
        is($tag2->is_private, $tag->is_private);
    }
}

my $entry4 = MT::Entry->load(1);
my @tags3 = $entry4->tags;
my %tags3 = map { $_ => 1; } @tags3;
my @tags_to_test = ('rain', 'grandpa', 'strolling');
while (my $test = shift @tags_to_test) {
    ok(exists $tags3{$test});
}

sub setup {
    use MT::Notification;
    my $note = MT::Notification->new;
    $note->email($emails[0]);
    $note->blog_id(1);
    $note->save;
    $note = undef;
    my $note2 = MT::Notification->new;
    $note2->email($emails[1]);
    $note2->blog_id(1);
    $note2->save;
    $note2 = undef;

    my $cat = MT::Category->load({ label => 'bar', blog_id => 1});
    if ($cat) {
        $cat->allow_pings(1);
        $cat->save;
    }
    
    require MT::TBPing;
    my $ping = MT::TBPing->load(2);
    if (!$ping) {
        $ping = new MT::TBPing;
        $ping->tb_id(2);
        $ping->blog_id(1);
        $ping->ip('127.0.0.1');
        $ping->title('Cat Trackback');
        $ping->excerpt('Foo Bar Baz Quux');
        $ping->source_url('http://example.net/');
        $ping->blog_name("Example Blog 2");
        $ping->created_on('20050405000000');
        $ping->id(2);
        $ping->visible(1);
        $ping->save
    }

    my @default_roles = (
        # { name => 'System Administrator',
        #   perms => ['administer'] },
        # { name => 'System Designer',
        #   perms => ['edit_templates', 'rebuild'] },
        { name => 'Weblog Administrator',
          description => 'Can administer the weblog.',
          perms => ['administer_blog'] },
        { name => 'Designer',
          description => 'Can edit, manage and rebuild weblog templates.',
          perms => ['edit_templates', 'rebuild'] },
        { name => 'Editor',
          description => 'Can edit all entries/categories/tags on a weblog and rebuild.',
          perms => ['edit_all_posts', 'edit_categories', 'rebuild', 'edit_tags'], },
        { name => 'Editor (can upload)',
          description => 'Can upload files, edit all entries/categories/tags on a weblog and rebuild.',
          perms => ['edit_all_posts', 'edit_categories', 'edit_tags', 'rebuild', 'upload'], },
        { name => 'Publisher',
          description => 'Can upload files, edit all entries/categories/tags on a weblog, rebuild and send notifications.',
          perms => ['edit_all_posts', 'edit_categories', 'edit_tags', 'send_notifications', 'rebuild', 'upload'], },
        { name => 'Writer',
          description => 'Can create entries and edit their own.',
          perms => ['post'], },
        { name => 'Writer (can upload)',
          description => 'Can create entries, edit their own and upload files.',
          perms => ['post', 'upload'], },
        # { name => 'System Blog Administrator',
        #   perms => ['administer_blog'] },
    );

    require MT::Role;
    foreach my $r (@default_roles) {
        my $role = MT::Role->new();
        $role->name(MT->translate($r->{name}));
        $role->description(MT->translate($r->{description}));
        $role->clear_full_permissions;
        $role->set_these_permissions($r->{perms});
        if ($r->{name} =~ m/^System/) {
            $role->is_system(1);
        }
        $role->save;
    }

    require MT::Association;
    my $b1 = MT::Blog->load(1);
    my $r = MT::Role->load({ name => 'Weblog Administrator' });
    MT::Association->link($chuck => $r => $b1); # Chuck is a weblog admin

    my $r2 = MT::Role->load({ name => 'Publisher' });
    MT::Association->link($bob => $r2 => $b1); # Bob is a publisher

    my $r3 = MT::Role->load({ name => 'Writer' });
    MT::Association->link($mel => $r3 => $b1); # Melody is a writer
}