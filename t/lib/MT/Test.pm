package MT::Test;

use strict;
# Handle cwd = MT_DIR, MT_DIR/t
use lib 't/lib', 'extlib', 'lib', '../lib', '../extlib';
use File::Spec;
use MT;

BEGIN {
    # if MT_HOME is not set, set it
    unless ($ENV{MT_HOME}) {
        require Cwd;
        my $cwd = Cwd::getcwd();
        my @pieces = File::Spec->splitdir($cwd);
        pop @pieces unless -d 't';
        $ENV{MT_HOME} = File::Spec->catdir(@pieces);
    }
    # if MT_CONFIG is not set, set it
    if ($ENV{MT_CONFIG}) {
        if (!File::Spec->file_name_is_absolute($ENV{MT_CONFIG})) {
            $ENV{MT_CONFIG} = File::Spec->catfile($ENV{MT_HOME}, "t", $ENV{MT_CONFIG});
        }
    } else {
        $ENV{MT_CONFIG} = File::Spec->catfile($ENV{MT_HOME}, "t", "mt.cfg");
    }
    chdir $ENV{MT_HOME};
    my $ds_dir = File::Spec->catdir($ENV{MT_HOME}, "t", "db");
    if (!-d $ds_dir) {
        mkdir $ds_dir;
    }
}

sub import {
    my $pkg = shift;
    foreach my $opt (@_) {
        $pkg->init_db() if $opt eq ':db';
        $pkg->init_test_db() if $opt eq ':testdb';
        $pkg->sample_data() if $opt eq ':data';
    }
}

sub init_test_db {
    my $pkg = shift;
    # This is a bit of MT::Upgrade magic to prevent the full
    # instantiation of the MT schema. We force the classes list
    # to only contain the test 'Foo', 'Bar' classes and neuter
    # the 
    require MT::Upgrade;
    # Add our test 'Foo' and 'Bar' classes to the list of
    # object classes to install.
    %MT::Upgrade::classes = (foo=>'Foo',bar=>'Bar');
    #MT::Upgrade->register_class(['Foo', 'Bar']);
    MT->instance;
    MT->registry->{object_types}->{foo} = 'Foo';
    MT->registry->{object_types}->{bar} = 'Bar';

    # Replace the standard seed_database/install_template functions
    # with stubs since we're not creating a full schema.
    MT::Upgrade->register_upgrade_function({
        core_seed_database     => { code => sub { 1 } },
        core_upgrade_templates => { code => sub { 1 } },
        core_upgrade_templates => { code => sub { 1 } },
        core_finish            => { code => sub { 1 } },
    });
    $pkg->init_db();
}

sub init_db {
    my $pkg = shift;
    my ($cfg) = @_;

    my $mt = MT->instance($cfg ? (Config => $cfg) : ())
        or die "No MT object " . MT->errstr;

    my $types = MT->registry('object_types');
    my @classes = map { $types->{$_} } grep { $_ !~ /\./ } keys %$types;
    foreach my $class (@classes) {
        if (ref($class) eq 'ARRAY') {
            next; #TODO for now - it won't hurt when we do driver-tests.
        }
        else {
            eval 'require '.$class or die $@;
        }
    }

    # Clear existing database tables
    my $driver = MT::Object->driver();
    foreach my $class (@classes) {
        if (ref($class) eq 'ARRAY') {
            next; #TODO for now - it won't hurt when we do driver-tests.
        }
        else {
            if ($driver->dbd->ddl_class->table_exists($class)) {
                $driver->sql(
                    $driver->dbd->ddl_class->drop_table_sql($class),
                );
                $driver->dbd->ddl_class->drop_sequence($class),
            }
        }
    }

    require MT::Upgrade;
    # Initialize the MT database
    MT::Upgrade->do_upgrade(
        Install => 1, 
        App     => __PACKAGE__, 
        User    => {},
        Blog    => {}
    );
    eval {
        MT::Entry->remove;
        MT::Comment->remove;
    };
}

sub progress {}
sub error {
    my ($x, $msg) = @_;
    print "ERROR: $msg\n";
}

sub sample_data {
    my $pkg = shift;
    my $blog = MT::Blog->new();
    $blog->set_values({
        name => 'none',
        site_url => 'http://narnia.na/nana/',
        archive_url => 'http://narnia.na/nana/archives/',
        site_path => 't/site/',
        archive_path => 't/site/archives/',
        archive_type=>'Individual,Monthly,Weekly,Daily,Category,Page',
        archive_type_preferred => 'Individual',
        description => "Narnia None Test Blog",
        custom_dynamic_templates => 'custom',
        convert_paras => 1,
        allow_reg_comments => 1,
        allow_unreg_comments => 0,
        allow_pings => 1,
        sort_order_posts => 'descend',
        sort_order_comments => 'ascend',
        remote_auth_token => 'token',
        convert_paras_comments => 1,
        google_api_key => 'r9Vj5K8PsjEu+OMsNZ/EEKjWmbCeQAv1',
        cc_license => 'by-nc-sa http://creativecommons.org/licenses/by-nc-sa/2.0/ http://creativecommons.org/images/public/somerights20.gif',
        server_offset => '-3.5',
        children_modified_on => '20000101000000',
        language => 'en_us',
        file_extension => 'html',
    });
    $blog->id(1);
    $blog->commenter_authenticators('enabled_TypeKey');
    $blog->save() or die "Couldn't save blog 1: ". $blog->errstr;

    require MT::Entry;
    require MT::Author;
    my $chuckd = MT::Author->new();
    $chuckd->set_values({
        name => 'Chuck D',
        nickname => 'Chucky Dee', 
        email => 'chuckd@example.com',
        url => 'http://chuckd.com/',
        api_password => 'seecret',
        auth_type => 'MT',
    });
    $chuckd->set_password("bass");
    $chuckd->type(MT::Author::AUTHOR());
    $chuckd->id(2);
    $chuckd->is_superuser(1);
    $chuckd->save()
        or die "Couldn't save author record 2: " . $chuckd->errstr;

    my $bobd = MT::Author->new();
    $bobd->set_values({
        name => 'Bob D',
        nickname => 'Dylan', 
        email => 'bobd@example.com',
        auth_type => 'MT',
    });
    $bobd->set_password("flute");
    $bobd->type(MT::Author::AUTHOR());
    $bobd->id(3);
    $bobd->save() or die "Couldn't save author record 3: " . $bobd->errstr;

    my $johnd = MT::Author->new();
    $johnd->set_values({
        name => 'John Doe',
        nickname => 'John Doe',
        email => 'jdoe@doe.com',
        auth_type => 'TypeKey',
    });
    $johnd->type(MT::Author::COMMENTER());
    $johnd->password('(none)');
    $johnd->id(4);
    $johnd->save() or die "Couldn't save author record 4: " . $johnd->errstr;

    my $hiro = MT::Author->new();
    $hiro->set_values({
        name => 'Hiro Nakamura',
        nickname => 'Hiro',
        email => 'hiro@heroes.com',
        auth_type => 'MT',
    });
    $hiro->type(MT::Author::AUTHOR());
    $hiro->password('time');
    $hiro->id(5);
    $hiro->status(2);
    $hiro->save() or die "Couldn't save author record 5: " . $hiro->errstr;

    require MT::Association;
    my $assoc = MT::Association->new();
    $assoc->author_id($chuckd->id);
    $assoc->blog_id(1);
    $assoc->role_id(3);
    $assoc->type(1);
    $assoc->save();

    $assoc = MT::Association->new();
    $assoc->author_id($bobd->id);
    $assoc->blog_id(1);
    $assoc->role_id(4);
    $assoc->type(1);
    $assoc->save();

    $assoc = MT::Association->new();
    $assoc->author_id($hiro->id);
    $assoc->blog_id(1);
    $assoc->role_id(3);
    $assoc->type(1);
    $assoc->save();

    # set permission record for johnd commenter on blog 1
    $johnd->approve(1);

    my $entry = MT::Entry->load(1);
    if (!$entry) {
        $entry = MT::Entry->new();
        $entry->set_values({
            blog_id => 1,
            title => 'A Rainy Day',
            text => 'On a drizzly day last weekend,',
            text_more => 'I took my grandpa for a walk.',
            excerpt => 'A story of a stroll.',
            keywords => 'keywords',
            created_on => '19780131074500',
            authored_on => '19780131074500',
            modified_on => '19780131074600',
            authored_on => '19780131074500',
            author_id => $chuckd->id,
            pinged_urls => 'http://technorati.com/',
            allow_comments => 1,
            allow_pings => 1,
            status => MT::Entry::RELEASE(),
        });
        $entry->id(1);
        $entry->tags('rain', 'grandpa', 'strolling');
        $entry->save() or die "Couldn't save entry record 1: ".$entry->errstr;
    }

    $entry = MT::Entry->load(2);
    if (!$entry) {
        $entry = MT::Entry->new();
        $entry->set_values({
            blog_id => 1,
            title => 'A preponderance of evidence',
            text => 'It is sufficient to say...',
            text_more => 'I suck at making up test data.',
            created_on => '19790131074500',
            authored_on => '19790131074500',
            modified_on => '19790131074600',
            authored_on => '19780131074500',
            author_id => $bobd->id,
            allow_comments => 1,
            status => MT::Entry::FUTURE(),
        });
        $entry->id(2);
        $entry->save() or die "Couldn't save entry record 2: ".$entry->errstr;
    }

    $entry = MT::Entry->load(3);
    if (!$entry) {
        $entry = MT::Entry->new();
        $entry->set_values({
            blog_id => 1,
            title => 'Spurious anemones',
            text => '...are better than the non-spurious',
            text_more => 'variety.',
            created_on => '19770131074500',
            authored_on => '19790131074500',
            modified_on => '19770131074600',
            authored_on => '19780131074500',
            author_id => $chuckd->id,
            allow_comments => 1,
            allow_pings => 0,
            status => MT::Entry::HOLD(),
        });
        $entry->id(3);
        $entry->tags('anemones');
        $entry->save() or die "Couldn't save entry record 3: ".$entry->errstr;
    }

    require MT::Trackback;
    my $tb = MT::Trackback->load(1);
    if (!$tb) {
        $tb = new MT::Trackback;
        $tb->entry_id(1);
        $tb->blog_id(1);
        $tb->title("Entry TrackBack Title");
        $tb->description("Entry TrackBack Description");
        $tb->category_id(0);
        $tb->id(1);
        $tb->save or die "Couldn't save Trackback record 1: " . $tb->errstr;;
    }

    require MT::TBPing;
    my $ping = MT::TBPing->load(1);
    if (!$ping) {
        $ping = new MT::TBPing;
        $ping->tb_id(1);
        $ping->blog_id(1);
        $ping->ip('127.0.0.1');
        $ping->title('Foo');
        $ping->excerpt('Bar');
        $ping->source_url('http://example.com/');
        $ping->blog_name("Example Blog");
        $ping->created_on('20050405000000');
        $ping->id(1);
        $ping->visible(1);
        $ping->save or die "Couldn't save TBPing record 1: " . $ping->errstr;
    }

    my @verses = (
        'Oh, where have you been, my blue-eyed son?
Oh, where have you been, my darling young one?',
        'I saw a newborn baby with wild wolves all around it
I saw a highway of diamonds with nobody on it',
        'Heard one hundred drummers whose hands were a-blazin\',
Heard ten thousand whisperin\' and nobody listenin\'',
        'I met one man who was wounded in love,
I met another man who was wounded with hatred',
        'Where hunger is ugly, where souls are forgotten,
Where black is the color, where none is the number,
And it\'s a hard, it\'s a hard, it\'s a hard, it\'s a hard,
It\'s a hard rain\'s a-gonna fall',
    );

    require MT::Category;
    my $cat = MT::Category->load({ label => 'foo', blog_id => 1});
    if (!$cat) {
        $cat = new MT::Category;
        $cat->blog_id(1);
        $cat->label('foo');
        $cat->description('bar');
        $cat->author_id($chuckd->id);
        $cat->parent(0);
        $cat->id(1);
        $cat->save or die "Couldn't save category record 1: ". $cat->errstr;
    }

    $cat = MT::Category->load({ label => 'bar', blog_id => 1});
    if (!$cat) {
        $cat = new MT::Category;
        $cat->blog_id(1);
        $cat->label('bar');
        $cat->description('foo');
        $cat->author_id($chuckd->id);
        $cat->parent(0);
        $cat->id(2);
        $cat->save or die "Couldn't save category record 2: ". $cat->errstr;
    }

    $tb = MT::Trackback->load(2);
    if (!$tb) {
        $tb = new MT::Trackback;
        $tb->title("Category TrackBack Title");
        $tb->description("Category TrackBack Description");
        $tb->entry_id(0);
        $tb->blog_id(1);
        $tb->category_id(2);
        $tb->id(2);
        $tb->save or die "Couldn't save Trackback record 2: " . $tb->errstr;;
    }

    $cat = MT::Category->load({ label => 'subfoo', blog_id => 1});
    if (!$cat) {
        $cat = new MT::Category;
        $cat->blog_id(1);
        $cat->label('subfoo');
        $cat->description('subcat');
        $cat->author_id($bobd->id);
        $cat->parent(1);
        $cat->id(3);
        $cat->save or die "Couldn't save category record 3: ". $cat->errstr;
    }

    require MT::Placement;
    foreach my $i (1..@verses) {
        $entry = MT::Entry->load($i+3);
        if (!$entry) {
            $entry = MT::Entry->new();
            $entry->set_values({
                blog_id => 1,
                title => "Verse $i",
                text => $verses[$i],
                author_id => ($i == 3 ? $bobd->id : $chuckd->id),
                created_on => sprintf("%04d0131074501", $i + 1960),
                authored_on => sprintf("%04d0131074501", $i + 1960),
                modified_on => sprintf("%04d0131074601", $i + 1960),
                authored_on => sprintf("%04d0131074501", $i + 1960),
                allow_comments => ($i <= 2 ? 0 : 1),
                status => MT::Entry::RELEASE(),
            });
            $entry->id($i+3);
            $entry->tags('verse');
            $entry->save()
                or die "Couldn't save entry record ".($entry->id).": ". $entry->errstr;
            if ($i == 3) {
                my $place = new MT::Placement;
                $place->entry_id($entry->id);
                $place->blog_id(1);
                $place->category_id(1);
                $place->is_primary(1);
                $place->save
                    or die "Couldn't save placement record: ".$place->errstr;
            }
            if ($i == 4) {
                my $place = new MT::Placement;
                $place->entry_id($entry->id);
                $place->blog_id(1);
                $place->category_id(3);
                $place->is_primary(1);
                $place->save
                    or die "Couldn't save placement record: ".$place->errstr;
            }
        }
    }

    # entry id 1 - 1 visible comment
    # entry id 4 - no comments, commenting is off
    require MT::Comment;
    unless (MT::Comment->count({entry_id => 1})) {
        my $cmt = new MT::Comment();
        $cmt->set_values({
            text => 'Postmodern false consciousness has always been firmly rooted in post-Freudian Lacanian neo-Marxist bojangles. Needless to say, this quickly and asymptotically approches a purpletacular jouissance of etic jumpinmypants.',
            entry_id => 1,
            author => 'v14GrUH 4 cheep',
            visible => 1,
            email => 'jake@fatman.com',
            url => 'http://fatman.com/',
            blog_id => 1,
            ip => '127.0.0.1',
            created_on => '20040914182800',
        });
        $cmt->id(1);
        $cmt->save() or die "Couldn't save comment record 1: ".$cmt->errstr;

        $cmt->id(11);
        $cmt->text('Comment reply for comment 1');
        $cmt->author('Comment 11');
        $cmt->created_on('20040812182900');
        $cmt->parent_id(1);
        $cmt->save() or die "Couldn't save comment record 11: ".$cmt->errstr;

        $cmt->id(12);
        $cmt->text('Comment reply for comment 11');
        $cmt->author('Comment 12');
        $cmt->created_on('20040810183000');
        $cmt->parent_id(11);
        $cmt->save() or die "Couldn't save comment record 12: ".$cmt->errstr;
    }
    # entry id 5 - 1 comment, commenting is off (closed)
    unless (MT::Comment->count({entry_id => 5})) {
        my $cmt = new MT::Comment();
        $cmt->set_values({
            text => 'Comment for entry 5, visible',
            entry_id => 5,
            author => 'Comment 2',
            visible => 1,
            email => 'johnd@doe.com',
            url => 'http://john.doe.com/',
            commenter_id => $johnd->id,
            blog_id => 1,
            ip => '127.0.0.1',
            created_on => '20040912182800',
        });
        $cmt->id(2);
        $cmt->junk_score(1.5);
        $cmt->save() or die "Couldn't save comment record 2: ".$cmt->errstr;
    }
    # entry id 6 - 3 comment visible, 1 moderated
    unless (MT::Comment->count({entry_id => 6})) {
        my $cmt = new MT::Comment();
        $cmt->set_values({
            text => 'Comment for entry 6, visible',
            entry_id => 6,
            author => 'Comment 3',
            visible => 1,
            email => '',
            url => '',
            blog_id => 1,
            ip => '127.0.0.1',
            created_on => '20040911182800',
        });
        $cmt->id(3);
        $cmt->save() or die "Couldn't save comment record 3: ".$cmt->errstr;

        $cmt->id(4);
        $cmt->visible(0);
        $cmt->author('Comment 4');
        $cmt->text('Comment for entry 6, moderated');
        $cmt->created_on('20040910182800');
        $cmt->save() or die "Couldn't save comment record 4: ".$cmt->errstr;
        
        $cmt->text("All your comments are belonged to me.");
        $cmt->commenter_id($chuckd->id);
        $cmt->visible(1);
        $cmt->id(14);
        $cmt->save or die "Couldn't save comment record 1: ".$cmt->errstr;

        $cmt->text("All your comments are belonged to us MT Authors.");
        $cmt->commenter_id($bobd->id);
        $cmt->visible(1);
        $cmt->id(15);
        $cmt->save or die "Couldn't save comment record 1: ".$cmt->errstr;
    }
    # entry id 7 - 0 comment visible, 1 moderated
    unless (MT::Comment->count({entry_id => 7})) {
        my $cmt = new MT::Comment();
        $cmt->set_values({
            text => 'Comment for entry 7, moderated',
            entry_id => 7,
            author => 'Comment 7',
            visible => 0,
            email => '',
            url => '',
            blog_id => 1,
            ip => '127.0.0.1',
            created_on => '20040909182800',
        });
        $cmt->id(5);
        $cmt->save() or die "Couldn't save comment record 5: ".$cmt->errstr;
    }
    # entry id 8 - 1 comment visible, 1 moderated, 1 junk
    unless (MT::Comment->count({entry_id => 8})) {
        my $cmt = new MT::Comment();
        $cmt->set_values({
            text => 'Comment for entry 8, visible',
            entry_id => 8,
            author => 'Comment 8',
            visible => 1,
            email => '',
            url => '',
            blog_id => 1,
            ip => '127.0.0.1',
            created_on => '20040814182800',
        });
        $cmt->id(6);
        $cmt->save() or die "Couldn't save comment record 6: ".$cmt->errstr;

        $cmt->id(7);
        $cmt->visible(0);
        $cmt->text('Comment for entry 8, moderated');
        $cmt->author('JD7');
        $cmt->created_on('20040812182800');
        $cmt->save() or die "Couldn't save comment record 7: ".$cmt->errstr;

        $cmt->id(8);
        $cmt->visible(0);
        $cmt->junk_status(-1);
        $cmt->text('Comment for entry 8, junk');
        $cmt->author('JD8');
        $cmt->created_on('20040810182800');
        $cmt->save() or die "Couldn't save comment record 8: ".$cmt->errstr;
    }

    require MT::Template;
    require MT::TemplateMap;

    my $tmpl = new MT::Template;
    $tmpl->blog_id(1);
    $tmpl->name('blog-name');
    $tmpl->text('<MTBlogName>');
    $tmpl->type('custom');
    $tmpl->save or die "Couldn't save template record 1: ".$tmpl->errstr;

    ### Asset
    use MT::Asset;

    my $img_pkg = MT::Asset->class_handler('image');
    my $file_pkg = MT::Asset->class_handler('file');
    my $asset = new $img_pkg;
    $asset->blog_id(1);
    $asset->url('http://narnia.na/nana/images/test.jpg');
    $asset->file_path(File::Spec->catfile($ENV{MT_HOME}, "t", 'images', 'test.jpg'));
    $asset->file_name('test.jpg');
    $asset->file_ext('jpg');
    $asset->image_width(640);
    $asset->image_height(480);
    $asset->mime_type('image/jpeg');
    $asset->label('Image photo');
    $asset->description('This is a test photo.');
    $asset->created_by(1);
    $asset->tags('alpha', 'beta', 'gamma');
    $asset->save;

    $asset->set_score('unit test', $bobd, 5, 1);
    $asset->set_score('unit test', $johnd, 3, 1);
    $asset->set_score('unit test', MT::Author->load(1), 4, 1);

    $asset = new $file_pkg;
    $asset->blog_id(1);
    $asset->url('http://narnia.na/nana/files/test.tmpl');
    $asset->file_path(File::Spec->catfile($ENV{MT_HOME}, "t", 'test.tmpl'));
    $asset->file_name('test.tmpl');
    $asset->file_ext('tmpl');
    $asset->mime_type('text/plain');
    $asset->label('Template');
    $asset->description('This is a test template.');
    $asset->created_by(1);
    $asset->created_on('19780131074500');
    $asset->tags('beta');
    $asset->save;

    $asset->set_score('unit test', $chuckd, 2, 1);
    $asset->set_score('unit test', $johnd, 3, 1);
    
    ## ObjectScore
    my $e5 = MT::Entry->load(5);
    $e5->set_score('unit test', $bobd, 5, 1);
    $e5->set_score('unit test', $johnd, 3, 1);
    $e5->set_score('unit test', MT::Author->load(1), 4, 1);

    my $e6 = MT::Entry->load(6);
    $e6->set_score('unit test', $chuckd, 1, 1);
    $e6->set_score('unit test', $johnd, 1, 1);
    
    my $e4 = MT::Entry->load(4);
    $e4->set_score('unit test', $chuckd, 2, 1);
    $e4->set_score('unit test', $johnd, 3, 1);

    ## Page
    require MT::Page;
    my $page = MT::Page->new();
    $page->set_values({
        blog_id => 1,
        title => 'Watching the River Flow',
        text => 'What the matter with me,',
        text_more => 'I don\'t have much to say,',
        keywords => 'no folder',
        excerpt => 'excerpt',
        created_on => '19780131074500',
        authored_on => '19780131074500',
        modified_on => '19780131074600',
        author_id => $chuckd->id,
        status => MT::Entry::RELEASE(),
    });
    $page->id(20);
    $page->tags('river', 'flow', 'watch');
    $page->save() or die "Couldn't save page record 20: ".$page->errstr;

    require MT::Folder;
    my $folder = MT::Folder->new();
    $folder->blog_id(1);
    $folder->label('info');
    $folder->description('information');
    $folder->author_id($chuckd->id);
    $folder->parent(0);
    $folder->id(20);
    $folder->save or die "Could'n sae folder record 20:" . $folder->errstr;

    $folder = MT::Folder->new();
    $folder->blog_id(1);
    $folder->label('download');
    $folder->description('download top');
    $folder->author_id($chuckd->id);
    $folder->parent(0);
    $folder->id(21);
    $folder->save or die "Could'n sae folder record 21:" . $folder->errstr;

    $folder = MT::Folder->new();
    $folder->blog_id(1);
    $folder->label('nightly');
    $folder->description('nightly build');
    $folder->author_id($chuckd->id);
    $folder->parent(21);
    $folder->id(22);
    $folder->save or die "Could'n sae folder record 22:" . $folder->errstr;

    $page = MT::Page->new();
    $page->set_values({
        blog_id => 1,
        title => 'Page #1',
        text => 'Wish I was back in the city',
        text_more => 'Instead of this old bank of sand,',
        keywords => 'keywords',
        created_on => '19790131074500',
        authored_on => '19790131074500',
        modified_on => '19790131074600',
        author_id => $chuckd->id,
        status => MT::Entry::RELEASE(),
    });
    $page->id(21);
    $page->tags('page1', 'page2', 'page3');
    $page->save() or die "Couldn't save page record 21: ".$page->errstr;

    my $folder_place = new MT::Placement;
    $folder_place->entry_id(21);
    $folder_place->blog_id(1);
    $folder_place->category_id(20);
    $folder_place->is_primary(1);
    $folder_place->save
        or die "Couldn't save placement record: ".$folder_place->errstr;

    $page = MT::Page->new();
    $page->set_values({
        blog_id => 1,
        title => 'Page #2',
        text => 'With the sub beating down over the chimney tops',
        text_more => 'And the one I love so close at hand',
        keywords => 'keywords',
        created_on => '19800131074500',
        authored_on => '19800131074500',
        modified_on => '19800131074600',
        author_id => $chuckd->id,
        status => MT::Entry::RELEASE(),
    });
    $page->id(22);
    $page->tags('page2', 'page3');
    $page->save() or die "Couldn't save page record 22: ".$page->errstr;

    $folder_place = new MT::Placement;
    $folder_place->entry_id(22);
    $folder_place->blog_id(1);
    $folder_place->category_id(21);
    $folder_place->is_primary(1);
    $folder_place->save
        or die "Couldn't save placement record: ".$folder_place->errstr;

    $page = MT::Page->new();
    $page->set_values({
        blog_id => 1,
        title => 'Page #3',
        text => 'If I had wings and I could fly,',
        text_more => 'I know where I would go.',
        keywords => 'keywords',
        created_on => '19810131074500',
        authored_on => '19810131074500',
        modified_on => '19810131074600',
        author_id => $bobd->id,
        status => MT::Entry::RELEASE(),
    });
    $page->id(23);
    $page->tags('page3');
    $page->save() or die "Couldn't save page record 23: ".$page->errstr;

    $folder_place = new MT::Placement;
    $folder_place->entry_id(23);
    $folder_place->blog_id(1);
    $folder_place->category_id(22);
    $folder_place->is_primary(1);
    $folder_place->save
        or die "Couldn't save placement record: ".$folder_place->errstr;

    unless (MT::Comment->count({entry_id => $page->id})) {
        my $page_cmt = new MT::Comment();
        $page_cmt->set_values({
            text => "Your time is limited, so don't waste it living someone else's life. Don't be trapped by dogma - which is living with the results of other people's thinking. Don't let the noise of others' opinions drown out your own inner voice. And most important, have the courage to follow your heart and intuition. They somehow already know what you truly want to become. Everything else is secondary.",
            entry_id => 23,
            author => 'Steve Jobs',
            visible => 1,
            email => 'f@example.com',
            url => 'http://example.com/',
            blog_id => 1,
            ip => '127.0.0.1',
            created_on => '20040114182800',
            modified_on => '20040114182800',
        });
        $page_cmt->id(13);
        $page_cmt->save() or die "Couldn't save comment record 1: ".$page_cmt->errstr;
    }

    my $page_tb = MT::Trackback->new;
    $page_tb->entry_id($page->id);
    $page_tb->blog_id(1);
    $page_tb->title("Page TrackBack Title");
    $page_tb->description("Page TrackBack Description");
    $page_tb->category_id(0);
    $page_tb->id(3);
    $page_tb->save or die "Couldn't save Trackback record 1: " . $tb->errstr;;

    my $page_ping = MT::TBPing->new;
    $page_ping->tb_id($page_tb->id);
    $page_ping->blog_id(1);
    $page_ping->ip('127.0.0.1');
    $page_ping->title('Trackbacking to a page');
    $page_ping->excerpt('Four bridges in the bayarea.  Golden Gate, Bay, San Mateo and Dan Burton.');
    $page_ping->source_url('http://example.com/');
    $page_ping->blog_name("Example Blog");
    $page_ping->created_on('20040101000000');
    $page_ping->modified_on('20040101000000');
    $page_ping->visible(1);
    $page_ping->id(3);
    $page_ping->save or die "Couldn't save TBPing record 1: " . $ping->errstr;

    MT->instance->rebuild(
        BlogId => 1,
        EntryCallback => sub { print STDERR "# Rebuilding entry " . $_[0]->id . "\n" }
    );

    ### Make ObjectAsset mappings
    require MT::ObjectAsset;
    my $map;
    $entry = MT::Entry->load(1);
    if ($entry) {
        $map = new MT::ObjectAsset;
        $map->blog_id($entry->blog_id);
        $map->asset_id(1);
        $map->object_ds($entry->datasource);
        $map->object_id($entry->id);
        $map->save;
    }
    $page = MT::Page->load(20);
    if ($entry) {
        $map = new MT::ObjectAsset;
        $map->blog_id($page->blog_id);
        $map->asset_id(2);
        $map->object_ds($page->datasource);
        $map->object_id($page->id);
        $map->save;
    }

    1;
}

1;
