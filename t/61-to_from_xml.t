#!/usr/bin/perl
# $Id:$
use strict;
use warnings;

use Test::More tests => 1575;

use MT;
use MT::Tag;
use MT::Author;
use MT::Blog;
use MT::Role;
use MT::Category;
use MT::Entry;
use MT::TBPing;
use MT::Comment;

use vars qw( $DB_DIR $T_CFG );

use lib 't';

use MT::BackupRestore;
use Data::Dumper;

system("rm t/db/* 2>null");
require 'test-common.pl';
require 'blog-common.pl';

my %ds_table = (
    'tag' => 'MT::Tag',
    'author' => 'MT::Author',
    'blog' => 'MT::Blog',
    'notification' => 'MT::Notification',
    'template' => 'MT::Template',
    'templatemap' => 'MT::TemplateMap',
    'role' => 'MT::Role',
    'association' => 'MT::Association',
    'permission' => 'MT::Permission',
    'category' => 'MT::Category',
    'asset' => 'MT::Asset',
    'entry' => 'MT::Entry',
    'fileinfo' => 'MT::FileInfo',
    'objecttag' => 'MT::ObjectTag',
    'placement' => 'MT::Placement',
    'trackback' => 'MT::Trackback',
    'tbping' => 'MT::TBPing',
    'comment' => 'MT::Comment',
    'plugindata' => 'MT::PluginData',
);

my @emails = ( 'fumiakiy@sixapart.jp', 'fyoshimatsu@sixapart.com' );
my $chuck = MT::Author->load({ name => 'Chuck D' });
my $bob = MT::Author->load({ name => 'Bob D' });
my $mel = MT::Author->load({ name => 'Melody' });
&setup;

my $mt = MT->new( Config => $T_CFG ) or die MT->errstr;
isa_ok($mt, 'MT');

my $backup_data = '';
my $printer = sub { $backup_data .= $_[0] };

my @tags = MT::Tag->load;
isnt(scalar(@tags), 0);
my @authors = MT::Author->load;
isnt(scalar(@authors), 0);
my @blogs = MT::Blog->load;
isnt(scalar(@blogs), 0);
my @roles = MT::Role->load;
isnt(scalar(@roles), 0);
my @categories = MT::Category->load;
isnt(scalar(@categories), 0);
my @entries = MT::Entry->load;
isnt(scalar(@entries), 0);
my @tbpings = MT::TBPing->load;
isnt(scalar(@tbpings), 0);
my @comments = MT::Comment->load;
isnt(scalar(@comments), 0);
my @notifications = MT::Notification->load;
isnt(scalar(@notifications), 0);
my @templates = MT::Template->load;
isnt(scalar(@templates), 0);
my @templatemaps = MT::TemplateMap->load;
isnt(scalar(@templatemaps), 0);
my @associations = MT::Association->load;
isnt(scalar(@associations), 0);
my @permissions = MT::Permission->load;
isnt(scalar(@permissions), 0);
my @assets = MT::Asset->load;

my @fileinfos = MT::FileInfo->load;
isnt(scalar(@fileinfos), 0);
my @objecttags = MT::ObjectTag->load;
isnt(scalar(@objecttags), 0);
my @placements = MT::Placement->load;
isnt(scalar(@placements), 0);
my @trackbacks = MT::Trackback->load;
isnt(scalar(@trackbacks), 0);
my @plugindata = MT::PluginData->load;




MT::BackupRestore->backup(undef, $printer, sub {}, sub {}, 0, 'UTF-8');

use IO::String;
my $h = IO::String->new(\$backup_data);
my (%objects, %deferred, @errors);
MT::BackupRestore->restore_process_single_file($h, \%objects, \%deferred, \@errors, sub { print $_[0]; });

is(scalar(keys %deferred), 0);
print join "\n", @errors;
is(scalar(@errors), 0);

&checkthemout(\@tags, \%objects);
&checkthemout(\@authors, \%objects);
&checkthemout(\@blogs, \%objects);
&checkthemout(\@roles, \%objects);
&checkthemout(\@categories, \%objects);
&checkthemout(\@entries, \%objects);
&checkthemout(\@tbpings, \%objects);
&checkthemout(\@comments, \%objects);
&checkthemout(\@notifications, \%objects);
&checkthemout(\@templates, \%objects);
&checkthemout(\@templatemaps, \%objects);
&checkthemout(\@associations, \%objects);
&checkthemout(\@permissions, \%objects);
&checkthemout(\@assets, \%objects);
&checkthemout(\@fileinfos, \%objects);
&checkthemout(\@objecttags, \%objects);
&checkthemout(\@placements, \%objects);
&checkthemout(\@trackbacks, \%objects);
&checkthemout(\@plugindata, \%objects);


&finish;

sub checkthemout {
    my ($oldies, $objects) = @_;
    for my $old (@$oldies) {
        my $class = ref $old;
        my $key = "$class#" . $old->id;
        my $tmp_obj = $objects->{$key};
        isnt(undef, $tmp_obj);
        my $obj = $class->load($tmp_obj->id, {cached_ok=>0});
        isnt($obj, undef);
        for my $col (@{$obj->column_names}) {
            next if $col eq 'id';
            if ($col =~ /(\w+)_id$/) {
                my $parent_class = $ds_table{$1};
                next if !defined($parent_class);
                my $old_parent_id = $obj->column($col);
                next if !defined($old_parent_id); # like MT::Entry's category_id...
                next if $old_parent_id eq '0'; # like MT::Trackback's category_id...
                my $parent_key = $parent_class . '#' . $old_parent_id;
                my $new_parent = $objects->{$parent_key};
                my $parent = $parent_class->load($new_parent->id);
                isnt(undef, $parent);
            } else {
                next if $col eq 'modified_on';
                next if (
#                    ($col eq 'text') &&
                    (defined($old->column($col)) && ($old->column($col) eq '')) &&
                    (!defined($obj->column($col)))
                );
                is($old->column($col), $obj->column($col), "$class$col" . $obj->id);
            }
        }
    }
}

sub finish {
    use MT::Notification;
    MT::Notification->remove({email => $_}) foreach @emails;
    
    use MT::TBPing;
    MT::TBPing->remove({tb_id=>2, blog_id=>1,id=>2});
    
    use MT::Role;
    MT::Role->remove;
    
    use MT::Association;
    MT::Association->remove;
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