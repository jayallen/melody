#!/usr/bin/perl
# $Id:$
use strict;
use warnings;

use lib 't/lib', 'extlib', 'lib', '../lib', '../extlib';
use Test::More qw(no_plan);#tests => 3598;

use MT;
use MT::Tag;
use MT::Author;
use MT::Blog;
use MT::Role;
use MT::Category;
use MT::Entry;
use MT::TBPing;
use MT::Comment;
use MT::Test qw(:db :data);

use vars qw( $DB_DIR $T_CFG );

use MT::BackupRestore;
use Data::Dumper;

system("rm t/db/* 2>null");

my @emails = ( 'fumiakiy@sixapart.jp', 'fyoshimatsu@sixapart.com' );
my $chuck = MT::Author->load({ name => 'Chuck D' });
my $bob = MT::Author->load({ name => 'Bob D' });
my $mel = MT::Author->load({ name => 'Melody' });
&setup;

my $mt = MT->new( Config => $T_CFG ) or die MT->errstr;
isa_ok($mt, 'MT');

my $backup_data = '';
my $printer = sub { $backup_data .= $_[0] };

my %skip = (
    'session' => 1,
    'config'  => 1,
    'schwartz_job' => 1,
    'schwartz_error' => 1,
    'schwartz_funcmap' => 1,
    'schwartz_exitstatus' => 1,
);
my %oldies;
my $types = MT->registry('object_types');
foreach my $key (keys %$types) {
    next if exists $skip{$key};
    next if $key =~ /\w+\.\w+/; # skip subclasses
    my $iter = MT->model($key)->load_iter;
    my @data;
    while ( my $obj = $iter->() ) {
        push @data, $obj unless $obj->can('class') && ($obj->class ne $key);
    }
    $oldies{$key} = \@data;
}

MT::BackupRestore->backup(undef, $printer, sub {}, sub {}, sub { print $_[0], "\n"; }, 0, 'UTF-8');

use IO::String;
my $h = IO::String->new(\$backup_data);
my (%objects, %deferred, @errors);
MT::BackupRestore->restore_process_single_file($h, \%objects, \%deferred, \@errors, "4.0", 0, sub { print $_[0], "\n"; });

is(scalar(keys %deferred), 0, 'no deferred objects remain');
warn join "\n", @errors if @errors;
is(scalar(@errors), 0, 'no error during backup');
&checkthemout(\%oldies, \%objects);

&finish;
require MIME::Base64;

sub checkthemout {
    my ($oldies, $objects) = @_;
    foreach my $name (keys %$oldies) {
        my $old_objects = $oldies->{$name};
        my %meta;
        for my $old (@$old_objects) {
            my $class = MT->model($name);
            isnt($class, undef, "$name must be valid");
            if ($class =~ /MT::Asset(::.+)*/) {
                $class = 'MT::Asset';
            }
            my $key = "$class#" . $old->id;
            my $tmp_obj = $objects->{$key};
            isnt(undef, $tmp_obj, "$key must not hold undef");
            my $obj = $class->load($tmp_obj->id, {cached_ok=>0});
            isnt($obj, undef);
            for my $col (@{$obj->column_names}) {
                next if $col eq 'id';
                if ($col =~ /(\w+)_id$/) {
                    my $parent_name = $1;
                    my $parent_class = MT->model($parent_name);
                    next if !defined($parent_class);
                    if ('ARRAY' ne ref($parent_class)) {
                        $parent_class = [ $parent_class ];
                    }
                    my $old_parent_id = $old->column($col);
                    next if !defined($old_parent_id); # like MT::Entry's category_id...
                    next if $old_parent_id eq '0'; # like MT::Trackback's category_id...
                    my $parent;
                    foreach (@$parent_class) {
                        my $parent_key = $_ . '#' . $old_parent_id;
                        my $new_parent = $objects->{$parent_key};
                        next unless $new_parent;
                        $parent = $_->load($new_parent->id);
                        last if $parent;
                    }
                    unless ($parent) {
                        # try the other way to find package name for the parents
                        my $parents_hash = $class->parents;
                        $parent_class = $parents_hash->{$col} if $parents_hash;
                        if ( ref($parent_class) eq 'HASH' ) {
                            $parent_class = $parent_class->{class};
                        }
                        if ( !$parent_class && ($col eq 'entry_id') && ('MT::Trackback' eq $class) ) {
                            $parent_class = [ MT->model('entry'), MT->model('page') ];
                        }
                        if ( $parent_class && ( 'ARRAY' eq ref($parent_class) ) ) {
                            foreach (@$parent_class) {
                                my $parent_key = $_ . '#' . $old_parent_id;
                                my $new_parent = $objects->{$parent_key};
                                next unless $new_parent;
                                $parent = $_->load($new_parent->id);
                                last if $parent;
                            }
                        }
                    }
                    isnt(undef, $parent, "parent object(" . $old->id . ") of $class pointed to by $col should not be undef");
                } else {
                    next if $col eq 'modified_on';
                    next if (
                        (defined($old->column($col)) && ($old->column($col) eq '')) &&
                        (!defined($obj->column($col)))
                    );
                    next if ($name eq 'category' && ($col eq 'parent'));
                    next if ($name eq 'folder' && ($col eq 'parent'));
                    if ( ($name eq 'trackback') && ($col eq 'is_disabled') ) {
                        if ( defined($obj->is_disabled) && $obj->is_disabled
                          && (!defined($obj->entry->allow_pings) || ($obj->entry->allow_pings == 0)) )
                        {
                            # is_disabled will be changed upon $entry->save
                            # and save may occur $comment's post_save trigger
                            # no harm for the testing purpose, ignore the case.
                            next;
                        }
                    }
                    if ('HASH' eq ref($old->$col)) {
                        is(Dumper($old->$col), Dumper($old->$col), $col);
                    } elsif ('blob' eq $obj->column_defs->{$col}->{type}) {
                        is(
                            MIME::Base64::encode_base64($old->$col, ''),
                            MIME::Base64::encode_base64($obj->$col, ''),
                            "blob - $col");
                    } else {
                        is($old->$col, $obj->$col, "$class<$col>" . $obj->id);
                    }
                }
            }
            unless ( exists($meta{ref($obj)}) ) {
                my @metacolumns = MT::Meta->metadata_by_class( ref($obj) );
                my %metacolumns = map { $_->{name} => $_->{type} } @metacolumns;
                $meta{ref($obj)} = \%metacolumns
            }
            my $metacolumns = $meta{ref($obj)};
            foreach my $metacol (keys %$metacolumns) {
                if ( my $type = $metacolumns->{$metacol} ) {
                    if ( 'vblob' eq $type ) {
                        if ( defined($old->$metacol) && defined($obj->$metacol) ) {
                            is(
                                MIME::Base64::encode_base64($old->$metacol, ''),
                                MIME::Base64::encode_base64($obj->$metacol, ''),
                                "vblob - $metacol");
                        }
                    }
                    else {
                        is($old->$metacol, $obj->$metacol, "$class<meta:$metacol>" . $obj->id);
                    }
                }
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
#        { name => 'Writer',
#          description => 'Can create entries and edit their own.',
#          perms => ['post'], },
#        { name => 'Writer (can upload)',
#          description => 'Can create entries, edit their own and upload files.',
#          perms => ['post', 'upload'], },
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
