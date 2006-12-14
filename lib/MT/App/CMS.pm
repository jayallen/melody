# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::App::CMS;
use strict;

use Symbol;
use File::Spec;
use MT::Util qw( encode_html format_ts offset_time_list offset_time epoch2ts
                 remove_html get_entry mark_odd_rows first_n_words
                 perl_sha1_digest_hex is_valid_email relative_date ts2epoch
                 perl_sha1_digest encode_url dirify encode_js is_valid_date
                 archive_file_for );
use MT::App;
use MT::I18N qw( substr_text const length_text wrap_text encode_text
                 break_up_text first_n_text guess_encoding );
use CGI;
use MT::Author qw(:constants);
use MT::Permission;
@MT::App::CMS::ISA = qw( MT::App );

my @RebuildOptions = ();

my %API = (
    author => 'MT::Author',
    commenter => 'MT::Author',
    comment => 'MT::Comment',
    entry   => 'MT::Entry',
    template => 'MT::Template',
    blog => 'MT::Blog',
    notification => 'MT::Notification',
    templatemap => 'MT::TemplateMap',
    category => 'MT::Category',
    banlist => 'MT::IPBanList',
    ping => 'MT::TBPing',
    ping_cat => 'MT::TBPing',
    log => 'MT::Log',
    tag => 'MT::Tag',
    role => 'MT::Role',
    association => 'MT::Association',
    asset => 'MT::Asset',
);

sub init {
    my $app = shift;
    $app->SUPER::init(@_) or return;
    $app->add_methods(
        'menu' => \&show_menu,
        'admin' => \&show_admin,
        'status' => \&show_status,
        'save' => \&save_object,
        'view' => \&edit_object,
        'list' => \&list_objects,
        'list_plugins' => \&list_plugins,
        'list_pings' => \&list_pings,
        'list_entries' => \&list_entries,
        'list_comments' => \&list_comments,
        'list_authors' => \&list_authors,
        'list_commenters' => \&list_commenters,
        'list_assets' => \&list_assets,
        'asset_insert' => \&asset_insert,
        'save_commenter_perm' => \&save_commenter_perm,
        'trust_commenter' => \&trust_commenter,
        'ban_commenter' => \&ban_commenter,
        'approve_item' => \&approve_item,
        'unapprove_item' => \&unapprove_item,
        'save_entries' => \&save_entries,
        'save_entry' => \&save_entry,
        'preview_entry' => \&preview_entry,
        'cfg_archives' => \&cfg_archives,
        'cfg_archives_do_add' => \&cfg_archives_do_add,
        'cfg_prefs' => \&cfg_prefs,
        'cfg_entries' => \&cfg_entries,
        'cfg_plugins' => \&cfg_plugins,
        'cfg_feedback' => \&cfg_feedback,
        'list_blogs' => \&list_blogs,
        'system_list_blogs' => \&system_list_blogs,
        'list_cat' => \&list_categories,
        'save_cat' => \&save_category,
        'edit_placements' => \&edit_placements,
        'save_placements' => \&save_placements,
        'delete_confirm' => \&delete_confirm,
        'delete' => \&delete,
        'enable_object' => \&enable_object,
        'disable_object' => \&disable_object,
        'edit_role' => \&edit_role,
        'save_role' => \&save_role,
        'ping' => \&send_pings,
        'rebuild_phase' => \&rebuild_phase,
        'rebuild' => \&rebuild_pages,
        'rebuild_new_phase' => \&rebuild_new_phase,
        'start_rebuild' => \&start_rebuild_pages,
        'rebuild_confirm' => \&rebuild_confirm,
        'send_notify' => \&send_notify,
        'start_upload' => \&start_upload,
        'upload_file' => \&upload_file,
        'start_upload_entry' => \&start_upload_entry,
        'logout' => \&logout,
        'start_recover' => \&start_recover,
        'recover' => \&recover_password,
        'bookmarklets' => \&bookmarklets,
        'make_bm_link' => \&make_bm_link,
        'view_log' => \&view_log,
        'list_log' => \&view_log,
        'reset_log' => \&reset_log,
        'export_log' => \&export_log,
        'start_import' => \&start_import,
        'search_replace' => \&search_replace,
        'export' => \&export,
        'import' => \&do_import,
        'pinged_urls' => \&pinged_urls,
        'show_entry_prefs' => \&show_entry_prefs,
        'save_entry_prefs' => \&save_entry_prefs,
        'reg_file' => \&reg_file,
        'reg_bm_js' => \&reg_bm_js,
        'category_add' => \&category_add,
        'category_do_add' => \&category_do_add,
        'cc_return' => \&cc_return,
        'reset_blog_templates' => \&reset_blog_templates,
        'handshake' => \&handshake,
        'itemset_action' => \&itemset_action,
        'empty_junk' => \&empty_junk,
        'handle_junk' => \&handle_junk,
        'not_junk' => \&not_junk,
        'cfg_system' => \&cfg_system_general,
        'cfg_system_feedback' => \&cfg_system_feedback,
        'save_plugin_config' => \&save_plugin_config,
        'reset_plugin_config' => \&reset_plugin_config,
        'save_cfg_system_feedback' => \&save_cfg_system_feedback,
        'save_cfg_system_general' => \&save_cfg_system_general,
        'update_list_prefs' => \&update_list_prefs,
        'update_welcome_message' => \&update_welcome_message,
        'upgrade' => \&upgrade,
        'plugin_control' => \&plugin_control,
        'recover_profile_password' => \&recover_profile_password,
        'js_tag_check' => \&js_tag_check,
        'js_tag_list' => \&js_tag_list,
        'list_tags' => \&list_tags,
        'rename_tag' => \&rename_tag,
        'list_associations' => \&list_associations,
        'list_roles' => \&list_roles,
        'dialog_select_weblog' => \&dialog_select_weblog,
        'dialog_grant_role' => \&dialog_grant_role,
        'grant_role' => \&grant_role,
        'backup_restore' => \&backup_restore,
        'backup' => \&backup,
        'backup_download' => \&backup_download,
        'restore' => \&restore,
        'restore_upload_manifest' => \&restore_upload_manifest,
        'dialog_restore_upload' => \&dialog_restore_upload,
        'restore_premature_cancel' => \&restore_premature_cancel,
    );
    $app->{state_params} = [
        '_type', 'id', 'tab', 'offset', 'filter',
        'filter_val', 'blog_id', 'is_power_edit'
    ];
    $app->{template_dir} = 'cms';
    $app->{plugin_template_path} = '';
    $app->{is_admin} = 1;
    $app->init_core_itemset_actions();
    $app;
}

sub init_plugins {
    my $app = shift;
    # This has to be done prior to plugin initialization since we
    # may have plugins that register themselves using some of the
    # older callback names. The callback aliases are declared
    # in init_core_callbacks.
    $app->init_core_callbacks();
    $app->SUPER::init_plugins(@_);
}

sub init_request {
    my $app = shift;

    $app->{default_mode} = 'list_blogs';

    $app->SUPER::init_request(@_);

    my $mode = $app->mode;
    if (($mode ne 'logout') && ($mode ne 'start_recover') &&
        ($mode ne 'recover') && ($mode ne 'upgrade')) {
        my $schema = $app->config('SchemaVersion');
        if (!$schema || ($schema < $app->schema_version)) {
            $mode = 'upgrade';
            $app->mode($mode);
        } else {
            foreach my $plugin (@MT::Plugins) {
                if ($plugin->needs_upgrade) {
                    $mode = 'upgrade';
                    $app->mode($mode);
                }
            }
        }
    }

    $app->{requires_login} = $mode && ($mode eq 'start_recover' ||
        $mode eq 'recover' || $mode eq 'reg_bm_js' ||
        $mode eq 'upgrade' || $mode eq 'logout') ?
        0 : 1;
}

sub init_core_itemset_actions {
    my $app = shift;
    $app->add_itemset_action({type => 'entry',
                              key => "set_published",
                              label => "Publish Entries",
                              code => \&publish_entries,
                          }, 1);
    $app->add_itemset_action({type => 'entry',
                              key => "set_draft",
                              label => "Unpublish Entries",
                              code => \&draft_entries,
                          }, 1);
    $app->add_itemset_action({type => 'entry',
                              key => "add_tags",
                              label => "Add Tags...",
                              code => \&add_tags_to_entries,
                              input => 1,
                              input_label => 'Tags to add to selected entries',
                              condition => sub { $app->user->is_superuser() || ($app->param('blog_id') && $app->{perms}->can_edit_all_posts) },
                          }, 1);
    $app->add_itemset_action({type => 'entry',
                              key => "remove_tags",
                              label => "Remove Tags...",
                              code => \&remove_tags_from_entries,
                              input => 1,
                              input_label => 'Tags to remove from selected entries',
                              condition => sub { $app->user->is_superuser() || ($app->param('blog_id') && $app->{perms}->can_edit_all_posts) },
                          }, 1);
    $app->add_itemset_action({type => 'asset',
                              key => "add_tags",
                              label => "Add Tags...",
                              code => \&add_tags_to_assets,
                              input => 1,
                              input_label => 'Tags to add to selected assets',
                              condition => sub { $app->user->is_superuser() || ($app->param('blog_id') && $app->{perms}->can_edit_all_posts) },
                          }, 1);
    $app->add_itemset_action({type => 'asset',
                              key => "remove_tags",
                              label => "Remove Tags...",
                              code => \&remove_tags_from_assets,
                              input => 1,
                              input_label => 'Tags to remove from selected assets',
                              condition => sub { $app->user->is_superuser() || ($app->param('blog_id') && $app->{perms}->can_edit_all_posts) },
                          }, 1);
    $app->add_itemset_action({type => 'ping',
                              key => "unapprove_ping",
                              label => "Unpublish TrackBack(s)",
                              code => \&unapprove_item,
                              condition => sub { $_[0] ne 'junk' }, # param is tab name
                          }, 1);
    $app->add_itemset_action({type => 'comment',
                              key => "unapprove_comment",
                              label => "Unpublish Comment(s)",
                              code => \&unapprove_item,
                              condition => sub { $_[0] ne 'junk' },
                          }, 1);
    $app->add_itemset_action({type => 'comment',
                              key => "trust_commenter",
                              label => "Trust Commenter(s)",
                              code => \&trust_commenter_by_comment,
                              condition => sub { $app->user_can_admin_commenters },
                          }, 1);
    $app->add_itemset_action({type => 'comment',
                              key => "untrust_commenter",
                              label => "Untrust Commenter(s)",
                              code => \&untrust_commenter_by_comment,
                              condition => sub { $app->user_can_admin_commenters },
                              }, 1);
    $app->add_itemset_action({type => 'comment',
                              key => "ban_commenter",
                              label => "Ban Commenter(s)",
                              code => \&ban_commenter_by_comment,
                              condition => sub { $app->user_can_admin_commenters },
                              }, 1);
    $app->add_itemset_action({type => 'comment',
                              key => "unban_commenter",
                              label => "Unban Commenter(s)",
                              code => \&unban_commenter_by_comment,
                              condition => sub { $app->user_can_admin_commenters },
                              }, 1);
    $app->add_itemset_action({type => 'commenter',
                              key => "untrust",
                              label => "Untrust Commenter(s)",
                              code => \&untrust_commenter,
                              condition => sub { $app->user_can_admin_commenters },
                          }, 1);
    $app->add_itemset_action({type => 'commenter',
                              key => "unban",
                              label => "Unban Commenter(s)",
                              code => \&unban_commenter,
                              condition => sub { $app->user_can_admin_commenters },
                          }, 1);
    $app->add_itemset_action({type => 'author',
                              key => "recover_passwords",
                              label => "Recover Password(s)",
                              continue_prompt => "_WARNING_PASSWORD_RESET_MULTI",
                              code => \&recover_passwords,
                              condition => sub { $app->user->is_superuser() },
                          }, 1);
    $app->add_itemset_action({type => 'author',
                              key => "delete_user",
                              label => "Delete",
                              continue_prompt =>
                                "_WARNING_DELETE_USER",
                              code => \&delete,
                              condition => sub { 
                                  $app->user->is_superuser();
                              },
                          }, 1);
}

sub init_core_callbacks {
    my $app = shift;
    # old name => new name
    my @names = qw(
        CMSSavePermissionFilter_notification CMSSaveFilter_notification
        CMSSavePermissionFilter_banlist CMSSaveFilter_banlist
        CMSViewPermissionFilter_author CMSSavePermissionFilter_author
        CMSDeletePermissionFilter_author CMSSaveFilter_author
        CMSPreSave_author CMSPostSave_author CMSViewPermissionFilter_blog
        CMSSavePermissionFilter_blog CMSDeletePermissionFilter_blog
        CMSPreSave_blog CMSPostSave_blog CMSSaveFilter_blog CMSPostDelete_blog
        CMSViewPermissionFilter_category CMSSavePermissionFilter_category
        CMSDeletePermissionFilter_category CMSPreSave_category
        CMSPostSave_category CMSSaveFilter_category
        CMSViewPermissionFilter_comment CMSSavePermissionFilter_comment
        CMSDeletePermissionFilter_comment CMSPreSave_comment
        CMSPostSave_comment CMSViewPermissionFilter_commenter
        CMSDeletePermissionFilter_commenter CMSViewPermissionFilter_entry
        CMSDeletePermissionFilter_entry CMSPreSave_entry
        CMSViewPermissionFilter_ping CMSSavePermissionFilter_ping
        CMSDeletePermissionFilter_ping CMSPreSave_ping CMSPostSave_ping
        CMSViewPermissionFilter_template CMSSavePermissionFilter_template
        CMSDeletePermissionFilter_template CMSPreSave_template
        CMSPostSave_template
        CMSPostDelete_notification CMSPostDelete_author CMSPostDelete_category
        CMSPostDelete_comment CMSPostDelete_entry CMSPostDelete_ping
        CMSPostDelete_template CMSPostDelete_tag
        CMSPostSave_asset CMSPostDelete_asset
    );
    $MT::CallbackAlias{'AppPostEntrySave'} = 'CMSPostSave.entry';
    $MT::CallbackAlias{'CMSPostEntrySave'} = 'CMSPostSave.entry';
    for (@names) {
        my $x = $_; $x =~ s/_/./;
        $MT::CallbackAlias{$_} = $x;
    }

    MT->_register_core_callbacks({
        # notification callbacks
        'CMSSavePermissionFilter.notification' => sub {
            my ($eh, $app, $id) = @_;
            return $app->{perms}->can_edit_notifications;
        },
        'CMSSaveFilter.notification' => \&CMSSaveFilter_notification,
        'CMSPostDelete.notification' => \&CMSPostDelete_notification,

        # banlist callbacks
        'CMSSavePermissionFilter.banlist' => sub {
            my ($eh, $app, $id) = @_;
            $app->{perms}->can_edit_config;
        },
        'CMSSaveFilter.banlist' => \&CMSSaveFilter_banlist,

        # associations
        'CMSDeletePermissionFilter.association' => \&CMSDeletePermissionFilter_association,

        # user callbacks
        'CMSViewPermissionFilter.author' => \&CMSViewPermissionFilter_author,
        'CMSSavePermissionFilter.author' => \&CMSSavePermissionFilter_author,
        'CMSDeletePermissionFilter.author' => \&CMSDeletePermissionFilter_author,
        'CMSSaveFilter.author' => \&CMSSaveFilter_author,
        'CMSPreSave.author' => \&CMSPreSave_author,
        'CMSPostSave.author' => \&CMSPostSave_author,
        'CMSPostDelete.author' => \&CMSPostDelete_author,

        # blog callbacks
        'CMSViewPermissionFilter.blog' => \&CMSViewPermissionFilter_blog,
        'CMSSavePermissionFilter.blog' => \&CMSSavePermissionFilter_blog,
        'CMSDeletePermissionFilter.blog' => \&CMSDeletePermissionFilter_blog,
        'CMSPreSave.blog' => \&CMSPreSave_blog,
        'CMSPostSave.blog' => \&CMSPostSave_blog,
        'CMSSaveFilter.blog' => \&CMSSaveFilter_blog,
        'CMSPostDelete.blog' => \&CMSPostDelete_blog,

        # category callbacks
        'CMSViewPermissionFilter.category' => \&CMSViewPermissionFilter_category,
        'CMSSavePermissionFilter.category' => \&CMSSavePermissionFilter_category,
        'CMSDeletePermissionFilter.category' => \&CMSDeletePermissionFilter_category,
        'CMSPreSave.category' => \&CMSPreSave_category,
        'CMSPostSave.category' => \&CMSPostSave_category,
        'CMSSaveFilter.category' => \&CMSSaveFilter_category,
        'CMSPostDelete.category' => \&CMSPostDelete_category,

        # comment callbacks
        'CMSViewPermissionFilter.comment' => \&CMSViewPermissionFilter_comment,
        'CMSSavePermissionFilter.comment' => \&CMSSavePermissionFilter_comment,
        'CMSDeletePermissionFilter.comment' => \&CMSDeletePermissionFilter_comment,
        'CMSPreSave.comment' => \&CMSPreSave_comment,
        'CMSPostSave.comment' => \&CMSPostSave_comment,
        'CMSPostDelete.comment' => \&CMSPostDelete_comment,

        # commenter callbacks
        'CMSViewPermissionFilter.commenter' => \&CMSViewPermissionFilter_commenter,
        'CMSDeletePermissionFilter.commenter' => \&CMSDeletePermissionFilter_commenter,

        # entry callbacks
        'CMSViewPermissionFilter.entry' => \&CMSViewPermissionFilter_entry,
        'CMSDeletePermissionFilter.entry' => \&CMSDeletePermissionFilter_entry,
        'CMSPreSave.entry' => \&CMSPreSave_entry,
        'CMSPostDelete.entry' => \&CMSPostDelete_entry,

        # ping callbacks
        'CMSViewPermissionFilter.ping' => \&CMSViewPermissionFilter_ping,
        'CMSSavePermissionFilter.ping' => \&CMSSavePermissionFilter_ping,
        'CMSDeletePermissionFilter.ping' => \&CMSDeletePermissionFilter_ping,
        'CMSPreSave.ping' => \&CMSPreSave_ping,
        'CMSPostSave.ping' => \&CMSPostSave_ping,
        'CMSPostDelete.ping' => \&CMSPostDelete_ping,

        # template callbacks
        'CMSViewPermissionFilter.template' => \&CMSViewPermissionFilter_template,
        'CMSSavePermissionFilter.template' => \&CMSSavePermissionFilter_template,
        'CMSDeletePermissionFilter.template' => \&CMSDeletePermissionFilter_template,
        'CMSPreSave.template' => \&CMSPreSave_template,
        'CMSPostSave.template' => \&CMSPostSave_template,
        'CMSPostDelete.template' => \&CMSPostDelete_template,

        # tags
        'CMSDeletePermissionFilter.tag' => \&CMSDeletePermissionFilter_tag,
        'CMSPostDelete.tag' => \&CMSPostDelete_tag,

        # junk-related callbacks
        #'HandleJunk' => \&_builtin_spam_handler,
        #'HandleNotJunk' => \&_builtin_spam_unhandler,
        'NotJunkTest' => \&_cb_notjunktest_filter,

        # assets
        'CMSPostSave.asset' => \&CMSPostSave_asset,
        'CMSPostDelete.asset' => \&CMSPostDelete_asset,
    });
}

sub user_can_admin_commenters {
    my $app = shift;
    $app->{author}->is_superuser() ||
        ($app->{perms} && ($app->{perms}->can_administer_blog || $app->{perms}->can_edit_config));
}

sub validate_magic {
    my $app = shift;
    if (my $feed_token = $app->param('feed_token')) {
        return unless $app->user;
        my $pw = $app->user->api_password;
        return undef if ($pw || '') eq '';
        require MT::Util;
        my $auth_token = MT::Util::perl_sha1_digest_hex('feed:' . $pw);
        return $feed_token eq $auth_token;
    } else {
        return $app->SUPER::validate_magic(@_);
    }
}

sub update_welcome_message {
    my $app = shift;
    $app->validate_magic or return;

    # FIXME: permission check
    my $perms = $app->{perms};
    return $app->errtrans("Permission denied.")
        unless $perms && $perms->can_edit_config;

    my $blog_id = $app->param('blog_id');
    my $message = $app->param('welcome-message-text');
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1})
        or return $app->error($app->translate("Invalid blog"));
    $blog->welcome_msg($message);
    $blog->save;
    $app->redirect($app->uri( mode => 'menu', args => { blog_id => $blog_id } ));
}

sub upgrade {
    my $app = shift;

    # check for an empty database... no author table would do it...
    my $driver = MT::Object->driver;
    my $upgrade_script = $app->config('UpgradeScript');
    if (!$driver || !$driver->table_exists('MT::Author')) {
        return $app->redirect($app->path . $upgrade_script .
                              $app->uri_params( mode => 'install'));
    }

    return $app->redirect($app->path . $upgrade_script);
}

sub pre_run {
    my $app = shift;
    $app->SUPER::pre_run();
    ## Localize the label of the default text filter.
    $MT::Text_filters{__default__}{label} =
        $app->translate('Convert Line Breaks');
}

sub logout {
    my $app = shift;
    $app->SUPER::logout(@_);
}

sub start_recover {
    my $app = shift;
    $app->add_breadcrumb($app->translate('Password Recovery'));
    $app->build_page('recover.tmpl');
}

sub recover_password {
    my $app = shift;
    my $q = $app->param;
    my $name = $q->param('name');
    my $class;
    if (MT::Object->driver->isa('MT::ObjectDriver::DBM')) {
        $class = $app->user_class;
    } else {
        $class = 'MT::BasicAuthor';
    }
    eval "use $class;";
    my @author = $class->load({ name => $name });
    my $author;
    foreach (@author) {
        next unless $_->password && ($_->password ne '(none)');
        $author = $_;
    }

    my ($rc, $res) = $app->reset_password($author, $q->param('hint'), $name);

    if ($rc){
        $app->add_breadcrumb($app->translate('Password Recovery'));
        $app->build_page('recover.tmpl', { recovered => 1,
                                           email => $author->email });
    } else {
        $app->error($res);
    }
}

sub recover_profile_password {
    my $app = shift;
    $app->validate_magic or return;
    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser();

    my $q = $app->param;
    my $author_id = $q->param('author_id');
    my $author = MT::Author->load($author_id, {cached_ok=>1});

    return $app->error($app->translate("Invalid author_id"))
        if !$author || $author->type != AUTHOR || !$author_id;

    my ($rc, $res) = $app->reset_password($author, $author->hint, $author->name);

    if ($rc){
        my $url = $app->uri('mode' => 'view', 
                            args => { _type => 'author', recovered => 1, id => $author_id});
        $app->redirect($url);
    } else {
        $app->error($res);
    }
}

sub reset_password {
    my ($app, $author, $hint, $name) = @_;
    
    require MT::Log;
    my ($errstr, $log_msg);
    if (! $author) {
        $log_msg = $app->translate("Invalid username '[_1]' in password recovery attempt", $name);
        $errstr = $app->translate("Username or password recovery phrase is incorrect.");
    } elsif ($hint && !$author->hint) {
        $log_msg = $app->translate("Password recovery for user '[_1]' failed due to lack of recovery phrase specified in profile.", $name);
        $errstr = $app->translate(
            "No password recovery phrase set in user profile. Please see your system administrator for password recovery.");        
    } elsif ($hint ne $author->hint) {
        $log_msg = $app->translate("Invalid attempt to recover password (used recovery phrase '[_1]')", $hint);
        $errstr = $app->translate("Username or password recovery phrase is incorrect.");
    } elsif (!$author->email) {
        $log_msg = $app->translate("Password recovery for user '[_1]' failed due to lack of email specified in profile.", $author->name);
        $errstr = $app->translate("No email specified in user profile.  Please see your system administrator for password recovery.");
    }

    if ($errstr) {    
        $app->log({
            message => $log_msg,
            level => MT::Log::SECURITY(),
            class => 'system',
            category => 'recover_password'
        });
        return (0, $errstr);
    }

    $app->log({
        message => $app->translate("Invalid user name '[_1]' in password recovery attempt", $name),
        level => MT::Log::SECURITY(),
        class => 'system',
        category => 'recover_password',
    }), return (0, $app->translate("User name or birthplace is incorrect.")) unless $author;
    return (0, $app->translate(
        "User has not set birthplace; cannot recover password"))
        if ($hint && !$author->hint);

    $app->log({
        message => $app->translate("Invalid attempt to recover password (used birthplace '[_1]')", $hint),
        level => MT::Log::SECURITY(),
        class => 'system',
        category => 'recover_password'
    }), return (0, $app->translate("User name or birthplace is incorrect."))
        unless $author->hint eq $hint;

    return (0, $app->translate("User does not have email address"))
        unless $author->email;

    my @pool = ('a'..'z', 0..9);
    my $pass = '';
    for (1..8) { $pass .= $pool[ rand @pool ] }
    $author->set_password($pass);
    $author->save;
    my $message = $app->translate("Password was reset for user '[_1]' (user #[_2]). Password was sent to the following address: [_3]", $author->name, $author->id, $author->email);
    $app->log({
        message => $message,
        level => MT::Log::SECURITY(),
        class => 'system',
        category => 'recover_password'
    });

    # column method needed for BasicAuthor
    my $address = defined $author->column('nickname')
        ? $author->nickname .' <'. $author->email .'>'
        : $author->email;
    my %head = (
        To => $address,
        From => $app->config('EmailAddressMain') || $address,
        Subject => $app->translate("Password Recovery")
    );
    my $charset = $app->config('PublishCharset');
    my $mail_enc = uc ($app->config('MailEncoding') || $charset);
    $head{'Content-Type'} = qq(text/plain; charset="$mail_enc");

    my $body = $app->build_email('recover-password.tmpl', {user_password => $pass});
    $body = wrap_text($body, 72);
    require MT::Mail;
    MT::Mail->send(\%head, $body) or
        return (0, $app->translate(
            "Error sending mail ([_1]); please fix the problem, then " .
            "try again to recover your password.", MT::Mail->errstr));
    (1, $message);
}

sub js_tag_list {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    my $type = $app->param('_type') || 'entry';

    my $js;
    require MT::Tag;
    my $class = $app->_load_driver_for($type) or return;
    if (my $tag_list = MT::Tag->cache(blog_id => $blog_id,
        class => $class)) {
        require JSON;
        $js = JSON::objToJson($tag_list);
    }
    $js ||= '{}';
    $app->send_http_header('text/javascript');
    $app->{no_print_body} = 1;
    $app->print($js);
}

sub js_tag_check {
    my $app = shift;
    my $name = $app->param('tag_name');
    my $blog_id = $app->param('blog_id');
    my $type = $app->param('_type') || 'entry';
    require MT::Tag;
    my $tag = MT::Tag->load({ name => $name }, { binary => { name => 1 }});
    my $class = $app->_load_driver_for($type) or return;
    if ($tag && $blog_id) {
        require MT::ObjectTag;
        my $count = MT::ObjectTag->count({
           object_datasource => $class->datasource,
           blog_id => $blog_id,
           tag_id => $tag->id
        });
        undef $tag unless $count;
    }
    my $exists = $tag ? 'true' : 'false';
    $app->{no_print_body} = 1;
    $app->send_http_header("text/plain");
    $app->print($exists);
}

sub recover_passwords {
    my $app = shift;
    my @id = $app->param('id');

    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser();

    my $class;
    if (MT::Object->driver->isa('MT::ObjectDriver::DBM')) {
        $class = $app->user_class;
    } else {
        $class = 'MT::BasicAuthor';
    }
    eval "use $class;";

    my @msg_loop;
    foreach (@id) {
        my $author = $class->load($_);
        my ($rc, $res) = $app->reset_password($author, $author->hint);
        push @msg_loop, { message => $res };
    }

    $app->build_page('recover_password_result.tmpl', {message_loop => \@msg_loop, return_url => $app->return_uri});
}

sub listing {
    my $app = shift;
    my ($opt) = @_;

    my $type = $opt->{Type};
    my $tmpl = $opt->{Template} || 'list_' . $type . '.tmpl';
    my $iter_method = $opt->{Iterator} || 'load_iter';
    my $param = $opt->{Params} || {};
    my $hasher = $opt->{Code};
    my $terms = $opt->{Terms} || {};
    my $args = $opt->{Args} || {};
    my $no_html = $opt->{NoHTML};
    my $json = $app->param('json');
    $param->{json} = 1 if $json;

    my $class = $app->_load_driver_for($type) or return;
    my $list_pref = $app->list_pref($type);
    $param->{$_} = $list_pref->{$_} for keys %$list_pref;
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    $args->{offset} = $offset if $offset;
    $args->{limit} = $limit + 1;

    # handle search parameter
    if (my $search = $app->param('search')) {
        $app->param('do_search', 1);
        my $search_param = $app->do_search_replace();
        if ($hasher) {
            my $data = $search_param->{object_loop};
            if ($data && @$data) {
                foreach my $row (@$data) {
                    my $obj = $row->{object};
                    $row = $obj->column_values();
                    $hasher->($obj, $row);
                }
            }
        }
        $param->{$_} = $search_param->{$_} for keys %$search_param;
        $param->{limit_none} = 1;
    } else {
        # handle filter options
        if ((my $filter_col = $app->param('filter'))
            && (my $val = $app->param('filter_val')))
        {
            if ((($filter_col eq 'normalizedtag') || ($filter_col eq 'exacttag'))
                && ($class->isa('MT::Taggable'))) {
                my $normalize = ($filter_col eq 'normalizedtag');
                require MT::Tag;
                require MT::ObjectTag;
                my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
                my @filter_vals = MT::Tag->split($tag_delim, $val);
                my @filter_tags = @filter_vals;
                if ($normalize) {
                    push @filter_tags, MT::Tag->normalize($_) foreach @filter_vals;
                }
                my @tags = MT::Tag->load({ name => [ @filter_tags ] }, { binary => { name => 1 }});
                my @tag_ids;
                foreach (@tags) {
                    push @tag_ids, $_->id;
                    if ($normalize) {
                        my @more = MT::Tag->load({ n8d_id => $_->n8d_id ? $_->n8d_id : $_->id });
                        push @tag_ids, $_->id foreach @more;
                    }
                }
                @tag_ids = ( 0 ) unless @tags;
                $args->{'join'} = MT::ObjectTag->join_on('object_id',
                    { tag_id => \@tag_ids, object_datasource => $class->datasource }, { unique => 1 } );
            } elsif (!exists ($terms->{$filter_col})) {
                $terms->{$filter_col} = $val;
            }
            $param->{filter} = $filter_col;
            $param->{filter_val} = $val;
            my $url_val = encode_url($val);
            $param->{filter_args} = "&filter=$filter_col&filter_val=$url_val";
            $param->{"filter_col_$filter_col"} = 1;
        }

        # automagic blog scoping
        my $blog = $app->blog;
        if ($blog) {
            # In blog context, class defines blog_id as a column,
            # so restrict listing to active blog:
            if ($class->column_def('blog_id')) {
                $terms->{blog_id} ||= $blog->id;
            }
        }

        my $iter = $class->$iter_method($terms, $args)
            or return $app->error($class->errstr);
        my @data;
        while (my $obj = $iter->()) {
            my $row = $obj->column_values();
            $hasher->($obj, $row) if $hasher;
            push @data, $row;
            last if scalar @data == $limit;
        }

        $param->{object_loop} = \@data;
        $param->{object_type} = $type;

        # handle pagination
        my $pager = {
            offset => $offset,
            limit => $limit,
            rows => scalar @data,
            listTotal => $class->count($terms, $args),
            chronological => $param->{list_noncron} ? 0 : 1,
            return_args => $app->make_return_args,
        };
        require JSON;
        $param->{pager_json} = $json ? $pager : JSON::objToJson($pager);
        # pager.rows (number of rows shown)
        # pager.listTotal (total number of rows in datasource)
        # pager.offset (offset currently used)
        # pager.chronological (boolean, whether the listing is chronological or not)
    }

    my $plural = $type;
    # entry -> entries; user -> users
    if ($type =~ m/y$/) {
        $plural =~ s/y$/ies/;
    } else {
        $plural .= 's';
    }
    $param->{object_type_plural} = $app->translate($plural);
    if ($app->user->is_superuser()) {
        $param->{is_superuser} = 1;
    }

    my $plugin_actions = $app->plugin_itemset_actions($type);
    $param->{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions($type);
    $param->{core_itemset_action_loop} = $core_actions || [];
    $param->{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;

    if ($json) {
        my $html = $app->build_page($tmpl, $param);
        my $data = {
            html => $html,
            pager => $param->{pager_json},
        };
        $app->send_http_header("text/javascript+json");
        require JSON;
        $app->print(JSON::objToJson($data));
        $app->{no_print_body} = 1;
    } else {
        $no_html ? $param : $app->build_page($tmpl, $param);
    }
}

sub list_assets {
    my $app = shift;

    my $blog_id = $app->param('blog_id');
    my $blog;
    if ($blog_id) {
        $blog = MT::Blog->load($blog_id)
            or return $app->errtrans("Invalid request.");
        return $app->errtrans("Permission denied.")
            unless $app->user->is_superuser || $app->{perms}->role_mask;
    }

    require MT::Asset;
    my %terms;
    my %args = ( sort => 'created_on', direction => 'descend' );

    my $class_filter;
    my $filter = ($app->param('filter') || '');
    if ($filter eq 'class') {
        $class_filter = $app->param('filter_val');
    }

    $app->add_breadcrumb($app->translate("Assets"));
    if ($blog_id) {
        $terms{blog_id} = $blog_id;
    } else {
        unless ($app->user->is_superuser) {
            $args{join} = MT::Permission->join_on('blog_id', {
                author_id => $app->user->id,
            });
        }
    }

    my %blogs;
    require File::Basename;
    require JSON;
    my $auth_prefs = $app->user->entry_prefs;
    my $tag_delim = chr($auth_prefs->{tag_delim});

    my $hasher = sub {
        my ($obj, $row) = @_;
        my $blog;
        unless ($blog_id) {
            $blog = $blogs{$obj->blog_id} ||= MT::Blog->load($obj->blog_id, { cached_ok => 1 });
        } else {
            $blog = $app->blog;
        }
        $row->{blog_name} = $blog ? $blog->name : '-';
        $row->{file_name} = File::Basename::basename($row->{file_path});
        my $meta = $obj->metadata;
        if (-f $row->{file_path}) {
            my @stat = stat($row->{file_path});
            my $size = $stat[7];
            $row->{thumbnail_url} = $meta->{thumbnail_url} =
                $obj->thumbnail_url(Height => 230, Width => 164);
            $row->{asset_class} = $obj->class_label;
            $row->{file_size} = $size;
            if ($size < 1024) {
            } elsif ($size < 1024000) {
                $row->{file_size_formatted} = sprintf("%.1f KB", $size / 1024);
            } else {
                $row->{file_size_formatted} = sprintf("%.1f MB", $size / 1024000);
            }
            my $ts = $obj->created_on;
            unless ($ts) {
                $ts = $stat[10];
                $ts = epoch2ts($blog, $ts);
            }
            if (my $by = $obj->created_by) {
                my $user = MT::Author->load($by, { cached_ok => 1 });
                $row->{created_by} = $user ? $user->name : '';
            }
            if ($ts) {
                $row->{created_on_formatted} =
                    format_ts("%Y.%m.%d", $ts); 
                $row->{created_on_time_formatted} =
                    format_ts("%Y-%m-%d %H:%M:%S", $ts); 
                $row->{created_on_relative} =
                    relative_date($ts, time, $blog);
            }
        } else {
            $row->{file_is_missing} = 1;
        }
        $row->{metadata_json} = JSON::objToJson($meta);
    };

    if ($class_filter) {
        my $asset_pkg = MT::Asset->class_handler($class_filter);
        $terms{class} = $asset_pkg->classes;
    }

    # identifier => name
    my $classes = MT::Asset->class_labels;
    my @class_loop;
    foreach my $class (keys %$classes) {
        push @class_loop, {
            class_id => $class,
            class_label => $classes->{$class},
        };
    }
    # Now, sort it
    @class_loop = sort { $a->{class_label} cmp $b->{class_label} } @class_loop;

    $app->listing({
        Terms => \%terms,
        Args => \%args,
        Type => 'asset',
        Code => $hasher,
        Template => $app->param('dialog_view') ? 'dialog_list_assets.tmpl' : '',
        Params => {
            ($blog ? (
                blog_id => $blog_id,
                blog_name => $blog->name || '',
                edit_blog_id => $blog_id,
                edit_field => $app->param('edit_field') || '',
                dialog_view => ($app->param('dialog_view') ? 1 : 0),
            ) : ()),
            class_loop => \@class_loop,
            can_delete_files => ($blog ? $app->{perms}->can_edit_assets : $app->user->is_superuser),
            nav_assets => 1,
        },
    });
}

sub list_roles {
    my $app = shift;
    my $author_id = $app->param('author_id');

    my $pref = $app->list_pref('role');
    my $all_perms;
    if ($pref->{view_expanded}) {
        my @all_perms = @{ MT::Permission->perms() };
        $all_perms = [ @all_perms ];
        foreach (@$all_perms) {
            $_->[2] = $app->translate($_->[2]);
        }
    }

    if ($author_id) {
        unless ($app->user->is_superuser || ($app->user->id == $author_id)) {
            return $app->errtrans("Permission denied.");
        }
        require MT::Author;
        require MT::Role;
        require MT::Association;
        my $user = MT::Author->load($author_id)
            or return $app->error($app->translate("Invalid user id"));
        $app->add_breadcrumb($app->translate("Users"),
            $app->user->is_superuser ? $app->uri(mode => 'list_authors',
                      args => { author_id => $author_id }) : undef);
        $app->add_breadcrumb($app->translate("User Roles"));
        my $hasher = sub {
            my ($obj, $param) = @_;
            my $role = $obj->role;
            $param->{name} = $role->name;
            my $blog = $obj->blog;
            $param->{blog_name} = $blog ? $blog->name : '-';

            # populate permissions for the expanded view
            if ($pref->{view_expanded}) {
                my @perms;
                foreach (@$all_perms) {
                    next unless length($_->[2] || '');
                    push @perms, { name => $_->[2] } if $obj->has($_->[1]);
                }
                $param->{perm_loop} = \@perms;
            }
        };
        $app->listing({
            Args => { sort => 'name' },
            Type => 'association',
            Template => 'list_role.tmpl',
            Terms => {
                type => MT::Association::USER_BLOG_ROLE(),
                author_id => $author_id
            },
            Code => $hasher,
            Params => {
                nav_authors => 1,
                edit_author_name => $user->name,
                edit_author_id => $author_id,
                list_noncron => 1,
                can_create_role => $app->user->is_superuser,
                has_expanded_mode => 1,
            },
        });
    } else {
        require MT::Association;
        my $hasher = sub {
            my ($obj, $row) = @_;
            my $user_count = MT::Association->count({
                role_id => $obj->id,
                author_id => [1, undef],
            }, {
                unique => 'author_id',
                range_incl => { author_id => 1 },
            });
            $row->{members} = $user_count;
            $row->{weblogs} = MT::Association->count({
                role_id => $obj->id,
                blog_id => [1, undef],
            }, {
                unique => 'blog_id',
                range_incl => { blog_id => 1 },
            });
            if ($obj->created_by) {
                my $user = MT::Author->load($obj->created_by, { cached_ok => 1 });
                $row->{created_by} = $user ? $user->name : '';
            } else {
                $row->{created_by} = '';
            }

            # populate permissions for the expanded view
            if ($pref->{view_expanded}) {
                my @perms;
                foreach (@$all_perms) {
                    next unless length($_->[2] || '');
                    push @perms, { name => $_->[2] } if $obj->has($_->[1]);
                }
                $row->{perm_loop} = \@perms;
            }
        };
        unless ($app->user->is_superuser()) {
            return $app->errtrans("Permission denied.");
        }
        $app->add_breadcrumb($app->translate("Roles"));
        $app->listing({
            Args => { sort => 'name' },
            Type => 'role',
            Code => $hasher,
            Params => {
                nav_privileges => 1,
                list_noncron => 1,
                can_create_role => $app->user->is_superuser,
                has_expanded_mode => 1,
            },
        });
    }
}

sub list_associations {
    my $app = shift;

    my $blog_id = $app->param('blog_id');
    my $author_id = $app->param('author_id');
    my $role_id = $app->param('role_id');

    my $this_user = $app->user;
    if (!$this_user->is_superuser) {
        if ((!$blog_id || !$this_user->permissions($blog_id)->can_administer_blog) &&
            (!$author_id || ($author_id != $this_user->id))) {
            return $app->errtrans("Permission denied.")
        }
    }

    my ($user, $role);
    if ($author_id) {
        $user = MT::Author->load($author_id, { cached_ok => 1 });
        $app->add_breadcrumb($app->translate('Users'),
            $app->user->is_superuser ? $app->uri(mode => 'list_authors')
                                     : undef);
        $app->add_breadcrumb($user->name,
            $app->uri(mode => 'view', args => { _type => 'author', id => $author_id })
        );
        $app->add_breadcrumb($app->translate('User Associations'));
    }
    if ($role_id) {
        require MT::Role;
        $role = MT::Role->load($role_id, { cached_ok => 1 });
        $app->add_breadcrumb($app->translate("Roles"),
            $app->uri(mode => "list_roles"));
        $app->add_breadcrumb($role->name,
            $app->uri(mode => 'edit_role', args => { _type => 'role', id => $role_id })
        );
        $app->add_breadcrumb($app->translate("Role Users"));
    }
    if (!$role_id && !$author_id) {
        if ($blog_id) {
            $app->add_breadcrumb($app->translate("Users"));
        } else {
            $app->add_breadcrumb($app->translate("Associations"));
        }
    }

    my $pref = $app->list_pref('association');
    my $all_perms;
    if ($pref->{view_expanded}) {
        my @all_perms = @{ MT::Permission->perms() };
        $all_perms = [ @all_perms ];
        foreach (@$all_perms) {
            $_->[2] = $app->translate($_->[2]);
        }
    }

    # Supplies additional parameters for the row being listed
    my %users;
    $users{$this_user->id} = $this_user;
    my $hasher = sub {
        my ($obj, $row) = @_;
        if (my $user = $obj->user) {
            $row->{user_id} = $user->id;
            $row->{user_name} = $user->name;
        }
        if (my $role = $obj->role) {
            $row->{role_name} = $role->name;
            # populate permissions for the expanded view
            if ($pref->{view_expanded}) {
                my @perms;
                foreach (@$all_perms) {
                    next unless length($_->[2] || '');
                    push @perms, { name => $_->[2] } if $role->has($_->[1]);
                }
                $row->{perm_loop} = \@perms;
            }
        } else {
            $row->{role_name} = $app->translate("(Custom)");
        }
        if (my $blog = $obj->blog) {
            $row->{blog_name} = $blog->name;
        }
        if (my $ts = $obj->created_on) {
            $row->{created_on_formatted} =
                format_ts("%Y.%m.%d", $ts); 
            $row->{created_on_time_formatted} =
                format_ts("%Y-%m-%d %H:%M:%S", $ts); 
            $row->{created_on_relative} =
                relative_date($ts, time, $obj->blog);
        }
        if ($row->{created_by}) {
            my $created_user = $users{$row->{created_by}} ||= MT::Author->load($row->{created_by});
            if ($created_user) {
                $row->{created_by} = $created_user->name;
            } else {
                $row->{created_by} = $app->translate('(user deleted)');
            }
        }
    };
    require MT::Association;
    my $types;
    if (!$author_id && !$blog_id) {
        $types = [ MT::Association::USER_BLOG_ROLE(),
                   MT::Association::USER_ROLE() ];
    } elsif (!$author_id) {
        $types = [ MT::Association::USER_BLOG_ROLE() ];
    } elsif ($author_id) {
        $types = [ MT::Association::USER_BLOG_ROLE(),
                   MT::Association::USER_ROLE() ];
    }
    $app->listing({
        Args => { sort => 'created_on', direction => 'descend' },
        Type => 'association',
        Code => $hasher,
        Terms => {
            type => $types,
            $author_id ? (author_id => $author_id) : (),
            $blog_id ? (blog_id => $blog_id) : (),
            $role_id ? (role_id => $role_id) : (),
        },
        Params => {
            can_create_association => $app->user->is_superuser
                || ($blog_id && $app->user->permissions($blog_id)->can_administer_blog),
            has_expanded_mode => 1,
            nav_privileges => ($author_id || $blog_id ? 0 : 1) || $role_id,
            nav_authors => ($author_id || $blog_id ? 1 : 0) && !$role_id,
            blog_view => $blog_id ? 1 : 0,
            user_view => $author_id ? 1 : 0,
            role_view => $role_id ? 1 : 0,
            $role_id ? (
                role_id => $role_id,
                role_name => $role->name,
            ) : (),
            $author_id ? (
                edit_author_id => $author_id,
                edit_author_name => $user->name,
                status_enabled => $user->is_active ? 1 : 0,
            ) : (),
            saved => $app->param('saved') || 0,
            saved_deleted => $app->param('saved_deleted') || 0,
            association_view => !$author_id && !$role_id,
            blog_id => $blog_id,
        },
    });
}

sub list_tags {
    my $app = shift;
    my %param;
    my $type = $app->param('_type') || 'entry';
    my $plural;
    $param{TagObjectType} = $type;
    $param{Package} = $API{$type};

    if (!$app->blog && !$app->user->is_superuser) {
        return $app->error($app->translate("No permissions"));
    }

    # FIXME
    if ($type =~ m/y$/) {
        $plural = $type;
        $plural =~ s/y$/ies/;
    } else {
        $plural = $type . 's';
    }
    $plural =~ s/(.*)/\u$1/;

    $param{TagObjectTypePlural} = $plural;
    $app->_load_driver_for($type) or return;
    unless (UNIVERSAL::can($param{Package}, 'tag_count')) {
        return $app->errtrans("Invalid type");
    }
    $app->list_tags_for(%param);
}

sub list_tags_for {
    my $app = shift;
    my (%params) = @_;

    my $pkg = $params{Package};

    my $q = $app->param;
    my $blog_id = $app->param('blog_id');
    my $list_pref = $app->list_pref('tag');
    my %param = %$list_pref;

    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;

    my (%terms, %arg);

    require MT::Tag;
    require MT::ObjectTag;
    my $total = $pkg->tag_count($blog_id ? { blog_id => $blog_id } : undef) || 0;

    $arg{'sort'} = 'name';
    $arg{limit} = $limit + 1;
    if ($offset > $total - 1) {
        $arg{offset} = $offset = $total - $limit;
    } elsif ($offset < 0) {
        $arg{offset} = $offset = 0;
    } else {
        $arg{offset} = $offset if $offset;
    }
    $arg{join} = MT::ObjectTag->join_on('tag_id', { object_datasource => $pkg->datasource, ($blog_id ? (blog_id => $blog_id) : ())}, { unique => 1 });

    my $data = $app->build_tag_table( load_args => [ \%terms, \%arg ],
        'package' => $pkg, param => \%param );
    delete $param{tag_table} unless @$data;

    ## We tried to load $limit + 1 entries above; if we actually got
    ## $limit + 1 back, we know we have another page of entries.
    my $have_next_entry = @$data > $limit;
    pop @$data while @$data > $limit;
    if ($offset) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
     }
    if ($have_next_entry) {
        $param{next_offset} = 1;
        $param{next_offset_val} = $offset + $limit;
    }

    $param{limit} = $limit;
    $param{offset} = $offset;
    $param{tag_object_type} = $params{TagObjectType};
    $param{tag_object_type_plural} = $app->translate($params{TagObjectTypePlural});
    $param{object_type} = 'tag';
    $param{object_type_plural} = $app->translate('tags');
    $param{list_start} = $offset + 1;
    $param{list_end} = $offset + scalar @$data;
    $param{list_total} = $total;
    $param{next_max} = $param{list_total} - $limit;
    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    $param{list_noncron} = 1;

    $param{saved} = $q->param('saved');
    $param{saved_deleted} = $q->param('saved_deleted');
    $param{nav_tags} = 1;
    $app->add_breadcrumb($app->translate('Tags'));

    $app->build_page('list_tags.tmpl', \%param);
}

sub rename_tag {
    my $app = shift;
    my $perms = $app->{perms};
    my $blog_id = $app->blog->id if $app->blog;
    ($blog_id && $perms && $perms->can_edit_tags) || ($app->user->is_superuser())
        or return $app->errtrans("Permission denied.");
    my $id = $app->param('id');
    my $name = $app->param('tag_name');
    require MT::Tag;
    require MT::ObjectTag;
    my $tag = MT::Tag->load($id)
        or return $app->error($app->translate("No such tag"));
    my $tag2 = MT::Tag->load({name => $name}, { binary => { name => 1 }});
    if ($tag2) {
        return $app->call_return if $tag->id == $tag2->id;
    }

    my $terms = { tag_id => $tag->id };
    $terms->{blog_id} = $blog_id if $blog_id;
    my $iter = MT::Entry->load_iter(undef, { join => MT::ObjectTag->join_on('object_id', $terms) });
    my @entries;
    while (my $entry = $iter->()) {
        $entry->remove_tags($tag->name);
        $entry->add_tags($name);
        push @entries, $entry;
    }
    $_->save foreach @entries;

    if ($tag2) {
        $app->add_return_arg(merged => 1);
    } else {
        $app->add_return_arg(renamed => 1);
    }
    $app->call_return;
}

sub build_tag_table {
    my $app = shift;
    my (%args) = @_;

    my $iter;
    if ($args{load_args}) {
        my $class = $app->_load_driver_for('tag');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { shift @{ $args{items} } };
    }
    return [] unless $iter;

    my $param = $args{param} || {};
    my $blog_id = $app->param('blog_id');
    my $pkg = $args{'package'};

    my @data;
    while (my $tag = $iter->()) {
        my $count = $pkg->tagged_count($tag->id, {($blog_id ? (blog_id => $blog_id) : ())});
        $count ||= 0;
        my $row = {
           tag_id => $tag->id,
           tag_name => $tag->name,
           tag_count => $count,
           object => $tag,
        };
        push @data, $row;
    }
    return [] unless @data;

    $param->{tag_table}[0]{object_loop} = \@data;
    $app->load_itemset_actions('tag', $param->{tag_table}[0]);
    \@data;
}

sub load_itemset_actions {
    my $app = shift;
    my ($type, $param, @p) = @_;
    my $plugin_actions = $app->plugin_itemset_actions($type, @p);
    $param->{plugin_itemset_action_loop} = $plugin_actions;
    my $core_actions = $app->core_itemset_actions($type, @p);
    $param->{core_itemset_action_loop} = $core_actions;
    $param->{has_itemset_actions} =
        (@$plugin_actions || @$core_actions) ? 1 : 0;
}

sub is_authorized {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    $app->{perms} = undef;
    return 1 unless $blog_id;
    return unless my $user = $app->user;
    require MT::Permission;
    my $perms = $app->{perms} = $user->permissions($blog_id);
    $perms ? 1 :
        $app->error($app->translate(
            "You are not authorized to log in to this blog."));
}

sub build_page {
    my $app = shift;
    my($page, $param) = @_;

    my $mode = $app->mode;
    $param->{mt_news} = $app->config('NewsURL');
    $param->{mt_support} = $app->config('SupportURL');
    my $lang = lc MT->current_language || 'en_us';
    $param->{language_id} = ($lang !~ /en[_-]us/) ? $lang : '';
    $param->{mode} = $app->mode;
    if (my $perms = $app->{perms}) {
        $param->{can_post} = $perms->can_post;
        $param->{can_upload} = $perms->can_upload;
        $param->{can_edit_entries} =
            $perms->can_post || $perms->can_edit_all_posts;
        $param->{can_search_replace} = $perms->can_edit_all_posts;
        $param->{can_edit_templates} = $perms->can_edit_templates;
        $param->{can_edit_authors} = $perms->can_administer_blog;
        $param->{can_edit_config} = $perms->can_edit_config;
        $param->{can_edit_assets} = $perms->can_edit_assets;
        # FIXME: once we have edit_commenters permission
        $param->{can_access_assets} = $param->{can_edit_entries} || $param->{can_edit_assets};
        $param->{can_edit_commenters} = $perms->can_edit_config();
        $param->{can_rebuild} = $perms->can_rebuild;
        $param->{can_edit_categories} = $perms->can_edit_categories;
        $param->{can_edit_tags} = $perms->can_edit_tags;
        $param->{can_edit_notifications} = $perms->can_edit_notifications;
        $param->{has_manage_label} =
            $param->{can_edit_templates} || $perms->can_administer_blog ||
            $param->{can_edit_categories} || $param->{can_edit_config} ||
            $param->{can_edit_tags};
        $param->{has_posting_label} =
            $param->{can_post} || $param->{can_edit_entries} ||
            $param->{can_access_assets};
        $param->{has_community_label} =
            $param->{can_edit_entries} || $param->{can_edit_config} ||
            $perms->{can_edit_notifications};
        $param->{can_view_log} = $perms->can_view_blog_log;
    }
    my $blog_id = $app->param('blog_id');
    my $blog;
    require MT::Blog;
    if (my $auth = $app->user) {
        $param->{is_administrator} = $auth->is_superuser;
        $param->{can_create_blog} = $auth->can_create_blog;
        $param->{can_view_log} ||= $auth->can_view_log;
        $param->{author_id} = $auth->id;
        $param->{author_name} = $auth->name;
        require MT::Permission;
        my @perms = MT::Permission->load({ author_id => $auth->id });
        $param->{has_authors_button} = $auth->is_superuser ||
            grep { $_->can_administer_blog } @perms;
        my @blogs = MT::Blog->load(undef, { join => [ 'MT::Permission', 'blog_id', { author_id => $auth->id }, undef ] });
        my %blogs = map { $_->id => $_ } @blogs;
        $blog = $blogs{$blog_id} if $blog_id;
        my @data;
        for my $perms (@perms) {
            next unless $perms->role_mask;
            my $blog = $blogs{$perms->blog_id};
            next unless $blog;
            push @data, { top_blog_id => $blog->id,
                          top_blog_name => $blog->name };
            $data[-1]{top_blog_selected} = 1
                if $blog_id && ($blog->id == $blog_id);
        }
        @data = sort { $a->{top_blog_name} cmp $b->{top_blog_name} } @data;
        $param->{top_blog_loop} = \@data;
    }
    $blog ||= MT::Blog->load($blog_id, {cached_ok=>1}) if $blog_id;
    if ($blog_id && $page ne 'login.tmpl') {
        if ($blog) {
            $param->{blog_name} = $blog->name;
            $param->{blog_id} = $blog->id;
            $param->{blog_url} = $blog->site_url;
        } else {
            $app->error($app->translate("No such blog [_1]", $blog_id));
        }
    }
    if ($app->param('is_bm')) {
        $param->{is_bookmarklet} = 1;
    }
    if ($page ne 'login.tmpl') {
        if (ref $app eq 'MT::App::CMS') {
            $param->{system_overview_nav} = 1
                unless $blog_id ||
                exists $param->{system_overview_nav} ||
                $param->{no_breadcrumbs} ||
                $param->{is_bookmarklet};
            $param->{quick_search} = 1 unless defined $param->{quick_search};
        }
    }

    my $static_app_url = $app->static_path;
    $param->{help_url} = $app->config('HelpURL') || $static_app_url . 'docs/';

    $param->{show_ip_info} ||= $app->config('ShowIPInformation');
    $param->{agent_mozilla} = ($ENV{HTTP_USER_AGENT} || '') =~ /gecko/i;
    #$param->{have_tangent} = eval { require MT::Tangent; 1 } ? 1 : 0;
    my $type = $app->param('_type') || '';
    $param->{plugin_action_loop} ||= $app->plugin_actions($mode) || [];
    $param->{"mode_$mode" . ($type ? "_$type" : '')} = 1;
    $param->{return_args} ||= $app->make_return_args;
    if ($param->{system_overview_nav}) {
        unshift @{$app->{breadcrumbs}}, { bc_name => $app->translate("System Overview"),
                             bc_uri => $app->uri('mode' => 'admin') };
    } elsif ($blog) {
        unshift @{$app->{breadcrumbs}}, { bc_name => $blog->name,
                         bc_uri => $app->uri('mode' => 'menu', args => { blog_id => $blog->id})};
    }
    unshift @{$app->{breadcrumbs}}, { bc_name => $app->translate('Main Menu'),
                              bc_uri => $app->mt_uri };

    $app->SUPER::build_page($page, $param);
}

sub get_newsbox_content {
    my $app = shift;

    my $newsbox_url = $app->config('NewsboxURL');
    if ($newsbox_url && $newsbox_url ne 'disable') {
        my $NEWSCACHE_TIMEOUT = 60 * 60 * 24;
        require MT::Session;
        my ($news_object) = ("");
        my $retries = 0;
        $news_object = MT::Session->load({ id => 'NW' });
        if ($news_object &&
            ($news_object->start() < (time - $NEWSCACHE_TIMEOUT))) {
            $news_object->remove;
            $news_object = undef;
        }
        return encode_text($news_object->data(), 'utf-8', undef)
            if ($news_object);

        my $ua = $app->new_ua;
        return unless $ua;
        $ua->max_size(undef) if $ua->can('max_size');

        my $req = new HTTP::Request(GET => $newsbox_url);
        my $resp = $ua->request($req);
        return unless $resp->is_success();
        my $result = $resp->content();
        if ($result) {
            require MT::Sanitize;
            # allowed html
            my $spec = 'a href,* style class id,ul,li,div,span,br';
            $result = MT::Sanitize->sanitize($result, $spec);
            $news_object = MT::Session->new();
            $news_object->set_values({id => 'NW',
                                      kind => 'NW',
                                      start => time(),
                                      data => $result});
            $news_object->save();
            $result = encode_text($result, 'utf-8', undef);
        }
        return $result;
    }
}

sub make_blog_list {
    my $app = shift;
    my ($blogs) = @_;

    require MT::TBPing;
    require MT::Entry;
    require MT::Comment;
    my $author = $app->user;
    my $data;
    my $i;
    my @blog_ids;
    push @blog_ids, $_->id for @$blogs;
    my ($entry_count, $ping_count, $comment_count);
    my $can_edit_authors = 1 if $author->is_superuser;
    for my $blog (@$blogs) {
        my $blog_id = $blog->id;
        my $perms = $author->permissions($blog_id);
        my $row = {
            id => $blog->id,
            name => $blog->name,
            description => $blog->description,
            site_url => $blog->site_url
        };
        # we should use count by group here...
        $row->{num_entries} = ($entry_count ? $entry_count->{$blog_id} : $entry_count->{$blog_id} = MT::Entry->count({ blog_id => $blog_id })) || 0;
        $row->{num_comments} = ($comment_count ? $comment_count->{$blog_id} : $comment_count->{$blog_id} = MT::Comment->count({ blog_id => $blog_id, junk_status => [ 0, 1 ] })) || 0;
        $row->{num_pings} = ($ping_count ? $ping_count->{$blog_id} : $ping_count->{$blog_id} = MT::TBPing->count({ blog_id => $blog_id, junk_status => [ 0, 1 ] })) || 0;
        $row->{num_authors} = 0;
        # FIXME: this isn't efficient
        my $iter = MT::Permission->load_iter({
            blog_id => [0, $blog_id],
            role_mask => [ 2, undef ]
        }, {
            range_incl => { 'role_mask' => 1 }
        });
        while (my $p = $iter->()) {
            $row->{num_authors}++ if $p->can_post;
        }
        $row->{can_post} = $perms->can_post;
        $row->{can_edit_entries} = $perms->can_post|| $perms->can_edit_all_posts;
        $row->{can_edit_templates} = $perms->can_edit_templates;
        $row->{can_edit_config} = $perms->can_edit_config || $perms->can_administer_blog;
        $row->{can_administer_blog} = $perms->can_administer_blog;
        push @$data, $row;
    }
    $data;
}

sub build_blog_table {
    my $app = shift;
    my (%args) = @_;

    require MT::Blog;
    require MT::TBPing;
    require MT::Entry;
    require MT::Comment;

    my $iter;
    if ($args{load_args}) {
        my $class = $app->_load_driver_for('blog');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $param = $args{param};

    my $author = $app->user;
    my $can_edit_authors = $author->is_superuser;
    my @data;
    my $i;
    my ($entry_count, $ping_count, $comment_count);
    while (my $blog = $iter->()) {
        my $blog_id = $blog->id;
        my $row = {
            id => $blog->id,
            name => $blog->name,
            description => $blog->description,
            site_url => $blog->site_url
        };
        # we should use count by group here...
        $row->{num_entries} = ($entry_count ? $entry_count->{$blog_id} : $entry_count->{$blog_id} = MT::Entry->count({ blog_id => $blog_id })) || 0;
        $row->{num_comments} = ($comment_count ? $comment_count->{$blog_id} : $comment_count->{$blog_id} = MT::Comment->count({ blog_id => $blog_id, junk_status => [ 0, 1 ] })) || 0;
        $row->{num_pings} = ($ping_count ? $ping_count->{$blog_id} : $ping_count->{$blog_id} = MT::TBPing->count({ blog_id => $blog_id, junk_status => [ 0, 1 ] })) || 0;
        $row->{num_authors} = 0;
        # FIXME: This isn't efficient
        my $iter = MT::Permission->load_iter({
            blog_id => [0, $blog_id],
            role_mask => [ 2, undef ]
        }, {
            range_incl => { 'role_mask' => 1 }
        });
        while (my $p = $iter->()) {
            $row->{num_authors}++ if $p->can_post;
        }
        if ($author->is_superuser) {
            $row->{can_post} = 1;
            $row->{can_edit_entries} = 1;
            $row->{can_edit_templates} = 1;
            $row->{can_edit_config} = 1;
            $row->{can_administer_blog} = 1;
        } else {
            my $perms = $author->permissions($blog_id);
            $row->{can_post} = $perms->can_post;
            $row->{can_edit_entries} = $perms->can_post|| $perms->can_edit_all_posts;
            $row->{can_edit_templates} = $perms->can_edit_templates;
            $row->{can_edit_config} = $perms->can_edit_config || $perms->can_administer_blog;
            $row->{can_administer_blog} = $perms->can_administer_blog;
        }
        $row->{object} = $blog;
        push @data, $row;
    }

    if (@data) {
        $param->{blog_table}[0]{object_loop} = \@data;

        my $plugin_actions = $app->plugin_itemset_actions('blog');
        $param->{blog_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
        my $core_actions = $app->core_itemset_actions('blog');
        $param->{blog_table}[0]{core_itemset_action_loop} = $core_actions || [];
        $param->{blog_table}[0]{has_itemset_actions} =
            ($plugin_actions || $core_actions) ? 1 : 0;
        $param->{blog_table}[0]{plugin_action_loop} = $app->plugin_actions('system_list_blogs') || [];

        $param->{object_loop} = $param->{blog_table}[0]{object_loop};
    }

    \@data;
}

## Application methods

sub list_blogs {
    my $app = shift;
    my $q = $app->param;
    require MT::Blog;
    require MT::Permission;
    require MT::Entry;
    require MT::Comment;
    my $author = $app->user;
    my %args;
    my $list_pref = $app->list_pref('main_menu');
    if ($list_pref->{'sort'} eq 'name') {
        $args{'sort'} = 'name';
    } elsif ($list_pref->{'sort'} eq 'created') {
        $args{'sort'} = 'id';
    } elsif ($list_pref->{'sort'} eq 'updated') {
        $args{'sort'} = 'children_modified_on';
    }
    if ($list_pref->{'order'} eq 'descend') {
        $args{'direction'} = 'descend';
    }
    $args{join} = MT::Permission->join_on('blog_id',
                   { author_id => $author->id,
                     role_mask => [1, undef] }, # don't count those with mask 0
                   { range_incl => {role_mask => 1} });
    my @blogs = MT::Blog->load(undef, \%args);
    my %param = %$list_pref;
    my $i = 1;

    $param{blog_loop} = $app->make_blog_list(\@blogs);
    delete $param{blog_loop} unless ref $param{blog_loop};

    $param{can_create_blog} = $author->can_create_blog;
    $param{can_view_log} = $author->can_view_log;
    if ($param{blog_loop}) {
        $param{can_edit_entries} = grep { $_->{can_edit_entries} }
            @{$param{blog_loop}};
    } else {
        $param{can_edit_entries} = $author->is_superuser;
    }
    $param{can_edit_tags} = $author->is_superuser;
    $param{can_edit_authors} = $author->is_superuser;
    $param{saved_deleted} = $q->param('saved_deleted');
    if ($author->can_create_blog()) {
        $param{blog_count} = MT::Blog->count();
        $param{blog_count_plural} = $param{blog_count} != 1;
        $param{author_count} = MT::Author->count({type => AUTHOR, status => ACTIVE});
        $param{author_count_plural} = $param{author_count} != 1;
        $param{can_view_blog_count} = 1;
    }

    $param{news_html} = $app->get_newsbox_content()||'';
    $param{system_overview_nav} = 0;
    $param{quick_search} = 0;
    $param{no_breadcrumbs} = 1;
    $app->build_page('list_blog.tmpl', \%param);
}

sub list_pref {
    my $app = shift;
    my ($list) = @_;
    my $updating = $app->mode eq 'update_list_prefs';
    unless ($updating) {
        my $pref = $app->request("list_pref_$list");
        return $pref if defined $pref;
    }

    my $cookie = $app->cookie_val('mt_list_pref') || '';
    my $mode = $app->mode;
    # defaults:
    my $d = $app->config->DefaultListPrefs;
    my %default = map { $_ => lc $d->{$_} } keys %$d;
    my $list_pref;
    if ($list eq 'main_menu') {
        $list_pref = {
            'sort' => 'name',
            order => $default{SortOrder} || 'ascend',
            view => $default{Format} || 'compact',
            dates => $default{DateFormat} || 'relative',
        };
    } else {
        $list_pref = {
            rows => $default{Rows} || 20,
            view => $default{Format} || 'compact',
            bar => $default{Button} || 'above',
            dates => $default{DateFormat} || 'relative',
        };
    }
    my @list_prefs = split /;/, $cookie;
    my $new_cookie = '';
    foreach my $pref (@list_prefs) {
        my ($name, $prefs) = $pref =~ m/^(\w+):(.*)$/;
        next unless $name && $prefs;
        if ($name eq $list) {
            my @prefs = split /,/, $prefs;
            foreach (@prefs) {
                my ($k, $v) = split /=/;
                $list_pref->{$k} = $v if exists $list_pref->{$k};
            }
        } else {
            $new_cookie .= ($new_cookie ne '' ? ';' : '') . $pref;
        }
    }

    if ($updating) {
        my $updated = 0;
        if (my $limit = $app->param('limit')) {
            $limit = 20 if $limit eq 'none';
            $list_pref->{rows} = $limit > 0 ? $limit : 20;
            $updated = 1;
        }
        if (my $view = $app->param('verbosity')) {
            if ($view =~ m!^compact|expanded$!) {
                $list_pref->{view} = $view;
                $updated = 1;
            }
        }
        if (my $bar = $app->param('actions')) {
            if ($bar =~ m!^above|below|both$!) {
                $list_pref->{bar} = $bar;
                $updated = 1;
            }
        }
        if (my $ord = $app->param('order')) {
            if ($ord =~ m!^ascend|descend$!) {
                $list_pref->{order} = $ord;
                $updated = 1;
            }
        }
        if (my $sort = $app->param('sort')) {
            if ($sort =~ m!^name|created|updated$!) {
                $list_pref->{'sort'} = $sort;
                $updated = 1;
            }
        }
        if (my $dates = $app->param('dates')) {
            if ($dates =~ m!^relative|full$!) {
                $list_pref->{'dates'} = $dates;
                $updated = 1;
            }
        }

        if ($updated) {
            my @list_prefs;
            foreach (keys %$list_pref) {
                push @list_prefs, $_ . '=' . $list_pref->{$_};
            }
            my $prefs = join ',', @list_prefs;
            $new_cookie .= ($new_cookie ne '' ? ';' : '') . $list . ':' . $prefs;
            $app->bake_cookie(-name => 'mt_list_pref', -value => $new_cookie,
                -expires => '+10y');
        }
    }

    if ($list_pref->{rows}) {
        $list_pref->{"limit_" . $list_pref->{rows}} = $list_pref->{rows};
    }
    if ($list_pref->{view}) {
        $list_pref->{"view_" . $list_pref->{view}} = 1;
    }
    if ($list_pref->{dates}) {
        $list_pref->{"dates_" . $list_pref->{dates}} = 1;
    }
    if ($list_pref->{bar}) {
        if ($list_pref->{bar} eq 'both') {
            $list_pref->{"position_actions_both"} = 1;
            $list_pref->{"position_actions_top"} = 1;
            $list_pref->{"position_actions_bottom"} = 1;
        } elsif ($list_pref->{bar} eq 'below') {
            $list_pref->{"position_actions_bottom"} = 1;
        } elsif ($list_pref->{bar} eq 'above') {
            $list_pref->{"position_actions_top"} = 1;
        }
    }
    if ($list_pref->{'sort'}) {
        $list_pref->{'sort_' . $list_pref->{'sort'}} = 1;
    }
    if ($list_pref->{'order'}) {
        $list_pref->{'order_' . $list_pref->{'order'}} = 1;
    }
    $app->request("list_pref_$list", $list_pref);
}

sub system_list_blogs {
    my $app = shift;
    my $author = $app->user;
    my $list_pref = $app->list_pref('blog');

    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    my $args = { offset => $offset, sort => 'name' };
    $args->{limit} = $limit + 1;
    unless ($author->is_superuser) {
        $args->{join} = MT::Permission->join_on('blog_id',
                         { author_id => $author->id }, { unique => 1 } );
    }
    require MT::Blog;
    my %param = %$list_pref;
    my @blogs = MT::Blog->load(undef, $args);
    my $can_edit_authors = $author->is_superuser;
    my $blog_loop = $app->make_blog_list(\@blogs);

    if ($blog_loop) {
        ## We tried to load $limit + 1 entries above; if we actually got
        ## $limit + 1 back, we know we have another page of entries.
        my $have_next = @$blog_loop > $limit;
        pop @$blog_loop while @$blog_loop > $limit;
        if ($offset) {
            $param{prev_offset} = 1;
            $param{prev_offset_val} = $offset - $limit;
            $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
        }
        if ($have_next) {
            $param{next_offset} = 1;
            $param{next_offset_val} = $offset + $limit;
        }
    }
    $param{object_type} = 'blog';
    $param{object_type_plural} = $app->translate('weblogs');
    $param{list_start} = $offset + 1;
    delete $args->{limit};
    delete $args->{offset};
    $param{list_total} = MT::Blog->count(undef, $args);
    $param{list_end} = $offset + ($blog_loop ? scalar @$blog_loop : 0);
    $param{next_max} = $param{list_total} - $limit;
    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    $param{can_create_blog} = $author->can_create_blog;
    $param{saved_deleted} = $app->param('saved_deleted');
    $param{nav_blogs} = 1;
    $param{list_noncron} = 1;

    if ($blog_loop) {
        $param{blog_table}[0]{object_loop} = $blog_loop;
        my $plugin_actions = $app->plugin_itemset_actions('blog');
        $param{blog_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
        my $core_actions = $app->core_itemset_actions('blog');
        $param{blog_table}[0]{core_itemset_action_loop} = $core_actions || [];
        $param{blog_table}[0]{has_itemset_actions} =
            ($plugin_actions || $core_actions) ? 1 : 0;
    }

    $param{feed_name} = $app->translate("Weblog Activity Feed");
    $param{feed_url} = $app->make_feed_link('blog');
    $app->add_breadcrumb($app->translate("Weblogs"));
    $param{nav_weblogs} = 1;
    $app->build_page('system_list_blog.tmpl', \%param)
}

sub list_authors {
    my $app = shift;
    my $this_author = $app->user;
    return $app->errtrans("Permission denied.")
        unless $this_author->is_superuser();
    my $this_author_id = $this_author->id;
    my $list_pref = $app->list_pref('author');
    my %param = %$list_pref;
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    my $args = { offset => $offset, sort => 'name' };
    $args->{limit} = $limit + 1;
    my %author_entry_count;
    $param{tab_users} = 1;
    my ($filter_col, $val, $group_id, $group);
    $param{filter_args} = "";
    my %terms = ( type => MT::Author::AUTHOR() );
    if (($filter_col = $app->param('filter'))
        && ($val = $app->param('filter_val')))
    {
        if (!exists ($terms{$filter_col})) {
            $terms{$filter_col} = $val;
            $param{filter} = $filter_col;
            $param{filter_val} = $val;
            my $url_val = encode_url($val);
            $param{filter_args} = "&filter=$filter_col&filter_val=$url_val";
        }
    }
    $param{can_create_user} = $this_author->is_superuser;
    $param{external_user_management} = $app->config->ExternalUserManagement;
    $param{synchronized} = 1 if $app->param('synchronized');
    $param{error} = 1 if $app->param('error');
    my $author_iter = MT::Author->load_iter(\%terms, $args);
    my (@data, %authors, %entry_count_refs);
    require MT::Entry;
    while (my $au = $author_iter->()) {
        my $row = $au->column_values;
        $row->{name} = '(unnamed)' if !$row->{name};
        $authors{$au->id} ||= $au;
        $row->{id} = $au->id;
        $row->{email} = '' unless (!defined $au->email) or ($au->email =~ /@/);
        $row->{entry_count} = 0;
        $entry_count_refs{$au->id} = \$row->{entry_count};
        $row->{is_me} = $au->id == $this_author_id;
        $row->{has_edit_access} = $this_author->is_superuser;
        $row->{status_enabled} = $au->is_active;
        if ($row->{created_by}) {
            my $parent_author = $authors{$au->created_by} ||= MT::Author->load($au->created_by) if $au->created_by;
            if ($parent_author) {
                $row->{created_by} = $parent_author->name;
            } else {
                $row->{created_by} = $app->translate('(user deleted)');
            }
        }
        push @data, $row;
        last if scalar @data == $limit;
    }
    require MT::Entry;
    if (MT::Object->driver->can('count_group_by')) {
        # Berkeley DB users don't get the count of entries per user
        my $author_entry_count_iter = MT::Entry->count_group_by({
            author_id => [ keys %entry_count_refs ]
        }, {
            group => ['author_id']
        });
        while (my ($count, $author_id) = $author_entry_count_iter->()) {
            ${$entry_count_refs{$author_id}} = $count;
        }
    }
    $param{object_loop} = \@data;
    $param{object_type} = 'author';
    $param{object_type_plural} = $app->translate('users');
    if ($this_author->is_superuser()) {
        $param{search_type} = $app->translate('Users');
        $param{is_superuser} = 1;
    }

    $param{limit} = $limit;
    $param{list_start} = $offset + 1;
    delete $args->{limit}; delete $args->{offset};
    $param{list_total} = MT::Author->count(\%terms, $args);
    $param{list_end} = $offset + (scalar @data);
    $param{next_offset_val} = $offset + (scalar @data);
    $param{next_offset} = $param{next_offset_val} < $param{list_total} ? 1 : 0;
    $param{next_max} = $param{list_total} - $limit;
    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    if ($offset > 0) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
    }
    $param{list_noncron} = 1;
    $param{saved_deleted} = $app->param('saved_deleted');
    $param{saved_removed} = $app->param('saved_removed');
    $param{saved} = $app->param('saved');
    my $status = $app->param('saved_status');
    $param{"saved_status_$status"} = 1 if $status;
    $param{unchanged} = $app->param('unchanged');
    my $plugin_actions = $app->plugin_itemset_actions('author');
    $param{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('author');
    $param{core_itemset_action_loop} = $core_actions || [];
    $param{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;

    $app->add_breadcrumb($app->translate("Users"));
    $param{nav_authors} = 1;
    $app->build_page('list_author.tmpl', \%param)
}

sub bookmarklets {
    my $app = shift;
    $app->add_breadcrumb($app->translate('QuickPost'));
    $app->build_page('bookmarklets.tmpl');
}

sub make_feed_link {
    my $app = shift;
    my ($view, $params) = @_;
    my $user = $app->user;
    return if ($user->api_password || '') eq '';

    $params ||= {};
    $params->{view} = $view;
    $params->{username} = $user->name;
    $params->{token} = perl_sha1_digest_hex('feed:' . $user->api_password);
    $app->base . $app->mt_path . $app->config('ActivityFeedScript') . $app->uri_params(args => $params);
}

sub make_bm_link {
    my $app = shift;
    my %param = ( have_link => 1 );
    my @show = $app->param('show');
    my $height = 490;
    s/[^\w]//g foreach @show; # non-word chars could be harmful
    my %show = map { $_ => 1 } @show;
    $height += 50 if $show{t};  # trackback
    $height += 40 if $show{ac}; # allow comments
    $height += 20 if $show{ap}; # allow pings
    $height += 40 if $show{cb}; # convert breaks
    $height += 20 if $show{c}; # category
    $height += 80 if $show{e}; # excerpt
    $height += 80 if $show{k}; # keywords
    $height += 80 if $show{'m'}; # more text
    $height += 20 if $show{tg}; # tags
    $param{bm_show} = join ',', @show;
    $param{bm_height} = $height;
    $param{bm_js} = $app->_bm_js($param{bm_show}, $height);
    $app->add_breadcrumb($app->translate('QuickPost'));
    $app->build_page('bookmarklets.tmpl', \%param);
}

sub build_author_table {
    my $app = shift;
    my (%args) = @_;

    my $i = 1;
    my @author;
    my $iter;
    if ($args{load_args}) { 
        my $class = $app->_load_driver_for('author');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $param = $args{param};
    $param->{has_edit_access} = $app->user->is_superuser();
    $param->{is_administrator} = $app->user->is_superuser();
    my (%blogs, %entry_count_refs);
    while (my $author = $iter->()) {
        my $row = { author_name => $author->name, author_nickname => $author->nickname,
                    author_email => $author->email, author_url => $author->url,
                    author_created_by => $author->email, author_url => $author->url,
                    status_enabled => $author->is_active,
                    id => $author->id, entry_count => 0,
                    is_me => ($app->user->id == $author->id ? 1 : 0) };
        $entry_count_refs{$author->id} = \$row->{entry_count};
        $row->{object} = $author;
        push @author, $row;
    }
    return [] unless @author;
    require MT::Entry;
    if (MT::Object->driver->can('count_group_by')) {
        my $author_entry_count_iter = MT::Entry->count_group_by({
            author_id => [ keys %entry_count_refs ]
        }, {
            group => ['author_id']
        });
        while (my ($count, $author_id) = $author_entry_count_iter->()) {
            ${$entry_count_refs{$author_id}} = $count;
        }
    }
    $param->{author_table}[0]{object_loop} = \@author;

    my $plugin_actions = $app->plugin_itemset_actions('author');
    $param->{author_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('author');
    $param->{author_table}[0]{core_itemset_action_loop} = $core_actions || [];
    $param->{author_table}[0]{has_itemset_actions} =
        ($plugin_actions || $core_actions) ? 1 : 0;
    $param->{author_table}[0]{plugin_action_loop} = $app->plugin_actions('list_authors') || [];
    $param->{object_loop} = $param->{author_table}[0]{object_loop};

    \@author;
}

sub _bm_js {
    my $app = shift;
    my($show, $height) = @_;
    my %args = (is_bm => 1, bm_show => $show, '_type' => 'entry');
    my $uri = $app->base . $app->uri('mode' => 'view', args => \%args);
    qq!javascript:d=document;w=window;t='';if(d.selection)t=d.selection.createRange().text;else{if(d.getSelection)t=d.getSelection();else{if(w.getSelection)t=w.getSelection()}}void(w.open('$uri&link_title='+escape(d.title)+'&link_href='+escape(d.location.href)+'&text='+escape(t),'_blank','scrollbars=yes,width=400,height=$height,status=yes,resizable=yes'))!;
}

sub apply_log_filter {
    my $app = shift;
    my ($param) = @_;
    my %arg;
    if ($param) {
        my $filter_col = $param->{filter};
        my $val = $param->{filter_val};
        if ($filter_col && $val) {
            if ($filter_col eq 'level') {
                my @types;
                for (1,2,4,8,16) {
                    push @types, $_ if $val & $_;
                }
                if (@types) {
                    $arg{'level'} = \@types;
                }
            } elsif ($filter_col eq 'class') {
                $arg{class} = [ split /,/, $val ];
            }
        }
        $arg{blog_id} = [ split /,/, $param->{blog_id} ]
            if $param->{blog_id};
    }
    \%arg;
}

sub view_log {
    my $app = shift;
    my $author = $app->user;
    my $blog_id = $app->param('blog_id');
    if ($blog_id) {
        return $app->error($app->translate("Permission denied."))
            unless $app->{perms}->can_view_blog_log || $author->can_view_log;
    } else {
        return $app->error($app->translate("Permission denied."))
            unless $author->can_view_log;
    }
    require MT::Log;
    my $list_pref = $app->list_pref('log');
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    my $terms = { $blog_id ? (blog_id => $blog_id) : () };
    my $cfg = $app->config;
    my %param = ( %$list_pref );
    my ($filter_col, $val);
    $param{filter_args} = "";
    if (($filter_col = $app->param('filter'))
        && ($val = $app->param('filter_val')))
    {
        $param{filter} = $filter_col;
        $param{filter_val} = $val;
        my %filter_arg = %{ $app->apply_log_filter( \%param ) };
        $terms->{$_} = $filter_arg{$_} foreach keys %filter_arg;
        my $url_val = encode_url($val);
        $param{filter_args} = "&filter=$filter_col&filter_val=$url_val";
    }
    my $iter = MT::Log->load_iter($terms,
        { ($cfg->ObjectDriver ne 'DBM' ?  # work around a flaw in DBM driver
           ('sort' => 'id') :
           ('sort' => 'created_on')),
           'direction' => 'descend',
          'offset' => $offset,
          'limit' => $limit });

    my @class_loop;
    foreach (keys %MT::Log::Classes) {
        push @class_loop, {
            class_name => $_,
            class_label => $MT::Log::Classes{$_}->class_label,
        };
    }
    push @class_loop, {
        class_name => 'comment,ping',
        class_label => $app->translate("All Feedback"),
    }, {
        class_name => 'search',
        class_label => $app->translate("Search"),
    };
    @class_loop = sort { $a->{class_label} cmp $b->{class_label} } @class_loop;
    $param{class_loop} = \@class_loop;

    my $log = $app->build_log_table(iter => $iter, param => \%param);
    my $blog = MT::Blog->load($blog_id, { cached_ok => 1 }) if $blog_id;
    my ($so);
    if ($blog) {
        $so = $blog->server_offset;
    } else {
        $so = $app->config('TimeOffset');
    }
    if ($so) {
        my $partial_hour_offset = 60 * abs($so - int($so));
        my $tz = sprintf("%s%02d:%02d", $so < 0 ? '-' : '+',
            abs($so), $partial_hour_offset);
        $param{time_offset} = $tz;
    }
    $param{object_type} = 'log';
    $param{object_type_plural} = $app->translate('log records');
    $param{search_type} = $app->translate('Activity Log');
    $param{list_start} = $offset + 1;
    $param{list_total} = MT::Log->count($terms);
    $param{list_end} = $offset + (scalar @$log);
    $param{offset} = $offset;
    $param{next_offset_val} = $offset + (scalar @$log);
    $param{next_offset} = $param{next_offset_val} < $param{list_total} ? 1 : 0;
    $param{next_max} = $param{list_total} - $limit;
    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    if ($offset > 0) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
    }
    $param{'reset'} = $app->param('reset');
    $param{nav_log} = 1;
    $param{feed_name} = $app->translate("System Activity Feed");
    $param{feed_url} = $app->make_feed_link('system', $blog_id ? { blog_id => $blog_id } : undef);
    if ($param{feed_url} && $param{filter_args}) {
        $param{feed_url} .= $param{filter_args};
    }
    $app->add_breadcrumb($app->translate('Activity Log'));
    unless ($app->param('blog_id')) {
        $param{system_overview_nav} = 1;
    }
    $app->build_page('view_log.tmpl', \%param);
}

sub build_log_table {
    my $app = shift;
    my (%args) = @_;

    my $blog = $app->blog;
    my $blog_view = $blog ? 1 : 0;
    my $i = 1;
    my @log;
    my $iter;
    if ($args{load_args}) { 
        my $class = $app->_load_driver_for('log');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $param = $args{param};
    my %blogs;
    while (my $log = $iter->()) {
        my $row = { log_message => $log->message, log_ip => $log->ip, id => $log->id };
        if (my $ts = $log->created_on) {
            if ($blog_view) {
                $row->{created_on_formatted} = format_ts("%Y.%m.%d %H:%M:%S",
                    epoch2ts($blog, ts2epoch(undef, $ts)));
            } else {
                $row->{created_on_formatted} = format_ts("%Y.%m.%d %H:%M:%S",
                    epoch2ts(undef, offset_time(ts2epoch(undef, $ts))));
                if ($log->blog_id) {
                    $blog = $blogs{$log->blog_id} ||= MT::Blog->load($log->blog_id, { cache_ok => 1 });
                    $row->{weblog_name} = $blog ? $blog->name : '';
                } else {
                    $row->{weblog_name} = '';
                }
            }
            $row->{created_on_relative} = relative_date($ts, time);
            $row->{log_detail} = $log->description;
        }
        push @log, $row;
    }
    return [] unless @log;
    $param->{log_table}[0]{object_loop} = \@log;
    \@log;
}

sub reset_log {
    my $app = shift;
    my $author = $app->user;
    return $app->error($app->translate("Permission denied."))
        unless $author->can_view_log;
    $app->validate_magic() or return;
    require MT::Log;
    if (my $blog_id = $app->param('blog_id')) {
        my $blog = MT::Blog->load($blog_id, { cache_ok => 1 });
        if (MT::Log->remove({ blog_id => $blog_id })) {
            $app->log({
                message => $app->translate("Activity log for blog '[_1]' (ID:[_2]) reset by '[_3]'", $blog->name, $blog_id, $author->name),
                level => MT::Log::INFO(),
                class => 'system',
                category => 'reset_log'
            });
        }
    } else {
        MT::Log->remove_all;
        $app->log({
            message => $app->translate("Activity log reset by '[_1]'", $author->name),
            level => MT::Log::INFO(),
            class => 'system',
            category => 'reset_log'
        });
    }
    $app->add_return_arg('reset' => 1);
    $app->call_return;
}

sub export_log {
    my $app = shift;
    my $author = $app->user;
    my $perms = $app->{perms};
    my $blog = $app->blog;
    my $blog_view = $blog ? 1 : 0;
    if ($blog_view) {
        return $app->error($app->translate("Permission denied."))
            unless $author->can_view_log || ($perms && $perms->can_view_blog_log);
    } else {
        return $app->error($app->translate("Permission denied."))
            unless $author->can_view_log;
    }
    $app->validate_magic() or return;
    $| = 1;
    my $enc = $app->config('ExportEncoding');
    $enc = $app->config('LogExportEncoding') if (!$enc);
    $enc = ($app->config('PublishCharset') || '') if (!$enc);

    my $q = $app->param;
    my $filter_args = $q->param('filter_args');
    my %terms;
    if ($filter_args) {
        $q->parse_params($filter_args) if $filter_args;
        %terms = %{ $app->apply_log_filter( { filter => $q->param('filter'),
            filter_val => $q->param('filter_val') } ) };
    }
    if ($blog) {
        $terms{blog_id} = $blog->id;
    }
    require MT::Log;
    my $iter = MT::Log->load_iter(\%terms, { 'sort' => 'created_on', 'direction' => 'ascend' });
    my %blogs;

    my $file = '';
    $file = dirify($blog->name) . '-' if $blog;
    $file = "Blog-" . $blog->id . '-' if $file eq '-';
    my @ts = gmtime(time);
    my $ts = sprintf "%04d-%02d-%02d-%02d-%02d-%02d",
        $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];
    $file .= "log_$ts.csv";
    $app->{no_print_body} = 1;
    $app->set_header("Content-Disposition" => "attachment; filename=$file");
    $app->send_http_header($enc ? "text/csv; charset=$enc"
                                : 'text/csv');

    my $csv = "timestamp,ip,weblog,message\n";
    while (my $log = $iter->()) {
        # columns:
        # date, ip address, weblog, log message
        my @col;
        my $ts = $log->created_on;
        if ($blog_view) {
            push @col, format_ts("%Y-%m-%d %H:%M:%S",
                epoch2ts($blog, ts2epoch(undef, $ts)));
        } else {
            push @col, format_ts("%Y-%m-%d %H:%M:%S", $log->created_on);
        }
        push @col, $log->ip;
        if ($log->blog_id) {
            my $blog = $blogs{$log->blog_id} ||= MT::Blog->load($log->blog_id, {cached_ok=>1});
            my $name = $blog->name;
            $name =~ s/"/\\"/gs;
            $name =~ s/[\r\n]+/ /gs;
            $name = encode_text($name, undef, $enc) if $enc;
            push @col, '"' . $name . '"';
        } else {
            push @col, '';
        }
        my $msg = $log->message;
        $msg = encode_text($msg, undef, $enc) if $enc;
        $msg =~ s/"/\\"/gs;
        $msg =~ s/[\r\n]+/ /gs;
        push @col, '"' . $msg . '"';
        $csv .= (join ',', @col) . "\n";
        $app->print($csv);
        $csv = '';
    }
}

sub start_import {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    my %param;
    require MT::Category;
    my $iter = MT::Category->load_iter({ blog_id => $blog_id });
    my @data;
    while (my $cat = $iter->()) {
        push @data, { category_id => $cat->id,
                      category_label => $cat->label };
    }
    @data = sort { $a->{category_label} cmp $b->{category_label} }
            @data;
    $param{category_loop} = \@data;
    $param{nav_import} = 1;
    #$param{can_edit_authors} = $app->{perms}->can_administer_blog;
    $param{encoding_names} = const('ENCODING_NAMES');
    $param{password_needed} = 1;
    $app->add_breadcrumb($app->translate('Import/Export'));
    $app->build_page('import.tmpl', \%param);
}

sub show_admin {
    my $app = shift;
    my %param;
    $param{nav_admin} = 1;

    # System Stats

    require MT::Blog;
    $param{blog_count} = MT::Blog->count();

    # active author count: someone who has logged in within 90 days
    require MT::Session;
    my $from = time - (60*60*24*90 + 60*60*24);
    MT::Session->remove({ kind => 'UA', start => [undef, $from] }, { range => { start => 1 }});
    $param{active_author_count} = MT::Session->count({ kind => 'UA' });

    require MT::Author;
    $param{author_count} = MT::Author->count( { type => MT::Author::AUTHOR(), status => MT::Author::ACTIVE() });

    require MT::Entry;
    $param{entry_count} = MT::Entry->count();

    require MT::Comment;
    $param{comment_count} = MT::Comment->count( { junk_status => [0, 1] });

    require MT::TBPing;
    $param{trackback_count} = MT::TBPing->count( { junk_status => [0, 1] });

    $param{nav_info} = 1;
    $param{news_html} = $app->get_newsbox_content()||'';
    $param{quick_search} = 0;
    my $lang = $app->current_language;
    $lang =~ s/[-_].+//;
    $param{"language_$lang"} = 1;
    $app->build_page('admin.tmpl', \%param);
}

sub show_status {
    my $app = shift;
    my %param;
    $param{nav_status} = 1;

    # System Stats

    require MT::Blog;
    $param{blog_count} = MT::Blog->count();

    # active author count: someone who has posted within 90 days
    require MT::Author;
    my $to = time;
    my $from = epoch2ts(undef, time - (60*60*24*90 + 1));
    $param{active_author_count} = MT::Author->count( { type => MT::Author::AUTHOR(), status => MT::Author::ACTIVE() },
        { join => MT::Entry->join_on('author_id', { created_on => [ $from, $to ] }, { unique => 1, range_incl => { created_on => 1 } } ) } );

    require MT::Author;
    $param{author_count} = MT::Author->count( { type => MT::Author::AUTHOR(), status => MT::Author::ACTIVE() });

    require MT::Entry;
    $param{entry_count} = MT::Entry->count();

    require MT::Comment;
    $param{comment_count} = MT::Comment->count( { junk_status => [0, 1] } );

    require MT::TBPing;
    $param{trackback_count} = MT::TBPing->count( { junk_status => [0, 1] } );

    $param{nav_info} = 1;
    $param{quick_search} = 0;
    $app->build_page('system_info.tmpl', \%param);
}

sub show_menu {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->errtrans("Permission denied.");
    require MT::Comment;
    require MT::TBPing;
    require MT::Trackback;
    require MT::Permission;
    require MT::Entry;
    my $blog_id = $app->param('blog_id');
    my $iter = MT::Entry->load_iter({ blog_id => $blog_id },
        { 'sort' => 'created_on',
          direction => 'descend',
          limit => 5 });
    my @e_data;
    my $i = 1;
    my $author_id = $app->user->id;
    while (my $entry = $iter->()) {
        my $row = { entry_id => $entry->id,
                    entry_blog_id => $entry->blog_id, };
        $row->{entry_title} = remove_html($entry->title);
        $row->{"status_" . MT::Entry::status_text($entry->status)} = 1;
        $row->{status_text} = MT::Entry::status_text($entry->status);
        my $max_len = const('DISPLAY_LENGTH_MENU_TITLE');
        if (defined($row->{entry_title}) && ($row->{entry_title} =~ m/\S/)) {
            $row->{entry_title} = substr_text($row->{entry_title}, 0, $max_len) . '...'
                if $row->{entry_title} && length_text($row->{entry_title}) > $max_len;
        } else {
            my $title = remove_html($entry->text);
            $row->{entry_title} = substr_text($title||"", 0, $max_len) . '...';
        }
        $row->{entry_created_on} = format_ts("%Y.%m.%d", $entry->created_on);
        $row->{has_edit_access} = $perms->can_edit_all_posts ||
            $entry->author_id == $author_id;
        push @e_data, $row;
    }
    $iter = MT::Comment->load_iter({ blog_id => $blog_id, junk_status => [ 0, 1 ] },
        { 'sort' => 'created_on',
          direction => 'descend',
          limit => 5 });
    my @c_data;
    $i = 1;
    my $max_len = const('DISPLAY_LENGTH_MENU_TITLE');
    while (my $comment = $iter->()) {
        my $row = { comment_id => $comment->id,
                    comment_author => $comment->author,
                    comment_blog_id => $comment->blog_id, };
        $row->{comment_author} = substr_text($row->{comment_author}, 0, $max_len) . '...'
            if $row->{comment_author} && length_text($row->{comment_author}) > $max_len;
        $row->{comment_created_on} = format_ts("%Y.%m.%d",
            $comment->created_on);
        $row->{visible} = $comment->visible();
        $row->{has_edit_access} = $perms->can_edit_all_posts ||
            (($_ = $comment->entry) && ($_->author_id == $author_id));
        push @c_data, $row;
    }
    $iter = MT::TBPing->load_iter({ blog_id => $blog_id, junk_status => [ 0, 1 ] },
        { 'sort' => 'created_on',
          direction => 'descend',
          limit => 5 });
    my @p_data;
    $i = 1;
    while (my $ping = $iter->()) {
        my $row = { ping_id => $ping->id,
                    ping_title => $ping->title || '[No title]',
                    ping_url => $ping->source_url,
                    ping_blog_id => $ping->blog_id, };
        # FIXME: trim this shorter.
        $row->{ping_title} = substr_text($row->{ping_title}, 0, $max_len) . '...'
            if length_text($row->{ping_title}) > $max_len;
        $row->{ping_created_on} = format_ts("%Y.%m.%d", $ping->created_on);
        $row->{visible} = $ping->visible();
        my $tb = MT::Trackback->load($ping->tb_id);
        if ($tb->entry_id) {
            my $entry = MT::Entry->load($tb->entry_id);
            $row->{has_edit_access} = $perms->can_edit_all_posts ||
                ($entry && $entry->author_id == $author_id);
            $row->{ping_entry_id} = $tb->entry_id;
        }
        push @p_data, $row;
    }
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    if (!$blog) {
        return $app->error($app->translate("Invalid blog id [_1].", $blog_id));
    }
    my %param = (entry_loop => \@e_data, comment_loop => \@c_data,
                 ping_loop => \@p_data);
    $param{plugin_action_loop} = $app->plugin_actions('blog') || [];
    $param{blog_description} = $blog->description;
    $param{welcome} = $blog->welcome_msg;
    $param{num_entries} = MT::Entry->count({ blog_id => $blog_id });
    $param{num_comments} = MT::Comment->count({ blog_id => $blog_id });
    $param{num_authors} = 0;
    $param{quick_search} = 0 unless $perms->can_post;
    $param{has_edit_access} = $perms->can_post || $perms->can_edit_all_posts;
    $param{feed_name} = $app->translate("Weblog Activity Feed");
    $param{feed_url} = $app->make_feed_link('blog', { blog_id => $blog_id });
    $iter = MT::Permission->load_iter({ blog_id => $blog_id, role_mask => [2, undef] }, { range_incl => { role_mask => 1 }});
    while (my $p = $iter->()) {
        $param{num_authors}++ if $p->can_post;
    }
    $app->build_page('menu.tmpl', \%param);
}

sub edit_object {
    my $app = shift;
    my %param = $_[0] ? %{ $_[0] } : ();
    my $q = $app->param;
    my $type = $q->param('_type');
    return unless $API{$type};
    my $blog_id = $q->param('blog_id');
    if (defined($blog_id) && $blog_id) {
        return $app->error($app->translate("Invalid parameter"))
            unless ($blog_id =~ m/\d+/);
    }
    my $id = $q->param('id');
    my $perms = $app->{perms};
    my $author = $app->user;
    my $cfg = $app->config;
    $param{styles} = '';
    return $app->errtrans("Permission denied.")
        if !$perms && $id && $type ne 'author';

    my $class = $app->_load_driver_for($type) or return;
    my $cols = $class->column_names;
    require MT::Promise;
    my $obj_promise = MT::Promise::delay(sub {
        return $class->load($id) || undef;
    });

    if (!$author->is_superuser) {
        MT->run_callbacks('CMSViewPermissionFilter.' . $type,
                          $app, $id, $obj_promise)
            || return $app->error($app->translate("Permission denied.")
                                  . MT->errstr());
    }
    my $obj;
    my $blog;
    require MT::Blog;
    if ($blog_id) {
        $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    }

    if ($id) {          # object exists, we're just editing it.
        # Stash the object itself so we don't have to keep forcing the promise
        $obj = $obj_promise->force() or
            return $app->error($app->translate("Load failed: [_1]",
                $class->errstr || $app->translate("(no reason given)")));
        # Populate the param hash with the object's own values
        for my $col (@$cols) {
            $param{$col} = defined $q->param($col) ?
                $q->param($col) : $obj->$col();
        }
        # Make certain any blog-specific element matches the blog we're
        # dealing with. If not, call shenanigans.
        if (defined($blog_id) && (exists $param{blog_id}) && ($blog_id != $obj->blog_id)) {
            return $app->error($app->translate("Invalid parameter"));
        }

        # Set type-specific display parameters
        if ($type eq 'entry') {
            $param{nav_entries} = 1;
            $param{entry_edit} = 1;
            $app->add_breadcrumb($app->translate('Entries'),
                                 $app->uri( 'mode' => 'list_entries',
                                     args => { blog_id => $blog_id }));
            $app->add_breadcrumb((!defined($obj->title) || $obj->title eq '') ? $app->translate('(untitled)') : $obj->title);
            ## Don't pass in author_id, because it will clash with the
            ## author_id parameter of the author currently logged in.
            delete $param{'author_id'};
            unless (defined $q->param('category_id')) {
                delete $param{'category_id'};
                if (my $cat = $obj->category) {
                    $param{category_id} = $cat->id;
                }
            }
            $blog_id = $obj->blog_id;
            my $status = $q->param('status') || $obj->status;
            $param{"status_" . MT::Entry::status_text($status)} = 1;
            $param{"allow_comments_" . ($q->param('allow_comments')
                                        || $obj->allow_comments || 0)} = 1;
            my $df = $q->param('created_on_manual') ||
                format_ts("%Y-%m-%d %H:%M:%S", $obj->created_on);
            $param{'created_on_formatted'} = $df;
            my $comments = $obj->comments;
            my @c_data;
            my $i = 1;
            @$comments = grep { $_->junk_status > -1 } @$comments;
            @$comments = sort { $a->created_on cmp $b->created_on }
                         @$comments;
            my $c_data = $app->build_comment_table( items => $comments, param => \%param );
            $param{num_comment_rows} = @$c_data + 3;
            $param{num_comments} = @$c_data;

            # Check permission to send notifications and if the
            # blog has notification list subscribers
            if ($perms->can_send_notifications && $obj->status == MT::Entry::RELEASE) {
                require MT::Notification;
                $param{can_send_notifications} = 1;                
                $param{has_subscribers} = MT::Notification->count({blog_id => $blog_id});
            }


            ## Load list of trackback pings sent for this entry.
            require MT::Trackback;
            require MT::TBPing;
            my $tb = MT::Trackback->load({ entry_id => $obj->id });
            my $tb_data;
            if ($tb) {
                my $iter = MT::TBPing->load_iter({ tb_id => $tb->id,
                    'junk_status' => [ 0, 1 ] },
                    { 'sort' => 'created_on',
                      direction => 'descend' });
                $tb_data = $app->build_ping_table( iter => $iter, param => \%param );
            } else {
                $tb_data = [];
            }
            $param{num_ping_rows} = @$tb_data + 3;
            $param{num_pings} = @$tb_data;

            $param{show_pings_tab} = @$tb_data || $obj->allow_pings;
            $param{show_comments_tab} = @$c_data || $obj->allow_comments;

            ## Load next and previous entries for next/previous links
            if (my $next = $obj->next) {
                $param{next_entry_id} = $next->id;
            }
            if (my $prev = $obj->previous) {
                $param{previous_entry_id} = $prev->id;
            }

            $param{has_any_pinged_urls} = ($obj->pinged_urls||'') =~ m/\S/;
            $param{ping_errors} = $q->param('ping_errors');
            $param{can_view_log} = $app->user->can_view_log;

            $param{"tab_" . ($app->param('tab') || 'entry')} = 1;
            $param{entry_permalink} = $obj->permalink;
            $param{'mode_view_entry'} = 1;
            $param{'basename_old'} = $obj->basename;

            my $plugin_actions = $app->plugin_itemset_actions($type);
            $param{plugin_itemset_action_loop} = $plugin_actions || [];
            # disabling for now since the existing core actions aren't terribly
            # useful on for edit entry screen.
            #my $core_actions = $app->core_itemset_actions($type);
            #$param{core_itemset_action_loop} = $core_actions
            #    if $core_actions;
            $param{has_itemset_actions} = scalar(@$plugin_actions) > 0 ? 1 : 0;
        } elsif ($type eq 'category') {
            $param{nav_categories} = 1;
            $param{"tab_" . ($app->param('tab') || 'details')} = 1;
            $app->add_breadcrumb($app->translate('Categories'),
                                 $app->uri( 'mode' => 'list_cat',
                                     args => { blog_id => $obj->blog_id }));
            $app->add_breadcrumb($obj->label);
            require MT::Trackback;
            my $tb = MT::Trackback->load({ category_id => $obj->id });
            if ($tb) {
                my $list_pref = $app->list_pref('ping');
                %param = (%param, %$list_pref);
                my $path = $app->config('CGIPath');
                $path .= '/' unless $path =~ m!/$!;
                my $script = $app->config('TrackbackScript');
                $param{tb_url} = $path . $script . '/' . $tb->id;
                if ($param{tb_passphrase} = $tb->passphrase) {
                    $param{tb_url} .= '/' .
                        encode_url($param{tb_passphrase});
                }
                # load pings for trackback object loop
                require MT::TBPing;
                my $iter = MT::TBPing->load_iter({ tb_id => $tb->id,
                    'junk_status' => [ 0, 1 ] },
                    { 'sort' => 'created_on',
                      direction => 'descend' });
                my $data = $app->build_ping_table( iter => $iter, param => \%param );
                $param{ping_table}[0]{object_loop} = $data;
                $app->load_itemset_actions('ping', $param{ping_table}[0], 'pings');
            }
        } elsif ($type eq 'template') {
            $param{nav_templates} = 1;
            my $tab;
            if ($obj->type eq 'index') {
                $tab = 'index';
            } elsif ($obj->type eq 'archive' || $obj->type eq 'individual' || $obj->type eq 'category') {
                $tab = 'archive';
            } elsif ($obj->type eq 'custom') {
                $tab = 'module';
            } else {
                $tab = 'system';
            }
            $app->add_breadcrumb($app->translate('Templates'),
                        $app->uri( 'mode' => 'list', args => {
                            '_type' => 'template',
                            'blog_id' => $obj->blog_id,
                            'tab' => $tab }));
            $blog_id = $obj->blog_id;
            $param{has_name} = $obj->type eq 'index' ||
                               $obj->type eq 'custom' ||
                               $obj->type eq 'archive' ||
                               $obj->type eq 'category' ||
                               $obj->type eq 'individual';
            if (!$param{has_name}) {
                $param{name} = $app->translate($obj->name);
            }
            $app->add_breadcrumb($param{name});
            $param{has_outfile} = $obj->type eq 'index';
            $param{has_rebuild} = $obj->type eq 'index';
            $param{custom_dynamic} = ($blog->custom_dynamic_templates||"") 
                                       eq 'custom';
            $param{has_build_options} = ($param{custom_dynamic}
                                          || $param{has_rebuild});
            $param{is_special} = $param{type} ne 'index'
                                 && $param{type} ne 'archive'
                                 && $param{type} ne 'category'
                                 && $param{type} ne 'individual';
            $param{has_build_options} = $param{has_build_options}
                                         && $param{type} ne 'custom'
                                         && ! $param{is_special};
            $param{rebuild_me} = defined $obj->rebuild_me ?
                $obj->rebuild_me : 1;
            $param{search_type} = $app->translate('Templates');
            $param{object_type} = 'template';
            my $published_url = $obj->published_url;
            $param{published_url} = $published_url if $published_url;
            $param{saved_rebuild} = 1 if $q->param('saved_rebuild');
        } elsif ($type eq 'blog') {
            require MT::IPBanList;
            my $output = $param{output} || '';
            $param{need_full_rebuild} = 1 if $q->param('need_full_rebuild');
            $param{need_index_rebuild} = 1 if $q->param('need_index_rebuild');
            $param{show_ip_info} = MT::IPBanList->count({'blog_id' => $id});
            $param{use_plugins} = $cfg->UsePlugins;

            my $blog_prefs = $app->user_blog_prefs;
            my $config_view = $blog_prefs->{config_view};
            $param{"settings_mode_${config_view}"} = 1;

            # settings common to both cfg_prefs.tmpl and cfg_simple.tmpl
            my $entries_on_index = ($obj->entries_on_index || 0);
            if ($entries_on_index) {
                $param{'list_on_index'} = $entries_on_index;
                $param{'posts'} = 1;
            } else {
                $param{'list_on_index'} = ($obj->days_on_index || 0);
                $param{'days'} = 1;
            }
            my $lang = $obj->language || 'en';
            $lang = 'en' if lc($lang) eq 'en-us' || lc($lang) eq 'en_us';
            $lang = 'ja' if lc($lang) eq 'jp';
            $param{'language_' . $lang} = 1;

            # settings common to cfg_feedback.tmpl and cfg_simple.tmpl
            $param{system_allow_comments} = $cfg->AllowComments;
            $param{system_allow_pings} = $cfg->AllowPings;
            $param{tk_available} = eval { require MIME::Base64; 1; }
                                && eval { require LWP::UserAgent; 1 };
            $param{'auto_approve_commenters'} =
                        !$obj->manual_approve_commenters;
            $param{identity_system} = $app->config('IdentitySystem');
            $param{handshake_return} = $app->base . $app->mt_uri;
            $param{"moderate_comments"} = $obj->moderate_unreg_comments;
            $param{"moderate_comments_" . ($obj->moderate_unreg_comments || 0)} = 1;
            $param{"moderate_pings_" . ($obj->moderate_pings || 0 )} = 1;

            if ($output eq 'cfg_prefs.tmpl') {
                if ($config_view eq 'basic') {
                    $app->add_breadcrumb($app->translate('Settings'));
                } else {
                    $app->add_breadcrumb($app->translate('General Settings'));
                }
                $param{global_sanitize_spec} = $cfg->GlobalSanitizeSpec;
                $param{'sanitize_spec_' . ($obj->sanitize_spec ? 1 : 0)} = 1;
                $param{sanitize_spec_manual} = $obj->sanitize_spec
                    if $obj->sanitize_spec;
                $param{words_in_excerpt} = 40
                    unless defined $param{words_in_excerpt} &&
                    $param{words_in_excerpt} ne '';
                $param{'sort_order_comments_' . ($obj->sort_order_comments || 0)} = 1;
                $param{'sort_order_posts_' . ($obj->sort_order_posts || 0)} = 1;
                ##my $lang = $obj->language || 'en';
                ##$lang = 'en' if lc($lang) eq 'en-us' || lc($lang) eq 'en_us';
                ##$lang = 'ja' if lc($lang) eq 'jp';
                ##$param{'language_' . $lang} = 1;
                if ($obj->cc_license) {
                    $param{cc_license_name} = MT::Util::cc_name($obj->cc_license);
                    $param{cc_license_image_url} = MT::Util::cc_image($obj->cc_license);
                    $param{cc_license_url} = MT::Util::cc_url($obj->cc_license);
                }
            } elsif ($output eq 'cfg_feedback.tmpl') {
                $app->add_breadcrumb($app->translate('Feedback Settings'));
                my $threshold = $obj->junk_score_threshold || 0;
                $threshold = '+' . $threshold if $threshold > 0;
                $param{junk_score_threshold} = $threshold;
                $param{email_new_comments_1} = ($obj->email_new_comments || 0) == 1;
                $param{email_new_comments_2} = ($obj->email_new_comments || 0) == 2;
                $param{email_new_pings_1} = ($obj->email_new_pings || 0) == 1;
                $param{email_new_pings_2} = ($obj->email_new_pings || 0) == 2;
                $param{junk_folder_expiry} = $obj->junk_folder_expiry || 60;
                $param{auto_delete_junk} = $obj->junk_folder_expiry;
            } elsif ($output eq 'cfg_entries.tmpl') {
                $app->add_breadcrumb($app->translate('New Entry Default Settings'));
                $param{system_allow_comments} = $cfg->AllowComments && ($blog->allow_reg_comments || $blog->allow_unreg_comments);
                $param{system_allow_pings} = $cfg->AllowPings && $blog->allow_pings;
                $param{system_allow_selected_pings} = $cfg->OutboundTrackbackLimit eq 'selected';
                $param{system_allow_outbound_pings} = $cfg->OutboundTrackbackLimit eq 'any';
                $param{system_allow_local_pings} = ($cfg->OutboundTrackbackLimit eq 'local') || ($cfg->OutboundTrackbackLimit eq 'any');
                $param{'status_default_' . $obj->status_default} = 1 if
                    $obj->status_default;
                $param{'allow_comments_default_' . ($obj->allow_comments_default||0)} = 1;

                ## load entry preferences for new/edit entry page of the blog
                my $pref_param = $app->load_entry_prefs;
                %param = ( %param, %$pref_param );
            } elsif ($output eq 'cfg_archives.tmpl') {
                $app->add_breadcrumb($app->translate('Publishing Settings'));
                if ($obj->column('archive_path') || $obj->column('archive_url')) {
                    $param{enable_archive_paths} = 1;
                    $param{archive_path} = $obj->column('archive_path'); 
                    $param{archive_url} = $obj->column('archive_url'); 
                } else {
                    $param{archive_path} = '';
                    $param{archive_url} = '';
                }
                $param{'archive_type_preferred_' .
                       $blog->archive_type_preferred} = 1 if
                       $blog->archive_type_preferred;
                my $at = $blog->archive_type;
                if ($at && $at ne 'None') {
                    my @at = split /,/, $at;
                    for my $at (@at) {
                        $param{'archive_type_' . $at} = 1;
                    }
                }
            } elsif ($output eq 'list_plugin.tmpl') {
                $app->add_breadcrumb($app->translate('Plugin Settings'));
                $app->build_plugin_table(param => \%param, scope => 'blog:' . $blog_id);
                $param{can_config} = 1;
            } else {
                $app->add_breadcrumb($app->translate('Settings'));
            }
            (my $offset = $obj->server_offset) =~ s![-\.]!_!g;
            $offset =~ s!_00$!!;
            $param{'server_offset_' . $offset} = 1;
            if ($output eq 'cfg_feedback.tmpl' || $output eq 'cfg_entries.tmpl') {
                ## Load text filters.
                my $filters = MT->all_text_filters;
                my $default_entries = $obj->convert_paras;
                my $default_comments = $obj->convert_paras_comments;
                if ($default_entries eq '1') {
                    $default_entries = '__default__';
                }
                if ($default_comments eq '1') {
                    $default_comments = '__default__';
                }
                $param{text_filters} = [];
                $param{text_filters_comments} = [];
                for my $filter (keys %$filters) {
                    my $row = {
                        filter_key => $filter,
                        filter_label => $filters->{$filter}{label},
                    };
                    my $rowc = { %$row };
                    $row->{filter_selected} = $filter eq $default_entries;
                    $rowc->{filter_selected} = $filter eq $default_comments;
                    push @{ $param{text_filters} }, $row;
                    push @{ $param{text_filters_comments} }, $rowc;
                }
                $param{text_filters} = [
                    sort { $a->{filter_key} cmp $b->{filter_key} }
                    @{ $param{text_filters} } ];
                unshift @{ $param{text_filters} }, {
                    filter_key => '0',
                    filter_label => $app->translate('None'),
                    filter_selected => !$default_entries,
                };
                unshift @{ $param{text_filters_comments} }, {
                    filter_key => '0',
                    filter_label => $app->translate('None'),
                    filter_selected => !$default_entries,
                };
            }
            $param{nav_config} = 1;

        } elsif ($type eq 'ping') {
            $param{nav_trackbacks} = 1;
            $app->add_breadcrumb($app->translate('TrackBacks'),
                $app->uri('mode' => 'list_pings', args => { blog_id => $blog_id }));
            $app->add_breadcrumb($app->translate('Edit TrackBack'));
            $param{approved} = $app->param('approved');
            $param{unapproved} = $app->param('unapproved');
            require MT::Trackback;
            if (my $tb = MT::Trackback->load($obj->tb_id, {cached_ok=>1})) {
                if ($tb->entry_id) {
                    $param{entry_ping} = 1;
                    require MT::Entry;
                    if (my $entry = MT::Entry->load($tb->entry_id, {cached_ok=>1})) {
                        $param{entry_title} = $entry->title;
                        $param{entry_id} = $entry->id;
                    }
                } elsif ($tb->category_id) {
                    $param{category_ping} = 1;
                    require MT::Category;
                    if (my $cat = MT::Category->load($tb->category_id, {cached_ok=>1})) {
                        $param{category_id} = $cat->id;
                        $param{category_label} = $cat->label;
                    }
                }
            }

            $param{"ping_approved"} = $obj->is_published or
                $param{"ping_pending"} = $obj->is_moderated or
                $param{"is_junk"} = $obj->is_junk;

            ## Load next and previous entries for next/previous links
            if (my $next = $obj->next) {
                $param{next_ping_id} = $next->id;
            }
            if (my $prev = $obj->previous) {
                $param{previous_ping_id} = $prev->id;
            }
            my $parent = $obj->parent;
            if (ref $parent eq 'MT::Entry') {
                if ($parent->status == MT::Entry::RELEASE()) {
                    $param{entry_permalink} = $parent->permalink;
                }
            }

            if ($obj->junk_log) {
                $app->build_junk_table(param => \%param, object => $obj);
            }

            $param{created_on_time_formatted} =
                format_ts("%Y-%m-%d %H:%M:%S", $obj->created_on());
            $param{created_on_day_formatted} =
                format_ts("%Y.%m.%d", $obj->created_on());

            $param{search_type} = $app->translate('TrackBacks');
            $param{object_type} = 'ping';

            my $plugin_actions = $app->plugin_itemset_actions($type);
            $param{plugin_itemset_action_loop} = $plugin_actions || [];
            my $core_actions = $app->core_itemset_actions($type);
            $param{core_itemset_action_loop} = $core_actions || [];
            $param{has_itemset_actions} =
                (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;

            # since MT::App::build_page clobbers it:
            $param{source_blog_name} = $param{blog_name};
        } elsif ($type eq 'comment') {
            $param{nav_comments} = 1;
            $app->add_breadcrumb($app->translate('Comments'),
               $app->uri('mode' => 'list_comments', args => { blog_id => $blog_id }));
            $app->add_breadcrumb($app->translate('Edit Comment'));
            if (my $entry = $obj->entry) {
                my $title_max_len = const('DISPLAY_LENGTH_EDIT_COMMENT_TITLE');
                $param{entry_title} = (!defined($entry->title) || $entry->title eq '') ? $app->translate('(untitled)') : $entry->title;
                $param{entry_title} = substr_text($param{entry_title}, 0, $title_max_len) . '...'
                    if $param{entry_title} && length_text($param{entry_title}) > $title_max_len;
                $param{entry_permalink} = $entry->permalink;
            } else {
                $param{no_entry} = 1;
            }
            $param{comment_approved} = $obj->is_published or
                $param{comment_pending} = $obj->is_moderated or
                $param{is_junk} = $obj->is_junk;

            $param{created_on_time_formatted} =
                format_ts("%Y-%m-%d %H:%M:%S", $obj->created_on());
            $param{created_on_day_formatted} =
                format_ts("%Y.%m.%d", $obj->created_on());

            $param{approved} = $app->param('approved');
            $param{unapproved} = $app->param('unapproved');
            $param{is_junk} = $obj->is_junk;

            ## Load next and previous entries for next/previous links
            if (my $next = $obj->next) {
                $param{next_comment_id} = $next->id;
            }
            if (my $prev = $obj->previous) {
                $param{previous_comment_id} = $prev->id;
            }
            if ($obj->junk_log) {
                $app->build_junk_table(param => \%param, object => $obj);
            }

            my $perm = MT::Permission->load({author_id => $obj->commenter_id,
                                             blog_id => $obj->blog_id});
            if ($perm) {
                $param{commenter_approved} = ($perm->can_comment()
                                              && !$perm->can_not_comment()
                                               ? 1 : undef);
                $param{commenter_banned} = ($perm->can_not_comment()
                                               ? 1 : undef);
            }
            if ($obj->commenter_id) {
                if ($obj->email !~ m/@/) {  # no email for this commenter
                    $param{email_withheld} = 1;
                }
            }
            $param{invisible_unregistered} = !$obj->visible &&
                                             !$obj->commenter_id;

            $param{search_type} = $app->translate('Comments');
            $param{object_type} = 'comment';

            my $plugin_actions = $app->plugin_itemset_actions($type);
            $param{plugin_itemset_action_loop} = $plugin_actions || [];
            my $core_actions = $app->core_itemset_actions($type);
            $param{core_itemset_action_loop} = $core_actions || [];
            $param{has_itemset_actions} =
                (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
        } elsif ($type eq 'author') {
            # TODO: Populate permissions / blogs for this user
            # populate blog_loop, permission_loop
            $param{is_me} = 1 if $id == $author->id;
            $param{editing_other_profile} = 1
                if !$param{is_me} && $author->is_superuser;
 
            require MT::Permission;
            # General permissions...
            # my $sys_perms = MT::Permission->perms('system');
            # foreach (@$sys_perms) {
            #     $param{'perm_can_' . $_->[1]} = $obj->permissions->has($_->[1]);
            # }
            $param{perm_is_superuser} = $obj->is_superuser;
            $param{perm_can_create_blog} = $obj->can_create_blog;
            $param{perm_can_view_log} = $obj->can_view_log;
            $param{status_enabled} = $obj->is_active ? 1 : 0;

            if ($app->user->is_superuser) {
                $param{search_type} = $app->translate('Users');
                $param{object_type} = 'author';
            }
            $param{can_edit_username} = 1;
            $param{can_recover_password} = 1;
            $param{languages} = $app->languages_list($obj->preferred_language);
        } elsif ($type eq 'commenter') {
            $app->add_breadcrumb($app->translate("Authenticated Commenters"),
                $app->uri(mode => 'list_commenters',
                          args => { blog_id => $blog_id }));
            $app->add_breadcrumb($app->translate("Commenter Details"));
            my $tab = $q->param('tab') || 'commenter';
            # populate the comments / junk comments for this user
            $param{'mode_view_commenter'} = 1;
            if ($tab eq 'commenter') {
                # we need itemset actions for commenters
                my $plugin_actions = $app->plugin_itemset_actions('commenter');
                $param{plugin_itemset_action_loop} = $plugin_actions || [];
                #my $core_actions = $app->core_itemset_actions('commenter');
                #$param{core_itemset_action_loop} = $core_actions
                #    if $core_actions;
                # no native actions for this screen.
                $param{has_itemset_actions} = @$plugin_actions ? 1 : 0;
                $param{is_email_hidden} = $obj->is_email_hidden;
                $param{status} = {PENDING => "pending",
                                  APPROVED => "approved",
                                  BANNED => "banned"}->{$obj->status($blog_id)};
                $param{commenter_approved} = $obj->status($blog_id) == APPROVED;
                $param{commenter_banned} = $obj->status($blog_id) == BANNED;
                $param{profile_page} = $app->config('IdentityURL');
                $param{profile_page} .= "/" unless $param{profile_page} =~ m|/$|;
                $param{profile_page} .= $obj->name();
            } else {
                my $list_pref = $app->list_pref('comment');
                %param = (%param, %$list_pref);
                my $limit = $list_pref->{rows};
                my $offset = $q->param('offset') || 0;
                my (%terms, %arg);
                $terms{commenter_id} = $id;
                if ($tab eq 'comments') {
                    $terms{junk_status} = [ 0, 1 ];
                } elsif ($tab eq 'junk') {
                    $terms{junk_status} = -1;
                }
                $arg{offset} = $offset if $offset;
                require MT::Comment;
                my $iter = MT::Comment->load_iter(\%terms, \%arg);
                my $loop = $app->build_comment_table( iter => $iter,
                    param => \%param );
                ## We tried to load $limit + 1 entries above; if we actually got
                ## $limit + 1 back, we know we have another page of entries.
                my $have_next = @$loop > $limit;
                pop @$loop while @$loop > $limit;
                if ($offset) {
                    $param{prev_offset} = 1;
                    $param{prev_offset_val} = $offset - $limit;
                    $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
                }
                if ($have_next) {
                    $param{next_offset} = 1;
                    $param{next_offset_val} = $offset + $limit;
                }
                $param{limit} = $limit;
                $param{offset} = $offset;
                $param{object_type} = 'comment';
                $param{object_type_plural} = $app->translate('comments');
                $param{search_type} = $app->translate('Comments');
                $param{list_start} = $offset + 1;
                $param{list_end} = $offset + scalar @$loop;
                delete $arg{limit}; delete $arg{offset};
                $param{list_total} = MT::Comment->count(\%terms, \%arg);
                if ($param{list_total}) {
                    $param{next_max} = $param{list_total} - $limit;
                    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
                }
                # These are stubs for the commenter-scoped itemset references
                $param{plugin_itemset_action_loop} = [];
                $param{core_itemset_action_loop} = [];
            }
            $param{"tab_$tab"} = 1;
        }
        $param{new_object} = 0;
    } else {                                        # object is new
        $param{new_object} = 1;
        for my $col (@$cols) {
            $param{$col} = $q->param($col);
        }
        if ($type eq 'entry') {
            $param{entry_edit} = 1;
            if ($blog_id) {
                $app->add_breadcrumb($app->translate('Entries'), 
                     $app->uri('mode' => 'list_entries', args => { blog_id => $blog_id }));
                $app->add_breadcrumb($app->translate('New Entry'));
                $param{nav_new_entry} = 1;
            }
            # (if there is no blog_id parameter, this is a
            # bookmarklet post and doesn't need breadcrumbs.)
            delete $param{'author_id'};
            delete $param{'pinged_urls'};
            my $blog_timezone = 0;
            if ($blog_id) {
                my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
                $blog_timezone = $blog->server_offset();
                my $def_status = $q->param('status') ||
                                 $blog->status_default;
                if ($def_status) {
                    $param{"status_" . MT::Entry::status_text($def_status)}
                        = 1;
                }
                $param{'allow_comments_' . 
                       (defined $q->param('allow_comments')
                         ? $q->param('allow_comments')
                         : $blog->allow_comments_default)} = 1;
                $param{allow_comments} = $blog->allow_comments_default
                    unless defined $q->param('allow_comments');
                $param{allow_pings} = $blog->allow_pings_default
                    unless defined $q->param('allow_pings');
            }

            require POSIX;
            $param{created_on_formatted} = $q->param('created_on_manual')
                           || POSIX::strftime("%Y-%m-%d %H:%M:%S", 
                                       offset_time_list(time, $blog));
            if ($q->param('is_bm')) {
                $param{selected_text} = $param{text};
                my $enc = guess_encoding(CGI::unescape(scalar $q->param('link_title'). $param{text}));
                my $bm_link_title = encode_text(CGI::unescape(scalar $q->param('link_title')),$enc);
                $bm_link_title = encode_html($bm_link_title);
                my $bm_link_href = scalar $q->param('link_href');
                my $bm_text = encode_text(CGI::unescape($param{text}),$enc);
                $param{text} = sprintf qq(<a title="%s" href="%s">%s</a>\n\n%s),
                    $bm_link_title,
                    $bm_link_href,
                    $bm_link_title,
                    $bm_text;

                my $show = $q->param('bm_show') || '';
                if ($show =~ /\b(trackback|t)\b/) {
                    $param{show_trackback} = 1;
                    ## Now fetch original page and scan it for embedded
                    ## TrackBack RDF tags.
                    my $url = $q->param('link_href');
                    if (my $items = MT::Util::discover_tb($url, 1)) {
                        if (@$items == 1) {
                            $param{to_ping_urls} = $items->[0]->{ping_url};
                        } else {
                            $param{to_ping_url_loop} = [ grep { $_->{title} = encode_text($_->{title}) } @$items ];
                        }
                    }
                }

                # This is needed for the QuickPost entry screen.
                require MT::Permission;
                my $iter = MT::Permission->load_iter({ author_id =>
                    $app->user->id });
                my @data;
                while (my $perms = $iter->()) {
                    next unless $perms->can_post;
                    my $blog = MT::Blog->load($perms->blog_id, {cached_ok=>1});
                    next unless $blog;
                    push @data, { blog_id => $blog->id,
                                  blog_name => $blog->name,
                                  blog_convert_breaks => $blog->convert_paras,
                                  blog_status => $blog->status_default,
                                  blog_allow_comments =>
                                      $blog->allow_comments_default,
                                  blog_allow_pings =>
                                      $blog->allow_pings_default,
                                  blog_basename_limit => $blog->basename_limit || 30 };
                    # populate category
                    $param{avail_blogs}{$blog->id} = 1;
                }
                @data = sort { $a->{blog_name} cmp $b->{blog_name} } @data;
                $param{blog_loop} = \@data;
            }
        } elsif ($type eq 'author') {
            require MT::Permission;
            # $param{editing_other_profile} = 1;
        } elsif ($type eq 'template') {
            my $template_type = $q->param('type')
                   || return $app->errtrans("Create template requires type");
            $param{nav_templates} = 1;
            my $tab;
            if ($template_type eq 'index') {
                $tab = 'index';
            } elsif ($template_type eq 'archive' || $template_type eq 'individual' || $template_type eq 'category') {
                $tab = 'archive';
            } elsif ($template_type eq 'custom') {
                $tab = 'module';
            } else {
                $tab = 'system';
            }
            $app->add_breadcrumb($app->translate('Templates'), $app->uri('mode' => 'list', args => { '_type' => 'template', blog_id => $blog->id,
                'tab' => $tab }));
            $app->add_breadcrumb($app->translate('New Template'));
            $param{has_name} = $template_type eq 'index' ||
                               $template_type eq 'custom' ||
                               $template_type eq 'archive' ||
                               $template_type eq 'category' ||
                               $template_type eq 'individual';
            $param{has_outfile} = $template_type eq 'index';
            $param{has_rebuild} = $template_type eq 'index';
            $param{custom_dynamic} = $blog->custom_dynamic_templates eq 'custom';
            $param{has_build_options} = 
                    $blog->custom_dynamic_templates eq 'custom'
                      || $param{has_rebuild};
            $param{is_special} = $param{type} ne 'index'
                                 && $param{type} ne 'archive'
                                 && $param{type} ne 'category'
                                 && $param{type} ne 'individual';
            $param{has_build_options} = $param{has_build_options}
                                         && $param{type} ne 'custom'
                                         && !$param{is_special};;

            $param{rebuild_me} = 1;
        } elsif ($type eq 'blog') {
            $app->add_breadcrumb($app->translate('New Weblog'));
            (my $tz = $cfg->DefaultTimezone) =~ s![-\.]!_!g;
            $tz =~ s!_00$!!;
            $param{'server_offset_' . $tz} = 1;
        }
    }
    # Regardless of whether the obj is new, load data into $param
    if ($type eq 'entry') {
        ## Load categories and process into loop for category pull-down.
        require MT::Placement;
        my $cat_id = $param{category_id};
        my $depth = 0;
        my %places;

        if ($id) {
            my @places = MT::Placement->load({ entry_id => $id, is_primary => 0});
            %places = map { $_->category_id => 1 } @places;
        }
        if ($q->param('reedit')) {
            $param{reedit} = 1;
            if (!$q->param('basename_manual')) {
                $param{'basename'} = '';
            }
        }

        ## Now load user's preferences and customization for new/edit
        ## entry page.
        if ($perms) {
            my $pref_param = $app->load_entry_prefs($perms->entry_prefs);
            %param = ( %param, %$pref_param );
            $param{disp_prefs_bar_colspan} = $param{new_object} ? 1 : 2;
            if ($param{disp_prefs_show_tags}) {
                my $auth_prefs = $author->entry_prefs;
                if (my $delim = chr($auth_prefs->{tag_delim})) {
                    if ($delim eq ',') {
                        $param{'auth_pref_tag_delim_comma'} = 1;
                    } elsif ($delim eq ' ') {
                        $param{'auth_pref_tag_delim_space'} = 1;
                    } else {
                        $param{'auth_pref_tag_delim_other'} = 1;
                    }
                    $param{'auth_pref_tag_delim'} = $delim;
                }

                require MT::ObjectTag;
                my $count = MT::Tag->count(undef,
                    { 'join' => MT::ObjectTag->join_on('tag_id',
                    { blog_id => $blog_id, object_datasource => MT::Entry->datasource },
                    { unique => 1 } )
                });
                if ($count > 1000) {  # FIXME: Configurable limit?
                    $param{defer_tag_load} = 1;
                } else {
                    require JSON;
                    $param{tags_js} = JSON::objToJson(MT::Tag->cache(blog_id => $blog_id, class => 'MT::Entry'));
                }
            }
        }

        if (!$q->param('is_bm')) {
            ## Load categories if user displays them
            if ($param{disp_prefs_show_category}) {
                my $data = $app->_build_category_list(blog_id => $blog_id, markers => 1);
                foreach (@$data) {
                    next unless exists $_->{category_id};
                    $_->{category_is_primary} = $cat_id && $cat_id == $_->{category_id};
                    $param{selected_category} = $_->{category_id} if $_->{category_is_primary};
                    if ($param{reedit}) {
                        $_->{category_is_selected} = $q->param('add_category_id_' . $_->{category_id}) || $_->{category_is_primary};;
                    } else {
                        $_->{category_is_selected} = exists $places{$_->{category_id}} || $_->{category_is_primary};
                    }
                }
                my $top = { category_id => '',
                            category_label => $app->translate('Select') };
                $top->{category_is_selected} = 1 unless $cat_id;
                $param{category_loop} = [ $top, @$data ];
                $param{have_multiple_categories} = scalar @$data > 1;
                $param{add_category_loop} = $data;
            }
        }

        $param{basename_limit} = ($blog ? $blog->basename_limit : 0) || 30; # FIXME

        if ($q->param('tags')) {
            $param{tags} = $q->param('tags');
        } else {
            if ($obj) {
                my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
                require MT::Tag;
                my $tags = MT::Tag->join($tag_delim, $obj->tags);
                $param{tags} = $tags;
            }
        }

        ## Load text filters if user displays them
        if ($param{disp_prefs_show_convert_breaks} || $q->param('is_bm')) {
            my %entry_filters;
            if (defined(my $filter = $q->param('convert_breaks'))) {
                $entry_filters{$filter} = 1;
            } elsif ($obj) {
                %entry_filters = map { $_ => 1 } @{ $obj->text_filters };
            } elsif ($blog) {
                my $cb = $blog->convert_paras;
                $cb = '__default__' if $cb eq '1';
                $entry_filters{$cb} = 1;
                $param{convert_breaks} = $cb;
            }
            my $filters = MT->all_text_filters;
            $param{text_filters} = [];
            for my $filter (keys %$filters) {
                push @{ $param{text_filters} }, {
                    filter_key => $filter,
                    filter_label => $filters->{$filter}{label},
                    filter_selected => $entry_filters{$filter},
                    filter_docs => $filters->{$filter}{docs},
                };
            }
            $param{text_filters} = [
                sort { $a->{filter_key} cmp $b->{filter_key} }
                    @{ $param{text_filters} } ];
            unshift @{ $param{text_filters} }, {
                filter_key => '0',
                filter_label => $app->translate('None'),
                filter_selected => (!keys %entry_filters),
            };
        }
        if ($blog) {
            if (!defined $param{convert_breaks}) {
                my $cb = $blog->convert_paras;
                $cb = '__default__' if $cb eq '1';
                $param{convert_breaks} = $cb;
            }
            my $ext = ($blog->file_extension || '');
            $ext = '.' . $ext if $ext ne '';
            $param{blog_file_extension} = $ext;
        }
    } elsif ($type eq 'template') {
        $param{"type_$param{type}"} = 1;
        if ($perms) {
            my $pref_param = $app->load_template_prefs($perms->template_prefs);
            %param = ( %param, %$pref_param );
        }
    } elsif ($type eq 'blog') {
        my $cwd = '';
        if ($ENV{MOD_PERL}) {
            ## If mod_perl, just use the document root.
            $cwd = $app->{apache}->document_root;
        } else {
            $cwd = $app->config('DefaultSiteRoot') || $ENV{DOCUMENT_ROOT} || $app->mt_dir;
        }
        $cwd = File::Spec->canonpath($cwd);
        $cwd =~ s!([\\/])cgi(?:-bin)?([\\/].*)?$!$1!;
        $cwd =~ s!([\\/])mt[\\/]?$!$1!i;
        if (!$param{site_path}) {
            $param{site_path} = $cwd;
        }
        if(!$param{id}) {
            $param{site_path} = File::Spec->catdir($param{site_path}, 'WEBLOG-NAME');
        }
        # If not yet defined, set the site_url to the config default, if one exists.
        $param{site_url} ||= $app->config('DefaultSiteURL');
        if (!$param{site_url}) {
            $param{site_url} = $app->base . '/';
            $param{site_url} =~ s!/cgi(?:-bin)?(/.*)?$!/!;
            $param{site_url} =~ s!/mt/?$!/!i;
        }
        if(!$param{id}) {
            $param{site_url} .= '/' unless $param{site_url} =~ /\/$/;
            $param{site_url} .= 'WEBLOG-NAME/';
        }
    } elsif ($type eq 'author') {
        $app->add_breadcrumb($app->translate("Users"),
             $app->user->is_superuser ? $app->uri(mode => 'list_authors') : undef);
        my $auth_prefs;
        if ($obj) {
            $app->add_breadcrumb($obj->name);
            $param{languages} = $app->languages_list($obj->preferred_language);
            $auth_prefs = $obj->entry_prefs;
        } else {
            $app->add_breadcrumb($app->translate("Create New User"));
            $param{languages} = $app->languages_list($app->config('DefaultUserLanguage'));
            $auth_prefs = { tag_delim => $app->config->DefaultUserTagDelimiter };
        }
        my $delim = chr($auth_prefs->{tag_delim});
        if ($delim eq ',') {
            $param{'auth_pref_tag_delim_comma'} = 1;
        } elsif ($delim eq ' ') {
            $param{'auth_pref_tag_delim_space'} = 1;
        } else {
            $param{'auth_pref_tag_delim_other'} = 1;
        }
        $param{'auth_pref_tag_delim'} = $delim;
        $param{'nav_authors'} = 1;
    }
    if (($q->param('msg')||"") eq 'nosuch') {
        $param{nosuch} = 1;
    }
    for my $p ($q->param) {
        $param{$p} = $q->param($p) if $p =~ /^saved/;
    }
    if ($type eq 'comment') {
        my $cmntr = MT::Author->load({ id => $obj->commenter_id(),
                                       type => MT::Author::COMMENTER });
        $param{email_hidden} = $cmntr && $cmntr->is_email_hidden();
        $param{email} = $cmntr ? $cmntr->email : $obj->email;
        $param{comments_script_uri} = $app->config('CommentScript');
        if ($cmntr) {
            $param{profile_page} = $app->config('IdentityURL');
            $param{profile_page} .= "/" unless $param{profile_page} =~ m|/$|;
            $param{profile_page} .= $cmntr->name();
        }
    }
    $param{plugin_action_loop} = $app->plugin_actions($type) || [];
    if ($q->param('is_bm')) {
        my $show = $q->param('bm_show') || '';
        my %opts = ('c' => 'category', 't' => 'trackback', 'ap' => 'allow_pings', 'ac' => 'allow_comments', 'cb' => 'convert_breaks', 'e' => 'excerpt', 'k' => 'keywords', 'm' => 'text_more', 'b' => 'basename', 'tg' => 'tags');
        if ($show) {
            my @show = map "show_$_", split /,/, $show;
            @param{ @show } = (1) x @show;
            # map the shortened show options to the long names used in the
            # quick post template
            foreach (@show) {
                s/^show_//;
                $param{"show_" . $opts{$_}} = 1 if exists $opts{$_};
            }
        }
        if ($show =~ /\b(category|c)\b/) {
            my @c_data;
            my $blog_loop = $param{blog_loop};
            foreach my $blog (@$blog_loop) {
                my $blog_id = $blog->{blog_id};
                my $blog_cats = $app->_build_category_list(blog_id => $blog_id, markers => 1);
                my $i = 0;
                for my $row (@$blog_cats) {
                    $row->{category_blog_id} = $blog_id;
                    $row->{category_index} = $i++;
                    next unless exists $row->{category_id};
                    my $spacer = $row->{category_label_spacer} || '';
                    $spacer =~ s/\&nbsp;/\\u00A0/g;
                    $row->{category_label_js} = $spacer . encode_js($row->{category_label});
                }
                push @c_data, @$blog_cats;
                $blog->{add_category_loop} = $blog_cats;
            }
            $param{category_loop} = \@c_data;
        }
        $param{show_feedback} = $param{show_allow_pings} || $param{show_allow_comments};
        $param{refocus} = 1;
        return $app->build_page("bm_entry.tmpl", \%param);
    } elsif ($param{output}) {
        return $app->build_page($param{output}, \%param);
    } else {
        return $app->build_page("edit_${type}.tmpl", \%param);
    }
}

sub load_default_entry_prefs {
    my $app = shift;
    my $prefs;
    require MT::Permission;
    my $blog_id;
    $blog_id = $app->blog->id if $app->blog;
    my $perm = MT::Permission->load({blog_id => $blog_id, author_id => 0});
    if ($perm && $perm->entry_prefs) {
        $prefs = $perm->entry_prefs;
    } else {
        my %default = %{$app->config->DefaultEntryPrefs};
        if ($default{Type} eq 'Basic') {
            $prefs = 'Basic';
        } elsif ($default{Type} eq 'Advanced' or $default{Type} eq 'All') {
            $prefs = 'Advanced';
        } elsif ($default{Type} eq 'Custom') {
            my %map = (
                Category => 'category',
                ExtendedEntry => 'extended',
                Excerpt => 'excerpt',
                Keywords => 'keywords',
                Tags => 'tags',
                TextFormatting => 'convert_breaks',
                AllowComments => 'allow_comments',
                AllowTrackbacks => 'allow_pings',
                Date => 'authored_on',
                Basename => 'basename',
                TrackbackURLs => 'ping_urls',
            );
            my @p;
            foreach my $p (keys %map) {
                push @p, $map{$p} . ':' . $default{$p} if $default{$p};
            }
            $prefs = join ',', @p;
            $prefs ||= 'Custom';
        }
        $default{Button} = 'Bottom' if $default{Button} eq 'Below';
        $default{Button} = 'Top' if $default{Button} eq 'Above';
        $prefs .= '|' . $default{Button} if $prefs;
    }
    $prefs ||= 'Basic|Bottom';
    $prefs;
}

sub load_template_prefs {
    my $app = shift;
    my ($prefs) = @_;
    my %param;

    if (!$prefs) {
        $prefs = '';
    }
    my @p = split /,/, $prefs;
    for my $p (@p) {
        if ($p =~ m/^(.+?):(\d+)$/) {
            $param{'disp_prefs_height_' . $1} = $2;
        }
    }
    \%param;
}

sub _parse_entry_prefs {
    my $app = shift;
    my ($prefs, $param) = @_;

    my @p = split /,/, $prefs;
    for my $p (@p) {
        if ($p =~ m/^(.+?):(\d+)$/) {
            my ($name, $num) = ($1, $2);
            if ($num) {
                $num = $app->config->DefaultEntryPrefs->{Height}
                    if $name eq 'extended' && $num == 1;
                $param->{'disp_prefs_height_' . $name} = $num;
            }
            $param->{'disp_prefs_show_' . $name} = 1;
        } else {
            if (($p eq 'Basic') || ($p eq 'Advanced') || ($p eq 'Default')) {
                $param->{'disp_prefs_' . $p} = 1;
            } else {
                $param->{'disp_prefs_show_' . $p} = 1;
            }
        }
    }
}

sub load_entry_prefs {
    my $app = shift;
    my ($prefs) = @_;
    my %param;
    my $pos;
    my $is_from_db = 1;
    # defaults:
    if (!$prefs) {
        $prefs = $app->load_default_entry_prefs;
        ($prefs, $pos) = split /\|/, $prefs;
        $is_from_db = 0;
        $param{'disp_prefs_Default'} = 1;
        $app->_parse_entry_prefs($prefs, \%param);
        my @fields;
        foreach (keys %param) {
            if (m/^disp_prefs_show_(.+)/) {
                push @fields, { name => $1 };
            }
        }
        $param{disp_prefs_default_fields} = \@fields;
    } else {
        ($prefs, $pos) = split /\|/, $prefs;
    }
    $app->_parse_entry_prefs($prefs, \%param);
    if ($is_from_db) {
        my $default_prefs = $app->load_default_entry_prefs;
        ($default_prefs, my($default_pos)) = split /\|/, $default_prefs;
        $pos ||= $default_pos;
        $app->_parse_entry_prefs($default_prefs, \my %def_param);
        my @fields;
        foreach (keys %def_param) {
            if (m/^disp_prefs_show_(.+)/) {
                push @fields, { name => $1 };
            }
        }
        if ($param{disp_prefs_Default}) {
            # apply default settings
            %param = (%def_param, %param);
        }
        $param{disp_prefs_default_fields} = \@fields;
    }
    $pos ||= 'Bottom';
    if ($param{'disp_prefs_Basic'}) {
        my @all = qw( category extended excerpt convert_breaks
                      allow_comments authored_on allow_pings 
                      ping_urls basename tags keywords );
        for my $p (@all) {
            $param{'disp_prefs_show_' . $p} = 0;
        }
    } elsif ($param{'disp_prefs_Advanced'}) {
        my @all = qw( category body extended excerpt convert_breaks
                      allow_comments authored_on allow_pings 
                      ping_urls basename tags keywords );
        for my $p (@all) {
            $param{'disp_prefs_show_' . $p} ||= 1;
        }
    } else {
        $param{'disp_prefs_Custom'} = 1;
    }
    if ($pos eq 'Both') {
        $param{'position_buttons_top'} = 1;
        $param{'position_buttons_bottom'} = 1;
        $param{'position_buttons_both'} = 1;
    } else {
        $param{'position_buttons_' . $pos} = 1;
    }
    \%param;
}

sub build_junk_table {
    my $app = shift;
    my (%args) = @_;

    my $param = $args{param};
    my $obj = $args{object};

    if (defined $obj->junk_score) {
        $param->{junk_score} = ($obj->junk_score > 0 ? '+' : '') . $obj->junk_score;
    }
    my $log = $obj->junk_log || '';
    my @log = split /\r?\n/, $log;
    my @junk;
    for (my $i = 0; $i < scalar(@log); $i++) {
        my $line = $log[$i];
        $line =~ s/(^\s+|\s+$)//g;
        next unless $line;
        last if $line =~ m/^--->/;
        my ($test, $score, $log);
        ($test) = $line =~ m/^([^:]+?):/;
        if (defined $test) {
            ($score) = $test =~ m/\(([+-]?\d+?(?:\.\d*?)?)\)/;
            $test =~ s/\(.+\)//;
        }
        if (defined $score) {
            $score =~ s/\+//;
            $score .= '.0' unless $score =~ m/\./;
            $score = ($score > 0 ? '+' : '') . $score;
        }
        $log = $line;
        $log =~ s/^[^:]+:\s*//;
        $log = encode_html($log);
        for (my $j = $i + 1; $j < scalar(@log); $j++) {
            my $line = encode_html($log[$j]);
            if ($line =~ m/^\t+(.*)$/s) {
                $i = $j;
                $log .= "<br />" . $1;
            } else {
                last;
            }
        }
        push @junk, { test => $test, score => $score, log => $log };
    }
    $param->{junk_log_loop} = \@junk;
    \@junk;
}

sub CMSViewPermissionFilter_blog {
    my ($eh, $app, $id) = @_;
    if ( ($id && !$app->{perms}->can_edit_config) ||
        (!$id && !$app->user->can_create_blog)) {
        return 0;
    }
    1;
}

sub CMSViewPermissionFilter_template {
    my ($eh, $app, $id) = @_;
    return !$id || $app->{perms}->can_edit_templates;
}

sub CMSViewPermissionFilter_entry {
    my ($eh, $app, $id, $objp) = @_;
    if (!$id && !$app->param('is_bm') &&
        !$app->{perms}->can_post) {
        return 0;
    }
    if ($id) {
        my $obj = $objp->force();
        if (!$app->{perms}->can_edit_entry($obj, $app->user)) {
            return 0;
        }
    }
    1;
}

sub CMSViewPermissionFilter_author {
    my ($eh, $app, $id) = @_;
    return $id && ($app->user->id == $id);
}

sub CMSViewPermissionFilter_category {
    my ($eh, $app, $id) = @_;
    return $app->{perms}->can_edit_categories();
}

sub CMSViewPermissionFilter_commenter {
    my $eh = shift;
    my ($app, $id) = @_;
    my $auth = MT::Author->load( { id => $id, 
                                   type => MT::Author::COMMENTER });
    $auth ? 1 : 0;
}

sub CMSViewPermissionFilter_comment {
    my $eh = shift;
    my ($app, $id, $objp) = @_;
    return 0 unless ($id);
    my $obj = $objp->force() or return 0;
    require MT::Entry;
    my $entry = MT::Entry->load($obj->entry_id, {cached_ok=>1})
        or return 0;
    if (!($entry->author_id == $app->user->id
          || $app->{perms}->can_edit_all_posts)) {
        return 0;
    }
    1;
}

sub CMSViewPermissionFilter_ping {
    my $eh = shift;
    my ($app, $id, $objp) = @_;
    my $obj = $objp->force() or return 0;
    require MT::Trackback;
    my $tb = MT::Trackback->load($obj->tb_id, {cached_ok=>1});
    if ($tb) {
        if ($tb->entry_id) {
            require MT::Entry;
            my $entry = MT::Entry->load($tb->entry_id, {cached_ok=>1});
            return ($entry->author_id == $app->user->id
                    || $app->{perms}->can_edit_all_posts);
        } elsif ($tb->category_id) {
            require MT::Category;
            my $cat = MT::Category->load($tb->category_id,{cached_ok=>1});
            return $cat && $app->{perms}->can_edit_categories;
        }
    } else {
        return 0;   # no TrackBack center--no edit
    }
}        

sub CMSSaveFilter_author {
    my ($eh, $app) = @_;

    my $status = $app->param('status');
    return 1 if $status and $status == MT::Author::INACTIVE();

    my $name = $app->param('name');
    if (defined $name) {
        $name =~ s/(^\s+|\s+$)//g;
        $app->param('name', $name);
    }
    return $eh->error($app->translate("User requires username"))
        if (!$name);

    require MT::Author;
    my $existing = MT::Author->load({ name => $name,
                                      type => MT::Author::AUTHOR});
    my $id = $app->param('id');
    if ($existing && (($id && $existing->id ne $id) || !$id)) {
        return $eh->error($app->translate("A user with the same name already exists."));
    }

    if (!$app->param('id')) {  # it's a new object
        return $eh->error($app->translate("User requires password"))
            if (!$app->param('pass'));
        return $eh->error($app->translate("User requires password recovery word/phrase"))
            if (!$app->param('hint'));
    }
    return $eh->error(MT->translate("Email Address is required for password recovery"))
        unless $app->param('email');

    1;
}

sub CMSSaveFilter_notification {
    my $eh = shift;
    my ($app) = @_;
    my $email = lc $app->param('email');
    $email =~ s/(^\s+|\s+$)//gs;
    my $blog_id = $app->param('blog_id');
    if (!is_valid_email($email)) {
        return $eh->error($app->translate("The value you entered was not a valid email address"));
    }
    require MT::Notification;
    # duplicate check
    my $notification_iter = MT::Notification->load_iter({blog_id => $blog_id});
    while (my $obj = $notification_iter->()) {
        if (lc($obj->email) eq $email) {
            return $eh->error($app->translate("The e-mail address you entered is already on the Notification List for this weblog."));
        }
    }
    return 1;
}

sub CMSSaveFilter_banlist {
    my $eh = shift;
    my ($app) = @_;
    my $ip = $app->param('ip');
    $ip =~ s/(^\s+|\s+$)//g;
    return $eh->error(MT->translate("You did not enter an IP address to ban."))
        if ('' eq $ip);
    my $blog_id = $app->param('blog_id');
    require MT::IPBanList;
    my $existing = MT::IPBanList->load({ 'ip' => $ip, 'blog_id' => $blog_id});
    my $id = $app->param('id');
    if ($existing && (!$id || $existing->id != $id)) {
        return $eh->error($app->translate("The IP you entered is already banned for this weblog."));
    }   
    return 1;
}

sub CMSSaveFilter_blog {
    my $eh = shift;
    my ($app) = @_;
    my $name = $app->param('name');
    if (defined $name) {
        $name =~ s/(^\s+|\s+$)//g;
        $app->param('name', $name);
    }
    return $eh->error(MT->translate("You did not specify a weblog name."))
        if (!$app->param('cfg_screen') && $app->param('name') eq '');
    return $eh->error(MT->translate("Site URL must be an absolute URL."))
        if ($app->param('cfg_screen') eq 'cfg_archives'
            && $app->param('site_url') !~ m.^https?://.);
    return $eh->error(MT->translate("Archive URL must be an absolute URL."))
        if ($app->param('cfg_screen') eq 'cfg_archives'
            && $app->param('archive_url') !~ m.^https?://.
            && $app->param('enable_archive_paths'));
    require MT::Blog;
    return 1;
}


sub CMSSaveFilter_category {
    my $eh = shift;
    my ($app) = @_;
    return $app->errtrans("The name '[_1]' is too long!", $app->param('label'))
        if (length($app->param('label')) > 100);
    return 1;
}

sub CMSPreSave_ping {
    my $eh = shift;
    my ($app, $obj, $original) = @_;
    my $status = $app->param('status');
    if ($status eq 'publish') {
        $obj->approve;
        if ($original->junk_status != $obj->junk_status) {
            $app->run_callbacks('HandleNotJunk', $app, $obj);
        }
    } elsif ($status eq 'moderate') {
        $obj->moderate;
        $obj->junk_status(0);
    } elsif ($status eq 'junk') {
        $obj->junk;
        if ($original->junk_status != $obj->junk_status) {
            $app->run_callbacks('HandleJunk', $app, $obj);
        }
    }
    return 1;
}

sub CMSPreSave_comment {
    my $eh = shift;
    my ($app, $obj, $original) = @_;
    my $status = $app->param('status');
    if ($status eq 'publish') {
        $obj->approve;
        if ($original->junk_status != $obj->junk_status) {
            $app->run_callbacks('HandleNotJunk', $app, $obj);
        }
    } elsif ($status eq 'moderate') {
        $obj->moderate;
        $obj->junk_status(0);
    } elsif ($status eq 'junk') {
        $obj->junk;
        if ($original->junk_status != $obj->junk_status) {
            $app->run_callbacks('HandleJunk', $app, $obj);
        }
    }
    return 1;
}

sub CMSPreSave_author {
    my $eh = shift;
    my ($app, $obj, $original) = @_;
    # Authors should only be of type AUTHOR when created from
    # the CMS app; COMMENTERs are created from the Comments app.
    $obj->type(MT::Author::AUTHOR);

    my $pass = $app->param('pass');
    if ($pass) {
        $obj->set_password($pass);
    }

    my ($delim, $delim2) = $app->param('tag_delim');
    $delim = $delim ? $delim : $delim2;
    if ($delim =~ m/comma/i) {
        $delim = ord(',');
    } elsif ($delim =~ m/space/i) {
        $delim = ord(' ');
    } else {
        $delim = ord(',');
    }
    $obj->entry_prefs('tag_delim' => $delim);

    unless ($obj->id) {
        $obj->created_by($app->user->id);
    }
    1;
}

sub CMSPreSave_template {
    my $eh = shift;
    my ($app, $obj) = @_;
    $obj->rebuild_me(0) unless $app->param('rebuild_me');
    # (this is to hack around browsers' unwillingness to send value
    # of a disabled checkbox.)

    require MT::Blog;
    my $blog = MT::Blog->load($obj->blog_id, {cached_ok=>1});
    if ($blog->custom_dynamic_templates eq 'custom') {
        $obj->build_dynamic(0) unless $app->param('build_dynamic');
    } elsif ($blog->custom_dynamic_templates eq 'archives') {
        $obj->build_dynamic($obj->type eq 'archive' ||
                            $obj->type eq 'category' ||
                            $obj->type eq 'individual' || 0);
    } else {
        $obj->build_dynamic(0) unless $obj->build_dynamic;
    }
    ## Strip linefeed characters.
    (my $text = $obj->text) =~ tr/\r//d;
    $obj->text($text);

    # update text heights if necessary
    if ($app->{perms}) {
        my $prefs = $app->{perms}->template_prefs || '';
        my $text_height = $app->param('text_height');
        if (defined $text_height) {
            my ($pref_text_height) = $prefs =~ m/\btext:(\d+)\b/;
            $pref_text_height ||= 0;
            if ($text_height != $pref_text_height) {
                if ($prefs =~ m/\btext\b/) {
                    $prefs =~ s/\btext(:\d+)\b/text:$text_height/;
                } else {
                    $prefs = 'text:' . $text_height . ',' . $prefs;
                }
            }
        }

        if ($prefs ne ($app->{perms}->template_prefs || '')) {
            $app->{perms}->template_prefs($prefs);
            $app->{perms}->save;
        }
    }
    1;
}

sub CMSPreSave_blog {
    my $eh = shift;
    my ($app, $obj) = @_;
    if (!$app->param('overlay') &&
        $app->param('cfg_screen') )
    {
        # Checkbox options have to be blanked if they aren't passed.
        my $screen = $app->param('cfg_screen');
        my @fields;
        if ($screen eq 'cfg_prefs') {
#            @fields = qw( ping_weblogs ping_blogs ping_technorati autodiscover_links );
        } elsif ($screen eq 'cfg_entries') {
            @fields = qw( ping_blogs ping_weblogs ping_technorati
                          allow_comments_default allow_pings_default
                          autodiscover_links internal_autodiscovery );
        } elsif ($screen eq 'cfg_archives') {
            @fields = qw(site_url site_path archive_type_preferred
                         file_extension);
        } elsif ($screen eq 'cfg_templatemaps') {
        } elsif ($screen eq 'cfg_feedback') {
            @fields = qw( allow_pings require_comment_emails
                          allow_comment_html autolink_urls moderate_pings );
        } elsif ($screen eq 'cfg_plugins') {
        } elsif ($screen eq 'cfg_simple') {
            @fields = qw( allow_pings moderate_pings );
        }
        for my $cb (@fields) {
            $obj->$cb(0) if !defined $app->param($cb);
        }
        if (($screen eq 'cfg_feedback') || ($screen eq 'cfg_simple')) {
            # value for comments:  1 == Accept from anyone
            #                      2 == Accept authenticated only
            #                      0 == No comments
            my $comments = $app->param('allow_comments');
            if ($comments == 1) {
                $obj->allow_unreg_comments(1);
                $obj->allow_reg_comments(1);
            } elsif ($comments == 2) {
                $obj->allow_unreg_comments(0);
                $obj->allow_reg_comments(1);
            } elsif ($comments == 0) {
                $obj->allow_unreg_comments(0);
                $obj->allow_reg_comments(0);
            }
            $obj->moderate_unreg_comments($app->param('moderate_comments'));
            my $tok = '';
            ($tok = $obj->remote_auth_token) =~ s/\s//g;
            $obj->remote_auth_token($tok);
        }
        if ($screen eq 'cfg_feedback') {
            $obj->require_comment_emails($app->param('require_email_address'));

            my $pings = $app->param('allow_pings');
            if ($pings) {
                $obj->moderate_pings($app->param('moderate_pings'));
            } else {
                $obj->moderate_pings(1);
                $obj->email_new_pings(1);
            }
            my $threshold = $app->param('junk_score_threshold');
            $threshold =~ s/\+//; $threshold ||= 0;
            $obj->junk_score_threshold($threshold);
            my $expiry = $app->param('junk_folder_expiry') || 0;
            $obj->junk_folder_expiry($expiry);
            $obj->junk_folder_expiry(0) unless $app->param('auto_delete_junk');
        }
        if ($screen eq 'cfg_entries') {
            $obj->basename_limit(15) if $obj->basename_limit < 15; # 15 is the *minimum*
            $obj->basename_limit(250) if $obj->basename_limit > 250; # 15 is the *maximum*
        }
        if (($screen eq 'cfg_prefs') || ($screen eq 'cfg_simple')) {
            if ($app->param('days_or_posts') eq 'days') {
                $obj->days_on_index($app->param('list_on_index'));
                $obj->entries_on_index(0);
            } else {
                $obj->entries_on_index($app->param('list_on_index'));
                $obj->days_on_index(0);
            }
        }
        if ($screen eq 'cfg_archives') {
            if (my $dcty = $app->param('dynamicity')) {
                $obj->custom_dynamic_templates($dcty);
            }
            if (!$app->param('enable_archive_paths')) {
                $obj->archive_url('');
                $obj->archive_path('');
            }
        }
    } else {
        #$obj->is_dynamic(0) unless defined $app->{query}->param('is_dynamic');
    }

    if (($obj->sanitize_spec || '') eq '1') {
        $obj->sanitize_spec(scalar $app->param('sanitize_spec_manual'));
    }

    1;
}

sub CMSPostSave_category {
    my $eh = shift;
    my ($app, $obj, $original) = @_;

    if (!$original->id) {
        $app->log({
            message => $app->translate("Category '[_1]' created by '[_2]'", $obj->label, $app->user->name),
            level => MT::Log::INFO(),
            class => 'category',
            category => 'new',
        });
    }
    1;
}

sub CMSPreSave_category {
    my $eh = shift;
    my ($app, $obj) = @_;
    if (defined(my $pass = $app->param('tb_passphrase'))) {
        $obj->{__tb_passphrase} = $pass;
    }
    my @siblings = MT::Category->load({ parent => $obj->parent,
                                        blog_id => $obj->blog_id });
    foreach (@siblings) {
        next if $obj->id && ($_->id == $obj->id);
        return $eh->error($app->translate("The category label '[_1]' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.", $_->label))
            if $_->label eq $obj->label;
    }
    1;
}

sub CMSPreSave_entry {
    my $eh = shift;
    my ($app, $obj) = @_;
    my $tags = $app->param('tags');
    if (defined $tags) {
        require MT::Tag;
        my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
        my @tags = MT::Tag->split($tag_delim, $tags);
        $obj->set_tags(@tags);
    }
    # update text heights if necessary
    if ($app->{perms}) {
        my $prefs = $app->{perms}->entry_prefs || $app->load_default_entry_prefs;
        my $text_height = $app->param('text_height');
        if (defined $text_height) {
            my ($pref_text_height) = $prefs =~ m/\bbody:(\d+)\b/;
            $pref_text_height ||= 0;
            if ($text_height != $pref_text_height) {
                if ($prefs =~ m/\bbody\b/) {
                    $prefs =~ s/\bbody(:\d+)\b/body:$text_height/;
                } else {
                    $prefs = 'body:' . $text_height . ',' . $prefs;
                }
            }
        }
        my $text_more_height = $app->param('text_more_height');
        if (defined $text_more_height) {
            my ($pref_text_more_height) = $prefs =~ m/\bextended:(\d+)\b/;
            $pref_text_more_height ||= 0;
            if ($text_more_height != $pref_text_more_height) {
                if ($prefs =~ m/\bextended\b/) {
                    $prefs =~ s/\bextended(:\d+)?\b/extended:$text_more_height/;
                } else {
                    $prefs = 'extended:' . $text_more_height . ',' . $prefs;
                }
            }
        }
        if ($prefs ne ($app->{perms}->entry_prefs || '')) {
            $app->{perms}->entry_prefs($prefs);
            $app->{perms}->save;
        }
    }
    $obj->discover_tb_from_entry();
    1;
}

sub CMSPostSave_blog {
    my $eh = shift;
    my ($app, $obj, $original) = @_;

    my $screen = $app->param('cfg_screen') || '';
    if ($screen eq 'cfg_archives') {
        if (my $dcty = $app->param('dynamicity')) {
            $app->update_dynamicity($obj, 
                $app->param('dynamic_cache') ? 1 : 0, 
                $app->param('dynamic_conditional') ? 1 : 0);
        }
        $app->cfg_archives_save($obj);
    }
    if ($screen eq 'cfg_entries') {
        require MT::Permission;
        my $blog_id = $obj->id;
        my $perms = MT::Permission->load({blog_id => $blog_id, author_id => 0});
        if (!$perms) {
            $perms = new MT::Permission;
            $perms->blog_id($blog_id);
            $perms->author_id(0);
        }
        my $prefs = $app->_entry_prefs_from_params;
        if ($prefs) {
            $perms->entry_prefs($prefs);
            $perms->save
                or return $app->errtrans(
                    "Saving permissions failed: [_1]", $perms->errstr);
        }
    }

    if (!$original->id) {      # If the object is new, the "orignal" was blank
        ## If this is a new blog, we need to set up a permissions
        ## record for the existing user.
        require MT::Permission;
        my $perms = MT::Permission->new;
        $perms->author_id($app->user->id);
        $perms->blog_id($obj->id);
        $perms->set_full_permissions;
        $perms->save;

        ## Load default templates into new blog database.
        require MT::DefaultTemplates;
        my $tmpl_list = MT::DefaultTemplates->templates;
        return $app->errtrans("Can't find default template list; where is " .
                              "'default-templates.pl'?")
            if !$tmpl_list || ref($tmpl_list) ne 'ARRAY' ||!@$tmpl_list;
        require MT::Template;
        my @arch_tmpl;
        for my $val (@$tmpl_list) {
            $val->{name} = $app->translate($val->{name});
            $val->{text} = $app->translate_templatized($val->{text});
            my $tmpl = MT::Template->new;
            $tmpl->set_values($val);
            $tmpl->build_dynamic(0) unless $tmpl->build_dynamic();
            $tmpl->blog_id($obj->id);
            $tmpl->save or return $app->errtrans(
                    "Populating blog with default templates failed: [_1]",
                    $tmpl->errstr);
            if ($val->{type} eq 'archive' || $val->{type} eq 'category' ||
                $val->{type} eq 'individual') {
                push @arch_tmpl, $tmpl;
            }
        }

        ## Set up mappings from new templates to archive types.
        for my $tmpl (@arch_tmpl) {
            my(@at);
            if ($tmpl->type eq 'archive') {
                @at = qw( Daily Weekly Monthly );
            } elsif ($tmpl->type eq 'category') {
                @at = qw( Category );
            } elsif ($tmpl->type eq 'individual') {
                @at = qw( Individual );
            }
            require MT::TemplateMap;
            for my $at (@at) {
                my $map = MT::TemplateMap->new;
                $map->archive_type($at);
                $map->is_preferred(1);
                $map->template_id($tmpl->id);
                $map->blog_id($tmpl->blog_id);
                $map->save
                    or return $app->errtrans("Setting up mappings failed: [_1]",
                                             $map->errstr);
            }
        }
        require MT::Log;
        $app->log({
            message => $app->translate("Weblog '[_1]' (ID:[_2]) created by '[_3]'",
                                  $obj->name, $obj->id, $app->user->name),
            level => MT::Log::INFO(),
            class => 'blog',
            category => 'new',
        });
    } else {
        # if you've changed the comment configuration
        if ((grep { $original->column($_) ne $obj->column($_) }
             qw(allow_unreg_comments allow_reg_comments remote_auth_token)))
        {
            if (RegistrationAffectsArchives($obj->id,'Individual'))
            {
                $app->add_return_arg(need_full_rebuild => 1);
            } else {
                $app->add_return_arg(need_index_rebuild => 1);
            }
        }
        # if other settings were changed that would affect published pages:
        if (grep { $original->column($_) ne $obj->column($_) }
            qw(allow_pings allow_comment_html)) {
            $app->add_return_arg(need_full_rebuild => 1);
        }
    }
    1;
}

sub RegistrationAffectsArchives {       # :-P
    my ($blog_id, $archive_type) = @_;
    require MT::TemplateMap;
    require MT::Template;
    my @tms = MT::TemplateMap->load({archive_type => $archive_type,
                                     blog_id => $blog_id});
    grep { $_->text =~ /MTIfRegistrationRequired|MTIfRegistrationNotRequired|MTIfRegistrationAllowed/ }
     map { MT::Template->load($_->template_id) } @tms;
}

sub CMSPostSave_author {
    my $eh = shift;
    my ($app, $obj, $original) = @_;

    if (!$original->id) {
        $app->log({
            message => $app->translate("User '[_1]' (ID:[_2]) created by '[_3]'",
                                  $obj->name, $obj->id, $app->user->name),
            level => MT::Log::INFO(),
            class => 'author',
            category => 'new',
        });

        my $author_id = $obj->id;
        for my $blog_id ($app->param('add_to_blog')) {
            # FIXME: check for existing permission just in case
            my $pe = MT::Permission->new;
            $pe->blog_id($blog_id);
            $pe->author_id($author_id);
            # By default, a new user can post and comment
            $pe->can_post(1);
            $pe->can_comment(1);
            $pe->save;
        }
    } else {
        if ($app->user->id == $obj->id) {
            ## If this is a user editing his/her profile, $id will be
            ## some defined value; if so we should update the user's
            ## cookie to reflect any changes made to username and password.
            ## Otherwise, this is a new user, and we shouldn't update the
            ## cookie.
            $app->user($obj);
            if (($obj->name ne $original->name) ||
                ($app->param('pass'))) {
                $app->start_session();
            }
        }
    }
    1;
}

sub CMSPostSave_comment {
    my $eh = shift;
    my ($app, $obj, $original) = @_;
    if ($obj->visible || (($obj->visible || 0) != ($original->visible||0))) {
        $app->rebuild_entry(Entry => $obj->entry_id, BuildIndexes => 1);
    }
    1;
}

sub CMSPostSave_ping {
    my $eh = shift;
    my ($app, $obj, $original) = @_;
    require MT::Trackback;
    require MT::Entry;
    require MT::Category;
    if (my $tb = MT::Trackback->load($obj->tb_id, {cached_ok=>1})) {
        my ($entry, $cat); 
        if ($tb->entry_id && ($entry = MT::Entry->load($tb->entry_id, {cached_ok=>1}))) {
            if ($obj->visible || (($obj->visible || 0) != ($original->visible || 0))) {
                $app->rebuild_entry(Entry => $entry, BuildIndexes => 1);
            }
        } elsif ($tb->category_id && ($cat = MT::Category->load($tb->category_id, {cached_ok=>1}))) {
             # FIXME: rebuild single category
        }
    }
    1;
}

sub CMSPostSave_trackback {
    my $eh = shift;
    my ($app, $obj, $original) = @_;
    $app->rebuild_entry(Entry => $obj->entry_id, BuildIndexes => 1);
    1;
}

sub CMSPostSave_template {
    my $eh = shift;
    my ($app, $obj, $original) = @_;

    if (!$original->id) {
        $app->log({
            message => $app->translate("Template '[_1]' (ID:[_2]) created by '[_3]'",
                                  $obj->name, $obj->id, $app->user->name),
            level => MT::Log::INFO(),
            class => 'template',
            category => 'new',
        });
    }

    if ($obj->build_dynamic && !$original->build_dynamic) {
        if ($obj->type eq 'index') {
            $app->rebuild_indexes(BlogID => $obj->blog_id,
                                  Template => $obj);            # XXXX
        } else {
            $app->rebuild(BlogID => $obj->blog_id,
                          TemplateID => $obj->id);
        }
    }
    1;
}

sub CMSSavePermissionFilter_blog {
    my ($eh, $app, $id) = @_;
    return  ($id && $app->{perms}->can_edit_config)
        || (!$id && $app->user->can_create_blog);
}

sub CMSSavePermissionFilter_template {
    my ($eh, $app, $id) = @_;
    return $app->{perms}->can_edit_templates;
}

sub CMSSavePermissionFilter_category {
    my ($eh, $app, $id) = @_;
    return $app->{perms}->can_edit_categories();
}

sub CMSSavePermissionFilter_notification {
    my ($eh, $app, $id) = @_;
    return $app->{perms}->can_edit_notifications;
}

sub CMSSavePermissionFilter_author {
    my ($eh, $app, $id) = @_;
    my $author = $app->user;
    if (!$id) {
        return $author->is_superuser;
    } else {
        return $author->id == $id;
    }
}

sub CMSSavePermissionFilter_comment {
    my ($eh, $app, $id) = @_;
    return 0 unless $id;  # Can't create new comments here
    return 1 if $app->{perms}->can_edit_all_posts;
    if ($app->{perms}->can_post) {
        my $c = MT::Comment->load($id, {cached_ok=>1});
        return ($c->entry->author_id == $app->user->id);
    } else {
        return 0;
    }
}

sub CMSSavePermissionFilter_ping {
    my ($eh, $app, $id) = @_;
    return 0 unless $id;  # Can't create new pings here
    return 1 if $app->{perms}->can_edit_all_posts;
    my $p = MT::TBPing->load($id, {cached_ok=>1});
    my $tbitem = $p->parent;
    if ($tbitem->isa('MT::Entry')) { 
        return ($app->{perms}->can_post &&
                ($tbitem->author_id == $app->user->id));
    } else {
        return $app->{perms}->can_edit_categories;
    }
}

sub CMSSavePermissionFilter_banlist {
    my ($eh, $app, $id) = @_;
    $app->{perms}->can_edit_config;
}

sub CMSDeletePermissionFilter_association {
    my ($eh, $app, $obj) = @_;

    my $blog_id = $app->param('blog_id');
    my $user = $app->user;
    if (!$user->is_superuser) {
        if (!$blog_id || !$user->permissions($blog_id)->can_administer_blog) {
            return $eh->error(MT->translate("Permission denied."));
        }
        if ($obj->author_id == $user->id) {
            return $eh->error(MT->translate("You cannot delete your own association."));
        }
    }
    1;
}

sub CMSDeletePermissionFilter_author {
    my ($eh, $app, $obj) = @_;
    my $author = $app->user;
    if ($author->id == $obj->id) {
        return $eh->error(MT->translate("You cannot delete your own user record."));
    }
    return 1 if $author->is_superuser();
    if (!($obj->created_by && $obj->created_by == $author->id)) {
        return $eh->error(MT->translate("You have no permission to delete the user [_1].", $obj->name))
    }
}

sub CMSDeletePermissionFilter_blog {
    my ($eh, $app, $obj) = @_;
    my $author = $app->user;
    return 1 if $author->is_superuser();
    require MT::Permission;
    my $perms = $author->permissions($obj->id);
    ($perms && $perms->can_administer_blog);
}

sub CMSDeletePermissionFilter_category {
    my ($eh, $app, $obj) = @_;
    return 1 if $app->user->is_superuser();
    $app->{perms}->can_edit_categories();
}

sub CMSDeletePermissionFilter_comment {
    my ($eh, $app, $obj) = @_;
    my $author = $app->user;
    return 1 if $author->is_superuser();
    my $perms = $app->{perms};
    require MT::Entry;
    my $entry = MT::Entry->load($obj->entry_id, {cached_ok=>1});
    if (!$perms || $perms->blog_id != $entry->blog_id) {
        $perms ||= $author->permissions($entry->blog_id);
    }
    ($perms && $perms->can_edit_entry($entry, $author));
}

sub CMSDeletePermissionFilter_commenter {
    my ($eh, $app, $obj) = @_;
    my $author = $app->user;
    return 1 if $author->is_superuser();
    my $perms = $author->permissions($obj->blog_id);
    ($perms && $perms->can_administer_blog);
}

sub CMSDeletePermissionFilter_entry {
    my ($eh, $app, $obj) = @_;
    my $author = $app->user;
    return 1 if $author->is_superuser();
    my $perms = $app->{perms};
    if (!$perms || $perms->blog_id != $obj->blog_id) {
        $perms ||= $author->permissions($obj->blog_id);
    }
    ($perms && $perms->can_edit_entry($obj, $author));
}

sub CMSDeletePermissionFilter_ping {
    my($eh, $app, $obj) = @_;
    my $author = $app->user;
    return 1 if $author->is_superuser();
    my $perms = $app->{perms};
    require MT::Trackback;
    my $tb = MT::Trackback->load($obj->tb_id, {cached_ok=>1});
    if (my $entry = $tb->entry) {
        if (!$perms || $perms->blog_id != $entry->blog_id) {
            $perms ||= $author->permissions($entry->blog_id);
        }
        return ($perms && $perms->can_edit_entry($entry, $author));
    } elsif ($tb->category_id) {
        $perms ||= $author->permissions($tb->blog_id);
        return ($perms && $perms->can_edit_categories());
    }
    0;
}

sub CMSDeletePermissionFilter_tag {
    my ($eh, $app, $obj) = @_;
    return 1 if $app->user->is_superuser();
    return 1 if $app->blog && ($app->{perms}->can_administer_blog() || $app->{perms}->can_edit_tags);
    0;
}

sub CMSDeletePermissionFilter_template {
    my ($eh, $app, $obj) = @_;
    return 1 if $app->user->is_superuser();
    $app->{perms}->can_edit_templates;
}

sub CMSPostDelete_blog {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Weblog '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->name, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'blog',
        category => 'delete'
    });
}

sub CMSPostDelete_notification {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Subscriber '[_1]' (ID:[_2]) deleted from notification list by '[_3]'", $obj->email, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_author {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("User '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->name, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_category {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Category '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->label, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_comment {
    my ($eh, $app, $obj) = @_;

    require MT::Entry;
    my $title = '';
    if (my $entry = MT::Entry->load($obj->entry_id, {cached_ok=>1})) {
        $title = $entry->title;
    }

    $app->log({
        message => $app->translate("Comment (ID:[_1]) by '[_2]' deleted by '[_3]' from entry '[_4]'", $obj->id, $obj->author, $app->user->name, $title),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_entry {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Entry '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->title, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_ping {
    my ($eh, $app, $obj) = @_;

    my ($message,$title);
    my $obj_parent = $obj->parent();
    if ($obj_parent->isa('MT::Category')) {
        $title = $obj_parent->label || $app->translate('(Unlabeled category)');
        $message = $app->translate("Ping (ID:[_1]) from '[_2]' deleted by '[_3]' from category '[_4]'", $obj->id, $obj->blog_name, $app->user->name, $title);
    } else {
        $title = $obj_parent->title || $app->translate('(Untitled entry)');
        $message = $app->translate("Ping (ID:[_1]) from '[_2]' deleted by '[_3]' from entry '[_4]'", $obj->id, $obj->blog_name, $app->user->name, $title);
    }
        
    $app->log({
        message => $message,
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_template {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Template '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->name, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostDelete_tag {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Tag '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->name, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'delete'
    });
}

sub CMSPostSave_asset {
    my $eh = shift;
    my ($app, $obj, $original) = @_;

    if (!$original->id) {
        $app->log({
            message => $app->translate("Asset '[_1]' created by '[_2]'", $obj->file_name, $app->user->name),
            level => MT::Log::INFO(),
            class => 'asset',
            category => 'new',
        });
    }
    1;
}

sub CMSPostDelete_asset {
    my ($eh, $app, $obj) = @_;

    $app->log({
        message => $app->translate("Asset '[_1]' (ID:[_2]) deleted by '[_3]'", $obj->file_name, $obj->id, $app->user->name),
        level => MT::Log::INFO(),
        class => 'asset',
        category => 'delete'
    });
}

sub save_object {
    my $app = shift;
    my $q = $app->param;
    my $type = $q->param('_type');
    my $id = $q->param('id');
    $q->param('allow_pings', 0) if ($type eq 'category') && !defined($q->param('allow_pings'));

    $app->validate_magic() or return;
    my $author = $app->user;

    # Check permissions
    my $perms = $app->{perms};

    if (!$author->is_superuser) {
        if ($type ne 'author') {  # for authors, blog-ctx $perms is not relevant
            return $app->errtrans("Permisison denied.")
                if !$perms && $id;
        } 

        MT->run_callbacks('CMSSavePermissionFilter.' . $type, $app, $id)
            || return $app->error($app->translate("Permission denied.")
                                  . " " . MT->errstr());
    }

    my $filter_result = MT->run_callbacks('CMSSaveFilter.' . $type, $app);
        
    if (!$filter_result) {
        my %param;
        $param{error} = MT->errstr;
        $param{return_args} = $app->param('return_args');

        if (($type eq 'notification') || ($type eq 'banlist')) {
            return $app->list_objects(\%param);
        } elsif (($app->param('cfg_screen') || '') eq 'cfg_archives') {
            return $app->cfg_archives(\%param);
        } else {
            return $app->edit_object(\%param);
        }
    }

    return $app->errtrans('The Template Name and Output File fields are required.')
        if $type eq 'template' && !$q->param('name') && !$q->param('outfile');

    if ($type eq 'author') {
        ## If we are saving an author profile, we need to do some
        ## password maintenance. First make sure that the two
        ## passwords match...
        my %param;
        if ($q->param('pass') && $q->param('pass_verify') &&
            $q->param('pass') ne $q->param('pass_verify')) {
            $param{error} = $app->translate('Passwords do not match.');
        } else {
            if ($q->param('pass') && $id) {
                my $auth = MT::Author->load($id, {cached_ok=>1});
                if (!$auth->is_valid_password($q->param('old_pass'))) {
                    $param{error} = $app->translate('Failed to verify current password.');
                }
            }
        }
        if ($q->param('hint')) {
            my $hint = $q->param('hint') || '';
            $hint =~ s!^\s+|\s+$!!gs;
            $param{error} = $app->translate('Password recovery word/phrase is required.')
                unless $hint;
        }
        if ($param{error}) {
            $param{return_args} = $app->param('return_args');
            my $qual = $id ? '' : 'author_state_';
            # TBD: make sure all parameters are restored here. and this
            # is repetitive
            for my $f (qw( name nickname email url )) {
                $param{$qual . $f} = $q->param($f);
            }
            return $app->edit_object(\%param);
        }

        ## ... then check to make sure that the author isn't trying
        ## to change his/her username to one that already exists.
        my $name = $app->param('name');
        my $existing = MT::Author->load({ name => $name,
                                          type => MT::Author::AUTHOR});
        if ($existing && (!$q->param('id') ||
            $existing->id != $q->param('id'))) {
            my %param = (error => $app->translate('An author by that name already exists.'));
            my $qual = $id ? '' : 'author_state_';
            for my $f (qw( name email url )) {
                $param{$qual . $f} = $q->param($f);
            }
            return $app->edit_object(\%param);
        }
    }

    my $class = $app->_load_driver_for($type) or return;
    my($obj);
    if ($id) {
        $obj = $class->load($id);
    } else {
        $obj = $class->new;
    }

    my $original = $obj->clone();
    my $names = $obj->column_names;
    my %values = map { $_ => (scalar $q->param($_)) } @$names;

    if ($type eq 'author') {
        my @cols = qw(is_superuser can_create_blog can_view_log status);
        if (!$author->is_superuser) {
            delete $values{$_} for @cols;
        } else {
            if (!$id || ($author->id != $id)) {
                if ($values{'status'} == MT::Author::ACTIVE()) {
                    foreach (@cols) {
                        $values{$_} = 0 unless defined $values{$_};
                    }
                }
            }
        }
    }

    if ($type eq 'comment') {
        require MT::Entry;
        my $entry = MT::Entry->load($obj->entry_id, {cached_ok=>1});
        if (!($entry->author_id == $app->user->id
              || $perms->can_edit_all_posts)) {
            return $app->error($app->translate("Permission denied."));
        }
    }
    if ($type eq 'blog') {
        ## If this is a new blog, set the preferences and archive
        ## settings to the defaults.
        if (!$obj->id) {
            $obj->language($app->user->preferred_language);
        }
        
        $values{file_extension} =~ s/^\.*// if $q->param('file_extension') ne '';
    }

    $obj->set_values(\%values);

    if ($obj->properties->{audit}) {
        $obj->created_by($author->id) unless $obj->id;
        $obj->modified_by($author->id);
    }

    MT->run_callbacks('CMSPreSave.' . $type, $app, $obj, $original)
        || return $app->edit_object({ error => $app->translate("Save failed: [_1]", MT->errstr) });

    # Done pre-processing the record-to-be-saved; now save it.

    $obj->touch() if ($type eq 'blog');

    $obj->save or
        return $app->error($app->translate(
            "Saving object failed: [_1]", $obj->errstr));

    # Now post-process it.
    MT->run_callbacks('CMSPostSave.' . $type, $app, $obj, $original)
        or return $app->error(MT->errstr());

    # Finally, decide where to go next, depending on the object type.
    my $blog_id = $q->param('blog_id');
    if ($type eq 'blog') {
        $blog_id = $obj->id;
    }

    # TODO: convert this to use $app->call_return(); 
    # then templates can determine the page flow.
    if ($type eq 'notification') {
        return $app->redirect($app->uri('mode' => 'list',
            args => { '_type' => 'notification', blog_id => $blog_id,
                      saved => $obj->email }));
    } elsif (my $cfg_screen = $q->param('cfg_screen')) {
        if ($cfg_screen eq 'cfg_templatemaps') {
            $cfg_screen = 'cfg_archives';
        }
        my $site_path = $obj->site_path;
        my $fmgr = $obj->file_mgr;
        unless ($fmgr->exists($site_path)) {
            $fmgr->mkpath($site_path);
        }
        $app->add_return_arg( no_writedir => 1 )
            unless $fmgr->exists($site_path) && $fmgr->can_write($site_path);
    } elsif ($type eq 'banlist') {
        return $app->redirect($app->uri('mode' => 'list',
            args => {'_type' => 'banlist', blog_id => $blog_id,
                     saved => $obj->ip}));
    } elsif ($type eq 'template' && $q->param('rebuild')) {
        $q->param('type', 'index-' . $obj->id);
        $q->param('tmpl_id', $obj->id);
        $q->param('single_template', 1);
        return $app->start_rebuild_pages();
    } elsif ($type eq 'blog') {
        return $app->redirect($app->uri('mode' => 'cfg_prefs',
            args => { blog_id => $blog_id, saved => 1}));
    }
    $app->add_return_arg('id' => $obj->id) if !$original->id;
    $app->add_return_arg('saved' => 1);
    $app->call_return;
}

sub list_objects {
    my $app = shift;
    my %param = $_[0] ? %{ $_[0] } : ();
    my $q = $app->param;
    my $type = $q->param('_type');
    my $perms = $app->{perms};
    return $app->errtrans("Permission denied.")
        unless $perms;
    if ($perms &&
        (($type eq 'blog' && !$perms->can_edit_config) ||
         ($type eq 'template' && !$perms->can_edit_templates) ||
         ($type eq 'notification' && !$perms->can_edit_notifications))) {
        return $app->error($app->translate("Permission denied."));
    }
    my $id = $q->param('id');
    my $class = $app->_load_driver_for($type) or return;
    my $blog_id = $q->param('blog_id');
    my $list_pref = $app->list_pref($type);
    my (%terms, %args);
    %param = ( %param, %$list_pref );
    my $cols = $class->column_names;
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    for my $name (@$cols) {
        $terms{blog_id} = $blog_id, last
            if $name eq 'blog_id';
    }
    if ($type eq 'notification') {
        $args{direction} = 'descend';
        $args{offset} = $offset;
        $args{limit} = $limit + 1;
    } elsif ($type eq 'banlist') {
        $limit = 0;
    }
    my $iter = $class->load_iter(\%terms, \%args);

    my(@data, @index_data, @custom_data, @archive_data, @system_data);
    my(%authors);
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    while (my $obj = $iter->()) {
        my $row = $obj->column_values;
        if (my $ts = $obj->created_on) {
            $row->{created_on_formatted} = format_ts("%Y.%m.%d", $ts);
            $row->{created_on_time_formatted} = format_ts("%Y.%m.%d %H:%M:%S", $ts);
            $row->{created_on_relative} = relative_date($ts, time, $blog);
        }
        if ($type eq 'template') {
            $row->{name} = '' if !defined $row->{name};
            $row->{name} =~ s/^\s+|\s+$//g;
            $row->{name} = "(" . $app->translate("No Name") . ")"
                if $row->{name} eq '';
            #$row->{name} = $app->translate($row->{name});
            if ($obj->type eq 'index') {
                push @index_data, $row;
                $row->{rebuild_me} = defined $row->{rebuild_me} ?
                    $row->{rebuild_me} : 1;
                my $published_url = $obj->published_url;
                $row->{published_url} = $published_url if $published_url;
            } elsif ($obj->type eq 'custom') {
                push @custom_data, $row;
            } elsif ($obj->type eq 'archive' || $obj->type eq 'category' ||
                     $obj->type eq 'individual') {
                push @archive_data, $row;
            } else {
                $row->{name} = $app->translate($row->{name});
                my $system_template = '_SYSTEM_TEMPLATE_' . uc($row->{type});
                $row->{description} = $app->translate($system_template);
                push @system_data, $row;
            }
            $param{search_type} = $app->translate('Templates');
        } else {
            if ($limit && (scalar @data == $limit)) {
                $param{next_offset} = 1;
                last;
            }
            push @data, $row;
        }
        if ($type eq 'ping') {
            return $app->list_pings();
            require MT::Trackback;
            require MT::Entry;
            my $tb_center = MT::Trackback->load($obj->tb_id, {cached_ok=>1});
            my $entry = MT::Entry->load($tb_center->entry_id, {cached_ok=>1});
            if (my $ts = $obj->created_on) {
                $row->{created_on_time_formatted}
                   = format_ts("%Y.%m.%d %H:%M:%S", $ts);
                $row->{has_edit_access} = $perms->can_edit_all_posts
                                      || $app->user->id == $entry->author_id;
            }
        }
    } # end loop over the set of objects;
    # NOW transform the @data array
    if ($type eq 'notification') {
        $app->add_breadcrumb($app->translate('Notification List'));
        $param{nav_notifications} = 1;
        #@data = sort { $a->{email} cmp $b->{email} } @data;
        $param{object_type} = 'notification';
        $param{object_type_plural} = $app->translate('email addresses');
        $param{list_noncron} = 1;
    }
    if ($type eq 'template') {
        my $blog = MT::Blog->load(scalar $q->param('blog_id'), {cached_ok=>1});
        $app->add_breadcrumb($app->translate('Templates'));
        $param{nav_templates} = 1;
        for my $ref (\@index_data, \@custom_data, \@archive_data) {
            @$ref = sort { $a->{name} cmp $b->{name} } @$ref;
        }
        my $tab = $app->param('tab') || 'index';
        $param{"tab_$tab"} = 1;
        $param{object_index_loop} = \@index_data;
        $param{object_custom_loop} = \@custom_data;
        $param{object_archive_loop} = \@archive_data;
        $param{object_system_loop} = \@system_data;
        $param{object_type} = 'template';
        $param{object_type_plural} = $app->translate('templates');
    } else {
        $param{object_loop} = \@data;
    }
    # add any breadcrumbs
    if ($type eq 'banlist') {
        my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
        $app->add_breadcrumb($app->translate('IP Banning'));
        $param{nav_config} = 1;
        $param{object_type} = 'banlist';
        $param{show_ip_info} = 1;
        $param{object_type_plural} = $app->translate('IP addresses');
        $param{list_noncron} = 1;
    } elsif ($type eq 'ping') {
        $app->add_breadcrumb($app->translate('TrackBacks'));
        $param{nav_trackbacks} = 1;
        $param{object_type} = 'ping';
        $param{object_type_plural} = $app->translate('TrackBacks');
    }
    $param{object_count} = scalar @data;

    if ($type ne 'template') {
        $param{offset} = $offset;
        $param{list_start} = $offset + 1;
        delete $args{limit};
        delete $args{offset};
        $param{list_total} = $class->count(\%terms, \%args);
        $param{list_end} = $offset + (scalar @data);
        $param{next_offset_val} = $offset + (scalar @data);
        #$param{next_offset} = $param{next_offset_val} < $param{list_total} ? 1 : 0;
        $param{next_max} = $param{list_total} - $limit;
        $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
        if ($offset > 0) {
            $param{prev_offset} = 1;
            $param{prev_offset_val} = $offset - $limit;
            $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
        }
    }

    my $plugin_actions = $app->plugin_itemset_actions($type);
    $param{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions($type);
    $param{core_itemset_action_loop} = $core_actions || [];
    $param{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;

    $param{saved} = $q->param('saved');
    $param{saved_deleted} = $q->param('saved_deleted');
    $param{plugin_action_loop} = $app->plugin_actions('list_'.$type) || [];
    $app->build_page("list_${type}.tmpl", \%param);
}

sub delete_confirm {
    my $app = shift;
    my %param = ( type => scalar $app->param('_type') );
    my @data;
    for my $id ($app->param('id')) {
        push @data, { id => $id };
    }
    $param{parent} = $app->param('parent');
    $param{id_loop} = \@data;
    $param{num} = scalar @data;
    $param{'type_' . $param{type}} = 1;
    $param{is_zero} = @data == 0;
    $param{is_one} = @data == 1;
    $param{is_many} = !$param{is_zero} && !$param{is_one};
    $param{thisthese} = $param{is_one} ? 'this' : 'these';
    $param{is_power_edit} = $app->param('is_power_edit') ? 1 : 0;
    $param{return_args} = $app->param('return_args');
    $app->build_page('delete_confirm.tmpl', \%param);
}

sub delete {
    my $app = shift;
    my $q = $app->param;
    my $type = $q->param('_type');
    my $parent = $q->param('parent');
    my $blog_id = $q->param('blog_id');
    my $class = $app->_load_driver_for($type) or return;
    my $perms = $app->{perms};
    my $author = $app->user;

    return $app->error($app->translate("Can't delete that way"))
        if $app->request_method() ne 'POST';

    $app->validate_magic() or return;

    my($entry_id, $cat_id, $author_id) = ("", "", "");
    my %rebuild_entries;
    my @rebuild_cats;
    my $required_items = 0;
    for my $id ($q->param('id')) {
        next unless $id; # avoid 'empty' ids

        my $obj = $class->load($id, {cached_ok=>1});
        next unless $obj;
        MT->run_callbacks('CMSDeletePermissionFilter.' . $type, $app, $obj)
            || return $app->error($app->translate("Permission denied: [_1]", 
                          MT->errstr()));

        if ($type eq 'comment') {
            $entry_id = $obj->entry_id;
            $rebuild_entries{$entry_id} = 1 if $obj->visible;
        } elsif ($type eq 'ping' || $type eq 'ping_cat') {
            require MT::Trackback;
            my $tb = MT::Trackback->load($obj->tb_id, {cached_ok=>1});
            if ($tb) {
                $entry_id = $tb->entry_id;
                $cat_id = $tb->category_id;
                if ($obj->visible) {
                    $rebuild_entries{$entry_id} = 1 if $entry_id;
                    push @rebuild_cats, $cat_id if $cat_id;
                }
            }
        } elsif ($type eq 'tag') {
            # if we're in a blog context, remove ONLY tags from that weblog
            if ($blog_id) {
                require MT::ObjectTag;
                require MT::Entry;
                my $iter = MT::ObjectTag->load_iter({ blog_id => $blog_id,
                    object_datasource => MT::Entry->datasource,
                    tag_id => $id });

                if ($iter){
                    my @ot;
                    while (my $obj = $iter->()) {
                        push @ot, $obj->id;
                    }
                    foreach (@ot) {
                        my $obj = MT::ObjectTag->load($_);
                        $obj->remove;
                    }
                }

                MT->run_callbacks('CMSPostDelete.' . $type, $app, $obj);
                next;

            }
        } elsif ($type eq 'category') {
            my @kids = MT::Category->load({parent => $id});
            return $app->errtrans("You can't delete that category because it has sub-categories. Move or delete the sub-categories first if you want to delete this one.") if @kids;
            if ($app->config('DeleteFilesAtRebuild')) {
                $app->publisher->remove_entry_archive_file( Category => $obj,
                                                            ArchiveType => 'Category' );
            }
        } elsif ($type eq 'entry') {
            if ($app->config('DeleteFilesAtRebuild')) {
                $app->publisher->remove_entry_archive_file( Entry => $obj,
                                                            ArchiveType => 'Individual' );
            }
        }

        if ($type eq 'template' && $obj->type !~ /(custom|index|archive|individual|category)/o) {
            $required_items++;
        }
        else {
            $obj->remove;
            MT->run_callbacks('CMSPostDelete.' . $type, $app, $obj);
        }
    }
    require MT::Entry;
    for my $entry_id (keys %rebuild_entries) {
        my $entry = MT::Entry->load($entry_id, {cached_ok=>1});
        $app->rebuild_entry( Entry => $entry, BuildDependencies => 1 );
    }
    for my $cat_id (@rebuild_cats) {
        my $cat = MT::Category->load($cat_id, {cached_ok=>1});
        $app->rebuild( Category => $cat, BlogID => $blog_id,
                       ArchiveType => 'Category' );
    }
    $app->add_return_arg($type eq 'ping' ? (saved_deleted_ping => 1) 
                         : (saved_deleted => 1));
    if ($q->param('is_power_edit')) {
        $app->add_return_arg(is_power_edit => 1);
    }
    if ($required_items) {
        $app->add_return_arg(error => $app->translate("System templates can not be deleted."));
    }
    $app->call_return;
}

sub enable_object  { shift->set_object_status( MT::Author::ACTIVE() ) }
sub disable_object { shift->set_object_status( MT::Author::INACTIVE()) }
sub set_object_status {
    my $app = shift;
    my ($new_status) = @_;

    $app->validate_magic() or return;
    return $app->error($app->translate('Permission denied.'))
        unless $app->user->is_superuser;
    return $app->error($app->translate("Invalid request."))
        if $app->request_method ne 'POST';

    my $q = $app->param;
    my $type = $q->param('_type');
    return $app->error($app->translate('Invalid type'))
        unless ($type eq 'author');

    my $class = $app->_load_driver_for($type);

    my @sync;
    my $saved = 0;
    for my $id ($q->param('id')) {
        next unless $id; # avoid 'empty' ids
        my $obj = $class->load($id, { cached_ok => 1 });
        next unless $obj;
        if (($obj->id == $app->user->id) && ($type eq 'author')) {
            next;
        }
        next if $new_status == $obj->status;
        $obj->status($new_status);
        $obj->save;
        $saved++;
        if ($type eq 'author') {
            if ($new_status == MT::Author::ACTIVE()) {
                push @sync, $obj;
            }
        }
    }
    my $unchanged = 0;
    if (@sync) {
        MT::Auth->synchronize_author(User => \@sync);
        foreach (@sync) {
            if ($_->status != MT::Author::ACTIVE()) {
                $unchanged++;
            }
        }
    }
    if ($saved && ($saved > $unchanged)) {
        $app->add_return_arg(saved_status => ($new_status == MT::Author::ACTIVE()) ? 'enabled' : 'disabled');
    }
    $app->add_return_arg(is_power_edit => 1)
        if $q->param('is_power_edit');
    $app->add_return_arg(unchanged => $unchanged)
        if $unchanged;
    $app->call_return;
}

sub _load_driver_for {
    my $app = shift;
    my($type) = @_;
    my $class = $API{$type} or
        return $app->error($app->translate("Unknown object type [_1]",
            $type));
    eval "use $class;";
    if (my $err = $@) {
        return $app->error($app->translate(
            "Loading object driver [_1] failed: [_2]", $class, $err));
    }
    $class;
}

sub register_type {
    my $app = shift;
    my ($type, $param) = @_;
    $API{$type} = $param;
}

sub asset_insert {
    my $app = shift;
    defined(my $text = $app->_process_post_upload) or return;
    $app->build_page('asset_insert.tmpl', {
            upload_html => $text,
            edit_field => $app->param('edit_field'),
        },
    );
}

sub start_upload_entry {
    my $app = shift;
    my $q = $app->param;
    $q->param('_type', 'entry');
    defined(my $text = $app->_process_post_upload) or return;
    $q->param('text', $text);
    $app->edit_object;
}

sub _process_post_upload {
    my $app = shift;
    my $q = $app->param;
    my($url, $width, $height) = map $q->param($_), qw( url width height );
    my ($base_url, $fname) = $url =~ m|(.*)/([^/]*)|;
    $url = $base_url . '/' . $fname; # no need to re-encode filename; url is already encoded
    my $blog_id = $q->param('blog_id');
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    my($thumb, $thumb_width, $thumb_height);
    # Save new defaults if requested.
    if($q->param('image_defaults')) {
        return $app->error($app->translate(
            'Permission denied setting image defaults for blog #[_2]', $blog_id
        )) unless $app->{perms}->can_save_image_defaults;
        $blog->image_default_set(1);
        $blog->image_default_wrap_text($q->param('wrap_text') ? 1 : 0);
        $blog->image_default_align($q->param('align') || MT::Blog::ALIGN());
        $blog->image_default_thumb($q->param('thumb') ? 1 : 0);
        $blog->image_default_width($q->param('thumb_width') || MT::Blog::WIDTH());
        $blog->image_default_wunits($q->param('thumb_width_type') || MT::Blog::UNITS());
        $blog->image_default_height($q->param('thumb_height') || MT::Blog::WIDTH());
        $blog->image_default_hunits($q->param('thumb_height_type') || MT::Blog::UNITS());
        $blog->image_default_constrain($q->param('constrain') ? 1 : 0);
        $blog->image_default_popup($q->param('popup') ? 1 : 0);
    }
    else {
        $blog->image_default_set(0);
        $blog->image_default_wrap_text(0);
        $blog->image_default_align(MT::Blog::ALIGN());
        $blog->image_default_thumb(0);
        $blog->image_default_width(0);
        $blog->image_default_wunits(MT::Blog::UNITS());
        $blog->image_default_height(0);
        $blog->image_default_hunits(MT::Blog::UNITS());
        $blog->image_default_constrain(1);
        $blog->image_default_popup(0);
    }
    $blog->save;
    if ($thumb = $q->param('thumb')) {
        require MT::Image;
        my $base_path = $q->param('site_path') ?
            $blog->site_path : $blog->archive_path;
        my $file = $q->param('fname');
        if ($file =~ m!\.\.|\0|\|!) {
            return $app->error($app->translate("Invalid filename '[_1]'", $file));
        }
        my $i_file = File::Spec->catfile($base_path, $file);
        ## Untaint. We checked $file for security holes above.
        ($i_file) = $i_file =~ /(.+)/s;
        my $fmgr = $blog->file_mgr;
        my $data = $fmgr->get_data($i_file, 'upload')
            or return $app->error($app->translate(
                "Reading '[_1]' failed: [_2]", $i_file, $fmgr->errstr));
        my $image_type = scalar $q->param('image_type');
        my $img = MT::Image->new( Data => $data,
                                  Type => $image_type )
            or return $app->error($app->translate(
                "Thumbnail failed: [_1]", MT::Image->errstr));
        my($w, $h) = map $q->param($_), qw( thumb_width thumb_height );
        (my($blob), $thumb_width, $thumb_height) =
            $img->scale( Width => $w, Height => $h )
            or return $app->error($app->translate("Thumbnail failed: [_1]",
                $img->errstr));
        require File::Basename;
        my($base, $path, $ext) = File::Basename::fileparse($i_file, '\.[^.]*');
        my $t_file = $path . $base . '-thumb' . $ext;
        my $basename = $base . '-thumb' . $ext;
        $fmgr->put_data($blob, $t_file, 'upload')
            or return $app->error($app->translate(
                "Error writing to '[_1]': [_2]", $t_file, $fmgr->errstr));

        $file =~ s/\Q$base$ext\E$//;
        my $url = $q->param('site_path') ? $blog->site_url : $blog->archive_url;
        $url .= '/' unless $url =~ m!/$!;
        $url .= $file;
        $thumb = $url . encode_url($base . '-thumb' . $ext);

        require MT::Asset;
        my $img_pkg = MT::Asset->class_handler('image');
        my $asset = new $img_pkg;
        my $original = $asset->clone;
        $asset->blog_id($blog_id);
        #$asset->url($thumb);
        $asset->file_path($t_file);
        $asset->file_name($basename);
        my $ext2 = $ext;
        $ext2 =~ s/^\.//;
        $asset->file_ext($ext2);
        $asset->image_width($thumb_width);
        $asset->image_height($thumb_height);
        $asset->created_by($app->user->id);
        $asset->save;
        MT->run_callbacks('CMSPostSave.asset', $app, $asset, $original);

        $app->param('thumb_asset_id' => $asset->id);

        MT->run_callbacks('CMSUploadFile',
                          File => $t_file, Url => $thumb, Size => length($blob),
                          Asset => $asset,
                          Type => 'thumbnail',
                          Blog => $blog);

        MT->run_callbacks('CMSUploadImage',
                          File => $t_file, Url => $thumb,
                          Asset => $asset,
                          Width => $thumb_width, Height => $thumb_height,
                          ImageType => $image_type,
                          Size => length($blob),
                          Type => 'thumbnail',
                          Blog => $blog);
    }
    if ($q->param('popup')) {
        require MT::Template;
        if (my $tmpl = MT::Template->load({ blog_id => $blog_id,
                                            type => 'popup_image' })) {
            (my $rel_path = $q->param('fname')) =~ s!\.[^.]*$!!;
            if ($rel_path =~ m!\.\.|\0|\|!) {
                return $app->error($app->translate(
                    "Invalid basename '[_1]'", $rel_path));
            }
            my $ext = $blog->file_extension || '';
            $ext = '.' . $ext if $ext ne '';
            require MT::Template::Context;
            my $ctx = MT::Template::Context->new;
            $ctx->stash('image_url', $url);
            $ctx->stash('image_width', $width);
            $ctx->stash('image_height', $height);
            my $popup = $tmpl->build($ctx);
            my $fmgr = $blog->file_mgr;
            my $root_path = $q->param('site_path') ?
                $blog->site_path : $blog->archive_path;
            my $abs_file_path = File::Spec->catfile($root_path, $rel_path . $ext);

            ## If the popup filename already exists, we don't want to overwrite
            ## it, because it could contain valuable data; so we'll just make
            ## sure to generate the name uniquely.
            my($i, $rel_path_ext) = (0, $rel_path . $ext);
            while ($fmgr->exists($abs_file_path)) {
                $rel_path_ext = $rel_path . ++$i . $ext;
                $abs_file_path = File::Spec->catfile($root_path, $rel_path_ext);
            }
            my ($vol, $dirs, $basename) = File::Spec->splitpath($rel_path_ext);
            my $rel_url_ext = File::Spec->catpath($vol, $dirs, encode_url($basename));
 
            ## Untaint. We have checked for security holes above, so we
            ## should be safe.
            ($abs_file_path) = $abs_file_path =~ /(.+)/s;
            $fmgr->put_data($popup, $abs_file_path, 'upload')
                or return $app->error($app->translate(
                   "Error writing to '[_1]': [_2]", $abs_file_path,
                                                     $fmgr->errstr));
            $url = $q->param('site_path') ?
                $blog->site_url : $blog->archive_url;
            $url .= '/' unless $url =~ m!/$!;
            $rel_url_ext =~ s!^/!!;
            $url .= $rel_url_ext;

            my $img_pkg = MT::Asset->class_handler('image');
            my $asset = new $img_pkg;
            my $original = $asset->clone;
            $asset->blog_id($blog_id);
            $asset->url($url);
            $asset->file_path($abs_file_path);
            $asset->file_name($basename);
            $asset->file_ext($blog->file_extension);
            $asset->created_by($app->user->id);
            $asset->save;
            MT->run_callbacks('CMSPostSave.asset', $app, $asset, $original);

            MT->run_callbacks('CMSUploadFile',
                          File => $abs_file_path, Url => $url,
                          Asset => $asset,
                          Size => length($popup),
                          Type => 'popup',
                          Blog => $blog);
        }
    }
    return $app->asset_insert_text();
}

sub asset_insert_text {
    my $app = shift;
    my $q = $app->param;
    require MT::Asset;
    my $asset = MT::Asset->load($q->param('id')) ||
        return $app->errtrans("Can't load asset, ". $q->param('id') .'.');
    my $text = $asset->as_html($q);
    return $q->param('popup') || $q->param('link')
        ? $app->translate_templatized($text)
        : $text;
}

use constant NEW_PHASE => 1;

sub save_commenter_perm {
    my $app = shift;
    my ($params) = @_;
    my $q = $app->param;
    my $action = $q->param('action');

    $app->validate_magic() or return;

    my $acted_on;
    my %rebuild_set;
    my @ids = $params ? @$params : $app->param('commenter_id');
    my $blog_id = $q->param('blog_id');
    my $author = $app->user;

    foreach my $id (@ids) {
        ($id, $blog_id) = @$id if ref $id eq 'ARRAY';

        my $cmntr = MT::Author->load({ id => $id,
                                       type => MT::Author::COMMENTER })
            or return $app->errtrans("No such commenter [_1].", $id);
        my $old_status =  $cmntr->status($blog_id);
        
        if ($action eq 'trust' && $cmntr->status($blog_id) != APPROVED) {
            $cmntr->approve($blog_id) or return $app->error($cmntr->errstr);
            $app->log($app->translate("User '[_1]' trusted commenter '[_2]'.",
                    $author->name, $cmntr->name));
            $acted_on++;
        } elsif ($action eq 'ban' && $cmntr->status($blog_id) != BANNED) {
            $cmntr->ban($blog_id) or return $app->error($cmntr->errstr);
            $app->log($app->translate("User '[_1]' banned commenter '[_2]'.",
                    $author->name, $cmntr->name));
            $acted_on++;
        } elsif ($action eq 'unban' && $cmntr->status($blog_id) == BANNED) {
            $cmntr->pending($blog_id) or return $app->error($cmntr->errstr);
            $app->log($app->translate("User '[_1]' unbanned commenter '[_2]'.",
                    $author->name, $cmntr->name));
            $acted_on++;
        } elsif ($action eq 'untrust' && $cmntr->status($blog_id) == APPROVED) {
            $cmntr->pending($blog_id) or return $app->error($cmntr->errstr);
            $app->log($app->translate("User '[_1]' untrusted commenter '[_2]'.",
                    $author->name, $cmntr->name));
            $acted_on++;
        }
        
        require MT::Entry;
        require MT::Comment;
        my $iter = MT::Entry->load_iter(undef,
                                        { join =>
                                              MT::Comment->join_on('entry_id',
                                                {commenter_id => $cmntr->id}
                                              )
                                        });
        my $e;
        while ($e = $iter->()) {
            $rebuild_set{$id} = $e;
        }
    }
    if ($acted_on) {
        my %msgs = (trust => 'trusted',
                    ban => 'banned',
                    unban => 'unbanned',
                    untrust => 'untrusted');
        $app->add_return_arg($msgs{$action} => 1);
    }
    $app->call_return;
}

sub map_comment_to_commenter {
    my $app = shift;
    my ($comments) = @_;
    my %commenters;
    require MT::Comment;
    for my $id (@$comments) {
        my $cmt = MT::Comment->load($id, {cached_ok=>1});
        if ($cmt->commenter_id) {
            $commenters{$cmt->commenter_id . ':' . $cmt->blog_id} = [$cmt->commenter_id, $cmt->blog_id];
        } else {
            $app->add_return_arg('unauth', 1);
        }
    }
    return values %commenters;
}

sub trust_commenter_by_comment {
    my $app = shift;
    my @comments = $app->param('id');
    my @commenters = $app->map_comment_to_commenter(\@comments);
    $app->param('action', 'trust');
    $app->save_commenter_perm(\@commenters);
}

sub untrust_commenter_by_comment {
    my $app = shift;
    my @comments = $app->param('id');
    my @commenters = $app->map_comment_to_commenter(\@comments);
    $app->param('action', 'untrust');
    $app->save_commenter_perm(\@commenters);
}

sub ban_commenter_by_comment {
    my $app = shift;
    my @comments = $app->param('id');
    my @commenters = $app->map_comment_to_commenter(\@comments);
    $app->param('action', 'ban');
    $app->save_commenter_perm(\@commenters);
}

sub unban_commenter_by_comment {
    my $app = shift;
    my @comments = $app->param('id');
    my @commenters = $app->map_comment_to_commenter(\@comments);
    $app->param('action', 'unban');
    $app->save_commenter_perm(\@commenters);
}

sub trust_commenter {
    my $app = shift;
    my @commenters = $app->param('id');
    $app->param('action', 'trust');
    $app->save_commenter_perm(\@commenters);
}

sub ban_commenter {
    my $app = shift;
    my @commenters = $app->param('id');
    $app->param('action', 'ban');
    $app->save_commenter_perm(\@commenters);
}

sub unban_commenter {
    my $app = shift;
    my @commenters = $app->param('id');
    $app->param('action', 'unban');
    $app->save_commenter_perm(\@commenters);
}

sub untrust_commenter {
    my $app = shift;
    my @commenters = $app->param('id');
    $app->param('action', 'untrust');
    $app->save_commenter_perm(\@commenters);
}

sub rebuild_phase {
    my $app = shift;
    my $type = $app->param('_type') || 'entry';
    my @ids = $app->param('id');
    $app->{goback} = "window.location='". $app->return_uri . "'";
    if ($type eq 'entry') {
        require MT::Entry;
        foreach (@ids) {
            my $entry = MT::Entry->load($_, {cached_ok=>1});
            next unless $entry;
            if ($entry->status == MT::Entry::RELEASE()) {
                $app->rebuild_entry(Entry => $entry, BuildDependencies => 1)
                    or return;
            }
        }
    } elsif ($type eq 'template') {
        require MT::Template;
        foreach (@ids) {
            my $template = MT::Template->load($_, {cached_ok=>1});
            $app->rebuild_indexes(Template => $template,
                                  Force => 1) or return;
        }
    }
    $app->call_return;
}

sub draft_entries {
    require MT::Entry;
    $_[0]->update_entry_status(MT::Entry::HOLD(), $_[0]->param('id'));
}

sub publish_entries {
    require MT::Entry;
    $_[0]->update_entry_status(MT::Entry::RELEASE(), $_[0]->param('id'));
}

sub update_entry_status {
    my $app = shift;
    my ($new_status, @ids) = @_;
    return $app->errtrans("Need a status to update entries") unless $new_status;
    return $app->errtrans("Need entries to update status") unless @ids;
    my @bad_ids;
    my @rebuild_list;
    require MT::Entry;
    foreach my $id (@ids) {
        my $entry = MT::Entry->load($id, {cached_ok=>1}) or return $app->errtrans("One of the entries ([_1]) did not actually exist", $id);
        push @rebuild_list, $entry if $entry->status != $new_status;
        $entry->status($new_status);
        $entry->save() or (push @bad_ids, $id);
    }
    return $app->errtrans("Some entries failed to save") if (@bad_ids); # FIXME: we don't really want this
    $app->rebuild_entry(Entry => $_, BuildDependencies => 1) 
        foreach @rebuild_list; # FIXME: optimize, phase out to another page.
    my $blog_id = $app->param('blog_id');
    $app->add_return_arg('saved' => 1);
    $app->call_return;
}

sub approve_item {
    $_[0]->param('approve', 1);
    $_[0]->set_item_visible;
}

sub unapprove_item {
    $_[0]->param('unapprove', 1);
    $_[0]->set_item_visible;
}

sub set_item_visible {
    my $app = shift;
    my $perms = $app->{perms};
    my $author = $app->user;

    $app->validate_magic() or return;

    my $type = $app->param('_type');
    my $class = $app->_load_driver_for($type);

    my $new_visible;
    if ($app->param('approve')) {
        $new_visible = 1;
    } elsif ($app->param('unapprove')) {
        $new_visible = 0;
    }

    my %rebuild_set = ();
    my @obj_ids = $app->param('id');
    require MT::Entry;
    foreach my $id (@obj_ids) {
        my $obj = $class->load($id, {cached_ok=>1});
        my $old_visible = $obj->visible || 0;
        if ($old_visible != $new_visible) {
            if ($obj->isa('MT::TBPing')) {
                my $obj_parent = $obj->parent();
                if ($obj_parent->isa('MT::Category')) {
                    my $blog = MT::Blog->load($obj_parent->blog_id, { cached_ok => 1 });
                    next unless $blog;
                    $app->publisher->_rebuild_entry_archive_type(
                        Entry => undef, Blog => $blog,
                        Category => $obj_parent, ArchiveType => 'Category'
                    );
                } else {
                    if (!$author->is_superuser) {
                        if (!$perms || $perms->blog_id != $obj->blog_id) {
                            $perms = $author->permissions($obj->blog_id);
                        }
                        if (!$perms || (!$perms->can_edit_all_posts()
                            && $obj_parent->author_id != $author->id)) {
                            return $app->errtrans("You don't have permission to approve this TrackBack.");
                        }
                    }
                    $rebuild_set{$obj_parent->id} = $obj_parent;
                }
            } elsif ($obj->entry_id) {
                # TODO: Factor out permissions checking
                my $entry = MT::Entry->load($obj->entry_id, {cached_ok=>1}) 
                    || return $app->error($app->translate("Comment on missing entry!"));
                if (!$author->is_superuser) {
                    if (!$perms || $perms->blog_id != $obj->blog_id) {
                        $perms = $author->permissions($obj->blog_id);
                    }
                    if (!$perms || (!$perms->can_edit_all_posts()
                        && $entry->author_id != $author->id)) {
                        return $app->errtrans("You don't have permission to approve this comment.");
                    }
                }
                $rebuild_set{$obj->entry_id} = $entry;
            }
            $obj->visible($new_visible);
            $obj->save();
        }
    }
    my $approved_flag = ($new_visible ? '' : 'un') . 'approved';
    $app->add_return_arg($approved_flag => 1);
    return $app->rebuild_these(\%rebuild_set, how => NEW_PHASE);
}

sub list_commenters {
    my $app = shift;
    unless ($app->{perms}->can_edit_config()) {
        return $app->error($app->translate("Permission denied."));
    }

    my $q = $app->param;
    my $list_pref = $app->list_pref('commenter');
    my $blog_id = $q->param('blog_id');
    my %param = %$list_pref;
    my %terms = (type => COMMENTER);
    my %terms2 = ();
    my $limit = $list_pref->{rows};
    my $offset = $q->param('offset') || 0;
    my %arg;
    require MT::Comment;
    $arg{'join'} = MT::Comment->join_on('commenter_id',
                    { ( $blog_id ? (blog_id => $blog_id) : () ) },
                    { 'sort' => 'created_on',
                      direction => 'descend', unique => 1 });
    my ($filter_col, $val);
    $param{filter_args} = "";
    if (($filter_col = $q->param('filter'))
        && ($val = $q->param('filter_val')))
    {
        if (!exists ($terms{$filter_col})) {
            if ($filter_col eq 'status') {
                my ($role_mask) = 
                      ($val eq 'neutral' ? 0
                     : $val eq 'approved' ? 1
                     : $val eq 'banned' ? 2048 : 0);
                $arg{join} = 
                    MT::Permission->join_on('author_id', 
                     {role_mask => $role_mask, blog_id => $blog_id});
            } else {
                $terms{$filter_col} = $val;
            }

            $param{filter} = $filter_col;
            $param{filter_val} = $val;
            my $url_val = encode_url($val);
            $param{filter_args} = "&filter=$filter_col&filter_val=$url_val";
        }
    }
    $arg{'offset'} = $offset if $offset;
    $arg{'limit'} = $limit + 1;
    my $terms = \%terms;
    my $arg = \%arg;
    my $iter = MT::Author->load_iter($terms, $arg);

    my $data = $app->build_commenter_table(iter => $iter, param => \%param);
    if (@$data > $limit) {
        pop @$data;
        $param{next_offset} = 1;
        $param{next_offset_val} = $offset + $limit;
    }
    if ($offset > 0) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
    }

    $param{object_type} = 'commenter';
    $param{object_type_plural} = $app->translate('commenters');
    $param{search_type} = $app->translate('Commenters');
    $param{list_start} = $offset + 1;
    $param{list_end} = $offset + scalar @$data;
    $param{offset} = $offset;
    $param{limit} = $limit;
    delete $arg->{limit}; delete $arg->{offset};
    $param{list_total} = MT::Author->count($terms, $arg);
    if ($param{list_total}) {
        $param{next_max} = $param{list_total} - $limit;
        $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    }
    $app->add_breadcrumb($app->translate('Authenticated Commenters'));
    $param{nav_commenters} = 1;
    for my $msg (qw(trusted untrusted banned unbanned)) {
        $param{$msg} = 1 if $app->param($msg);
    }
    return $app->build_page('list_commenters.tmpl', \%param);
}

sub build_commenter_table {
    my $app = shift;
    my (%args) = @_;

    my $param = $args{param};
    my $iter;
    if ($args{load_args}) { 
        my $class = $app->_load_driver_for('commenter');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;

    my $app_user = $app->user;
    my $user_perm = $app->{perms};
    require MT::Permission;
    my $blog_id = $app->param('blog_id');
    
    my @data;
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    while (my $cmtr = $iter->()) {
        require MT::Comment;
        my $cmt_count = MT::Comment->count({commenter_id => $cmtr->id,
                                         blog_id => $blog_id});
        my $most_recent = MT::Comment->load({commenter_id => $cmtr->id,
                                             blog_id => $blog_id},
                                            {'sort' => 'created_on',
                                             direction => 'descend'})
            if $cmt_count > 0;

        
        my $blog_connection = MT::Permission->load({author_id => $cmtr->id,
                                                    blog_id => $blog_id});
        # Tells us whether the commenter is associated with this
        # blog. the role flags are not important
        next if (!$cmt_count && !$blog_connection);

        my $row = {};
        $row->{author_id} = $cmtr->id();
        $row->{author} = $cmtr->name();
        $row->{author_display} = $cmtr->nickname();
        $row->{email} = $cmtr->email();
        $row->{url} = $cmtr->url();
        $row->{email_hidden} = $cmtr->is_email_hidden();
        $row->{comment_count} = $cmt_count;
        if ($most_recent) {
            if (my $ts = $most_recent->created_on) {
                $row->{most_recent_time_formatted} =
                    format_ts("%Y-%m-%d %H:%M:%S", $ts); 
                $row->{most_recent_formatted} =
                    format_ts("%Y.%m.%d", $ts); 
                $row->{most_recent_relative} =
                    relative_date($ts, time, $blog);
            }
        }
        $row->{status} = {PENDING => "neutral",
                          APPROVED => "approved",
                          BANNED => "banned"}->{$cmtr->status($blog_id)};
        $row->{commenter_approved} = $cmtr->status($blog_id) == APPROVED;
        $row->{commenter_banned} = $cmtr->status($blog_id) == BANNED;
        $row->{profile_page} = $app->config('IdentityURL');
        $row->{profile_page} .= "/" unless $row->{profile_page} =~ m|/$|;
        $row->{profile_page} .= $cmtr->name();
        $row->{has_edit_access} = $user_perm->can_edit_config();
        $row->{object} = $cmtr;
        push @data, $row;
    }
    return [] unless @data;

    $param->{commenter_table}[0]{object_loop} = \@data if @data;
    my $plugin_actions = $app->plugin_itemset_actions('commenter');
    $param->{commenter_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('commenter');
    $param->{commenter_table}[0]{core_itemset_action_loop} = $core_actions || [];
    $param->{commenter_table}[0]{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
    $param->{commenter_table}[0]{plugin_action_loop} = $app->plugin_actions('list_commenters') || [];
    \@data;
}

sub core_itemset_actions {
    my $app = shift;
    my $actions = $app->itemset_actions('CoreItemsetActions', @_);
    $_->{label} = $app->translate($_->{orig_label}) foreach @$actions;
    $actions;
}

sub plugin_itemset_actions {
    my $app = shift;
    my $actions = $app->itemset_actions('PluginItemsetActions', @_);
    foreach (@$actions) {
        my $plugin_sig = $_->{plugin};
        if ($plugin_sig) {
            my $plugin = $MT::Plugins{$plugin_sig}{object};
            $_->{label} = $plugin->translate($_->{orig_label});
        } else {
            $_->{label} = $app->translate($_->{orig_label});
        }
    }
    $actions;
}

sub itemset_actions {
    my $app = shift;
    my ($which, $set, @param) = @_;
    my $actions = $app->{$which}{$set} if $app->{$which}{$set};
    $actions ||= [];
    @$actions = grep { $_->{condition} ? $_->{condition}->(@param) : 1 } @$actions;
    $actions;
}

sub list_comments {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms};

    if ($perms) {
        if (!$perms->can_edit_all_posts && !$perms->can_post) {
            return $app->error($app->translate("Permission denied."));
        }
    } # otherwise we simply filter the list of objects

    my $list_pref = $app->list_pref('comment');
    my $blog_id = $q->param('blog_id');
    require MT::Blog;
    my $blog;
    $blog = MT::Blog->load($blog_id, {cached_ok=>1}) if $blog_id;
    my %param = %$list_pref;
    my %terms;
    if ($blog_id) { $terms{blog_id} = $blog_id }
    elsif (!$app->user->is_superuser) {
        $terms{blog_id} = [map {$_->blog_id}
                           grep {$_->can_post || $_->can_edit_all_posts}
                           MT::Permission->load({author_id=>$app->user->id})];
    }
    my %terms2 = ();
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    ## We load $limit + 1 records so that we can easily tell if we have a
    ## page of next entries to link to. Obviously we only display $limit
    ## entries.
    my %arg = (
            'sort' => 'created_on',
            direction => 'descend',
    );
    if (($app->param('tab') || '') eq 'junk') {
        $terms{'junk_status'} = -1;
    } else {
        $terms{'junk_status'} = [ 0, 1 ];
    }

    my $cmtr_filter = undef;
    my @val = $q->param('filter_val');
    my $filter_col = $q->param('filter');
    if ($filter_col && (my ($val) = @val))
    {
        if (!exists $terms{$filter_col}) {
            if ($filter_col eq 'status') {
                $terms{visible} = $val eq 'approved' ? 1 : 0;
            } elsif ($filter_col eq 'commenter') {
                # authenticated, unauthenticated, trusted
                if ($val eq 'trusted') {
                    $cmtr_filter = sub { $_[0] && $_[0]->is_trusted($_[1]) };
                } elsif ($val eq 'authenticated') {
                    $cmtr_filter = sub { $_[0] && $_[0]->is_not_trusted($_[1]) };
                } elsif ($val eq 'unauthenticated') {
                    $cmtr_filter = sub { !$_[0] };
                }
            } else {
                if ($val[1]) {
                    $terms{$filter_col} = [ $val, $val[1] ];
                    $arg{'range_incl'} = { $filter_col => 1 };
                    $param{filter_val2} = $val[1];
                    $param{filter_range} = 1;
                } else {
                    $terms{$filter_col} = $val;
                }
            }
            my $url_val = encode_url($val);
            $param{filter} = $q->param('filter');
            $param{filter_val} = $q->param('filter_val');;
            $param{filter_args} = "&filter=$filter_col&filter_val=$url_val";
            $param{filter_args} .= "&filter_val=" . encode_url($val[1]) if $val[1];
            $param{is_filtered} = 1;
        }
    }

    require MT::Comment;
    require MT::Entry;
    my($iter, $iter1);

    # FIXME this offset logic breaks if you filter the iterator as below.
    my $total = MT::Comment->count(\%terms, \%arg) || 0;
    $arg{limit} = $limit + 1;
    if ($offset > $total - 1) {
        $arg{offset} = $offset = $total - $limit;
    } elsif ($offset < 0) {
        $arg{offset} = $offset = 0;
    } elsif ($offset) {
        $arg{offset} = $offset;
    }

    $iter1 = MT::Comment->load_iter(\%terms, \%arg);

    if ($cmtr_filter) {
        $iter = sub {  # filter the iterator
            my $cmt;
            while ($cmt = $iter1->()) {
                my $cmtr = $cmt->commenter_id ? MT::Author->load($cmt->commenter_id, {cached_ok=>1}) : undef;
                return $cmt if $cmtr_filter->($cmtr, $cmt->blog_id);
            }
            $cmt;
        };
    } else {
        $iter = $iter1;
    }

    my $loop = $app->build_comment_table( iter => $iter, param => \%param );

    ## We tried to load $limit + 1 entries above; if we actually got
    ## $limit + 1 back, we know we have another page of entries.
    my $have_next_entry = @$loop > $limit;
    pop @$loop while @$loop > $limit;
    if ($offset) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
    }
    if ($have_next_entry) {
        $param{next_offset} = 1;
        $param{next_offset_val} = $offset + $limit;
    }
    $param{is_ip_filter} = (($q->param('filter') || "") eq 'ip');
    $param{filter_val} = $q->param('filter_val');
    $param{filter_val} = substr($param{filter_val}, 0, 25) . '...'
        if $param{filter_val} && $param{filter_val} =~ m(\S{25,});
    $param{saved} = $q->param('saved');
    $param{approved} = $q->param('approved');
    $param{unapproved} = $app->param('unapproved');
    $param{junked} = $q->param('junked');
    $param{unjunked} = $q->param('unjunked');
    $param{unauth} = $q->param('unauth');
    $param{emptied} = $q->param('emptied');
    $param{saved_deleted} = $q->param('saved_deleted');
    $param{no_junk_found} = $q->param('no_junk_found');
    $param{limit} = $limit;
    $param{offset} = $offset;
    $param{object_type} = 'comment';
    $param{object_type_plural} = $app->translate('comments');
    $param{search_type} = $app->translate('Comments');
    $param{list_start} = $offset + 1;
    $param{list_end} = $offset + scalar @$loop;
    $param{list_total} = $total;
    if ($param{list_total}) {
        $param{next_max} = $param{list_total} - $limit;
        $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    }
    $param{plugin_action_loop} = $app->plugin_actions('list_comments') || [];
    $param{nav_comments} = 1;
    $param{has_expanded_mode} = 1;
    $param{tab} = $app->param('tab');
    $param{"tab_" . ($app->param('tab') || 'comments')} = 1;
    if (($param{'tab'} || '') ne 'junk') {
        $param{feed_name} = $app->translate("Comment Activity Feed");
        $param{feed_url} = $app->make_feed_link('comment', $blog_id ? { blog_id => $blog_id } : undef);
    }
    $app->add_breadcrumb($app->translate('Comments'));
    $app->build_page("list_comment.tmpl", \%param);
}

sub build_template_table {
    my $app = shift;
    my (%args) = @_;

    my $perms = $app->{perms};
    my $list_pref = $app->list_pref('template');
    my $limit = $args{limit};
    my $param = $args{param} || {};
    my $iter;
    if ($args{load_args}) {
        my $class = $app->_load_driver_for('template');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
        $limit = scalar @{$args{items}};
    }
    return [] unless $iter;

    my @data;
    my $i;
    my %blogs;
    while (my $tmpl = $iter->()) {
        my $blog = $blogs{$tmpl->blog_id} ||= MT::Blog->load($tmpl->blog_id, { cached_ok => 1 });
        my $row = $tmpl->column_values;
        $row->{name} = '' if !defined $row->{name};
        $row->{name} =~ s/^\s+|\s+$//g;
        $row->{name} = "(" . $app->translate("No Name") . ")"
            if $row->{name} eq '';
        my $published_url = $tmpl->published_url;
        $row->{published_url} = $published_url if $published_url;
        $row->{can_delete} = 1 if $tmpl->type =~ m/(custom|index|archive|individual|category)/;
        if ($blog) {
            $row->{blog_name} = $blog->name;
        } else {
            $row->{blog_name} = '* ' . $app->translate('Orphaned') . ' *';
        }
        $row->{object} = $tmpl;
        push @data, $row;
        last if @data > $limit;
    }
    return [] unless @data;

    $param->{template_table}[0] = { %$list_pref };
    $param->{template_table}[0]{object_loop} = \@data;
    $param->{template_table}[0]{object_type} = 'template';
    $param->{template_table}[0]{object_type_plural} = $app->translate('templates');
    my $plugin_actions = $app->plugin_itemset_actions('template');
    $param->{template_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('template');
    $param->{template_table}[0]{core_itemset_action_loop} = $core_actions || [];
    $param->{template_table}[0]{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
    \@data;
}

sub build_comment_table {
    my $app = shift;
    my (%args) = @_;

    my $author = $app->user;
    my $list_pref = $app->list_pref('comment');
    my $iter;
    if ($args{load_args}) {
        my $class = $app->_load_driver_for('comment');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $limit = $args{limit};
    my $param = $args{param} || {};

    my @data;
    my $i;
    $i = 1;
    my (%blogs, %entries, %perms, %cmntrs);
    my $trim_length = $app->config('ShowIPInformation')
        ? const('DISPLAY_LENGTH_EDIT_COMMENT_TEXT_SHORT')
        : const('DISPLAY_LENGTH_EDIT_COMMENT_TEXT_LONG');
    my $author_max_len = const('DISPLAY_LENGTH_EDIT_COMMENT_AUTHOR');
    my $comment_short_len = const('DISPLAY_LENGTH_EDIT_COMMENT_TEXT_BREAK_UP_SHORT');
    my $comment_long_len = const('DISPLAY_LENGTH_EDIT_COMMENT_TEXT_BREAK_UP_LONG');
    my $title_max_len = const('DISPLAY_LENGTH_EDIT_COMMENT_TITLE');
    while (my $obj = $iter->()) {
        my $row = $obj->column_values;
        $row->{author_display} = $row->{author};
        $row->{author_display} = substr_text($row->{author_display}, 0, $author_max_len) . '...'
            if $row->{author_display} && length_text($row->{author_display}) > $author_max_len;
        $row->{comment_short} = (substr_text($obj->text(), 0, $trim_length) .
                                 (length_text($obj->text) > $trim_length ? "..." : ""));
        $row->{comment_short} = break_up_text($row->{comment_short}, $comment_short_len); # break up really long strings
        $row->{comment_long} = remove_html($obj->text);
        $row->{comment_long} = break_up_text($row->{comment_long}, $comment_long_len); # break up really long strings

        $row->{visible} = $obj->visible();
        $row->{entry_id} = $obj->entry_id();
        my $blog = $blogs{$obj->blog_id} ||= $obj->blog;
        my $entry = $entries{$obj->entry_id} ||= MT::Entry->load($obj->entry_id, {cached_ok=>1});
        unless ($entry) {
            $entry = new MT::Entry;
            $entry->title('* ' . $app->translate('Orphaned comment') . ' *');
        }
        $row->{entry_title} = (defined($entry->title) ? $entry->title 
                            : defined($entry->text) ? $entry->text : '');
        $row->{entry_title} = $app->translate('(untitled)') if $row->{entry_title} eq '';
        $row->{entry_title} = substr_text($row->{entry_title}, 0, $title_max_len) . '...'
            if $row->{entry_title} && length_text($row->{entry_title}) > $title_max_len;
        $row->{commenter_id} = $obj->commenter_id() if $obj->commenter_id();
        my $cmntr;
        if ($obj->commenter_id) {
            $cmntr = $cmntrs{$obj->commenter_id} ||= MT::Author->load({ id => $obj->commenter_id(),
                                       type => MT::Author::COMMENTER });
        }
        if ($cmntr) {
            $row->{email_hidden} = $cmntr && $cmntr->is_email_hidden();

            my $status = $cmntr->status($obj->blog_id);
            $row->{commenter_approved} = ($cmntr->status($obj->blog_id)== APPROVED);
            $row->{commenter_banned} = ($cmntr->status($obj->blog_id) == BANNED);
        }
        if (my $ts = $obj->created_on) {
            $row->{created_on_time_formatted} =
                format_ts("%Y-%m-%d %H:%M:%S", $ts); 
            $row->{created_on_formatted} =
                format_ts("%Y.%m.%d", $ts); 

            $row->{created_on_relative} = relative_date($ts, time, $blog);
        }
        if ($author->is_superuser()) {
            $row->{has_edit_access} = 1;
        } else {
            my $perms = $perms{$obj->blog_id} ||= $author->permissions($obj->blog_id);
            $row->{has_edit_access} = ($perms && $perms->can_edit_all_posts)
                                      || $author->id == $entry->author_id;
        }
        if ($blog) {
            $row->{weblog_id} = $blog->id;
            $row->{weblog_name} = $blog->name;
        } else {
            $row->{weblog_name} = '* ' . $app->translate('Orphaned comment') . ' *';
        }
        $row->{object} = $obj;
        push @data, $row;
        last if $limit and @data > $limit;
    }
    return [] unless @data;

    my $junk_tab = ($app->param('tab') || '') eq 'junk';
    $param->{comment_table}[0] = { %$list_pref };
    $param->{comment_table}[0]{object_loop} = \@data;
    $param->{comment_table}[0]{object_type} = 'comment';
    $param->{comment_table}[0]{object_type_plural} = $app->translate('comments');
    my $plugin_actions = $app->plugin_itemset_actions('comment', $junk_tab ? 'junk' : 'comments');
    $param->{comment_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('comment', $junk_tab ? 'junk' : 'comments');
    $param->{comment_table}[0]{core_itemset_action_loop} = $core_actions || [];
    $param->{comment_table}[0]{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
    \@data;
}

sub plugin_control {
    my $app = shift;

    $app->validate_magic or return;
    return unless $app->user->is_superuser();

    my $plugin_sig = $app->param('plugin_sig') || '';
    my $state = $app->param('state') || '';

    my $cfg = $app->config;
    if ($plugin_sig eq '*') {
        $cfg->UsePlugins($state eq 'on' ? 1 : 0, 1);
    } else {
        if (exists $MT::Plugins{$plugin_sig}) {
            $cfg->PluginSwitch($plugin_sig . '=' . ($state eq 'on' ? '1' : '0'), 1);
        }
    }
    $cfg->save_config;

    $app->add_return_arg('switched' => 1);
    $app->call_return;
}

sub list_plugins {
    my $app = shift;
    my %param;
    my $cfg = $app->config;

    $param{can_config} = $app->user->is_superuser();
    $param{use_plugins} = $cfg->UsePlugins;
    $app->build_plugin_table(param => \%param, scope => 'system');
    $param{nav_config} = 1;
    $param{nav_settings} = 1;
    $param{nav_plugins} = 1;
    $param{switched} = 1 if $app->param('switched');
    $param{'reset'} = 1 if $app->param('reset');
    $param{saved} = 1 if $app->param('saved');
    $param{mod_perl} = 1 if $ENV{MOD_PERL};
    $app->add_breadcrumb($app->translate("Plugin Settings"));
    $app->build_page('list_plugin.tmpl', \%param);
}

sub build_plugin_table {
    my $app = shift;
    my (%opt) = @_;

    my $param = $opt{param};
    my $scope = $opt{scope} || 'system';
    my $cfg = $app->config;
    my $data = [];

    # we have to sort the plugin list in an odd fashion...
    #   PLUGINS
    #     (those at the top of the plugins directory and those
    #      that only have 1 .pl script in a plugin folder)
    #   PLUGIN SET
    #     (plugins folders with multiple .pl files)
    my %list;
    my %folder_counts;
    for my $sig (keys %MT::Plugins) {
        my $sub = $sig =~ m!/! ? 1 : 0;
        my $obj = $MT::Plugins{$sig}{object} ? 0 : 1;
        my $err = $MT::Plugins{$sig}{error} ? 0 : 1;
        my $on = $MT::Plugins{$sig}{enabled} ? 0 : 1;
        my ($fld, $plg);
        ($fld, $plg) = $sig =~ m!(.*)/(.*)!;
        $fld = '' unless $fld;
        $folder_counts{$fld}++ if $fld;
        $plg ||= $sig;
        $list{$sub.sprintf("%-100s",$fld).$obj.$plg} = $sig;
    }
    my @keys = keys %list;
    foreach my $key (@keys) {
        my $fld = substr($key, 1, 100);
        $fld =~ s/\s+$//;
        if (!$fld || ($folder_counts{$fld} == 1)) {
            my $sig = $list{$key};
            delete $list{$key};
            my $plugin = $MT::Plugins{$sig};
            my $name = $plugin && $plugin->{object}
                ? $plugin->{object}->name : $sig;
            $list{'0'.(' 'x100) . sprintf("%-102s", $name)} = $sig;
        }
    }

    my $last_fld = '*';
    my $next_is_first;
    my $id = 0;
    (my $cgi_path = $cfg->AdminCGIPath || $cfg->CGIPath) =~ s|/$||;
    for my $list_key (sort keys %list) {
        $id++;
        my $plugin_sig = $list{$list_key};
        next if $plugin_sig =~ m/^[^A-Za-z0-9]/;
        my $profile = $MT::Plugins{$plugin_sig};
        my ($plg);
        ($plg) = $plugin_sig =~ m!(?:.*)/(.*)!;
        my $fld = substr($list_key, 1, 100);
        $fld =~ s/\s+$//;
        my $folder = $fld ? $app->translate("Plugin Set: [_1]", $fld) : $app->translate("Plugins");
        my $row;
        my $icon = $app->static_path . 'images/plugin.gif';
        if (my $plugin = $profile->{object}) {
            my $plugin_icon;
            if ($plugin->icon) {
                $plugin_icon = $app->static_path . $plugin->envelope . '/' . $plugin->icon;
            } else {
                $plugin_icon = $icon;
            }
            my $plugin_name = remove_html($plugin->name());
            $plugin->{description} = $plugin->{description};
            my $plugin_page = ($cgi_path . '/' 
                               . $plugin->envelope . '/' .     $plugin->config_link())
                if $plugin->{config_link};
            my $doc_link = $plugin->doc_link;
            if ($doc_link && ($doc_link !~ m!^https?://!)) {
                $doc_link = $app->static_path .
                    $plugin->envelope . '/' . $doc_link;
            }

            my ($config_html);
            my %plugin_param;
            my $settings = $plugin->get_config_obj($scope);
            $plugin->load_config(\%plugin_param, $scope); 
            if (my $snip_tmpl = $plugin->config_template(\%plugin_param, $scope)) {
                my $tmpl;
                if (ref $snip_tmpl ne 'HTML::Template') {
                    require HTML::Template;
                    $tmpl = HTML::Template->new(scalarref => ref $snip_tmpl ? $snip_tmpl : \$snip_tmpl,
                                                die_on_bad_params => 0,
                                                loop_context_vars => 1);
                } else {
                    $tmpl = $snip_tmpl;
                }
                # Process template independent of $app to avoid premature
                # localization (give plugin a chance to do L10N first).
                $tmpl->param(\%plugin_param);
                $config_html = $tmpl->output();
                $config_html = $plugin->translate_templatized($config_html)
                    if $config_html =~ m/<MT_TRANS /;
            } else {
                # don't list non-configurable plugins for blog scope...
                next if $scope ne 'system';
            }

            if ($last_fld ne $fld) {
                $row = {
                    plugin_sig => $plugin_sig,
                    plugin_folder => $folder,
                    plugin_set => $fld ? $folder_counts{$fld} > 1 : 0,
                    plugin_error => $profile->{error},
                };
                push @$data, $row;
                $last_fld = $fld;
                $next_is_first = 1;
            }

            my $row = {
                first => $next_is_first,
                plugin_name => $plugin_name,
                plugin_page => $plugin_page,
                plugin_major => 1,
                plugin_icon => $plugin_icon,
                plugin_desc => $plugin->description(),
                plugin_version => $plugin->version(),
                plugin_author_name => $plugin->author_name(),
                plugin_author_link => $plugin->author_link(),
                plugin_plugin_link => $plugin->plugin_link(),
                plugin_full_path => $plugin->{full_path},
                plugin_doc_link => $doc_link,
                plugin_sig => $plugin_sig,
                plugin_key => $plugin->key(),
                plugin_config_link => $plugin->config_link(),
                plugin_config_html => $config_html,
                plugin_settings_id => $settings->id,
                plugin_id => $id,
            };
            $row->{plugin_tags} = listify($profile->{tags}) if $profile->{tags};
            $row->{plugin_attributes} = listify($profile->{attributes})
                if $profile->{attributes};
            $row->{plugin_junk_filters} = listify($profile->{junk_filters})
                if $profile->{junk_filters};
            $row->{plugin_text_filters} = listify($profile->{text_filters})
                if $profile->{text_filters};
            if ($profile->{text_filters} || $profile->{junk_filters}
                || $profile->{tags} || $profile->{attributes}) {
                $row->{plugin_resources} = 1;
            }
            push @$data, $row;
        } else {
            # don't list non-configurable plugins for blog scope...
            next if $scope ne 'system';

            if ($last_fld ne $fld) {
                $row = {
                    plugin_sig => $plugin_sig,
                    plugin_folder => $folder,
                    plugin_set => $fld ? $folder_counts{$fld} > 1 : 0,
                    plugin_error => $profile->{error},
                };
                push @$data, $row;
                $last_fld = $fld;
                $next_is_first = 1;
            }

            # no registered plugin objects--
            # are there any tags/attributes/filters to expose?
            $row = {
                first => $next_is_first,
                plugin_major => $fld ? 0 : 1,
                plugin_icon => $icon,
                plugin_name => $plugin_sig,
                plugin_sig => $plugin_sig,
                plugin_error => $profile->{error},
                plugin_disabled => $profile->{enabled} ? 0 : 1,
                plugin_id => $id,
            };
            $row->{plugin_tags} = listify($profile->{tags}) if $profile->{tags};
            $row->{plugin_attributes} = listify($profile->{attributes})
                if $profile->{attributes};
            $row->{plugin_junk_filters} = listify($profile->{junk_filters})
                if $profile->{junk_filters};
            $row->{plugin_text_filters} = listify($profile->{text_filters})
                if $profile->{text_filters};
            if ($profile->{text_filters} || $profile->{junk_filters}
                || $profile->{tags} || $profile->{attributes}) {
                $row->{plugin_resources} = 1;
            }
            push @$data, $row;
        }
        $next_is_first = 0;
    }
    $param->{plugin_loop} = $data;
}

sub listify {
    my ($arr) = @_;
    my @ret;
    foreach (@$arr) {
        push @ret, { name => $_ };
    }
    \@ret;
}

sub list_pings {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms};

    if ($perms) {
        if (!$perms->can_edit_all_posts && !$perms->can_post) {
            return $app->error($app->translate("Permission denied."));
        }
    } # otherwise we simply filter the list of objects

    my $list_pref = $app->list_pref('ping');
    my $class = $app->_load_driver_for("ping") or return;
    my $blog_id = $q->param('blog_id');
    my $blog;
    if ($blog_id) {
        require MT::Blog;
        $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    }
    my %param = %$list_pref;
    my %terms;
    if ($blog_id) { $terms{blog_id} = $blog_id; }
    elsif (!$app->user->is_superuser) {
        $terms{blog_id} = [ map { $_->blog_id }
                           grep { $_->can_post || $_->can_edit_all_posts }
                                MT::Permission->load({author_id =>
                                                          $app->user->id})];
    }
    my $cols = $class->column_names;
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;
    my $sort_direction = $q->param('sortasc') ? 'ascend' : 'descend';

    ## We load $limit + 1 records so that we can easily tell if we have a
    ## page of next entries to link to. Obviously we only display $limit
    ## entries.
    my %arg;
    if (($app->param('tab') || '') eq 'junk') {
        $terms{'junk_status'} = -1;
    } else {
        $terms{'junk_status'} = [ 0, 1 ];
    }

    my @val = $q->param('filter_val');
    my $filter_col = $q->param('filter');
    if ($filter_col && (my $val = $q->param('filter_val'))) {
        if ($filter_col eq 'status') {
            $terms{visible} = $val eq 'approved' ? 1 : 0;
        } elsif ($filter_col eq 'category_id' ||
            $filter_col eq 'entry_id') {
            require MT::Trackback;
            my $tb = MT::Trackback->load({ $blog_id ? ( blog_id => $blog_id ) : (), $filter_col => $val });
            if ($tb) {
                $filter_col = 'tb_id';
                $val = $tb->id;
            }
        } else {
            if ($val[1]) {
                $terms{$filter_col} = [ $val[0], $val[1] ];
                $arg{'range_incl'} = { $filter_col => 1 };
                $param{filter_val2} = $val[1];
                $param{filter_range} = 1;
            } else {
                $terms{$filter_col} = $val;
            }
        }
        (my $url_val = $val) =~
            s!([^a-zA-Z0-9_.-])!uc sprintf "%%%02x", ord($1)!eg;
        $param{filter_args} = "&filter=$filter_col&filter_val=$url_val";
        $param{filter} ||= $filter_col;
        $param{filter_val} ||= $val;
        $param{is_filtered} = 1;
        $param{is_ip_filter} = $filter_col eq "ip";
    }

    my $total = MT::TBPing->count(\%terms, \%arg) || 0;
    my @rows = MT::TBPing->load(\%terms, \%arg);
    $arg{'sort'} = 'created_on';
    $arg{direction} = $sort_direction;
    $arg{limit} = $limit + 1;
    if ($offset > $total - 1) {
        $arg{offset} = $offset = $total - $limit;
    } elsif ($offset < 0) {
        $arg{offset} = $offset = 0;
    } elsif ($offset) {
        $arg{offset} = $offset;
    }

    my $iter = $class->load_iter(\%terms, \%arg);
    my $data = $app->build_ping_table( iter => $iter, param => \%param );

    ## We tried to load $limit + 1 entries above; if we actually got
    ## $limit + 1 back, we know we have another page of entries.
    my $have_next_entry = @$data > $limit;
    pop @$data while @$data > $limit;
    if ($offset) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
    }
    if ($have_next_entry) {
        $param{next_offset} = 1;
        $param{next_offset_val} = $offset + $limit;
    }

    $param{ping_count} = scalar @$data;
    $param{limit} = $limit;
    $param{offset} = $offset;
    $param{saved} = $q->param('saved');
    $param{junked} = $q->param('junked');
    $param{unjunked} = $q->param('unjunked');
    $param{approved} = $q->param('approved');
    $param{unapproved} = $q->param('unapproved');
    $param{emptied} = $q->param('emptied');
    $param{saved_deleted_ping} = $q->param('saved_deleted')
                              || $q->param('saved_deleted_ping');
    $param{object_type} = 'ping';
    $param{object_type_plural} = $app->translate('TrackBacks');
    $param{search_type} = $app->translate('TrackBacks');
    $param{list_start} = $offset + 1;
    $param{list_end} = $offset + scalar @$data;
    $param{list_total} = $total;
    $param{next_max} = $param{list_total} - $limit if $param{list_total};
    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    $param{plugin_action_loop} = $app->plugin_actions('list_pings') || $app->plugin_actions('list_ping') || [];
    $param{nav_trackbacks} = 1;
    $param{has_expanded_mode} = 1;
    $param{tab} = $app->param('tab') || 'pings';
    $param{"tab_" . ($app->param('tab') || 'pings')} = 1;
    unless ($blog_id) {
        $param{system_overview_nav} = 1;
        $param{nav_pings} = 1;
    }
    if ($param{'tab'} ne 'junk') {
        $param{feed_name} = $app->translate("TrackBack Activity Feed");
        $param{feed_url} = $app->make_feed_link('ping', $blog_id ? { blog_id => $blog_id } : undef);
    }
    $app->add_breadcrumb($app->translate('TrackBacks'));
    $app->build_page("list_ping.tmpl", \%param);
}

# takes param and one of load_args, iter, or items
sub build_ping_table {
    my $app = shift;
    my (%args) = @_;

    require MT::Entry;
    require MT::Trackback;
    require MT::Category;

    my $author = $app->user;
    my $list_pref = $app->list_pref('ping');
    my $iter;
    if ($args{load_args}) {
        my $class = $app->_load_driver_for('ping');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $limit = $args{limit};
    my $param = $args{param};

    my @data;
    my (%blogs, %entries, %cats, %perms);
    my $excerpt_max_len = const('DISPLAY_LENGTH_EDIT_PING_TITLE_FROM_EXCERPT');
    my $title_max_len = const('DISPLAY_LENGTH_EDIT_PING_BREAK_UP');
    while (my $obj = $iter->()) {
        my $row = $obj->column_values;
        my $blog = $blogs{$obj->blog_id} ||= $obj->blog if $obj->blog_id;
        $row->{excerpt} = '[' . $app->translate("No Excerpt") . ']'
            unless ($row->{excerpt} || '') ne '';
        if (($row->{title} || '') eq ($row->{source_url} || '')) {
            $row->{title} = '[' . $app->translate("No Title") . ']';
        }
        if (!defined($row->{title})) {
            $row->{title} = substr_text($row->{excerpt}||"", 0, $excerpt_max_len) . '...';
        }
        $row->{excerpt} ||= '';
        $row->{title} = break_up_text($row->{title}, $title_max_len);
        $row->{excerpt} = break_up_text($row->{excerpt}, $title_max_len);
        $row->{blog_name} = break_up_text($row->{blog_name}, $title_max_len);
        $row->{object} = $obj;
        push @data, $row;

        my $tb_center = MT::Trackback->load($obj->tb_id);
        my $entry; my $cat;
        if ($tb_center->entry_id) {
            $entry = $entries{$tb_center->entry_id} ||= MT::Entry->load($tb_center->entry_id);
            if ($entry) {
                $row->{target_title} = $entry->title;
                $row->{target_link} = $app->uri('mode' => 'view', args => { '_type' => 'entry', id => $entry->id, blog_id => $entry->blog_id, tab => 'pings' });
            } else {
                $row->{target_title} = ('* ' . $app->translate('Orphaned TrackBack') . ' *');
            }
            $row->{target_type} = $app->translate('entry');
        } elsif ($tb_center->category_id) {
            $cat = $cats{$tb_center->category_id} ||= MT::Category->load($tb_center->category_id);
            if ($cat) {
                $row->{target_title} = ('* ' . $app->translate('Orphaned TrackBack') . ' *');
                $row->{target_title} = $cat->label;
                $row->{target_link} = $app->uri('mode' => 'view', args => { '_type' => 'category', id => $cat->id, blog_id => $cat->blog_id, tab => 'pings'});
            }
            $row->{target_type} = $app->translate('category');
        }
        if (my $ts = $obj->created_on) {
            $row->{created_on_time_formatted} = format_ts("%Y.%m.%d %H:%M:%S", $ts);
            $row->{created_on_formatted} = format_ts("%Y.%m.%d", $ts);
            $row->{created_on_relative} = relative_date($ts, time, $blog);
        }
        if ($blog) {
            $row->{weblog_id} = $blog->id;
            $row->{weblog_name} = $blog->name;
        } else {
            $row->{weblog_name} = '* ' . $app->translate('Orphaned TrackBack') . ' *';
        }
        if ($author->is_superuser()) {
            $row->{has_edit_access} = 1;
        } else {
            my $perms = $perms{$obj->blog_id} ||= $author->permissions($obj->blog_id);
            $row->{has_edit_access} = (
                    ($perms && (($entry && $perms->can_edit_all_posts)
                                || ($cat && $perms->can_edit_categories)))
                    || ($cat && $author->id == $cat->author_id)
                    || ($entry && $author->id == $entry->author_id)
            );
        }
    }
    return [] unless @data;

    my $junk_tab = ($app->param('tab') || '') eq 'junk';
    $param->{ping_table}[0] = { %$list_pref };
    $param->{ping_table}[0]{object_loop} = \@data;
    $param->{ping_table}[0]{object_type} = 'ping';
    $param->{ping_table}[0]{object_type_plural} = $app->translate('TrackBacks');
    my $plugin_actions = $app->plugin_itemset_actions('ping', $junk_tab ? 'junk' : 'pings');
    $param->{ping_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('ping', $junk_tab ? 'junk' : 'pings');
    $param->{ping_table}[0]{core_itemset_action_loop} = $core_actions || [];
    $param->{ping_table}[0]{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
    \@data;
}

sub list_entries {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms};
    if ($perms && (!$perms->can_edit_all_posts && !$perms->can_post)) {
        return $app->errtrans("Permission denied.");
    }

    require MT::Entry;

    my $list_pref = $app->list_pref('entry');
    my %param = %$list_pref;
    my $blog_id = $q->param('blog_id');
    my %terms;
    $terms{blog_id} = $blog_id if $blog_id;
    my $limit = $list_pref->{rows};
    my $offset = $app->param('offset') || 0;

    if (!$blog_id && !$app->user->is_superuser) {
        require MT::Permission;
        $terms{blog_id} = [ map {$_->blog_id}
                           grep {$_->can_post || $_->can_edit_all_posts}
                                MT::Permission->load({author_id =>
                                                          $app->user->id})];
    }

    my %arg;
    my $filter_col = $q->param('filter') || '';
    my $filter_val = $q->param('filter_val');
    if ($filter_col && $filter_val) {
        if (!exists ($terms{$filter_col})) {
            if ($filter_col eq 'category_id') {
                $arg{'join'} = MT::Placement->join_on('entry_id',
                    { category_id => $filter_val }, { unique => 1 });
            } elsif (($filter_col eq 'normalizedtag') || ($filter_col eq 'exacttag')) {
                my $normalize = ($filter_col eq 'normalizedtag');
                require MT::Tag;
                require MT::ObjectTag;
                my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
                my @filter_vals = MT::Tag->split($tag_delim, $filter_val);
                my @filter_tags = @filter_vals;
                if ($normalize) {
                    push @filter_tags, MT::Tag->normalize($_) foreach @filter_vals;
                }
                my @tags = MT::Tag->load({ name => [ @filter_tags ] }, { binary => { name => 1 }});
                my @tag_ids;
                foreach (@tags) {
                    push @tag_ids, $_->id;
                    if ($normalize) {
                        my @more = MT::Tag->load({ n8d_id => $_->n8d_id ? $_->n8d_id : $_->id });
                        push @tag_ids, $_->id foreach @more;
                    }
                }
                @tag_ids = ( 0 ) unless @tags;
                $arg{'join'} = MT::ObjectTag->join_on('object_id',
                    { tag_id => \@tag_ids, object_datasource => MT::Entry->datasource }, { unique => 1 } );
            } else {
                $terms{$filter_col} = $filter_val;
            }
            (my $url_val = $filter_val) =~
                s!([^a-zA-Z0-9_.-])!uc sprintf "%%%02x", ord($1)!eg;
            $param{filter_args} = "&filter=$filter_col&filter_val=$url_val";
            
            my ($filter_name, $filter_value);  # human-readable versions
            if ($filter_col eq 'category_id') {
                $filter_name = $app->translate('Category');
                require MT::Category;
                my $cat = MT::Category->load($filter_val);
                return $app->errtrans("Load failed: [_1]",
                                      MT::Category->errstr) unless $cat;
                $filter_value = $cat->label;
            } elsif (($filter_col eq 'normalizedtag') || ($filter_col eq 'exacttag')) {
                $filter_name = $app->translate('Tag');
                $filter_value = $filter_val;
            } elsif ($filter_col eq 'author_id') {
                $filter_name = $app->translate('User');
                my $author = MT::Author->load($filter_val);
                return $app->errtrans("Load failed: [_1]", MT::Author->errstr)
                    unless $author;
                $filter_value = $author->name;
            } elsif ($filter_col eq 'status') {
                $filter_name = $app->translate('Post Status');
                $filter_value = $app->translate(MT::Entry::status_text($filter_val));
            }
            if ($filter_name && $filter_value) {
                $param{filter} = $filter_col;
                $param{'filter_col_' . $filter_col} = 1;
                $param{filter_val} = $filter_val;
            }
        }
        $param{filter_unpub} = $filter_col eq 'status';
    }
    require MT::Category;
    require MT::Placement;

    my $total = MT::Entry->count(\%terms, \%arg) || 0;
    $arg{'sort'} = 'created_on';
    $arg{direction} = 'descend';
    $arg{limit} = $limit + 1;
    if ($offset > $total - 1) {
        $arg{offset} = $offset = $total - $limit;
    } elsif ($offset < 0) {
        $arg{offset} = $offset = 0;
    } else {
        $arg{offset} = $offset if $offset;
    }
    
    my $iter = MT::Entry->load_iter(\%terms, \%arg);

    my $is_power_edit = $q->param('is_power_edit');
    if ($is_power_edit) {
        $param{has_expanded_mode} = 0;
        delete $param{view_expanded};
    } else {
        $param{has_expanded_mode} = 1;
    }
    my $data = $app->build_entry_table( iter => $iter,
        is_power_edit => $is_power_edit, param => \%param );
    delete $param{entry_table} unless @$data;
    ## We tried to load $limit + 1 entries above; if we actually got
    ## $limit + 1 back, we know we have another page of entries.
    my $have_next_entry = @$data > $limit;
    pop @$data while @$data > $limit;
    if ($offset) {
        $param{prev_offset} = 1;
        $param{prev_offset_val} = $offset - $limit;
        $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
    }
    if ($have_next_entry) {
        $param{next_offset} = 1;
        $param{next_offset_val} = $offset + $limit;
    }

    $iter = MT::Author->load_iter({ type => MT::Author::AUTHOR }, {
        'join' => MT::Entry->join_on(
                    'author_id',
                    { $blog_id ? ( blog_id => $blog_id ) : () },
                    { 'unique' => 1,
                      'sort' => 'created_on',
                      direction => 'descend' } ),
    });
    my %seen;
    my @authors;
    while (my $au = $iter->()) {
        next if $seen{$au->id};
        $seen{$au->id} = 1;
        my $row = {author_name => $au->name,
                     author_id => $au->id };
        push @authors, $row;
        if (@authors == 50) {
            $iter->('finish');
            last;
        }
    }
    $param{entry_author_loop} = \@authors;

    $param{plugin_action_loop} = $app->plugin_actions('list_entries') || [];
    $param{can_power_edit} = $blog_id && !$is_power_edit;
    $param{is_power_edit} = $is_power_edit;
    $param{saved_deleted} = $q->param('saved_deleted');
    $param{saved} = $q->param('saved');
    $param{limit} = $limit;
    $param{offset} = $offset;
    $param{object_type} = 'entry';
    $param{object_type_plural} = $app->translate('entries');
    $param{search_type} = $app->translate('Entries');
    $param{list_start} = $offset + 1;
    $param{list_end} = $offset + scalar @$data;
    $param{list_total} = $total;
    $param{next_max} = $param{list_total} - $limit;
    $param{next_max} = 0 if ($param{next_max} || 0) < $offset + 1;
    $param{nav_entries} = 1;
    $param{feed_name} = $app->translate("Entry Activity Feed");
    $param{feed_url} = $app->make_feed_link('entry', $blog_id ? { blog_id => $blog_id } : undef);
    $app->add_breadcrumb($app->translate('Entries'));
    unless ($blog_id) {
        $param{system_overview_nav} = 1;
    }
    $app->build_page("list_entry.tmpl", \%param);
}

sub build_entry_table {
    my $app = shift;
    my (%args) = @_;

    my $app_author = $app->user;
    my $perms = $app->{perms};

    my $list_pref = $app->list_pref('entry');
    if ($args{is_power_edit}) {
        delete $list_pref->{view_expanded};
    }
    my $iter;
    if ($args{load_args}) {
        my $class = $app->_load_driver_for('entry');
        $iter = $class->load_iter( @{ $args{load_args} } );
    } elsif ($args{iter}) {
        $iter = $args{iter};
    } elsif ($args{items}) {
        $iter = sub { shift @{ $args{items} } };
    }
    return [] unless $iter;
    my $limit = $args{limit};
    my $is_power_edit = $args{is_power_edit} || 0;
    my $param = $args{param} || {};

    ## Load list of categories for display in filter pulldown (and selection
    ## pulldown on power edit page).
    my($c_data, %cats);
    my $blog_id = $app->param('blog_id');
    if ($blog_id && $is_power_edit) {
        $c_data = $app->_build_category_list(blog_id => $blog_id);
        my $i = 0;
        for my $row (@$c_data) {
            $row->{category_index} = $i++;
            my $spacer = $row->{category_label_spacer} || '';
            $spacer =~ s/\&nbsp;/\\u00A0/g;
            $row->{category_label_js} = $spacer . encode_js($row->{category_label});
            $cats{ $row->{category_id} } = $row;
        }
        $param->{category_loop} = $c_data;
    }
    
    ## Load list of users for display in filter pulldown (and selection
    ## pulldown on power edit page).
    my(@a_data, %authors);
    if ($is_power_edit) {
        # FIXME: Scaling issue for lots of authors on one blog
        my $auth_iter = MT::Author->load_iter({type => AUTHOR, is_superuser => 1 }, {
            'not' => { is_superuser => 1 },
            'join' => MT::Permission->join_on('author_id',
                        { blog_id => $blog_id } ) });
        while (my $author = $auth_iter->()) {
            $authors{ $author->id } = $author->name;
            push @a_data, { author_id => $author->id,
                            author_name => encode_js($author->name) };
        }
        $auth_iter = MT::Author->load_iter({type => AUTHOR, is_superuser => 1 });
        while (my $author = $auth_iter->()) {
            $authors{ $author->id } = $author->name;
            push @a_data, { author_id => $author->id,
                            author_name => encode_js($author->name) };
        }
        @a_data = sort { $a->{author_name} cmp $b->{author_name} } @a_data;
        my $i = 0;
        for my $row (@a_data) {
            $row->{author_index} = $i++;
        }
        $param->{author_loop} = \@a_data;
    }

    my(@cat_list, @auth_list);
    if ($is_power_edit) {
        @cat_list = sort { $cats{$a}->{category_index} <=> $cats{$b}->{category_index} } keys %cats;
        @auth_list = sort { $authors{$a} cmp $authors{$b} } keys %authors;
    }

    my @data;
    my %blogs;
    require MT::Blog;
    my $title_max_len = const('DISPLAY_LENGTH_EDIT_ENTRY_TITLE');
    my $excerpt_max_len = const('DISPLAY_LENGTH_EDIT_ENTRY_TEXT_FROM_EXCERPT');
    my $text_max_len = const('DISPLAY_LENGTH_EDIT_ENTRY_TEXT_BREAK_UP');
    my %blog_perms;
    $blog_perms{$perms->blog_id} = $perms if $perms;
    while (my $obj = $iter->()) {
        my $blog_perms;
        if (!$app_author->is_superuser()) {
            $blog_perms = $blog_perms{$obj->blog_id} || $app_author->blog_perm($obj->blog_id);
        }

        my $row = $obj->column_values;
        $row->{text} ||= '';
        if (my $ts = $obj->created_on) {
            $row->{created_on_formatted} = format_ts("%Y.%m.%d", $ts);
            $row->{created_on_time_formatted} =
                format_ts("%Y-%m-%d %H:%M:%S", $ts);
            $row->{created_on_relative} = 
                relative_date($ts, time, $obj->blog);
        }
        my $author = $obj->author;
        $row->{author_name} = $author ? $author->name : $app->translate('(user deleted)');
        $row->{category_name} = $obj->category ? $obj->category->label : '';
        $row->{title_short} = $obj->title;
        if (!defined($row->{title_short}) || $row->{title_short} eq '') {
            my $title = remove_html($obj->text);
            $row->{title_short} = substr_text(defined($title) ? $title : "", 0, $title_max_len) . '...';
        } else {
            $row->{title_short} = remove_html($row->{title_short});
            $row->{title_short} = substr_text($row->{title_short}, 0, $title_max_len + 3) . '...'
                if length_text($row->{title_short}) > $title_max_len;
        }
        if ($row->{excerpt}) {
            $row->{excerpt} = remove_html($row->{excerpt});
        }
        if (!$row->{excerpt}) {
            my $text = remove_html($row->{text}) || '';
            $row->{excerpt} = first_n_text($text, $excerpt_max_len);
            if (length($text) > length($row->{excerpt})) {
                $row->{excerpt} .= ' ...';
            }
        }
        $row->{text} = break_up_text($row->{text}, $text_max_len) if $row->{text};
        $row->{title_long} = remove_html($obj->title);
        $row->{status_text} =
            $app->translate(MT::Entry::status_text($obj->status));
        $row->{"status_" . MT::Entry::status_text($obj->status)} = 1;
        $row->{has_edit_access} = $app_author->is_superuser ||
            ($blog_perms && $blog_perms->can_edit_entry($obj, $app_author));
        if ($is_power_edit) {
            $row->{is_editable} = $row->{has_edit_access};

            ## This is annoying. In order to generate and pre-select the
            ## category, user, and status pull down menus, we need to
            ## have a separate *copy* of the list of categories and
            ## users for every entry listed, so that each row in the list
            ## can "know" whether it is selected for this entry or not.
            my @this_c_data;
            my $this_category_id = $obj->category ? $obj->category->id : undef;
            for my $c_id (@cat_list) {
                push @this_c_data, { %{$cats{$c_id}} };
                $this_c_data[-1]{category_is_selected} = $this_category_id &&
                    $this_category_id == $c_id ? 1 : 0;
            }
            $row->{row_category_loop} = \@this_c_data;

            my @this_a_data;
            my $this_author_id = $obj->author_id;
            for my $a_id (@auth_list) {
                push @this_a_data, { author_name => $authors{$a_id},
                                     author_id => $a_id };
                $this_a_data[-1]{author_is_selected} = $this_author_id &&
                    $this_author_id == $a_id ? 1 : 0;
            }
            $row->{row_author_loop} = \@this_a_data;
        }
        if (my $blog = $blogs{$obj->blog_id} ||= MT::Blog->load($obj->blog_id)) {
            $row->{weblog_id} = $blog->id;
            $row->{weblog_name} = $blog->name;
        }
        if ($obj->status == MT::Entry::RELEASE) {
            $row->{entry_permalink} = $obj->permalink;
        }
        $row->{object} = $obj;
        push @data, $row;
    }
    return [] unless @data;

    $param->{entry_table}[0] = { %$list_pref };
    $param->{entry_table}[0]{object_loop} = \@data;
    my $plugin_actions = $app->plugin_itemset_actions('entry');
    $param->{entry_table}[0]{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('entry');
    $param->{entry_table}[0]{core_itemset_action_loop} = $core_actions || [];
    $param->{entry_table}[0]{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
    \@data;
}

sub save_entries {
    my $app = shift;
    my $perms = $app->{perms};
    return $app->errtrans("Permission denied.")
        unless $perms && ($perms->can_post || $perms->can_edit_all_posts);
    
    $app->validate_magic() or return;

    my $q = $app->param;
    my @p = $q->param;
    require MT::Entry;
    require MT::Placement;
    my $blog_id = $q->param('blog_id');
    my $this_author = $app->user;
    my $this_author_id = $this_author->id;
    for my $p (@p) {
        next unless $p =~ /^category_id_(\d+)/;
        my $id = $1;
        my $entry = MT::Entry->load($id);
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_edit_entry($entry, $this_author);
        my $orig_obj = $entry->clone;
        my $author_id = $q->param('author_id_' . $id);
        $entry->author_id($author_id ? $author_id : 0);
        $entry->status(scalar $q->param('status_' . $id));
        $entry->title(scalar $q->param('title_' . $id));
        my $co = $q->param('created_on_' . $id);
        unless ($co =~
            m!(\d{4})-(\d{2})-(\d{2})\s+(\d{2}):(\d{2})(?::(\d{2}))?!) {
            return $app->error($app->translate(
                "Invalid date '[_1]'; authored on dates must be in the format YYYY-MM-DD HH:MM:SS.", $co));
        }
        my $s = $6 || 0;

        # Emit an error message if the date is bogus.
        return $app->error(
            $app->translate( "Invalid date '[_1]'; authored on dates should be real dates.", $co)
        ) if $s > 59 || $s < 0 ||
             $5 > 59 || $5 < 0 ||
             $4 > 23 || $4 < 0 ||
             $2 > 12 || $2 < 1 ||
             $3 < 1  ||
             (MT::Util::days_in($2, $1) < $3 && !MT::Util::leap_day($0, $1, $2));

        my $ts = sprintf "%04d%02d%02d%02d%02d%02d", $1, $2, $3, $4, $5, $s;
        $entry->created_on($ts);
        $entry->save
            or return $app->error($app->translate(
                "Saving entry '[_1]' failed: [_2]", $entry->title,
                $entry->errstr));
        my $cat_id = $q->param($p);
        my $place = MT::Placement->load({ entry_id => $id,
                                          is_primary => 1 });
        if ($place && !$cat_id) {
            $place->remove
                or return $app->error($app->translate(
                    "Removing placement failed: [_1]", $place->errstr));
        }
        elsif ($cat_id) {
            unless ($place) {
                $place = MT::Placement->new;
                $place->entry_id($id);
                $place->blog_id($blog_id);
                $place->is_primary(1);
            }
            $place->category_id(scalar $q->param($p));
            $place->save
                or return $app->error($app->translate(
                    "Saving placement failed: [_1]", $place->errstr));
        }
        MT->run_callbacks('CMSPostSave.entry', $app, $entry, $orig_obj);
    }
    $app->add_return_arg('saved' => 1, is_power_edit => 1);
    $app->call_return;
}

sub save_entry {
    my $app = shift;
    my $q = $app->param;
    my $author = $app->user;
    if ($q->param('preview_entry')) {
        return $app->preview_entry;
    } elsif ($q->param('reedit')) {
        $q->param('_type', 'entry');
        return $app->edit_object;
    } elsif ($q->param('cancel')) {
        return $app->redirect($app->uri('mode' => 'list_entries',
                                  args => { blog_id => $app->param('blog_id')}));
    }
    my $perms = $app->{perms}
        or return $app->errtrans("Permission denied.");
    my $id = $q->param('id');
    if (!$id) {
        return $app->errtrans("Permission denied.")
            unless $perms->can_post;
    }

    $app->validate_magic() or return;

    require MT::Blog;
    my $blog_id = $q->param('blog_id');
    my $blog = MT::Blog->load($blog_id);

    require MT::Entry;
    my($obj, $orig_obj, $orig_file);
    if ($id) {
        $obj = MT::Entry->load($id)
            || return $app->error($app->translate("No such entry."));
        return $app->error($app->translate("Invalid parameter"))
            unless $obj->blog_id == $blog_id;
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_edit_entry($obj, $author);
        $orig_obj = $obj->clone;
        $orig_file = archive_file_for($orig_obj, $blog, 'Individual');
    } else {
        $obj = MT::Entry->new;
    }
    my $status_old = $id ? $obj->status : 0;
    my $names = $obj->column_names;
    ## Get rid of category_id param, because we don't want to just set it
    ## in the Entry record; save it for later when we will set the Placement.
    my $cat_id = $q->param('category_id');
    $app->delete_param('category_id');
    if ($id) {
        ## Delete the author_id param (if present), because we don't want to
        ## change the existing author.
        $app->delete_param('author_id');
    }
    my @add_cat;
    my @param = $q->param();
    foreach (@param) {
        if (m/^add_category_id_(\d+)$/) {
            push @add_cat, $1;
        }
    }
    my %values = map { $_ => scalar $q->param($_) } @$names;
    ## Strip linefeed characters.
    for my $col (qw( text excerpt text_more keywords )) {
        $values{$col} =~ tr/\r//d if $values{$col};
    }
    $values{allow_comments} = 0 
        if !defined($values{allow_comments}) ||
           $q->param('allow_comments') eq '';
    delete $values{week_number}
        if ($q->param('week_number') || '') eq '';
    $obj->set_values(\%values);
    $obj->allow_pings(0)
        if !defined $q->param('allow_pings') ||
           $q->param('allow_pings') eq '';
    my $co = $q->param('created_on_manual');

    if (!$id) {
        #  basename check for this new entry...
        if (my $basename = $q->param('basename') &&
            !$q->param('basename_manual')) {
            my $cnt = MT::Entry->count({ blog_id => $blog_id, basename => $basename });
            if ($cnt) {
                $obj->basename(MT::Util::make_unique_basename($obj));
            }
        }
    }

    # check to make sure blog has site url and path defined.
    # otherwise, we can't publish a released entry
    if (($obj->status || 0) != MT::Entry::HOLD()) {
        if (!$blog->site_path || !$blog->site_url) {
            return $app->error($app->translate(
                "Your weblog has not been configured with a site path and URL. You cannot publish entries until these are defined."
            ));
        }
    }

    my ($previous_old, $next_old);
    if ($co && ($co ne $q->param('created_on_old') || !$obj->id)) {
        unless ($co =~
            m!(\d{4})-(\d{2})-(\d{2})\s+(\d{2}):(\d{2})(?::(\d{2}))?!) {
            return $app->error($app->translate(
                "Invalid date '[_1]'; authored on dates must be in the format YYYY-MM-DD HH:MM:SS.", $co));
        }
        my $s = $6 || 0;
    return $app->error($app->translate(
        "Invalid date '[_1]'; authored on dates should be real dates.", $co))
        if ($s > 59 || $s < 0  || $5 > 59 || $5 < 0 || $4 > 23 || $4 < 0
            || $2 > 12 || $2 < 1 || $3 < 1
            || (MT::Util::days_in($2, $1) < $3 && !MT::Util::leap_day($0, $1, $2)));
        $previous_old = $obj->previous(1);
        $next_old = $obj->next(1);
        my $ts = sprintf "%04d%02d%02d%02d%02d%02d", $1, $2, $3, $4, $5, $s;
        $obj->created_on($ts);
    }
    my $is_new = $obj->id ? 0 : 1;

    MT->run_callbacks('CMSPreSave.entry', $app, $obj, $orig_obj)
        || return $app->error($app->translate("PreSave failed [_1]", MT->errstr));

    $obj->save or
        return $app->error($app->translate(
            "Saving entry failed: [_1]", $obj->errstr));
    require MT::Log;
    $app->log({
        message => $app->translate("Entry '[_1]' (ID:[_2]) added by user '[_3]'", $obj->title, $obj->id, $author->name),
        level => MT::Log::INFO(),
        class => 'entry',
        category => 'new',
        metadata => $obj->id
    }) if $is_new;

    my $error_string = MT::callback_errstr();

    ## Now that the object is saved, we can be certain that it has an
    ## ID. So we can now add/update/remove the primary placement.
    require MT::Placement;
    my $place = MT::Placement->load({ entry_id => $obj->id, is_primary => 1 });
    if ($cat_id) {
        unless ($place) {
            $place = MT::Placement->new;
            $place->entry_id($obj->id);
            $place->blog_id($obj->blog_id);
            $place->is_primary(1);
        }
        $place->category_id($cat_id);
        $place->save;
    } else {
        if ((defined $cat_id) && ($place)) {
            $place->remove;
        }
    }

    my $placements_updated;
    # save secondary placements...
    my @place = MT::Placement->load({ entry_id => $obj->id,
                                      is_primary => 0 });
    for my $place (@place) {
        $place->remove;
        $placements_updated = 1;
    }       
    for my $cat_id (@add_cat) {
        ## Check for the stupid dummy option we have to add in order to
        ## get rid of the jumping select box on Mac IE.
        next if $cat_id == -1;

        # blog_id check for quickpost since it's possible to select
        # additional categories across weblogs...
        my $cat = MT::Category->load($cat_id, { cached_ok => 1 });
        next if $cat->blog_id != $obj->blog_id;

        my $place = MT::Placement->new;
        $place->entry_id($obj->id);
        $place->blog_id($obj->blog_id);
        $place->is_primary(0);
        $place->category_id($cat_id);
        $place->save
            or return $app->error($app->translate(
                "Saving placement failed: [_1]", $place->errstr));
        $placements_updated = 1;
    }
    if ($placements_updated) {
        $obj->reset_placement_cache();
        $orig_obj->reset_placement_cache() if $orig_obj;
    }

    MT->run_callbacks('CMSPostSave.entry', $app, $obj, $orig_obj);

    ## If the saved status is RELEASE, or if the *previous* status was
    ## RELEASE, then rebuild entry archives, indexes, and send the
    ## XML-RPC ping(s). Otherwise the status was and is HOLD, and we
    ## don't have to do anything.
    if (($obj->status || 0) == MT::Entry::RELEASE() ||
        $status_old eq MT::Entry::RELEASE()) {
        if ($app->config('PublishCommenterIcon')) {
            $app->publisher->make_commenter_icon($blog);
        }

        if ($app->config('DeleteFilesAtRebuild') && $orig_obj) {
            my $file = archive_file_for($obj, $blog, 'Individual');
            if ($file ne $orig_file || $obj->status != MT::Entry::RELEASE()) {
                $app->publisher->remove_entry_archive_file( Entry => $orig_obj );
            }
        }

        # If there are no static pages, just rebuild indexes.
        if ($blog->count_static_templates('Individual') == 0
            || MT::Util->launch_background_tasks()) {
            my $res = MT::Util::start_background_task(sub {
                $app->rebuild_entry(Entry => $obj, BuildDependencies => 1,
                                OldEntry => $orig_obj,
                                OldPrevious => ($previous_old)
                                                   ? $previous_old->id : undef,
                                OldNext => ($next_old) ? $next_old->id : undef)
                or return;
                1;
            });
            return unless $res;
            return $app->ping_continuation($obj, $blog, OldStatus => $status_old,
                                           IsNew => $is_new,
                                           IsBM => $q->param('is_bm')||0);
        } else {
            return $app->redirect($app->uri('mode' => 'start_rebuild', args => {
                      blog_id => $obj->blog_id, 'next' => 0, type => 'entry-' . $obj->id,
                      entry_id => $obj->id, is_bm => ($q->param('is_bm') || 0),
                      is_new => $is_new, old_status => $status_old,
                      ($previous_old ? (old_previous => $previous_old->id) : ()),
                      ($next_old ? (old_next => $next_old->id) : ())}));
        }
    }
    $app->_finish_rebuild_ping($obj, !$id);
}

sub ping_continuation {
    my $app = shift;
    my ($entry, $blog, %options) = @_;
    my $list = $app->needs_ping( Entry => $entry, Blog => $blog,
                                 OldStatus => $options{OldStatus} );
    require MT::Entry;
    if ($entry->status == MT::Entry::RELEASE() && $list) {
        my @urls = map { { url => $_ } } @$list;
        $app->build_page('pinging.tmpl', { blog_id => $blog->id,
                         entry_id => $entry->id,
                         old_status => $options{OldStatus},
                         is_new => $options{IsNew},
                         url_list => \@urls,
                         is_bm => $options{IsBM} } );
    } else {
        $app->_finish_rebuild_ping($entry, $options{IsNew});
    }
}

sub _finish_rebuild_ping {
    my $app = shift;
    my($entry, $is_new, $ping_errors) = @_;
    if ($app->param('is_bm')) {
        require MT::Blog;
        require MT::Entry;
        my $blog = MT::Blog->load($entry->blog_id);
        my %param = ( blog_id => $blog->id,
                      blog_name => $blog->name,
                      blog_url => $blog->site_url,
                      entry_id => $entry->id,
                      status_released =>
                          $entry->status == MT::Entry::RELEASE() );
        $app->build_page("bm_posted.tmpl", \%param);
    } else {
        $app->redirect($app->uri( 'mode' => 'view', args => { '_type' => 'entry', blog_id => $entry->blog_id, id => $entry->id,
                       ($is_new ? (saved_added => 1) : (saved_changes => 1)),
                       ($ping_errors ? (ping_errors => 1) : ())}));
    }
}

sub edit_placements {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->errtrans("Permission denied.");
    my $q = $app->param;
    my $entry_id = $q->param('entry_id');
    require MT::Entry;
    my $entry = MT::Entry->load($entry_id);
    return $app->errtrans("Permission denied.")
        unless $perms->can_edit_entry($entry, $app->user);
    my %param;
    require MT::Category;
    my %cats;
    my $blog_id = $q->param('blog_id');
    my $iter = MT::Category->load_iter({ blog_id => $blog_id });
    my $i = 0;
    while (my $cat = $iter->()) {
        $cats{ $cat->id } = $cat->label;
    }
    require MT::Placement;
    $iter = MT::Placement->load_iter({ entry_id => $entry_id,
                                       is_primary => 0 });
    my $prim_category_id = $entry->category ? $entry->category->id : undef;
    my(@p_data, %place);
    while (my $place = $iter->()) {
        $place{$place->category_id} = 1;
        push @p_data, { place_category_id => $place->category_id,
                        place_category_label => $cats{$place->category_id} };
    }
    $param{placement_loop} = \@p_data;
    my @c_data;
    for my $id (keys %cats) {
        if (!exists $place{$id} && (!$prim_category_id || $prim_category_id
            != $id)) {
            push @c_data, { category_id => $id,
                            category_label => $cats{ $id } };
        }
    }
    @c_data = sort { $a->{category_label} cmp $b->{category_label} } @c_data;
    $param{category_loop} = \@c_data;
    $param{entry_id} = $entry_id;
    $param{saved} = $q->param('saved') ? 1 : 0;
    $app->add_breadcrumb($app->translate('Edit Categories'));
    $app->build_page('edit_placements.tmpl', \%param);
}

sub save_placements {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms}
        or return $app->errtrans("Permission denied.");
    
    $app->validate_magic() or return;

    my $entry_id = $q->param('entry_id');
    my $blog_id = $q->param('blog_id');
    require MT::Entry;
    my $entry = MT::Entry->load($entry_id);
    return $app->errtrans("Permission denied.")
        unless $perms->can_edit_entry($entry, $app->user);
    my @cat_ids = $q->param('category_id');
    require MT::Placement;
    my @place = MT::Placement->load({ entry_id => $entry_id,
                                      is_primary => 0 });
    for my $place (@place) {
        $place->remove;
    }
    for my $cat_id (@cat_ids) {
        ## Check for the stupid dummy option we have to add in order to
        ## get rid of the jumping select box on Mac IE.
        next if $cat_id == -1;

        my $place = MT::Placement->new;
        $place->entry_id($entry_id);
        $place->blog_id($blog_id);
        $place->is_primary(0);
        $place->category_id($cat_id);
        $place->save
            or return $app->error($app->translate(
                "Saving placement failed: [_1]", $place->errstr));
    }
    $app->redirect($app->uri('mode' => 'edit_placements', args => { entry_id => $entry_id, blog_id => $blog_id, saved => 1}));
}

sub _build_category_list {
    my $app = shift;
    my (%param) = @_;

    my $blog_id = $param{blog_id};
    my $new_cat_id = $param{new_cat_id};
    my $include_markers = $param{markers};
    my $counts = $param{counts};

  
    my @data;
    my %authors;
  
    require MT::Category;
  
    my %expanded;
  
    if ($new_cat_id) {
        my $new_cat = MT::Category->load($new_cat_id);
        my @parents = $new_cat->parent_categories;
        %expanded = map { $_->id => 1 } @parents;
    }
  
    my @cats = MT::Category->_flattened_category_hierarchy($blog_id);
    my $cols = MT::Category->column_names;
    my $depth = 0;
    my $i = 1;
    my $top_cat = 1;
    my ($placement_counts, $tb_counts, %tb);

    if ($counts) {
        require MT::Placement;
        require MT::Trackback;
        require MT::TBPing;

        my $max_cat_id = 0;
        foreach (@cats) { $max_cat_id = $_->id if (ref $_) && ($_->id > $max_cat_id) }

        if (MT::Object->driver->can('count_group_by')) {
            $placement_counts = {};
            # Berkeley DB users don't get the count of entries per user
            my $cat_entry_count_iter =
                MT::Placement->count_group_by({ blog_id => $blog_id }, {group => ['category_id']});
            while (my ($count, $category_id) = $cat_entry_count_iter->()) {
                $placement_counts->{$category_id} = $count;
            }

            $tb_counts = {};
            my $tb_count_iter = MT::TBPing->count_group_by({ blog_id => $blog_id, junk_status => [0, 1] }, { group => ['tb_id']});
            while (my ($count, $tb_id) = $tb_count_iter->()) {
                $tb_counts->{$tb_id} = $count;
            }
        }
        my $tb_iter = MT::Trackback->load_iter({ blog_id => $blog_id,
            category_id => [ 1, $max_cat_id ] }, { range_incl => { 'category_id' => 1 }});
        while (my $tb = $tb_iter->()) {
            $tb{$tb->category_id} = $tb;
        }
    }

    while (my $obj = shift @cats) {
        my $row = { };
        if (!ref ($obj)) {
            if ($obj eq 'BEGIN_SUBCATS') {
                $depth++;
                $top_cat = 1;
            } elsif ($obj eq 'END_SUBCATS') {
                $depth--;
            }
            push @data, { $obj => 1 } if $include_markers;
            next;
        }
        for my $col (@$cols) {
            $row->{'category_' . $col} = $obj->$col();
        }
        $row->{category_label} = remove_html($row->{category_label});
        $row->{category_label_spacer} = '&nbsp; ' x $depth;
        if ($counts) {
            $row->{category_entrycount} = $placement_counts
                ? ($placement_counts->{$obj->id} || 0) : MT::Placement->count({
                    category_id => $obj->id });
            if (my $tb = $tb{$obj->id}) {
                $row->{has_tb} = 1;
                $row->{tb_id} = $tb->id;
                $row->{category_tbcount} = $tb_counts
                    ? ($tb_counts->{$tb->id} || 0) : MT::TBPing->count({
                        tb_id => $tb->id,
                        junk_status => [0,1] });
            }
        }
        $row->{category_is_expanded} = 1 if $expanded{$obj->id};
        $row->{category_pixel_depth} = 10 * $depth;
        $row->{top_cat} = $top_cat; $top_cat = 0;
        $row->{is_object} = 1;
        push @data, $row;
    }
    \@data;
}

sub list_categories {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms};
    return $app->errtrans("Permission denied.")
        unless $perms && $perms->can_edit_categories;
    require MT::Category;
    require MT::Placement;
    require MT::Trackback;
    require MT::TBPing;
    my %param;
    my %authors;
    my $data = $app->_build_category_list(blog_id => scalar $q->param('blog_id'), 
        counts => 1, new_cat_id => scalar $q->param ('new_cat_id'));
    $param{category_loop} = $data;
    $param{saved} = $q->param('saved');
    $param{saved_deleted} = $q->param('saved_deleted');
    my $plugin_actions = $app->plugin_itemset_actions('category');
    $param{plugin_itemset_action_loop} = $plugin_actions || [];
    my $core_actions = $app->core_itemset_actions('category');
    $param{core_itemset_action_loop} = $core_actions || [];
    $param{has_itemset_actions} =
        (scalar(@$plugin_actions) || scalar(@$core_actions)) ? 1 : 0;
    $param{nav_categories} = 1;
    $app->add_breadcrumb($app->translate('Categories'));
    $app->build_page('edit_categories.tmpl', \%param);
}

sub move_category {
    my $app = shift;
    my $cat = MT::Category->load ($app->param('move_cat_id'));
    my $new_parent = $app->param('move-radio');

    $app->validate_magic() or return;

    return 1 if ($new_parent == $cat->parent);

    $cat->parent ($new_parent);
    my @siblings = MT::Category->load({ parent => $cat->parent,
                                        blog_id => $cat->blog_id });
    foreach (@siblings) {
        return $app->errtrans("The category label '[_1]' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.", $_->label)
            if $_->label eq $cat->label;
    }
    
    $cat->save or
        return $app->error ($app->translate(
            "Saving category failed: [_1]", $cat->errstr));
}

sub save_category {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms};
    return $app->errtrans("Permission denied.")
        unless $perms && $perms->can_edit_categories;
  
    $app->validate_magic() or return;
  
    require MT::Category;
    my $blog_id = $q->param ('blog_id');
    my $cat;
    if (my $moved_cat_id = $q->param ('move_cat_id')) {
        $cat = MT::Category->load($q->param('move_cat_id'));
        $app->move_category() or return;
    } else {
        for my $p ($q->param) {
            my ($parent) = $p =~ /^category-new-parent-(\d+)$/;
            next unless (defined $parent);

            my $label = $q->param ($p);
            $label =~ s/(^\s+|\s+$)//g;
            next unless ($label ne '');

            $cat = MT::Category->new;
            my $original = $cat->clone;
            $cat->blog_id($blog_id);
            $cat->label($label);
            $cat->author_id($app->user->id);
            $cat->parent($parent);

            MT->run_callbacks('CMSPreSave.category', $app, $cat, $original)
                || return $app->errtrans("Saving category failed: [_1]", MT->errstr);

            $cat->save or
                return $app->error($app->translate(
                    "Saving category failed: [_1]", $cat->errstr));

            # Now post-process it.
            MT->run_callbacks('CMSPostSave.category', $app, $cat, $original);
        }
    }

    return $app->errtrans("The category must be given a name!") 
        if !$cat;

    $app->redirect($app->uri('mode' => 'list_cat', args => { blog_id => $blog_id,
                   saved => 1, new_cat_id => $cat->id}));
}

sub cfg_blog {
    my $q = $_[0]->{query};
    $q->param('_type', 'blog');
    $q->param('id', scalar $q->param('blog_id'));
    $_[0]->edit_object({ output => 'cfg_simple.tmpl' });
}

sub user_blog_prefs {
    my $app = shift;
    my $prefs = $app->request('user_blog_prefs');
    return $prefs if $prefs && !$app->param('config_view');

    return {} unless $app->{perms};
    my $perms = $app->{perms};
    my @prefs = split /,/, $perms->blog_prefs || '';
    my %prefs;
    foreach (@prefs) {
        my ($name, $value) = split /=/, $_, 2;
        $prefs{$name} = $value;
    }
    my $updated = 0;
    if (my $view = $app->param('config_view')) {
        $prefs{'config_view'} = $view;
        $updated = 1;
    }
    if ($updated) {
        my $pref = '';
        foreach (keys %prefs) {
            $pref .= ',' if $pref ne '';
            $pref .= $_ . '=' . $prefs{$_};
        }
        $perms->blog_prefs($pref);
        if (!$perms->blog_id) {
            my $blog = $app->blog;
            $perms->blog_id($blog->id) if $blog;
        }
        $perms->save if $perms->blog_id;
    }
    $prefs{config_view} ||= 'basic';
    $app->request('user_blog_prefs', \%prefs);
    \%prefs;
}

sub cfg_prefs {
    my $app = shift;
    my $q = $app->param;
    $q->param('_type', 'blog');
    $q->param('id', scalar $q->param('blog_id'));
    my $blog_prefs = $app->user_blog_prefs;
    my $view = $blog_prefs->{config_view};
    $app->edit_object({
        output => ($view eq 'basic'  ? 'cfg_simple.tmpl' : 'cfg_prefs.tmpl')
    });
}

sub cfg_entries {
    my $q = $_[0]->{query};
    $q->param('_type', 'blog');
    $q->param('id', scalar $q->param('blog_id'));
    $_[0]->edit_object({ output => 'cfg_entries.tmpl' });
}

sub cfg_plugins {
    my $app = shift;
    my $q = $app->param;
    $q->param('_type', 'blog');
    $q->param('id', scalar $q->param('blog_id'));

    my %param;
    # also handles view switch
    if ($app->blog) {
        my $blog_prefs = $app->user_blog_prefs;
        my $view = $blog_prefs->{config_view};
        $param{"settings_mode_$view"} = 1;
    }
    $param{output} = 'list_plugin.tmpl';

    $app->edit_object(\%param);
}

sub cfg_feedback {
    my $q = $_[0]->{query};
    $q->param('_type', 'blog');
    $q->param('id', scalar $q->param('blog_id'));
    $_[0]->edit_object({ output => 'cfg_feedback.tmpl' });
}

sub cfg_archives {
    my $app = shift;
    my %param;
    %param = %{$_[0]} if $_[0];
    my $q = $app->param;
    #my $perms = $app->{perms}
    #    or return $app->error($app->translate("No permissions"));
    #return $app->error($app->translate(
    #    "You do not have permission to configure the blog"))
    #    unless $perms->can_edit_config;
    require MT::Blog;
    require MT::TemplateMap;
    require MT::Template;
    my $blog_id = $q->param('blog_id');
    my $blog = MT::Blog->load($blog_id);
    my %at = map { $_ => 1 } split /\s*,\s*/, $blog->archive_type;
    my $iter = MT::Template->load_iter({ blog_id => $blog_id });
    my(%tmpl_name);
    while (my $tmpl = $iter->()) {
        my $type = $tmpl->type;
        next unless $type eq 'archive' || $type eq 'category' ||
                    $type eq 'individual';
        $tmpl_name{$tmpl->id} = $tmpl->name;
    }
    my %map;
    my $total_rows = 2;
    $iter = MT::TemplateMap->load_iter({ blog_id => $blog_id });
    while (my $map = $iter->()) {
        push @{ $map{ $map->archive_type } }, {
            map_id => $map->id,
            archive_type => $map->archive_type,
            map_template_id => $map->template_id,
            map_file_template => encode_html($map->file_template, 1),
            map_is_preferred => $map->is_preferred,
            map_template_name => $tmpl_name{ $map->template_id },
        };
        $total_rows++;
    }
    my @data;
    $param{archive_types} = \@data;
    my $index = $app->config('IndexBasename');
    my $ext = $blog->file_extension || '';
    $ext = '.' . $ext if $ext ne '';
    for my $at (qw( Individual Daily Weekly Monthly Category )) {
        $map{$at} = [] unless $map{$at};
        my @map = sort { $a->{map_template_name} cmp $b->{map_template_name} }
                  @{ $map{$at} };
        my $tmpl_loop;
        foreach my $map (@map) {
            if ($at eq 'Individual') {
                $tmpl_loop = [
                    { name => $app->translate('yyyy/mm/entry_basename') . $ext, value => '%y/%m/%f', default => 1 },
                    { name => $app->translate('yyyy/mm/entry-basename') . $ext, value => '%y/%m/%-f', default => 1 },
                    { name => $app->translate('yyyy/mm/entry_basename/') . $index . $ext, value => '%y/%m/%b/%i' },
                    { name => $app->translate('yyyy/mm/entry-basename/') . $index . $ext, value => '%y/%m/%-b/%i' },
                    { name => $app->translate('yyyy/mm/dd/entry_basename') . $ext, value => '%y/%m/%d/%f' },
                    { name => $app->translate('yyyy/mm/dd/entry-basename') . $ext, value => '%y/%m/%d/%-f' },
                    { name => $app->translate('yyyy/mm/dd/entry_basename/') . $index . $ext, value => '%y/%m/%d/%b/%i' },
                    { name => $app->translate('yyyy/mm/dd/entry-basename/') . $index . $ext, value => '%y/%m/%d/%-b/%i' },
                    { name => $app->translate('category/sub_category/entry_basename') . $ext, value => '%c/%f' },
                    { name => $app->translate('category/sub_category/entry_basename/') . $index . $ext, value => '%c/%b/%i' },
                    { name => $app->translate('category/sub-category/entry_basename') . $ext, value => '%-c/%f' },
                    { name => $app->translate('category/sub-category/entry-basename') . $ext, value => '%-c/%-f' },
                    { name => $app->translate('category/sub-category/entry_basename/') . $index . $ext, value => '%-c/%b/%i' },
                    { name => $app->translate('category/sub-category/entry-basename/') . $index . $ext, value => '%-c/%-b/%i' },
                    { name => $app->translate('primary_category/entry_basename') . $ext, value => '%C/%f' },
                    { name => $app->translate('primary_category/entry_basename/') . $index . $ext, value => '%C/%b/%i' },
                    { name => $app->translate('primary-category/entry_basename') . $ext, value => '%-C/%f' },
                    { name => $app->translate('primary-category/entry-basename') . $ext, value => '%-C/%-f' },
                    { name => $app->translate('primary-category/entry_basename/') . $index . $ext, value => '%-C/%b/%i' },
                    { name => $app->translate('primary-category/entry-basename/') . $index . $ext, value => '%-C/%-b/%i' },
                ];
                if ( $map->{map_file_template} eq '%e%x' ) {
                    push @$tmpl_loop,
                        { name => '000123' . $ext, value => '%e%x' };
                }
            } elsif ($at eq 'Monthly') {
                $tmpl_loop = [
                    { name => $app->translate('yyyy/mm/') . $index . $ext, value => '%y/%m/%i', default => 1 },
                ];
                if ( $map->{map_file_template} eq '%y_%m%x' ) {
                    push @$tmpl_loop,
                        { name => $app->translate('yyyy_mm') . $ext, value => '%y_%m%x' };
                }
            } elsif ($at eq 'Daily') {
                $tmpl_loop = [
                    { name => $app->translate('yyyy/mm/dd/') . $index . $ext, value => '%y/%m/%d/%i', default => 1 },
                ];
                if ( $map->{map_file_template} eq '%y_%m_%d%x' ) {
                    push @$tmpl_loop,
                        { name => $app->translate('yyyy_mm_dd') . $ext, value => '%y_%m_%d%x' };
                }
            } elsif ($at eq 'Weekly') {
                $tmpl_loop = [
                    { name => $app->translate('yyyy/mm/dd-week/') . $index . $ext, value => '%y/%m/%d-week/%i', default => 1 },
                ];
                if ( $map->{map_file_template} eq 'week_%y_%m_%d%x' ) {
                    push @$tmpl_loop,
                        { name => $app->translate('week_yyyy_mm_dd') . $ext, value => 'week_%y_%m_%d%x' };
                }
            } elsif ($at eq 'Category') {
                $tmpl_loop = [
                    { name => $app->translate('category/sub_category/') . $index . $ext, value => '%c/%i', default => 1 },
                    { name => $app->translate('category/sub-category/') . $index . $ext, value => '%-c/%i' },
                ];
                if ( $map->{map_file_template} eq 'cat_%C%x' ) {
                    push @$tmpl_loop,
                        { name => $app->translate('cat_category') . $ext, value => 'cat_%C%x' };
                }
            }
            my $custom = 1;
            foreach (@$tmpl_loop) {
                if ((!$map->{map_file_template} && $_->{default}) ||
                    ($map->{map_file_template} eq $_->{value})) {
                    $_->{selected} = 1;
                    $custom = 0;
                    $map->{map_file_template} = $_->{value} if !$map->{map_file_template};
                }
            }
            if ($custom) {
                unshift @$tmpl_loop, {
                    name => $map->{map_file_template},
                    value => $map->{map_file_template},
                    selected => 1,
                };
            }
            $map->{archive_tmpl_loop} = $tmpl_loop;
        }
        push @data, {
            archive_type_translated => $app->translate(uc($at)."_ADV"),
            archive_type => $at,
            template_map => \@map,
            map_count => (scalar @map) + 2,
            is_selected => $at{$at},
        };
        if (scalar @map > 1) {
            $_->{multiple_archives} = 1 foreach @map;
            $param{has_multiple_archives} = 1;
        }
    }
    $param{saved} = 1 if $q->param('saved');
    $param{saved_deleted} = 1 if $q->param('saved_deleted');
    $param{saved_added} = 1 if $q->param('saved_added');
    $param{archives_changed} = 1 if $q->param('archives_changed');
    $param{no_writedir} = $q->param('no_writedir');
    $param{no_cachedir} = $q->param('no_cachedir');
    $param{no_writecache} = $q->param('no_writecache');
    $blog = MT::Blog->load(scalar $q->param('blog_id'));
    $param{dynamic_none} = $blog->custom_dynamic_templates eq 'none';
    $param{dynamic_archives} = 
        $blog->custom_dynamic_templates eq 'archives';
    $param{dynamic_custom} = $blog->custom_dynamic_templates eq 'custom';
    $param{dynamic_all} = $blog->custom_dynamic_templates eq 'all';
    $param{show_build_options} = $app->config('ObjectDriver') =~ m/^DBI::(postgres|sqlite|mysql)/;
    my $mtview_path = File::Spec->catfile($blog->site_path(), "mtview.php");
    if (-f $mtview_path) {
        open my($fh), $mtview_path;
        while (my $line = <$fh>) {
            $param{dynamic_caching} = 1 if $line =~ m/^\s*\$mt->caching\s*=\s*true;/i;
            $param{dynamic_conditional} = 1 if $line =~ /^\s*\$mt->conditional\s*=\s*true;/i;
        }
        close $fh;
    }
    $iter = MT::Template->load_iter({ blog_id => $blog->id });
    my(@tmpl);
    while (my $tmpl = $iter->()) {
        my $type = $tmpl->type;
        next unless $type eq 'archive' || $type eq 'category' ||
                    $type eq 'individual';
        push @tmpl, { template_id => $tmpl->id, template_name => $tmpl->name };
    }
    @tmpl = sort { $a->{template_name} cmp $b->{template_name} } @tmpl;
    $param{templates} = \@tmpl;
    $param{output} = 'cfg_archives.tmpl';
    $q->param('_type', 'blog');
    $q->param('id', $blog_id);
    $app->edit_object(\%param);
}

sub cfg_archives_save {
    my $app = shift;
    my ($blog) = @_;

    my $q = $app->param;
    require MT::TemplateMap;
    my $old_types = $blog->archive_type || '';
    my @types = $q->param('archive_type');
    if (!@types) {
        $blog->archive_type_preferred('');
        $blog->archive_type('None');
    } else {
        $blog->archive_type(join ',', @types);
        if (!$blog->archive_type_preferred) {
            $blog->archive_type_preferred($types[0]);
        }
    }
 
    $blog->touch;
    $blog->save
        or return $app->error($app->translate(
            "Saving blog failed: [_1]", $blog->errstr));
    my @p = $q->param;
    for my $p (@p) {
        if ($p =~ /^archive_tmpl_preferred_(\w+)$/) {
            my $at = $1;
            my $map_id = $q->param($p);
            my @all = MT::TemplateMap->load({ blog_id => $blog->id,
                                              archive_type => $at });
            for my $map (@all) {
                next if $map->id eq $map_id;
                $map->is_preferred(0);
                $map->save;
            }

            my $map = MT::TemplateMap->load($map_id);
            $map->is_preferred(1);
            $map->save;
        }
        elsif ($p =~ /^archive_file_tmpl_(\d+)$/) {
            my $map_id = $1;
            my $map = MT::TemplateMap->load($map_id);
            $map->file_template($q->param($p));
            $map->save;
        }
    }
    if ($old_types ne $blog->archive_type) {
        $app->add_return_arg(archives_changed => 1);
    }
}

sub cfg_archives_do_add {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    return $app->error($app->translate(
        "You do not have permission to configure the blog"))
        unless $perms->can_edit_config;
    
    $app->validate_magic() or return;

    require MT::TemplateMap;
    my $blog_id = $q->param('blog_id');
    my $at = $q->param('new_archive_type');
    my $count = MT::TemplateMap->count({ blog_id => $blog_id,
                                         archive_type => $at });
    my $map = MT::TemplateMap->new;
    $map->is_preferred($count ? 0 : 1);
    $map->template_id(scalar $q->param('template_id'));
    $map->blog_id($blog_id);
    $map->archive_type($at);
    $map->save
        or return $app->error($app->translate(
            "Saving map failed: [_1]", $map->errstr));
    $app->redirect($app->uri('mode' => 'cfg_archives', args => {
        blog_id => $blog_id, saved_added => 1}));
}

sub cfg_system_general {
    my $app = shift;
    my %param;
    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser();
    my $cfg = $app->config;
    $app->add_breadcrumb($app->translate('General Settings'));
    $param{nav_config} = 1;
    $param{nav_settings} = 1;
    $param{languages} = $app->languages_list($app->config('DefaultUserLanguage'));
    my $tag_delim = $app->config('DefaultUserTagDelimiter') || 'comma';
    $param{"tag_delim_$tag_delim"} = 1;

    (my $tz = $app->config('DefaultTimezone')) =~ s![-\.]!_!g;
    $tz =~ s!_00$!!;
    $param{'server_offset_' . $tz} = 1;

    $param{default_site_root} = $app->config('DefaultSiteRoot');
    $param{default_site_url} = $app->config('DefaultSiteURL');
    $param{saved} = $app->param('saved');
    $param{error} = $app->param('error');
    $app->build_page('cfg_system_general.tmpl', \%param);
}

sub save_cfg_system_general {
    my $app = shift;
    $app->validate_magic or return;
    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser();

    my $tmpl_blog_id = $app->param('new_user_template_blog_id') || '';
    if ($tmpl_blog_id =~ m/^\d+$/) {
        MT::Blog->load($tmpl_blog_id)
            or return $app->error($app->translate("Invalid ID given for personal weblog clone source ID."));
    } else {
        if ($tmpl_blog_id ne '') {
            return $app->error($app->translate("Invalid ID given for personal weblog clone source ID."));
        }
    }

    my $cfg = $app->config;
    my $tz = $app->param('default_time_zone');
    $app->config('DefaultTimezone', $tz || undef, 1);
    $app->config('DefaultSiteRoot', $app->param('default_site_root') || undef, 1);
    $app->config('DefaultSiteURL', $app->param('default_site_url') || undef, 1);
    $app->config('NewUserTemplateBlogId', $tmpl_blog_id || undef, 1);
    $app->config('DefaultUserLanguage', $app->param('default_language'), 1);
    $app->config('DefaultUserTagDelimiter', $app->param('default_user_tag_delimiter') || undef, 1);
    $cfg->save_config();
    my $args = {};
    $args->{saved} = 1;

    $app->redirect($app->uri('mode' => 'cfg_system',
                             args => $args));
}

sub cfg_system_feedback {
    my $app = shift;
    my %param;
    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser();

    my $cfg = $app->config;
    $param{nav_config} = 1;
    $app->add_breadcrumb($app->translate('Feedback Settings'));
    $param{nav_settings} = 1;
    $param{comment_disable} = $cfg->AllowComments ? 0 : 1;
    $param{ping_disable} = $cfg->AllowPings ? 0 : 1;
    my $send = $cfg->OutboundTrackbackLimit || 'any';
    if ($send =~ m/^(any|off|selected|local)$/) {
        $param{"trackback_send_" . $cfg->OutboundTrackbackLimit} = 1;
        if ($send eq 'selected') {
            my @domains = $cfg->OutboundTrackbackDomains;
            my $domains = join "\n", @domains;
            $param{trackback_send_domains} = $domains;
        }
    } else {
        $param{"trackback_send_any"} = 1;
    }
    $param{saved} = $app->param('saved');
    $app->build_page('cfg_system_feedback.tmpl', \%param);
}

sub save_cfg_system_feedback {
    my $app = shift;
    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser();

    $app->validate_magic or return;
    my $cfg = $app->config;
    $cfg->AllowComments(($app->param('comment_disable') ? 0 : 1), 1);
    $cfg->AllowPings(($app->param('ping_disable') ? 0 : 1), 1);
    my $send = $app->param('trackback_send') || 'any';
    if ($send =~ m/^(any|off|selected|local)$/) {
        $cfg->OutboundTrackbackLimit($send, 1);
        if ($send eq 'selected') {
            my $domains = $app->param('trackback_send_domains') || '';
            $domains =~ s/[\r\n]+/ /gs;
            $domains =~ s/\s{2,}/ /gs;
            my @domains = split /\s/, $domains;
            $cfg->OutboundTrackbackDomains(\@domains, 1);
        }
    }
    $cfg->save_config();
    $app->redirect($app->uri('mode' => 'cfg_system_feedback',
                             args => { saved => 1 }));
}

sub reset_plugin_config {
    my $app = shift;

    my $q = $app->param;
    my $plugin_sig = $q->param('plugin_sig');
    my $profile = $MT::Plugins{$plugin_sig};
    my $blog_id = $q->param('blog_id');
    my %param;
    if ($profile && $profile->{object}) {
        $profile->{object}->reset_config($blog_id ? 'blog:' . $blog_id : 'system');
    }
    $app->add_return_arg('reset' => 1);
    $app->call_return;
}

sub save_plugin_config {
    my $app = shift;

    my $q = $app->param;
    my $plugin_sig = $q->param('plugin_sig');
    my $profile = $MT::Plugins{$plugin_sig};
    my $blog_id = $q->param('blog_id');
    my %param;
    my @params = $q->param;
    foreach (@params) {
        next if $_ =~ m/^(__mode|return_args|plugin_sig|magic_token|blog_id)$/;
        $param{$_} = $q->param($_);
    }
    if ($profile && $profile->{object}) {
        $profile->{object}->save_config(\%param, $blog_id ? 'blog:' . $blog_id : 'system');
    }

    $app->add_return_arg(saved => 1);
    $app->call_return;
}

sub preview_entry {
    my $app = shift;
    my $q = $app->param;
    require MT::Entry;
    require MT::Builder;
    require MT::Template::Context;
    require MT::Blog;
    my $blog_id = $q->param('blog_id');
    my $blog = MT::Blog->load($blog_id);
    my $id = $q->param('id');
    my $entry = MT::Entry->new;
    $entry->title($q->param('title'));
    ## Strip linefeed characters.
    for my $col (qw( text text_more )) {
        (my $val = $q->param($col) || '') =~  tr/\r//d;
        $entry->$col($val);
    }
    $entry->convert_breaks(scalar $q->param('convert_breaks'));
    my $ctx = MT::Template::Context->new;
    $ctx->stash('entry', $entry);
    $ctx->stash('blog', $blog);
    my $build = MT::Builder->new;
    my $preview_code = <<'HTML';
<p><b><$MTEntryTitle$></b></p>
<$MTEntryBody$>
<$MTEntryMore$>
HTML
    my $tokens = $build->compile($ctx, $preview_code)
        or return $app->error($app->translate(
            "Parse error: [_1]", $build->errstr));
    defined(my $html = $build->build($ctx, $tokens))
        or return $app->error($app->translate(
            "Build error: [_1]", $build->errstr));
    my %param = ( preview_body => $html );
    $param{id} = $id if $id;
    $param{new_object} = $param{id} ? 0 : 1;
    my $cols = MT::Entry->column_names;
    my @data = ({ data_name => 'author_id', data_value => $app->user->id });
    for my $col (@$cols) {
        next if $col eq 'created_on' || $col eq 'created_by' ||
                $col eq 'modified_on' || $col eq 'modified_by' ||
                $col eq 'author_id' || $col eq 'pinged_urls' ||
                $col eq 'tangent_cache';
        if ($col eq 'basename') {
            if ((!defined $q->param('basename')) || ($q->param('basename') eq '')) {
                $q->param('basename', $q->param('basename_old'));
            }
        }
        push @data, { data_name => $col,
            data_value => scalar $q->param($col) };
    }
    for my $data (qw( created_on_old created_on_manual basename_manual basename_old )) {
        push @data, { data_name => $data,
                      data_value => scalar $q->param($data) };
    }
    foreach my $qparam ($q->param) {
        next unless $qparam =~ m/^add_category_id_\d+$/;
        push @data, { data_name => $qparam,
            data_value => 1 };
    }
    my $tags = $q->param('tags');
    $tags = '' unless defined $tags;
    push @data, { data_name => 'tags', data_value => $tags };
    $param{entry_loop} = \@data;
    if ($id) {
        $app->add_breadcrumb($app->translate('Entries'),
                             $app->uri( 'mode' => 'list_entries',
                                 args => { blog_id => $blog_id }));
        $app->add_breadcrumb($entry->title || $app->translate('(untitled)'));
    } else {
        $app->add_breadcrumb($app->translate('Entries'),
             $app->uri('mode' => 'list_entries', args => { blog_id => $blog_id }));
        $app->add_breadcrumb($app->translate('New Entry'));
        $param{nav_new_entry} = 1;
    }
    $app->build_page('preview_entry.tmpl', \%param);
}

sub add_rebuild_option {
    my $class = shift;
    my ($args) = @_;
    $args->{label} ||= $args->{Name} || $args->{name};
    return $class->error(MT->translate("Rebuild-option name must not contain special characters"))
        if ($args->{label}) =~ /[\"\']/; #/[^A-Za-z0-9.:\[\]\(\)\+=!@\#\$\%\^\&\*-]/;
    my $rec = {};
    $rec->{code} = $args->{Code} || $args->{code};
    $rec->{label} = $args->{label};
    $rec->{key} = $args->{key} || dirify($rec->{label});
    push @RebuildOptions, $rec;
}

sub rebuild_confirm {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id);
    my $at = $blog->archive_type || '';
    my(@at, @data);
    if ($at && $at ne 'None') {
        @at = split /,/, $at;
        @data = map { {
                   archive_type => $_,
                   archive_type_label => $app->translate($_),
                } } @at;
    }
    my $order = join ',', @at, 'index';
    require MT::Entry;
    my $total_entries = MT::Entry->count({ blog_id => $blog_id, status => MT::Entry::RELEASE() });
    require MT::Category;
    my $total_cats = MT::Category->count({ blog_id => $blog_id });
    my %param = ( archive_type_loop => \@data,
                  build_order => $order,
                  build_next => 0,
                  total_cats => $total_cats,
                  total_entries => $total_entries );
    $param{index_selected} = ($app->param('prompt')||"") eq 'index';
    if (my $tmpl_id = $app->param('tmpl_id')) {
        require MT::Template;
        my $tmpl = MT::Template->load($tmpl_id);
        $param{index_tmpl_id} = $tmpl->id;
        $param{index_tmpl_name} = $tmpl->name;
    }
    my @options = @RebuildOptions;
    $app->run_callbacks('RebuildOptions', $app, \@options);
    $param{rebuild_option_loop} = \@options;
    $param{refocus} = 1;
    $app->add_breadcrumb($app->translate('Rebuild Site'));
    $app->build_page('rebuild_confirm.tmpl', \%param);
}

my %Limit_Multipliers = (
    Individual => 1,
    Category => 1,
    Daily => 2,
    Weekly => 5,
    Monthly => 10,
    Dynamic => 5,
);

sub start_rebuild_pages {
    my $app = shift;
    my $q = $app->param;
    my $type = $q->param('type');
    my $next = $q->param('next') || 0;
    my @order = split /,/, $type;
    my $type_name = $order[$next];
    my $total_entries = $q->param('total_entries');
    my $total_cats = $q->param('total_cats');
    my %param = ( build_type => $type,
                  build_next => $next,
                  total_entries => $total_entries,
                  total_cats => $total_cats,
                  build_type_name => $app->translate($type_name) );
    my $static_count;
    my $entries_per_rebuild = $app->config('EntriesPerRebuild');
    if (my $mult = $Limit_Multipliers{$type_name}) {
        $param{offset} = 0;
        $static_count = MT::Blog->load($q->param('blog_id'))->count_static_templates($type_name) || 0;
        if (!$static_count) {
            $param{limit} = $entries_per_rebuild * $mult * $Limit_Multipliers{'Dynamic'};
            $param{dynamic} = 1;
        } else {
            my $total = $type_name eq 'Category' ? $total_cats : $total_entries;
            $param{limit} = int($entries_per_rebuild * $mult / $static_count);
            $param{is_individual} = 1;
            $param{limit} = $entries_per_rebuild * $mult;
            $param{indiv_range} = "1 - " .
                ($param{limit} > $total ? $total : $param{limit});
        }
    } elsif ($type_name =~ /^index-(\d+)$/) {
        my $tmpl_id = $1;
        require MT::Template;
        my $tmpl = MT::Template->load($tmpl_id);
        $param{build_type_name} = $app->translate("index template '[_1]'", $tmpl->name);
        $param{is_one_index} = 1;
    } elsif ($type_name =~ /^entry-(\d+)$/) {
        my $entry_id = $1;
        require MT::Entry;
        my $entry = MT::Entry->load($entry_id);
        $param{build_type_name} = $app->translate("entry '[_1]'", $entry->title);
        $param{is_entry} = 1;
        $param{entry_id} = $entry_id;
        for my $col (qw( is_bm is_new old_status old_next old_previous )) {
            $param{$col} = $q->param($col);
        }
    }
    $param{is_full_screen} = ($param{is_entry} && !$param{is_bm}) 
        || $q->param('single_template');
    $param{page_titles} = [{bc_name => 'Rebuilding'}];
    $app->build_page('rebuilding.tmpl', \%param);
}

sub object_edit_uri {
    my $app = shift;
    my ($type, $id) = @_;
    die "no such object $type" unless $API{$type};
    eval "require " . $API{$type};
    my $obj = $API{$type}->load($id) 
        or die "object_edit_uri could not find $type object $id";
    my $blog_id = $obj->column('blog_id');
    $app->uri('mode' => 'view', args => { '_type' => $type, ($blog_id ? (blog_id => $blog_id) : ()), id => $_[1]});
}

sub rebuild_pages {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    require MT::Entry;
    require MT::Blog;
    my $q = $app->param;
    my $blog_id = $q->param('blog_id');
    my $blog = MT::Blog->load($blog_id);
    my $order = $q->param('type');
    my @order = split /,/, $order;
    my $next = $q->param('next');
    my $done = 0;
    my $type = $order[$next];
    $next++;
    $done++ if $next >= @order;
    my($offset);
    my ($limit) = $q->param('limit');

    my $total_entries = $q->param('total_entries');
    my $total_cats = $q->param('total_cats');
    my $total = $type eq 'Category' ? $total_cats : $total_entries;

    ## Tells MT::_rebuild_entry_archive_type to cache loaded templates so
    ## that each template is only loaded once.
    $app->{cache_templates} = 1;

    my($tmpl_saved);

    # Make sure errors go to a sensible place when in fs mode
    # TODO: create contin. earlier, pass it thru
    if ($app->param('fs')) {
        my ($type, $obj_id) = $app->param('type') =~ m/(entry|index)-(\d+)/;
        if ($type && $obj_id) {
            $type = 'template' if $type eq 'index';
            $app->{goback} = "window.location='" . 
                $app->object_edit_uri($type, $obj_id) . "'";
        }
    }

    # FIXME: Wrap the entire rebuild operation with begin/end callbacks
    if ($type eq 'all') {
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_rebuild;
        $app->rebuild( BlogID => $blog_id )
            or return;
    } elsif ($type eq 'index') {
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_rebuild;
        $app->rebuild_indexes( BlogID => $blog_id ) or return;
    } elsif ($type =~ /^index-(\d+)$/) {
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_rebuild;
        my $tmpl_id = $1;
        require MT::Template;
        $tmpl_saved = MT::Template->load($tmpl_id);
        $app->rebuild_indexes( BlogID => $blog_id, Template => $tmpl_saved,
                               Force => 1 )
            or return;
        $order = $app->translate("index template '[_1]'", $tmpl_saved->name);
    } elsif ($type =~ /^entry-(\d+)$/) {
        my $entry_id = $1;
        require MT::Entry;
        my $entry = MT::Entry->load($entry_id);
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_edit_entry($entry, $app->user);
        $app->rebuild_entry( Entry => $entry, BuildDependencies => 1,
                             OldPrevious => $q->param('old_previous'), 
                             OldNext => $q->param('old_next') )
            or return;
        $order = "entry '" . $entry->title . "'";
    } elsif ($type eq 'Category') {
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_rebuild;
        $offset = $q->param('offset') || 0;
        if ($offset < $total_cats) {
            $app->rebuild( BlogID => $blog_id,
                           ArchiveType => $type,
                           NoIndexes => 1,
                           Offset => $offset,
                           Limit => $limit)
                or return;
            $offset += $limit;
        }
        if ($offset < $total) {
            $done-- if $done;
            $next--;
        } else {
            $offset = 0;
        }
    } elsif ($Limit_Multipliers{$type} && $limit ne '*') {
        return $app->error($app->translate("Permission denied."))
            unless $perms->can_rebuild;
        $offset = $q->param('offset') || 0;
        if ($offset < $total) {
            $app->rebuild( BlogID => $blog_id,
                           ArchiveType => $type,
                           NoIndexes => 1,
                           Offset => $offset,
                           Limit => $limit)
                or return;
            $offset += $limit;
        }
        if ($offset < $total) {
            $done-- if $done;
            $next--;
        } else {
            $offset = 0;
        }
    } elsif ($type) {
        my $special = 0;
        my @options = @RebuildOptions;
        $app->run_callbacks('RebuildOptions', $app, \@options);
        for my $optn (@options) {
            if ($optn->{key} eq $type) {
                $optn->{code}->();
                $special = 1;
            }
        }
        if (!$special) {
            return $app->error($app->translate("Permission denied."))
                unless $perms->can_rebuild;
            $app->rebuild( BlogID => $blog_id,
                           ArchiveType => $type,
                           NoIndexes => 1 )
                or return;
        }
    }
    
    # Rebuild done--now form the continuation.
    unless ($done) {
        my $dynamic = 0;
        my $type_name = $order[$next];
        
        ## If we're moving on to the next rebuild step, recalculate the
        ## limit.
        my $mult = $Limit_Multipliers{$type_name} || 1;
        my $entries_per_rebuild = $app->config('EntriesPerRebuild');
        my $static_count;
        if ($type_name !~ m/^index/) {
            $static_count = $blog->count_static_templates($type_name) || 0;
        } else {
            $static_count = 1;
        }
        if (!$static_count) {
            $limit = $entries_per_rebuild * $mult * $Limit_Multipliers{'Dynamic'};
            $dynamic = 1;
        } elsif (defined($offset) && $offset == 0) {
            if ($mult) {
                $limit = int($entries_per_rebuild * $mult / $static_count);
            }
            $dynamic = 0;
        }
        my %param = ( build_type => $order, build_next => $next,
                      build_type_name => $app->translate($type_name),
                      total_entries => $total_entries,
                      total_cats => $total_cats,
                      offset => $offset, limit => $limit,
                      is_bm => scalar $q->param('is_bm'),
                      entry_id => scalar $q->param('entry_id'),
                      dynamic => $dynamic,
                      is_new => scalar $q->param('is_new'),
                      old_status => scalar $q->param('old_status') );
        if ($Limit_Multipliers{$type_name}) {
            if ($limit && !$dynamic) {
                $param{is_individual} = 1;
                $param{indiv_range} = sprintf "%d - %d", $offset+1,
                    $offset + $limit > $total ? $total :
                    $offset + $limit;
            }
        }
        $app->build_page('rebuilding.tmpl', \%param);
    } else {
        if ($q->param('entry_id')) {
            require MT::Entry;
            my $entry = MT::Entry->load(scalar $q->param('entry_id'));
            require MT::Blog;
            my $blog = MT::Blog->load($entry->blog_id);
            $app->ping_continuation($entry, $blog, 
                                    OldStatus => scalar $q->param('old_status'),
                                    IsNew => scalar $q->param('is_new'),
                                    IsBM => scalar $q->param('is_bm'));
        } else {
            my $all = $order =~ /,/;
            my $type = $order;
            my $is_one_index = $order =~ /index template/;
            my $is_entry = $order =~ /entry/;
            my $built_type;
            if ($is_entry || $is_one_index) {
                ($built_type = $type) =~ s/^(entry|index template)/$app->translate($1)/e;
            } else {
                $built_type = $app->translate($type);
            }
            my %param = ( all => $all, type => $built_type,
                          is_one_index => $is_one_index,
                          is_entry => $is_entry );
            if ($is_one_index) {
                $param{tmpl_url} = $blog->site_url;
                $param{tmpl_url} .= '/' if $param{tmpl_url} !~ m!/$!;
                $param{tmpl_url} .= $tmpl_saved->outfile;
            }
            if ($q->param('fs')) {        # full screen--go to a useful app page
                my $type = $q->param('type');
                $type =~ /index-(\d+)/;
                my $tmpl_id = $1;
                return $app->redirect($app->uri('mode' => 'view', args => {'_type' => 'template', id => $tmpl_id, blog_id => $blog->id, saved_rebuild => 1}));
            } else {                     # popup--just go to cnfrmn. page
                return $app->build_page('rebuilt.tmpl', \%param);
            }
        }
    }
}

sub send_pings {
    my $app = shift;
    my $q = $app->param;
    $app->validate_magic() or return;
    require MT::Entry;
    require MT::Blog;
    my $blog = MT::Blog->load(scalar $q->param('blog_id'));
    my $entry = MT::Entry->load(scalar $q->param('entry_id'));
    ## MT::ping_and_save pings each of the necessary URLs, then processes
    ## the return value from MT::ping to update the list of URLs pinged
    ## and not successfully pinged. It returns the return value from
    ## MT::ping for further processing. If a fatal error occurs, it returns
    ## undef.
    my $results = $app->ping_and_save(Blog => $blog, Entry => $entry,
        OldStatus => scalar $q->param('old_status'))
        or return;
    my $has_errors = 0;
    require MT::Log;
    for my $res (@$results) {
        $has_errors++, $app->log({
            message => $app->translate("Ping '[_1]' failed: [_2]", $res->{url}, encode_text($res->{error}, undef, undef)),
            class => 'system',
            level => MT::Log::WARNING()
        }) unless $res->{good};
    }
    $app->_finish_rebuild_ping($entry, scalar $q->param('is_new'), $has_errors);
}

sub edit_role {
    my $app = shift;
    my %param = $_[0] ? %{ $_[0] } : ();
    my $q = $app->param;
    my $author = $app->user;
    my $id = $q->param('id');

    require MT::Permission;
    if (!$author->is_superuser) {
        return $app->error($app->translate("Invalid request."));
    }
    my $role;
    if ($id) {
        require MT::Role;
        $role = MT::Role->load($id);
        # $param{is_enabled} = $role->is_active;
        $param{is_enabled} = 1;
        $param{name} = $role->name;
        $param{description} = $role->description;
        $param{id} = $role->id;
        require MT::Author;
        my $creator = MT::Author->load($role->created_by, { cached_ok => 1 })
            if $role->created_by;
        $param{created_by} = $creator ? $creator->name : '';
        my @masks = grep { m/^role_mask/ } @{ MT::Role->column_names };
        my %match = map { $_ => $role->column($_) } @masks;
        $match{id} = [ $id ];
        my $iter = MT::Role->load_iter(\%match, { not => { id => 1 } });
        my @same_perms;
        while (my $other_role = $iter->()) {
            push @same_perms, {
                name => $other_role->name,
                id => $other_role->id,
            };
        }
        $param{same_perm_loop} = \@same_perms if @same_perms;
    }

    my $all_perm_flags = MT::Permission->perms('blog');

    my @p_data;
    for my $ref (@$all_perm_flags) {
        next if $ref->[1] =~ /comment/;
        push @p_data, {
            have_access => $role && $role->has($ref->[1]),
            flag_name => $ref->[1],
            prompt => $app->translate($ref->[2]),
            mask => $ref->[0],
            bucket => $ref->[3],
        };
    }
    my $break = @p_data % 3 ? int(@p_data / 3) + 1 : @p_data / 3;
    my $set = 0;
    $param{'perm_loops'} = [];
    while (@p_data) {
        $set++;
        my $last = $#p_data;
        $last = $break - 1 if $break - 1 < $last;
        push @{$param{"perm_loops"}}, { perm_loop => [ @p_data[0..$last] ] };
        @p_data = $last == $#p_data ? () : @p_data[$last+1..$#p_data];
    }
    $param{saved} = $q->param('saved');
    $param{nav_privileges} = 1;
    $app->add_breadcrumb($app->translate('Roles'),
                         $app->uri(mode => 'list_roles'));
    if ($id) {
        $app->add_breadcrumb($role->name);
    } else {
        $app->add_breadcrumb($app->translate('Create New Role'));
    }
    $app->build_page('edit_role.tmpl', \%param);
}

sub save_role {
    my $app = shift;
    my $q = $app->param;
    $app->validate_magic() or return;
    $app->user->is_superuser or return $app->errtrans("Invalid request.");

    my $id = $q->param('id');
    my @perms = $q->param('permission');
    my $role;
    require MT::Role;
    $role = $id ? MT::Role->load($id) : MT::Role->new;
    my $name = $q->param('name') || '';
    $name =~ s/(^\s+|\s+$)//g;
    return $app->errtrans("Role name cannot be blank.")
        if $name eq '';
    my $role_by_name = MT::Role->load({ name => $name });
    if ($role_by_name && (($id && ($role->id != $id)) || !$id)) {
        return $app->errtrans("Another role already exists by that name.");
    }
    if (!@perms) {
        return $app->errtrans("You cannot define a role without permissions.");
    }

    $role->name($q->param('name'));
    $role->description($q->param('description'));
    $role->clear_full_permissions;
    $role->set_these_permissions(@perms);
    if ($role->id) {
        $role->modified_by($app->user->id);
    } else {
        $role->created_by($app->user->id);
    }
    $role->save or return $app->error($role->errstr);

    my $url;
    $url = $app->uri('mode' => 'edit_role',
                     args => { id => $role->id, saved => 1});
    $app->redirect($url);
}

sub languages_list {
    my $app = shift;
    my ($curr) = @_;

    my $langs = $app->supported_languages;
    my @data;
    $curr ||= $app->config('DefaultLanguage');
    $curr = 'en-us' if (lc($curr) eq 'en_us');
    for my $tag (keys %$langs) {
        (my $name = $langs->{$tag}) =~ s/\w+ English/English/;
        my $row = { l_tag => $tag, l_name => $app->translate($name) };
        $row->{l_selected} = 1 if $curr eq $tag;
        push @data, $row;
    }
    [ sort { $a->{l_name} cmp $b->{l_name} } @data ];
}

sub send_notify {
    my $app = shift;
    $app->validate_magic() or return;
    my $q = $app->param;
    my $entry_id = $q->param('entry_id') or
        return $app->error($app->translate("No entry ID provided"));
    require MT::Entry;
    require MT::Blog;
    my $entry = MT::Entry->load($entry_id, {cached_ok=>1}) or
        return $app->error($app->translate("No such entry '[_1]'", $entry_id));
    my $blog = MT::Blog->load($entry->blog_id, {cached_ok=>1});
    my $author = $entry->author;
    return $app->error($app->translate(
        "No email address for user '[_1]'", $author->name))
        unless $author->email;

    my $cols = 72;
    my %params;
    $params{blog_name} = $blog->name;
    $params{entry_title} = $entry->title;
    my @ts = offset_time_list(time, $blog);
    my $ts = sprintf "%04d%02d%02d%02d%02d%02d",
        $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];
    my $date = format_ts('%Y.%m.%d %H:%M:%S', $ts, $blog);
    my $fill_left = ' ' x int(($cols - length($date)) / 2);
    $params{entry_date} = $date;
    $params{spacer_date} = $fill_left;
    if ($q->param('send_excerpt')) {
        $params{send_excerpt} = 1;
        $params{entry_excerpt} = wrap_text($entry->get_excerpt, $cols - 4, "    ", "    ");
    }
    $params{entry_permalink} = $entry->permalink;
    $params{message} = wrap_text($q->param('message'), $cols, '', '');
    if ($q->param('send_body')) {
        $params{send_body} = 1;
        $params{entry_text} = wrap_text($entry->text, $cols);
    }

    my $addrs;
    if ($q->param('send_notify_list')) {
        require MT::Notification;
        my $iter = MT::Notification->load_iter({ blog_id => $blog->id });
        while (my $note = $iter->()) {
            next unless is_valid_email($note->email);
            $addrs->{$note->email} = 1;
        }
    }

    if ($q->param('send_notify_emails')) {
        my @addr = split /[\n\r,]+/, $q->param('send_notify_emails');
        for my $a (@addr) {
            next unless is_valid_email($a);
            $addrs->{$a} = 1;
        }
    }

    keys %$addrs or return $app->error($app->translate(
        "No valid recipients found for the entry notification."));

    my $body = $app->build_email('notify-entry.tmpl', \%params);

    my $subj = $app->translate("[_1] Update: [_2]", $blog->name, $entry->title);
    if ($app->current_language ne 'ja') {  # FIXME perhaps move to MT::I18N
        $subj =~ s![\x80-\xFF]!!g;
    }
    my $address = defined $author->nickname
        ? $author->nickname .' <'. $author->email .'>'
        : $author->email;
    my %head = (
        To => $address,
        From => $address,
        Subject => $subj,
        'Content-Transfer-Encoding' => '8bit',
    );
    my $charset = $app->config('MailEncoding') ||
                  $app->config('PublishCharset');
    $head{'Content-Type'} = qq(text/plain; charset="$charset");
    my $i = 1;
    require MT::Mail;
    MT::Mail->send(\%head, $body)
        or return $app->error($app->translate(
            "Error sending mail ([_1]); try another MailTransfer setting?",
            MT::Mail->errstr));
    delete $head{To};
    foreach my $email (keys %{$addrs}) {
        next unless $email;
        if ($app->config('EmailNotificationBcc')) {
            push @{ $head{Bcc} }, $email;
            if ($i++ % 20 == 0) {
                MT::Mail->send(\%head, $body) or
                    return $app->error($app->translate(
                     "Error sending mail ([_1]); try another MailTransfer setting?",
                     MT::Mail->errstr));
                @{ $head{Bcc} } = ();
            }
        } else {
            $head{To} = $email;
            MT::Mail->send(\%head, $body) or
                  return $app->error($app->translate(
                   "Error sending mail ([_1]); try another MailTransfer setting?",
                   MT::Mail->errstr));
            delete $head{To};
        }
    }
    if ($head{Bcc} && @{ $head{Bcc} }) {
        MT::Mail->send(\%head, $body)
            or return $app->error($app->translate(
             "Error sending mail ([_1]); try another MailTransfer setting?",
             MT::Mail->errstr));
    }
    $app->redirect($app->uri('mode' => 'view', args => { '_type' => 'entry' , blog_id => $entry->blog_id, id => $entry->id, saved_notify => 1}));
}

sub start_upload {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    return $app->error($app->translate("Permission denied."))
        unless $perms->can_upload;
    my $blog_id = $app->param('blog_id');
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    $app->add_breadcrumb($app->translate('Upload File'));
    my %param;
    my $label_path;
    if ($param{enable_archive_paths}) {
        $label_path = $app->translate('Archive Root');
    } else {
        $label_path = $app->translate('Site Root');
    }
    $param{enable_archive_paths} = $blog->column('archive_path');
    $param{local_site_path} = $blog->site_path;
    $param{local_archive_path} = $blog->archive_path;
    my @extra_paths;
    my $date_stamp = epoch2ts($blog, time);
    $date_stamp =~ s!^(\d\d\d\d)(\d\d)(\d\d).*!$1/$2/$3!;
    push @extra_paths, { path => $date_stamp, label => '<' . $app->translate($label_path) . '>' . '/' . $date_stamp };
    $param{extra_paths} = \@extra_paths;
    $param{refocus} = 1;
    $param{missing_paths} = -d $blog->site_path || -d $blog->archive_path ? 0 : 1;
    $param{entry_insert} = $app->param('entry_insert');
    $param{edit_field} = $app->param('edit_field');
    $app->build_page('upload.tmpl', \%param);
}

sub upload_file {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    return $app->error($app->translate("Permission denied."))
        unless $perms->can_upload;
    $app->validate_magic() or return;

    my $q = $app->param;
    my($fh, $no_upload);
    if ($ENV{MOD_PERL}) {
        my $up = $q->upload('file');
        $no_upload = !$up || !$up->size;
        $fh = $up->fh if $up;
    } else {
        ## Older versions of CGI.pm didn't have an 'upload' method.
        eval { $fh = $q->upload('file') };
        if ($@ && $@ =~ /^Undefined subroutine/) {
            $fh = $q->param('file');
        }
        $no_upload = !$fh;
    }
    my $has_overwrite = $q->param('overwrite_yes') || $q->param('overwrite_no');
    return $app->error($app->translate("You did not choose a file to upload."))
        if $no_upload && !$has_overwrite;
    my $basename = $q->param('file') || $q->param('fname');
    $basename =~ s!\\!/!g;   ## Change backslashes to forward slashes
    $basename =~ s!^.*/!!;   ## Get rid of full directory paths
    if ($basename =~ m!\.\.|\0|\|!) {
        return $app->error($app->translate("Invalid filename '[_1]'", $basename));
    }
    my $blog_id = $q->param('blog_id');
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1});
    my $fmgr = $blog->file_mgr;

    ## Set up the full path to the local file; this path could start
    ## at either the Local Site Path or Local Archive Path, and could
    ## include an extra directory or two in the middle.
    my($root_path, $relative_path, $middle_path);
    if ($q->param('site_path')) {
        $root_path = $blog->site_path;
    } else {
        $root_path = $blog->archive_path;
    }
    return $app->error($app->translate(
        "Before you can upload a file, you need to configure the publishing paths for your weblog."
    )) unless $root_path;
    $relative_path = $q->param('extra_path');
    $middle_path = $q->param('middle_path') || '';
    my $relative_path_save = $relative_path;
    if ($middle_path ne '') {
        $relative_path = $middle_path . ($relative_path ? '/' . $relative_path : '');
    }
    my $path = $root_path;
    if ($relative_path) {
        if ($relative_path =~ m!\.\.|\0|\|!) {
            return $app->error($app->translate(
                "Invalid extra path '[_1]'", $relative_path));
        }
        $path = File::Spec->catdir($path, $relative_path);
        ## Untaint. We already checked for security holes in $relative_path.
        ($path) = $path =~ /(.+)/s;
        ## Build out the directory structure if it doesn't exist. DirUmask
        ## determines the permissions of the new directories.
        unless ($fmgr->exists($path)) {
            $fmgr->mkpath($path)
                or return $app->error($app->translate(
                    "Can't make path '[_1]': [_2]", $path, $fmgr->errstr));
        }
    }
    my $relative_url = File::Spec->catfile($relative_path, encode_url($basename));
    $relative_path = File::Spec->catfile($relative_path, $basename);
    my $local_file = File::Spec->catfile($path, $basename);

    ## Untaint. We have already tested $basename and $relative_path for security
    ## issues above, and we have to assume that we can trust the user's
    ## Local Archive Path setting. So we should be safe.
    ($local_file) = $local_file =~ /(.+)/s;

    ## If $local_file already exists, we try to write the upload to a
    ## tempfile, then ask for confirmation of the upload.
    if ($fmgr->exists($local_file)) {
        if ($has_overwrite) {
            my $tmp = $q->param('temp');
            if ($tmp =~ m!([^/]+)$!) {
                $tmp = $1;
            } else {
                return $app->error($app->translate(
                    "Invalid temp file name '[_1]'", $tmp));
            }
            my $tmp_dir = $app->config('TempDir');
            my $tmp_file = File::Spec->catfile($tmp_dir, $tmp);
            if ($q->param('overwrite_yes')) {
                $fh = gensym();
                open $fh, $tmp_file
                    or return $app->error($app->translate(
                        "Error opening '[_1]': [_2]", $tmp_file, "$!"));
            } else {
                if (-e $tmp_file) {
                    unlink($tmp_file)
                        or return $app->error($app->translate(
                            "Error deleting '[_1]': [_2]", $tmp_file, "$!"));
                }
                return $app->start_upload;
            }
        } else {
            eval { require File::Temp };
            if ($@) {
                return $app->error($app->translate(
                    "File with name '[_1]' already exists. (Install " .
                    "File::Temp if you'd like to be able to overwrite " .
                    "existing uploaded files.)", $basename));
            }
            my $tmp_dir = $app->config('TempDir');
            my($tmp_fh, $tmp_file);
            eval {
                ($tmp_fh, $tmp_file) =
                    File::Temp::tempfile(DIR => $tmp_dir);
            };
            if ($@) { #!$tmp_fh) {
                return $app->errtrans(
                    "Error creating temporary file; please check your TempDir ".
                    "setting in mt.cfg (currently '[_1]') " .
                    "this location should be writable.",
                    ($tmp_dir ? $tmp_dir : '['.$app->translate('unassigned').']'));
            }
            defined(_write_upload($fh, $tmp_fh))
                or return $app->error($app->translate(
                    "File with name '[_1]' already exists; Tried to write " .
                    "to tempfile, but open failed: [_2]", $basename, "$!"));
            my($vol, $path, $tmp) = File::Spec->splitpath($tmp_file);
            return $app->build_page('upload_confirm.tmpl', {
                temp => $tmp, extra_path => $relative_path_save,
                site_path => scalar $q->param('site_path'),
                middle_path => $middle_path,
                entry_insert => $q->param('entry_insert'),
                edit_field => $app->param('edit_field'),
                fname => $basename });
        }
    }

    ## File does not exist, or else we have confirmed that we can overwrite.
    my $umask = oct $app->config('UploadUmask');
    my $old = umask($umask);
    defined(my $bytes = $fmgr->put($fh, $local_file, 'upload'))
        or return $app->error($app->translate(
            "Error writing upload to '[_1]': [_2]", $local_file,
            $fmgr->errstr));
    umask($old);

    ## Use Image::Size to check if the uploaded file is an image, and if so,
    ## record additional image info (width, height). We first rewind the
    ## filehandle $fh, then pass it in to imgsize.
    seek $fh, 0, 0;
    eval { require Image::Size; };
    return $app->error($app->translate(
        "Perl module Image::Size is required to determine " .
        "width and height of uploaded images.")) if $@;
    my($w, $h, $id) = Image::Size::imgsize($fh);

    ## Close up the filehandle.
    close $fh;

    ## If we are overwriting the file, that means we still have a temp file
    ## lying around. Delete it.
    if ($q->param('overwrite_yes')) {
        my $tmp = $q->param('temp');
        if ($tmp =~ m!([^/]+)$!) {
            $tmp = $1;
        } else {
            return $app->error($app->translate(
                "Invalid temp file name '[_1]'", $tmp));
        }
        my $tmp_file = File::Spec->catfile($app->config('TempDir'), $tmp);
        unlink($tmp_file)
            or return $app->error($app->translate(
                "Error deleting '[_1]': [_2]", $tmp_file, "$!"));
    }

    ## We are going to use $relative_path as the filename and as the url passed
    ## in to the templates. So, we want to replace all of the '\' characters
    ## with '/' characters so that it won't look like backslashed characters.
    ## Also, get rid of a slash at the front, if present.
    $relative_path =~ s!\\!/!g;
    $relative_path =~ s!^/!!;
    $relative_url =~ s!\\!/!g;
    $relative_url =~ s!^/!!;
    my %param = ( width => $w, height => $h, bytes => $bytes,
                  image_type => $id, fname => $relative_path,
                  site_path => scalar $q->param('site_path') );
    my $url = $q->param('site_path') ? $blog->site_url : $blog->archive_url;
    $url .= '/' unless $url =~ m!/$!;
    $relative_url =~ s!^/!!;
    $url .= $relative_url;
    $param{url} = $url;
    require File::Basename;
    my $local_basename = File::Basename::basename($local_file);
    my $ext = (File::Basename::fileparse($local_file, qr/[A-Za-z]+$/))[2];

    # Does the file have dimensions with a recognized image extension?
    require MT::Asset::Image;
    if(defined($w) && defined($h) && MT::Asset::Image->can_handle($local_basename)) {
        $param{is_image} = 1
    }
    require MT::Asset;
    my $img_pkg = MT::Asset->class_handler($param{is_image} ? 'image' : 'file');
    my $asset = new $img_pkg;
    my $original = $asset->clone;
    $asset->blog_id($blog_id);
    $asset->url($url);
    $asset->file_path($local_file);
    $asset->file_name($local_basename);
    $asset->file_ext($ext);
    if ($param{is_image}) {
        $asset->image_width($w);
        $asset->image_height($h);
    }
    $asset->created_by($app->user->id);
    $asset->save;
    MT->run_callbacks('CMSPostSave.asset', $app, $asset, $original);

    $param{asset_id} = $asset->id;

    $param{edit_field} = $q->param('edit_field');

    if ($param{is_image}) {
        eval { require MT::Image; MT::Image->new or die; };
        $param{do_thumb} = $@ ? 0 : 1;
        $param{entry_insert} = $q->param('entry_insert');
        # Pass image default settings along.
        $param{image_defaults} = $blog->image_default_set() ? 1 : 0;
        $param{make_thumb} = $blog->image_default_thumb() ? 1 : 0;
        $param{wrap_text} = $blog->image_default_wrap_text() ? 1 : 0;
        $param{align_left} = $blog->image_default_align() eq 'left' ? 1 : 0;
        $param{align_center} = $blog->image_default_align() eq 'center' ? 1 : 0;
        $param{align_right} = $blog->image_default_align() eq 'right' ? 1 : 0;
        $param{thumb_width} = $blog->image_default_width() || $w;
        $param{unit_wpixels} = $blog->image_default_wunits() eq 'pixels' ? 1 : 0;
        $param{unit_wpercent} = $blog->image_default_wunits() eq 'percent' ? 1 : 0;
        $param{thumb_height} = $blog->image_default_height() || $h;
        $param{unit_hpixels} = $blog->image_default_hunits() eq 'pixels' ? 1 : 0;
        $param{unit_hpercent} = $blog->image_default_hunits() eq 'percent' ? 1 : 0;
        $param{constrain} = $blog->image_default_constrain() ? 1 : 0;
        $param{popup_image} = $blog->image_default_popup() ? 1 : 0;
        $param{can_save_image_defaults} = $perms->can_save_image_defaults() ? 1 : 0;
        MT->run_callbacks('CMSUploadFile',
                          File => $local_file, Url => $url, Size => $bytes,
                          Asset => $asset,
                          Type => 'image',
                          Blog => $blog);
        MT->run_callbacks('CMSUploadImage',
                          File => $local_file, Url => $url, Size => $bytes,
                          Asset => $asset,
                          Height => $h, Width => $w,
                          Type => 'image',
                          ImageType => $id,
                          Blog => $blog);
    } else {
        MT->run_callbacks('CMSUploadFile',
                          File => $local_file, Url => $url, Size => $bytes,
                          Asset => $asset,
                          Type => 'file',
                          Blog => $blog);
    }
    $app->build_page('upload_complete.tmpl', \%param);
}

sub _write_upload {
    my($upload_fh, $dest_fh) = @_;
    my $fh = gensym();
    if (ref($dest_fh) eq 'GLOB') {
        $fh = $dest_fh;
    } else {
        open $fh, ">$dest_fh" or return;
    }
    binmode $fh;
    binmode $upload_fh;
    my($bytes, $data) = (0);
    while (my $len = read $upload_fh, $data, 8192) {
        print $fh $data;
        $bytes += $len;
    }
    close $fh;
    $bytes;
}

sub search_replace {
    my $app = shift;
    my $res = $app->do_search_replace(@_);
    $app->add_breadcrumb($app->translate('Search & Replace'));
    $app->build_page('search_replace.tmpl', $res);
}

sub do_search_replace {
    my $app = shift;
    my $q = $app->param;
    my $blog_id = $q->param('blog_id');
    my $author = $app->user;
    my @perms;
    if (!$blog_id) {
        if (!$author->is_superuser()) {
            require MT::Permission;
            @perms = MT::Permission->load({author_id => $author->id});
        }
    } else {
        @perms = $app->{perms}
            or return $app->error($app->translate("No permissions"));
    }

    my $search_api = {
        'entry' => {
            'perm_check' => sub {
                grep { $_->can_edit_entry($_[0], $author) } @perms
            },
            'search_cols' => [ qw(title text text_more keywords excerpt basename) ],
            'replace_cols' => [ qw(title text text_more keywords excerpt) ],
            'can_replace' => 1,
            'can_search_by_date' => 1,
        },
        'ping' => {
            'perm_check' => sub { 
                my $ping = shift;
                my $tb = MT::Trackback->load($ping->tb_id, {cached_ok=>1});
                if ($tb->entry_id) {
                    require MT::Entry;
                    my $entry = MT::Entry->load($tb->entry_id, {cached_ok=>1});
                    return grep {
                            $_->can_edit_entry($entry, $author) 
                        } @perms;
                } elsif ($tb->category_id) {
                    return grep { $_->can_edit_categories } @perms;
                }
            },
            'search_cols' => [ qw(title excerpt source_url blog_name ip) ],
            'replace_cols' => [ qw(title excerpt) ],
            'can_replace' => 1,
            'can_search_by_date' => 1,
        },
        'comment' => {
            'perm_check' => sub {
                require MT::Entry;
                my $entry = MT::Entry->load($_[0]->entry_id, {cached_ok=>1});
                grep { $_->can_edit_entry($entry, $author) } @perms;
            },
            'search_cols' => [ qw(text url email ip author) ],
            'replace_cols' => [ qw(text) ],
            'can_replace' => 1,
            'can_search_by_date' => 1,
        },
        'template' => {
            'perm_check' => sub { 
                my ($obj) = @_;
                # are there any perms that match this object and 
                # allow template editing?
                my @check = grep { $_->blog_id == $obj->blog_id
                                          && $_->can_edit_templates } @perms;
                return @check;
                
            },
            'search_cols' => [ qw(name text linked_file outfile) ],
            'replace_cols' => [ qw(name text linked_file outfile) ],
            'can_replace' => 1,
            'can_search_by_date' => 0,
        },
        'commenter' => {
            'perm_check' => sub { 
                1;
            },
            'search_cols' => [ qw(nickname email url) ],
            'can_replace' => 0,
            'can_search_by_date' => 1,
        },
        'log' => {
            'perm_check' => sub {
                my ($obj) = @_;
                return 1 if $author->can_view_log;
                my $perm = $author->permissions($obj->blog_id);
                return $perm->can_view_blog_log;
            },
            'search_cols' => [ qw(ip message) ],
            'can_replace' => 0,
            'can_search_by_date' => 1,
        },
        'author' => {
            'perm_check' => sub { 
                return 1 if $author->is_superuser;
                if ($blog_id) {
                    my $perm = $author->permissions($blog_id);
                    return $perm->can_administer_blog;
                }
                return 0;
            },
            'search_cols' => [ qw(name nickname email url) ],
            'can_replace' => 0,
            'can_search_by_date' => 0,
        },
        'blog' => {
            'perm_check' => sub {
                return 1 if $author->is_superuser;
                my ($obj) = @_;
                my $perm = $author->permissions($obj->id);
                $perm && ($perm->can_administer_blog || $perm->can_edit_config);
            },
            'search_cols' => [ qw(name site_url site_path description) ],
            'replace_cols' => [ qw(name site_url site_path description) ],
            'can_replace' => $author->is_superuser(),
            'can_search_by_date' => 0,
        }
    };

    my($search, $replace, $do_replace, $case, $is_regex, $is_limited, $type, $is_junk, $is_dateranged, $ids, $datefrom_year, $datefrom_month, $datefrom_day, $dateto_year, $dateto_month, $dateto_day, $from, $to, $show_all, $do_search, $orig_search) =
        map scalar $q->param($_), qw( search replace do_replace case is_regex is_limited _type is_junk is_dateranged replace_ids datefrom_year datefrom_month datefrom_day dateto_year dateto_month dateto_day from to show_all do_search orig_search );
    $replace && ($app->validate_magic() or return);
    $search = $orig_search if $replace;  # for safety's sake

    $type ||= 'entry';
    if ($type eq 'commenter') {
        if (!$author->is_superuser && (!$app->{perms} || !$app->{perms}->can_edit_config())) {
            return $app->error($app->translate("No permissions"));
        }
    }
    my $list_pref = $app->list_pref($type);
    # force action bars to top and bottom
    $list_pref->{"bar"} = 'both';
    $list_pref->{"position_actions_both"} = 1;
    $list_pref->{"position_actions_top"} = 1;
    $list_pref->{"position_actions_bottom"} = 1;
    $list_pref->{"view"} = 'compact';
    $list_pref->{"view_compact"} = 1;
    my (@cols, $datefrom, $dateto);
    $do_replace = 0 unless $search_api->{$type}{can_replace};
    $is_dateranged = 0 unless $search_api->{$type}{can_search_by_date};
    my @ids;
    if ($ids) {
        @ids = split /,/, $ids;
    }
    if ($is_limited) {
        @cols = $q->param('search_cols');
        my %search_api_cols = map {$_=>1} @{$search_api->{$type}{search_cols}};
        if (@cols && ($cols[0] =~ /,/)) {
            @cols = split /,/, $cols[0];
            @cols = grep { $search_api_cols{$_} } @cols;
        }
    } else {
        @cols = @{$search_api->{$type}->{search_cols}};
    }
    foreach ($datefrom_year, $datefrom_month, $datefrom_day, $dateto_year, $dateto_month, $dateto_day) {
        s!\D!!g if $_; 
    }
    if ($is_dateranged) {
        $datefrom = sprintf("%04d%02d%02d", $datefrom_year, $datefrom_month, $datefrom_day);
        $dateto = sprintf("%04d%02d%02d", $dateto_year, $dateto_month, $dateto_day);
        if (($datefrom eq '00000000') && ($dateto eq '00000000')) {
            $is_dateranged = 0;
        } else {
            if (!is_valid_date($datefrom . '000000') || !is_valid_date($dateto . '000000')) {
                return $app->error($app->translate("Invalid date(s) specified for date range."));
            }
        }
    } elsif ($from && $to) {
        $is_dateranged = 1;
        s!\D!!g foreach ($from, $to);
        $datefrom = substr($from, 0, 8); $dateto = substr($to, 0, 8);
    }
    my $tab = $q->param('tab') || 'entry';
    ## Sometimes we need to pass in the search columns like 'title,text', so
    ## we look for a comma (not a valid character in a column name) and split
    ## on it if it's there.
    if (defined $search) {
        my $enc = MT::ConfigMgr->instance->PublishCharset;
        $search = MT::I18N::encode_text($search, 'utf-8', $enc) if ($enc !~ m/utf-?8/i) && ('dialog_grant_role' eq $app->param('__mode'));
        $search = quotemeta($search) unless $is_regex;
        $search = '(?i)' . $search unless $case;
    }
    my (@to_save, @data);
    my %param = %$list_pref;
    my $limit = $q->param('limit') || 125;     # FIXME: mt.cfg setting?
    my $matches;
    if (($do_search && defined $search) || $show_all || $do_replace) {
        my $api = $search_api->{$type};
        my $class = $app->_load_driver_for($type);
        my %terms;
        my %args;
        if ($type eq 'author') {
            $terms{'type'} = MT::Author::AUTHOR();
            if ('dialog_grant_role' eq $app->param('__mode')) {
                @cols = qw(name nickname email url);
            } elsif ($blog_id) {
                $args{'join'} = MT::Permission->join_on('author_id', { blog_id => $blog_id } );
            }
        } elsif ($type eq 'blog') {
        } elsif ($type eq 'commenter') {
            $terms{'type'} = MT::Author::COMMENTER();
            $args{'join'} = MT::Permission->join_on('author_id', { blog_id => $blog_id } );
        } else {
            %terms = $blog_id ? ( blog_id => $blog_id ) : ();
            if ($type ne 'template') {
                %args = ( 'sort' => 'created_on', direction => 'descend' );
            }
        }
        if (($type eq 'ping') || ($type eq 'comment'))  {
            if ($is_junk) {
                $terms{junk_status} = -1;
            } else {
                $terms{junk_status} = [ 0, 1 ];
            }
        }
        if ($is_dateranged) {
            $args{range_incl}{created_on} = 1;
            if ($datefrom gt $dateto) {
                $terms{created_on} = [ $dateto . '000000', $datefrom . '235959' ];
            } else {
                $terms{created_on} = [ $datefrom . '000000', $dateto . '235959' ];
            }
        }
        my $iter;
        if ($do_replace) {
            $iter = sub {
                if (my $id = pop @ids) {
                    $class->load($id);
                }
            };
        } elsif ($type eq 'blog') {
            $args{sort} = 'name';
            $args{direction} = 'ascend';
            $iter = $class->load_iter(\%terms, \%args) or die $class->errstr;
        } elsif ($type eq 'log') {
            $iter = $class->load_iter(\%terms, \%args) or die $class->errstr;
        } elsif ($blog_id) {
            $iter = $class->load_iter(\%terms, \%args) or die $class->errstr;
        } else {
            # Get an iter for each accessible blog
            my @streams;
            if (@perms) {
                @streams = map { { iter =>
                                   $class->load_iter({ blog_id => $_->blog_id,
                                                       %terms },
                                                       \%args) } } @perms;
            } elsif ($author->is_superuser) {
                @streams = ({iter =>
                                   $class->load_iter(\%terms, \%args) });
            }

            # Pull out the head of each iterator
            # Next: effectively mergesort the various iterators
            # To call the iterator n times takes time in O(bn)
            #   with 'b' the number of blogs
            # we expect to hit the iterator l/p times where 'p' is the 
            #   prob. of the search term appearing and 'l' is $limit
            $_->{head} = $_->{iter}->() foreach @streams;
            if ($type ne 'template') {
                $iter = sub { 
                    # find the head with greatest created_on
                    my $which = \$streams[0];
                    foreach my $iter (@streams) {
                        next if !exists $iter->{head} || !$which || !${$which}->{head} || !defined($iter->{head});
                        if ($iter->{head}->created_on > ${$which}->{head}->created_on) {
                            $which = \$iter;
                        }
                    }
                    # Advance the chosen one
                    my $result = ${$which}->{head};
                    ${$which}->{head} = ${$which}->{iter}->() if $result;
                    $result;
                };
            } else {
                $iter = sub { 
                    return undef unless @streams;
                    # find the head with greatest created_on
                    my $which = \$streams[0];
                    while (@streams && (!defined ${$which}->{head})) {
                        shift @streams;
                        last unless @streams;
                        $which = \$streams[0];
                    }
                    my $result = ${$which}->{head};
                    ${$which}->{head} = ${$which}->{iter}->() if $result;
                    $result;
                };
            }
        }
        my $i = 1;
        my %replace_cols;
        if ($do_replace) {
            %replace_cols = map { $_ => 1 } @{$api->{replace_cols}};
        }

        my $re = eval { qr/$search/ } if defined $search;
        if (my $err = $@) {
            return $app->error($app->translate("Error in search expression: [_1]",  $@));
        }
        while (my $obj = $iter->()) {
            next unless $author->is_superuser || $api->{perm_check}->($obj);
            my $match = 0;
            unless ($show_all) {
                for my $col (@cols) {
                    next if $do_replace && !$replace_cols{$col};
                    my $text = $obj->column($col);
                    $text = '' unless defined $text;
                    if ($do_replace) {
                        if ($text =~ s!$re!$replace!g) {
                            $match++;
                            $obj->$col($text);
                        }
                    } else {
                        $match = defined $search ? $text =~ m!$re! : 1;
                        last if $match;
                    }
                }
            }
            if ($match || $show_all) {
                push @to_save, $obj if $do_replace && !$show_all;
                push @data, $obj;
            }
            last if ($limit ne 'all') && @data > $limit;
        }
        if (@data) {
            $param{have_results} = 1;
            # We got one extra to see if there were more
            if (($limit ne 'all') && @data > $limit) {
                $param{have_more} = 1;
                pop @data;
            }
            $matches = @data;
        } else {
            $matches = 0;
        }
    }
    my $replace_count = 0;
    for my $obj (@to_save) {
        $replace_count++;
        $obj->save
            or return $app->error($app->translate(
                "Saving object failed: [_2]", $obj->errstr));
    }
    if (@data) {
        my $meth = 'build_' . $type . '_table';
        $app->$meth( items => \@data, param => \%param );
    }
    if ($is_dateranged) {
        ($datefrom_year, $datefrom_month, $datefrom_day) 
            = $datefrom =~ m/^(\d\d\d\d)(\d\d)(\d\d)/;
        ($dateto_year, $dateto_month, $dateto_day)
            = $dateto =~ m/^(\d\d\d\d)(\d\d)(\d\d)/;
    }
    my %res = (
        error => $q->param('error') || '',
        limit => $limit,
        limit_all => $limit eq 'all',
        count_matches => $matches, 
        replace_count => $replace_count,
        "search_$type" => 1,
        search_type => $type,
        search => $do_replace ? $q->param('orig_search') 
                  : scalar $q->param('search'),
        searched => ($do_replace ? $q->param('orig_search')
                    : ($do_search && scalar $q->param('search'))) || $show_all,
        replace => $replace,
        do_replace => $do_replace,
        case => $case,
        datefrom_year => $datefrom_year,
        datefrom_month => $datefrom_month,
        datefrom_day => $datefrom_day,
        dateto_year => $dateto_year,
        dateto_month => $dateto_month,
        dateto_day => $dateto_day,
        is_regex => $is_regex,
        is_limited => $is_limited,
        is_dateranged => $is_dateranged,
        is_junk => $is_junk,
        can_search_junk => ($type eq 'comment' || $type eq 'ping'),
        can_replace => $search_api->{$type}{can_replace},
        can_search_by_date => $search_api->{$type}{can_search_by_date},
        quick_search => 0,
        "tab_$tab" => 1,
        %param
    );
    $res{'tab_junk'} = 1 if $is_junk;
    $res{'search_cols_' . $_} = 1 foreach @cols;
    $res{nav_search} = 1;
    \%res;
}

sub export {
    my $app = shift;
    $app->{no_print_body} = 1;
    local $| = 1;
    my $charset = MT::ConfigMgr->instance->PublishCharset;
    require MT::Blog;
    my $blog_id = $app->param('blog_id')
        or return $app->error($app->translate("No blog ID"));
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1})
        or return $app->error($app->translate(
            "Load of blog '[_1]' failed: [_2]", $blog_id, MT::Blog->errstr));
    my $perms = $app->{perms};
    return $app->error($app->translate("You do not have export permissions"))
        unless $perms && $perms->can_edit_config;
    $app->validate_magic() or return;
    my $file = dirify($blog->name) . ".txt";

    if ($file eq ".txt") {
        my @ts = localtime(time);
        $file = sprintf "export-%06d-%04d%02d%02d%02d%02d%02d.txt", 
                        $app->param('blog_id'), $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];
    }

    $app->set_header("Content-Disposition" => "attachment; filename=$file");
    $app->send_http_header($charset ? "text/plain; charset=$charset" 
                                    : 'text/plain');
    require MT::ImportExport;
    MT::ImportExport->export($blog, sub { $app->print(@_) })
        or return $app->error(MT::ImportExport->errstr);
    1;
}

sub do_import {
    my $app = shift;

    my $q = $app->param;
    require MT::Blog;
    my $blog_id = $q->param('blog_id')
        or return $app->error($app->translate("No blog ID"));
    my $blog = MT::Blog->load($blog_id, {cached_ok=>1})
        or return $app->error($app->translate(
            "Load of blog '[_1]' failed: [_2]", $blog_id, MT::Blog->errstr));

    my $import_as_me = $q->param('import_as_me');

    ## Determine the user as whom we will import the entries.
    my $author = $app->user;
    my $author_id = $author->id;
    if (!$author->is_superuser) {
        my $perms = $author->permissions($blog_id);
        return $app->error($app->translate("You do not have import permissions"))
            unless $perms && ($perms->can_edit_config || $perms->can_administer_blog);
        if (!$import_as_me) {
            return $app->error($app->translate("You do not have permission to create users"))
                unless $perms->can_administer_blog;
        }
    }

    my($pass);
    if (!$import_as_me) {
        $pass = $q->param('password')
            or return $app->error($app->translate(
                "You need to provide a password if you are going to\n" .
                "create new authors for each author listed in your blog.\n"));
    }

    $app->validate_magic() or return;

    my($fh, $no_upload);
    if ($ENV{MOD_PERL}) {
        my $up = $q->upload('file');
        $no_upload = !$up || !$up->size;
        $fh = $up->fh if $up;
    } else {
        ## Older versions of CGI.pm didn't have an 'upload' method.
        eval { $fh = $q->upload('file') };
        if ($@ && $@ =~ /^Undefined subroutine/) {
            $fh = $q->param('file');
        }
        $no_upload = !$fh;
    }

    my $stream;
    my $encoding;
    if ($no_upload) {
        $stream = $app->config('ImportPath');
    } else {
        $stream = $fh;
        $encoding = $q->param('encoding');
    }

    $app->{no_print_body} = 1;

    local $| = 1;
    my $charset = MT::ConfigMgr->instance->PublishCharset;
    $app->send_http_header('text/html' .
        ($charset ? "; charset=$charset" : ''));

    my $param;
    $param = { import_as_me => $import_as_me, import_upload => !$no_upload };

    $app->print($app->build_page('import_start.tmpl', $param));

    require MT::Entry;
    require MT::Placement;
    require MT::Category;
    require MT::Permission;
    require MT::Comment;
    require MT::TBPing;

    require MT::ImportExport;
    my $import_result = MT::ImportExport->do_import(
        Blog => $blog,
        Stream => $stream,
        Callback => sub { $app->print(@_) },
        Encoding => $encoding,
        ($import_as_me) ? ( ImportAs => $author )
                        : ( ParentAuthor => $author ),
        NewAuthorPassword => $q->param('password'),
        DefaultCategoryID => $app->param('default_cat_id'),
        TitleStart => $app->param('title_start'),
        TitleEnd => $app->param('title_end'),
        DefaultStatus => $app->param('default_status'),
    );

    $param->{import_success} = $import_result;
    $param->{error} = MT::ImportExport->errstr unless $import_result;

    $app->print($app->build_page("import_end.tmpl", $param));

    if (!$no_upload) {
        close $fh;
    }
    1;
}

sub show_entry_prefs {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    my %param = ( %{ $app->load_entry_prefs($perms->entry_prefs) } );
    if ($param{disp_prefs_Default}) {
        $param{disp_prefs_Basic} = 0;
        $param{disp_prefs_All} = 0;
        $param{disp_prefs_Advanced} = 0;
        $param{disp_prefs_Custom} = 0;
    }
    $param{entry_id} = $app->param('entry_id');
    $app->add_breadcrumb($app->translate('Preferences'));
    $app->build_page('entry_prefs.tmpl', \%param);
}

sub save_entry_prefs {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    $app->validate_magic() or return;
    my $q = $app->param;
    my $prefs = $app->_entry_prefs_from_params;
    $perms->entry_prefs($prefs);
    $perms->save
        or return $app->error($app->translate(
            "Saving permissions failed: [_1]", $perms->errstr));
    my $url = $app->uri('mode' => 'view', args => { '_type' => 'entry' });
    if (my $id = $q->param('entry_id')) {
        $url .= '&id=' . $id;
    }
    $url .= '&blog_id=' . $perms->blog_id . '&saved_prefs=1';
    $app->build_page('reload_opener.tmpl', { url => $url });
}

sub _entry_prefs_from_params {
    my $app = shift;
    my $q = $app->param;
    my $type = $q->param('entry_prefs');
    my %fields;
    if ($type eq 'Custom') {
        $fields{$_} = 1 foreach $q->param('custom_prefs');
    } else {
        $fields{$type} = 1;
    }
    if (my $body_height = $q->param('text_height')) {
        $fields{'body'} = $body_height;
    }
    if (my $extended_height = $q->param('text_more_height')) {
        if ($fields{'extended'} || $fields{'Advanced'}) {
            $fields{'extended'} = $extended_height;
        }
    }
    my $prefs = '';
    foreach (keys %fields) {
        $prefs .= ',' if $prefs ne '';
        $prefs .= $_;
        $prefs .= ':' . $fields{$_} if $fields{$_} > 1;
    }
    $prefs .= '|' . $q->param('bar_position');
    $prefs;
}

sub pinged_urls {
    my $app = shift;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    my %param;
    my $entry_id = $app->param('entry_id');
    require MT::Entry;
    my $entry = MT::Entry->load($entry_id, {cached_ok=>1});
    $param{url_loop} = [ map { { url => $_ } } @{ $entry->pinged_url_list } ];
    $param{failed_url_loop} = [ map { { url => $_ } } @{ $entry->pinged_url_list(OnlyFailures => 1) } ];
    $app->build_page('pinged_urls.tmpl', \%param);
}

sub reg_file {
    my $app = shift;
    my $q = $app->param;
    my $uri = $app->base .
        $app->uri( 'mode' => 'reg_bm_js', 
                   args => { bm_show => $q->param('bm_show'),
                             bm_height => $q->param('bm_height')});
    $app->{no_print_body} = 1;
    $app->set_header('Content-Disposition' => 'attachment; filename=mt.reg');
    $app->send_http_header('text/plain; name=mt.reg');
    $app->print(
        qq(REGEDIT4\r\n) .
        qq([HKEY_CURRENT_USER\\Software\\Microsoft\\Internet Explorer\\MenuExt\\QuickPost]\r\n) .
        qq(@="$uri"\r\n) .
        qq("contexts"=hex:31));
    1;
}

sub reg_bm_js {
    my $app = shift;
    my $q = $app->param;
    my $js = $app->_bm_js(scalar $q->param('bm_show'),
                    scalar $q->param('bm_height'));
    $js =~ s!d=document!d=external.menuArguments.document!;
    $js =~ s!d\.location\.href!external.menuArguments.location.href!;
    $js =~ s!^javascript:!!;
    $js =~ s!\%20! !g;
    $app->{no_print_body} = 1;
    $app->send_http_header('text/plain');
    $app->print('<script language="javascript">' . $js . '</script>');
    1;
}

sub category_add {
    my $app = shift;
    my $q = $app->param;
    my $data = $app->_build_category_list(blog_id => scalar $q->param('blog_id'));
    my %param;
    $param{'category_loop'} = $data;
    $app->add_breadcrumb($app->translate('Add a Category'));
    $app->build_page('category_add.tmpl', \%param);
}

sub category_do_add {
    my $app = shift;
    my $q = $app->param;
    my $author = $app->user;
    $app->validate_magic() or return;
    require MT::Category;
    my $name = $q->param('label') or return $app->error($app->translate("No label"));
    $name =~ s/(^\s+|\s+$)//g;
    return $app->errtrans("Category name cannot be blank.")
        if $name eq '';
    my $parent = $q->param ('parent') || '0';
    my $cat = MT::Category->new;
    my $original = $cat->clone;
    $cat->blog_id(scalar $q->param('blog_id'));
    $cat->author_id($app->user->id);
    $cat->label($name);
    $cat->parent($parent);

    if (!$author->is_superuser) {
        MT->run_callbacks('CMSSavePermissionFilter.category', $app, undef)
            || return $app->error($app->translate("Permission denied.")
                                  . MT->errstr());
    }

    my $filter_result = MT->run_callbacks('CMSSaveFilter.category', $app);
    if (!$filter_result) {
        return $app->error(MT->errstr);
    }

    MT->run_callbacks('CMSPreSave.category', $app, $cat, $original)
        || return $app->error(MT->errstr);
    
    $cat->save or return $app->error($cat->errstr);

    # Now post-process it.
    MT->run_callbacks('CMSPostSave.category', $app, $cat, $original)
        or return $app->error(MT->errstr());

    my $id = $cat->id;
    $name = encode_js($name);
    my %param = (javascript => <<SCRIPT);
    o.doAddCategoryItem('$name', '$id');
SCRIPT
    $app->build_page('reload_opener.tmpl', \%param);
}

sub cc_return {
    my $app = shift;
    my $code = $app->param('license_code');
    my $url = $app->param('license_url');
    my $image = $app->param('license_button');
    my %param = (license_name => MT::Util::cc_name($code));
    if ($url) {
        $param{license_code} = "$code $url $image";
    } else {
        $param{license_code} = $code;
    }
    $app->build_page('cc_return.tmpl', \%param);
}

sub reset_blog_templates {
    my $app = shift;
    my $q = $app->param;
    my $perms = $app->{perms}
        or return $app->error($app->translate("No permissions"));
    return $app->error($app->translate("Permission denied."))
        unless $perms->can_edit_templates;
    $app->validate_magic() or return;
    my $blog = MT::Blog->load($perms->blog_id, {cached_ok=>1});
    require MT::Template;
    my @tmpl = MT::Template->load({ blog_id => $blog->id });
    for my $tmpl (@tmpl) {
        $tmpl->remove or return $app->error($tmpl->errstr);
    }
    my $tmpl_list;
    eval { $tmpl_list = require 'MT/default-templates.pl' };
    return $app->error($app->translate(
        "Can't find default template list; where is " .
        "'default-templates.pl'?")) if
        $@ || !$tmpl_list || ref($tmpl_list) ne 'ARRAY' ||!@$tmpl_list;
    my @arch_tmpl;
    for my $val (@$tmpl_list) {
        $val->{name} = $app->translate($val->{name});
        $val->{text} = $app->translate_templatized($val->{text});
        my $tmpl = MT::Template->new;
        $tmpl->set_values($val);
        $tmpl->build_dynamic(0);
        $tmpl->blog_id($blog->id);
        $tmpl->save or
            return $app->error($app->translate(
                "Populating blog with default templates failed: [_1]",
                $tmpl->errstr));
        if ($val->{type} eq 'archive' || $val->{type} eq 'category' ||
            $val->{type} eq 'individual') {
            push @arch_tmpl, $tmpl;
        }
    }

    ## Set up mappings from new templates to archive types.
    for my $tmpl (@arch_tmpl) {
        my(@at);
        if ($tmpl->type eq 'archive') {
            @at = qw( Daily Weekly Monthly );
        } elsif ($tmpl->type eq 'category') {
            @at = qw( Category );
        } elsif ($tmpl->type eq 'individual') {
            @at = qw( Individual );
        }
        require MT::TemplateMap;
        for my $at (@at) {
            my $map = MT::TemplateMap->new;
            $map->archive_type($at);
            $map->is_preferred(1);
            $map->template_id($tmpl->id);
            $map->blog_id($tmpl->blog_id);
            $map->save
                or return $app->error($app->translate(
                    "Setting up mappings failed: [_1]", $map->errstr));
        }
    }
    $app->redirect($app->uri( 'mode' => 'list', args => { '_type' => 'template', blog_id => $blog->id, 'reset' => 1}));
}

sub update_dynamicity {
    my $app = shift;
    my ($blog, $cache, $conditional) = @_;
    my $dcty = $blog->custom_dynamic_templates;
    if ($dcty eq 'none') {
        require MT::Template;
        my @templates = MT::Template->load({ blog_id => $blog->id });
        for my $tmpl (@templates) {
            $tmpl->build_dynamic(0);
            $tmpl->save();
        }
    } elsif ($dcty eq 'archives') {
        require MT::Template;
        my @templates = MT::Template->load({ blog_id => $blog->id });
        for my $tmpl (@templates) {
            $tmpl->build_dynamic($tmpl->type ne 'index' || 0);
            $tmpl->save();
        }
    } elsif ($dcty eq 'custom') {
    } elsif ($dcty eq 'all') {
        require MT::Template;
        my @templates = MT::Template->load({
            blog_id => $blog->id,
            type => [ 'index', 'archive', 'individual', 'category' ],
        });
        for my $tmpl (@templates) {
            $tmpl->build_dynamic(1);
            $tmpl->save();
        }
    }

    if ($dcty ne 'none') {
        eval {
            my $htaccess_path = File::Spec->catfile($blog->site_path(),
                                                    ".htaccess");
            require URI;
            my $mtview_server_url = new URI($blog->site_url());
            $mtview_server_url = $mtview_server_url->path();
            $mtview_server_url .= ($mtview_server_url =~ m|/$| ? "" : "/")
                . "mtview.php";
            
            my $mtview_path = File::Spec->catfile($blog->site_path(), "mtview.php");
            my $contents = "";
            if (open(HT, $htaccess_path)) {
                local $/ = undef;
                $contents = <HT>;
                close HT;
            }
            if ($contents !~ /^\s*Rewrite(Cond|Engine|Rule)\b/m) {
                my $htaccess = <<HTACCESS;

## %%%%%%% Movable Type generated this part; don't remove this line! %%%%%%%
# Disable fancy indexes, so mtview.php gets a chance...
Options -Indexes +SymLinksIfOwnerMatch
  <IfModule mod_rewrite.c>
  # The mod_rewrite solution is the preferred way to invoke
  # dynamic pages, because of its flexibility.

  # Add mtview.php to the list of DirectoryIndex options, listing it last,
  # so it is invoked only if the common choices aren't present...
  <IfModule mod_dir.c>
    DirectoryIndex index.php index.html index.htm default.htm default.html default.asp $mtview_server_url
  </IfModule>

  RewriteEngine on

  # don't serve mtview.php if the request is for a real directory
  # (allows the DirectoryIndex lookup to function)
  RewriteCond %{REQUEST_FILENAME} !-d

  # don't serve mtview.php if the request is for a real file
  # (allows the actual file to be served)
  RewriteCond %{REQUEST_FILENAME} !-f
  # anything else is handed to mtview.php for resolution
  RewriteRule ^(.*)\$ $mtview_server_url [L,QSA]
</IfModule>

<IfModule !mod_rewrite.c>
  # if mod_rewrite is unavailable, we forward any missing page
  # or unresolved directory index requests to mtview
  # if mtview.php can resolve the request, it returns a 200
  # result code which prevents any 4xx error code from going
  # to the server's access logs. However, an error will be
  # reported in the error log file. If this is your only choice,
  # and you want to suppress these messages, adding a "LogLevel crit"
  # directive within your VirtualHost or root configuration for
  # Apache will turn them off.
  ErrorDocument 404 $mtview_server_url
  ErrorDocument 403 $mtview_server_url
</IfModule>
## ******* Movable Type generated this part; don't remove this line! *******

HTACCESS

                $blog->file_mgr->mkpath($blog->site_path);

                open(HT, ">>$htaccess_path")
                    || die "Couldn't open $htaccess_path for appending";
                print HT $htaccess || die "Couldn't write to $htaccess_path";
                close HT;
            }
        }; if ($@) { print STDERR $@; } 
        
        eval {
            my $mtview_path = File::Spec->catfile($blog->site_path(), "mtview.php");
            my $mv_contents = '';
            if (-f $mtview_path) {
                open(my $mv, "<$mtview_path");
                while (my $line = <$mv>) {
                    $mv_contents .= $line if ($line !~ m!^//|<\?(?:php)?|\?>!);
                }
                close $mv;
            }
            my $cgi_path = MT->instance->server_path() || "";
            $cgi_path =~ s!/*$!!;
            my $mtphp_path = File::Spec->canonpath("$cgi_path/php/mt.php");
            my $blog_id = $blog->id;
            my $config = MT->instance->{cfg_file};
            my $cache_code = $cache ? "\n    \$mt->caching = true;" : '';
            my $conditional_code = $conditional ? "\n    \$mt->conditional = true;" : '';
            my $new_mtview = <<NEW_MTVIEW;

    include('$mtphp_path');
    \$mt = new MT($blog_id, '$config');$cache_code$conditional_code
    \$mt->view();
NEW_MTVIEW
            if ($new_mtview ne substr($mv_contents, 0, length($new_mtview))) {
                $mv_contents =~ s!\n!\n//!gs;
                my $mtview = <<MTVIEW;
<?php
$new_mtview
$mv_contents
?>
MTVIEW

                $blog->file_mgr->mkpath($blog->site_path);
                open(my $mv, ">$mtview_path")
                    || die "Couldn't open $mtview_path for appending";
                print $mv $mtview || die "Couldn't write to $mtview_path";
                close $mv;
            }
        }; if ($@) { print STDERR $@; } 

        my $compiled_template_path = File::Spec->catfile($blog->site_path(), 
                                                         'templates_c');
        my $fmgr = $blog->file_mgr;
        my $saved_umask = $app->config('DirUmask');
        $app->config('DirUmask', '0000');
        $fmgr->mkpath($compiled_template_path);
        $app->config('DirUmask', $saved_umask);
        if (-d $compiled_template_path) {
            $app->add_return_arg('no_writecache' => 1)
                unless (-w $compiled_template_path);
        } else {
            $app->add_return_arg('no_cachedir' => 1)
                unless (-d $compiled_template_path);
        }
            # FIXME: use FileMgr

        if ($cache) {
            my $cache_path = File::Spec->catfile($blog->site_path(), 'cache');
            $app->config('DirUmask', '0000');
            $fmgr->mkpath($cache_path);
            $app->config('DirUmask', $saved_umask);
            if (-d $cache_path) {
                $app->add_return_arg('no_write_cachepath' => 1)
                    unless (-w $cache_path);
            } else {
                $app->add_return_arg('no_cachepath' => 1)
                    unless (-d $cache_path);
            }
        }
    }
    $app->add_return_arg(dynamic_set => 1);
}

sub handshake {
    my $app = shift;
    my $blog_id = $app->param('blog_id');
    my $remote_auth_token = $app->param('remote_auth_token');
    
    my %param = ();
    $param{remote_auth_token} = $remote_auth_token;
    $app->build_page('handshake_return.tmpl', \%param);
}

sub itemset_action {
    my $app = shift;
    $app->validate_magic or return;
    # plugin_action_selector should always (?) be in the query; use it?
    my $action_name = $app->param('action_name');
    my $type = $app->param('_type');
    my ($the_action) = (grep {$_->{key} eq $action_name}
                             @{$app->{CoreItemsetActions}{$type}},
                        grep {$_->{key} eq $action_name}
                             @{$app->{PluginItemsetActions}{$type}});
    return $app->errtrans("That action ([_1]) is apparently not implemented!",
                          $action_name)
        unless $the_action;

    $the_action->{code}->($app);
}

sub rebuild_new_phase {
    my ($app) = @_;
    my %reb_set = map { $_ => 1 } $app->param('id');
    $app->rebuild_these(\%reb_set, how => NEW_PHASE);
}

# rebuild_set is a hash whose keys are entry IDs
# the value can be the entry itself, for efficiency,
# but if the value is not a ref, the entry is loaded from the ID.
# This is not a handler but a utility routine
sub rebuild_these {
    my ($app, $rebuild_set, %options) = @_;

    # if there's nothing to rebuild, just return
    if (!keys %$rebuild_set) {
        return $app->call_return;
    }

    if ($options{how} eq NEW_PHASE) {
        my $params = {
            return_args => $app->return_args,
            id => [ keys %$rebuild_set ]
        };
        my %param = (is_full_screen => 1,
                     redirect_target => $app->uri( mode => 'rebuild_phase',
                                                   args => $params));
        return $app->build_page('rebuilding.tmpl', \%param);

    } else {
        require MT::Entry;
        for my $id (keys %$rebuild_set) {
            my $e = ref $rebuild_set->{$id} ?
                $rebuild_set->{$id} : MT::Entry->load($id, {cached_ok=>1});
            $app->rebuild_entry(Entry => $e, BuildDependencies => 1);
        }
    }
}

sub empty_junk {
    my $app = shift;
    my $perms = $app->{perms};
    my $user = $app->user;
    my $blog_id = $app->param('blog_id');
    return $app->errtrans("Permission denied.")
        if (!$blog_id && !$user->is_superuser()) ||
            ($perms && !($perms->can_administer_blog || $perms->can_edit_all_posts));

    my $type = $app->param('_type');
    my $class = $app->_load_driver_for($type);
    my $arg = {};
    $arg->{junk_status} = -1;
    $arg->{blog_id} = $blog_id if $blog_id;
    $class->remove($arg);
    $app->add_return_arg('emptied' => 1);
    $app->call_return;
}

sub handle_junk {
    my $app = shift;
    my @ids = $app->param("id");
    my $type = $app->param("_type");
    my $class = $app->_load_driver_for($type);
    my @item_loop;
    my $i = 0;
    my $blog_id = $app->param('blog_id');
    my (%rebuild_entries, %rebuild_categories);
    foreach my $id (@ids) {
        next unless $id;
        # TODO: Check permissions
        my $obj = $class->load($id, {cached_ok=>1}) or die "No $class $id";
        my $old_visible = $obj->visible || 0;
        $obj->junk;
        MT->run_callbacks('HandleJunk', $app, $obj); # mv this into blk below?
        $obj->save;     # (so that each cb doesn't have to save indiv'ly)
        next if $old_visible == $obj->visible;
        if ($obj->isa('MT::TBPing')) {
            my ($parent_type, $parent_id) = $obj->parent_id();
            if ($parent_type eq 'MT::Entry') {
                $rebuild_entries{$parent_id} = 1;
            } else {
                $rebuild_categories{$obj->category_id} = 1;
                # TODO: do something with this list.
            }
        } else {
            $rebuild_entries{$obj->entry_id} = 1;
        }
    }
    $app->add_return_arg('junked' => 1);
    if (%rebuild_entries) {
        $app->rebuild_these(\%rebuild_entries, how => NEW_PHASE);
    } else {
        $app->call_return;
    }
}

sub not_junk {
    my $app = shift;
    my @ids = $app->param("id");
    my @item_loop;
    my $i = 0;
    my $type = $app->param('_type');
    my $class = $app->_load_driver_for($type);
    my %rebuild_set;
    foreach my $id (@ids) {
        next unless $id;
        my $obj = $class->load($id, {cached_ok=>1});
        $obj->approve;
        MT->run_callbacks('HandleNotJunk', $app, $obj);
        if ($obj->isa('MT::TBPing')) {
            my ($parent_type, $parent_id) = $obj->parent_id();
            if ($parent_type eq 'MT::Entry') {
                $rebuild_set{$parent_id} = 1;
            } else {
            }
        } else {
            $rebuild_set{$obj->entry_id} = 1;
        }
        $obj->save();
    }
    $app->param('approve', 1);

    $app->add_return_arg('unjunked' => 1);

    $app->rebuild_these(\%rebuild_set, how => NEW_PHASE);
}

sub _cb_notjunktest_filter {
    my ($eh, $app, $obj) = @_;
    require MT::JunkFilter;
    MT::JunkFilter->filter($obj);
    $obj->is_junk ? 0 : 1;
}

sub add_itemset_action {
    my $app = shift;
    my ($itemset_action, $is_core) = @_;
    my $type = $itemset_action->{type};
    Carp::croak 'itemset actions require a string called "key"' 
        unless ($itemset_action->{key}
                && !(ref($itemset_action->{key})));
    Carp::croak 'itemset actions require a coderef called "code"'
        unless ($itemset_action->{code} && 
                (ref $itemset_action->{code} eq 'CODE'));
    Carp::croak 'itemset actions require a string called "label"'
        unless ($itemset_action->{label} && 
                !(ref $itemset_action->{label}));

    my $coreness = $is_core ?
        'CoreItemsetActions' : 'PluginItemsetActions';
    $itemset_action->{orig_label} = $itemset_action->{label};
    $itemset_action->{plugin} = $MT::plugin_sig if $MT::plugin_sig && !$is_core;
    push @{$app->{$coreness}{$type}}, $itemset_action;
}

sub update_list_prefs {
    my $app = shift;
    my $prefs = $app->list_pref($app->param('_type'));
    $app->call_return;
}

sub add_tags_to_entries {
    my $app = shift;

    my @id = $app->param('id');

    require MT::Tag;
    my $tags = $app->param('itemset_action_input');
    my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
    my @tags = MT::Tag->split($tag_delim, $tags);
    return $app->call_return unless @tags;

    require MT::Entry;

    my $user = $app->user;
    foreach my $id (@id) {
        next unless $id;
        my $entry = MT::Entry->load($id) or next;
        next unless $user->is_superuser ||
            $app->{perms}->can_edit_entry($entry, $user);

        $entry->add_tags(@tags);
        $entry->save or return $app->trans_error("Error saving entry: [_1]", $entry->errstr);
    }

    $app->add_return_arg('saved' => 1);
    $app->call_return;
}

sub remove_tags_from_entries {
    my $app = shift;

    my @id = $app->param('id');

    require MT::Tag;
    my $tags = $app->param('itemset_action_input');
    my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
    my @tags = MT::Tag->split($tag_delim, $tags);
    return $app->call_return unless @tags;

    require MT::Entry;

    my $user = $app->user;
    foreach my $id (@id) {
        next unless $id;
        my $entry = MT::Entry->load($id) or next;
        next unless $user->is_superuser ||
            $app->{perms}->can_edit_entry($entry, $user);
        $entry->remove_tags(@tags);
        $entry->save or return $app->trans_error("Error saving entry: [_1]", $entry->errstr);
    }

    $app->add_return_arg('saved' => 1);
    $app->call_return;
}

sub add_tags_to_assets {
    my $app = shift;

    my @id = $app->param('id');

    require MT::Tag;
    my $tags = $app->param('itemset_action_input');
    my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
    my @tags = MT::Tag->split($tag_delim, $tags);
    return $app->call_return unless @tags;

    require MT::Asset;

    my $user = $app->user;
    foreach my $id (@id) {
        next unless $id;
        my $asset = MT::Asset->load($id) or next;
        next unless $user->is_superuser; # ||
            #$app->{perms}->can_edit_entry($entry, $user);

        $asset->add_tags(@tags);
        $asset->save or return $app->trans_error("Error saving asset: [_1]", $asset->errstr);
    }

    $app->add_return_arg('saved' => 1);
    $app->call_return;
}

sub remove_tags_from_assets {
    my $app = shift;

    my @id = $app->param('id');

    require MT::Tag;
    my $tags = $app->param('itemset_action_input');
    my $tag_delim = chr($app->user->entry_prefs->{tag_delim});
    my @tags = MT::Tag->split($tag_delim, $tags);
    return $app->call_return unless @tags;

    require MT::Asset;

    my $user = $app->user;
    foreach my $id (@id) {
        next unless $id;
        my $asset = MT::Asset->load($id) or next;
        next unless $user->is_superuser; # ||
            # $app->{perms}->can_edit_entry($entry, $user);
        $asset->remove_tags(@tags);
        $asset->save or return $app->trans_error("Error saving asset: [_1]", $asset->errstr);
    }

    $app->add_return_arg('saved' => 1);
    $app->call_return;
}

# This mode can be called to service a number of views
# Adding roles->blogs for a user
# Adding users->roles->blogs
sub dialog_grant_role {
    my $app = shift;

    my $author_id = $app->param('author_id');
    my $blog_id = $app->param('blog_id');
    my $role_id = $app->param('role_id');

    my $this_user = $app->user;
    if (!$this_user->is_superuser) {
        if (!$blog_id || !$this_user->permissions($blog_id)->can_administer_blog) {
            return $app->errtrans("Permission denied.")
        }
    }

    my $type = $app->param('_type');
    my ($grp, $user, $role);
    if ($author_id) {
        $user = MT::Author->load($author_id, { cached_ok => 1 });
    }
    if ($role_id) {
        require MT::Role;
        $role = MT::Role->load($role_id, { cached_ok => 1 });
    }

    my $hasher = sub {
        my ($obj, $row) = @_;
        $row->{label} = $row->{name};
        $row->{description} = $row->{nickname} if exists $row->{nickname};
    };

    # Only show active users who are not commenters.
    my $terms = {};
    if ($type eq 'author') {
        $terms->{status} = MT::Author::ACTIVE();
        $terms->{type} = MT::Author::AUTHOR();
    }

    if ($app->param('search') || $app->param('json')) {
        $app->listing({
            Term => $terms,
            Type => $type,
            Code => $hasher,
            Params => {
                panel_type => $type,
                list_noncron => 1,
                panel_multi => 1,
            },
            Template => 'listing_panel.tmpl',
        });
    } else {
        # traditional, full-screen listing
        my $params = {
            $author_id ? (
                edit_author_name => $user->name,
                edit_author_id => $user->id,
            ) : (),
            $role_id ? (
                role_name => $role->name,
                role_id => $role->id,
            ) : (),
        };

        my @panels;
        if (!$role_id) {
            push @panels, 'role';
        }
        if (!$blog_id) {
            push @panels, 'blog';
        }
        if (!$author_id) {
            if ($type eq 'user') {
                unshift @panels, 'author';
            }
        }

        my $panel_info = {
            'blog' => {
                panel_title => $app->translate("Select Weblogs"),
                panel_label => $app->translate("Weblog Name"),
                items_prompt => $app->translate("Weblogs Selected"),
                search_prompt => $app->translate("Type a weblog name to filter the choices below."),
                panel_description => $app->translate("Description"),
            },
            'author' => {
                panel_title => $app->translate("Select Users"),
                panel_label => $app->translate("Username"),
                items_prompt => $app->translate("Users Selected"),
                search_prompt => $app->translate("Type a username to filter the choices below."),
                panel_description => $app->translate("Name"),
            },
            'role' => {
                panel_title => $app->translate("Select Roles"),
                panel_label => $app->translate("Role Name"),
                items_prompt => $app->translate("Roles Selected"),
                search_prompt => $app->translate(""),
                panel_description => $app->translate("Description"),
            },
        };

        $params->{blog_id} = $blog_id;
        $params->{dialog_title} = $app->translate("Create an Association");
        $params->{panel_loop} = [];
        $params->{panel_multi} = 1;

        for (my $i = 0; $i <= $#panels; $i++) {
            my $source = $panels[$i];
            my $panel_params = {
                panel_type => $source,
                %{$panel_info->{$source}},
                list_noncron => 1,
                panel_last => $i == $#panels,
                panel_first => $i == 0,
                panel_number => $i + 1,
                panel_total => $#panels + 1,
                panel_has_steps => ($#panels == '0' ? 0 : 1), 
                panel_searchable => ($source eq 'role' ? 0 : 1),
            };

            # Only show active users who are not commenters.
            my $terms = {};
            if ($source eq 'author') {
                $terms->{status} = MT::Author::ACTIVE();
                $terms->{type} = MT::Author::AUTHOR();
            }

            $app->listing({
                NoHTML => 1,
                Code => $hasher,
                Type => $source,
                Params => $panel_params,
                Terms => $terms,
                Args => { sort => 'name' },
            });
            if (!$panel_params->{object_loop} ||
                ($panel_params->{object_loop} && @{$panel_params->{object_loop}} < 1)
            ) {
                $params->{"missing_$source"} = 1;
                $params->{"missing_data"} = 1;
            }
            push @{$params->{panel_loop}}, $panel_params;
        }
        # save the arguments from whence we came...
        $params->{return_args} = $app->return_args;
        $app->build_page('dialog_grant_role.tmpl', $params);
    }
}

sub grant_role {
    my $app = shift;

    my $user = $app->user;

    my $blogs = $app->param('blog') || '';
    my $authors = $app->param('author') || '';
    my $roles = $app->param('role') || '';
    my $author_id = $app->param('author_id');
    my $blog_id = $app->param('blog_id');
    my $role_id = $app->param('role_id');

    my @blogs = split /,/, $blogs;
    my @authors = split /,/, $authors;
    my @roles = split /,/, $roles;

    require MT::Blog;
    require MT::Role;

    foreach (@blogs) {
        my $id = $_;
        $id =~ s/\D//g;
        $_ = MT::Blog->load($id, { cached_ok => 1 });
    }
    foreach (@roles) {
        my $id = $_;
        $id =~ s/\D//g;
        $_ = MT::Role->load($id, { cached_ok => 1 });
    }
    foreach (@authors) {
        my $id = $_;
        $id =~ s/\D//g;
        $_ = MT::Author->load($id, { cached_ok => 1 });
    }

    if ($author_id) {
        push @authors, MT::Author->load($author_id, { cached_ok => 1 });
    }
    if ($blog_id) {
        push @blogs, MT::Blog->load($blog_id, { cached_ok => 1 });
    }
    if ($role_id) {
        push @roles, MT::Role->load($role_id, { cached_ok => 1 });
    }

    if (!$user->is_superuser) {
        if ((scalar @blogs != 1)
            || (!$user->permissions($blogs[0])->can_administer_blog)) {
            return $app->errtrans("Permission denied.");
        }
    }

    require MT::Association;

    # TBD: handle case for associating system roles to users
    foreach my $blog (@blogs) {
        next unless ref $blog;
        foreach my $u (@authors) {
            next unless ref $u;
            foreach my $role (@roles) {
                next unless ref $role;
                MT::Association->link($u => $role => $blog);
            }
        }
    }

    $app->add_return_arg(saved => 1);
    $app->call_return;
}

sub backup_restore {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;

    my %param = ();
    $app->add_breadcrumb($app->translate('Backup & Restore'));
    $param{system_overview_nav} = 1;
    $param{nav_backup} = 1;
    my $missing_tgz = 0;
    eval "require Archive::Tar;";
    $missing_tgz = 1 if $@;
    eval "require IO::Compress::Gzip;";
    $missing_tgz = 1 if $@;
    $param{targz} = !$missing_tgz;
    my $missing_zip = 0;
    eval "require Archive::Zip;";
    $missing_zip = 1 if $@;
    $param{zip} = !$missing_zip;

    eval "require XML::XPath";
    $param{missing_xpath} = 1 if $@;

    my $limit = $app->config('CGIMaxUpload') || 2048;
    $param{over_300} = 1 if $limit >= 300 * 1024;
    $param{over_500} = 1 if $limit >= 500 * 1024;
    $param{over_1024} = 1 if $limit >= 1024 * 1024;
    $param{over_2048} = 1 if $limit >= 2048 * 1024;
    $app->build_page('backup_restore.tmpl', \%param);
}

sub _backup_finisher {
    my $app = shift;
    my ($fname, $param) = @_;
    $param->{filename} = $fname;
    $param->{backup_success} = 1;
    require MT::Session;
    my $sess = MT::Session->new;
    $sess->id($app->make_magic_token());
    $sess->kind('BU'); # BU == Backup
    $sess->name($fname);
    $sess->start(time);
    $sess->save;
    $app->print($app->build_page('backup_end.tmpl', $param));
}

sub backup {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;
    $app->validate_magic() or return;
    
    my $q = $app->param;

    my $what = $q->param('backup_what');
    return $app->errtrans("You must select what you want to backup.") if !$what;

    my $size = $q->param('size_limit') || 0;
    return $app->errtrans('[_1] is not a number.', $size)
        if $size !~ /^\d+$/;

    my $blog_ids = $q->param('selected_blog_ids') if $what eq 'custom';
    return $app->errtrans('Choose weblogs to backup.') if $what eq 'custom' && (!defined($blog_ids) || !$blog_ids);

    my @blog_ids = split ',', $blog_ids;

    my $archive = $q->param('backup_archive_format');
    my $enc = $app->config('PublishCharset') || 'utf-8';
    my @ts = gmtime(time);
    my $ts = sprintf "%04d-%02d-%02d-%02d-%02d-%02d",
        $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];
    my $file = "Movable_Type-$ts" . '-Backup';

    if ('1' eq $archive) {
        eval "require Archive::Tar;";
        return $app->errtrans('Archive::Tar is required to archive in tar.gz format.') if $@;
        eval "require IO::Compress::Gzip;";
        return $app->errtrans('IO::Compress::Gzip is required to archive in tar.gz format.') if $@;
    } elsif ('2' eq $archive) {
        eval "require Archive::Zip;";
        return $app->errtrans('Archive::Zip is required to archive in zip format.') if $@;
    }

    my $param = {};
    $app->{no_print_body} = 1;
    $app->add_breadcrumb($app->translate('Backup & Restore'), $app->uri(mode => 'backup_restore'));
    $app->add_breadcrumb($app->translate('Backup'));
    $param->{system_overview_nav} = 1;
    $param->{nav_backup} = 1;

    local $| = 1;
    my $charset = MT::ConfigMgr->instance->PublishCharset;
    $app->send_http_header('text/html' .
        ($charset ? "; charset=$charset" : ''));
    $app->print($app->build_page('backup_start.tmpl', $param));
    require File::Temp;
    require File::Spec;
    my $temp_dir = $app->config('TempDir');

    require MT::BackupRestore;
    require MT::Asset;
    my $num_assets = MT::Asset->count();
    my $printer;
    my $splitter;
    my $finisher;
    my $fh;
    my $fname;
    my $arc_buf;
    if (!($size || $num_assets)) {
        $splitter = sub {};

        if ('0' eq $archive) {
            ($fh, my $filepath) = File::Temp::tempfile('xml.XXXXXXXX', DIR => $temp_dir);
            (my $vol, my $dir, $fname) = File::Spec->splitpath($filepath);
            $printer = sub { my ($data, $message) = @_; print $fh $data; $app->print($message); return length($data); };
            $finisher = sub { 
                my ($asset_files) = @_;
                close $fh;
                $app->_backup_finisher($fname, $param);
            };
        } elsif ('1' eq $archive) { # tar.gz
            require Archive::Tar;
            $printer = sub { my ($data, $message) = @_; $arc_buf .= $data; $app->print($message); return length($data); };
            $finisher = sub {
                my ($asset_files) = @_;
                ($fh, my $filepath) = File::Temp::tempfile('tar.XXXXXXXX', DIR => $temp_dir);
                (my $vol, my $dir, $fname) = File::Spec->splitpath($filepath);
                my $arc = Archive::Tar->new;
                $arc->add_data("$file.xml", $arc_buf);
                $arc->add_data(
                    "$file.manifest",
                    "<manifest xmlns='" . MT::BackupRestore::NS_MOVABLETYPE() . "'><file type='backup' name='$file.xml' /></manifest>"); 
                require IO::Compress::Gzip;
                my $z = IO::Compress::Gzip->new($fh);
                $arc->write($z);
                $z->close;
                $app->_backup_finisher($fname, $param);
            }
        } elsif ('2' eq $archive) { # zip
            require Archive::Zip;
            $printer = sub { my ($data, $message) = @_; $arc_buf .= $data; $app->print($message); };
            $finisher = sub {
                my ($asset_files) = @_;
                ($fh, my $filepath) = File::Temp::tempfile('zip.XXXXXXXX', DIR => $temp_dir);
                (my $vol, my $dir, $fname) = File::Spec->splitpath($filepath);
                my $arc = Archive::Zip->new;
                $arc->addString($arc_buf, "$file.xml");
                $arc->addString(
                    "<manifest xmlns='" . MT::BackupRestore::NS_MOVABLETYPE() . "'><file type='backup' name='$file.xml' /></manifest>", 
                    "$file.manifest");
                $arc->writeToFileHandle($fh);
                close $fh;
                $app->_backup_finisher($fname, $param);
            };
        }
    } else {
        my $temp_dir = $app->config('TempDir');
        my @files;
        my $filename = File::Spec->catfile($temp_dir, $file . "-1.xml");
        $fh = gensym();
        open $fh, ">$filename";
        push @files, { 
            url => $app->uri . "?__mode=backup_download&name=$file-1.xml&magic_token=" . $app->current_magic,
            filename => $file . "-1.xml"
        };
        $printer = sub { my ($data, $message) = @_; print $fh $data; $app->print($message); return length($data); };
        $splitter = sub {
            my ($findex) = @_;
            print $fh '</movabletype>';
            close $fh;
            my $filename = File::Spec->catfile($temp_dir, $file . "-$findex.xml");
            $fh = gensym();
            open $fh, ">$filename";
            push @files, {
                url => $app->uri . "?__mode=backup_download&name=$file-$findex.xml&magic_token=" . $app->current_magic,
                filename => $file . "-$findex.xml"
            };
            my $header .= "<movabletype xmlns='" . MT::BackupRestore::NS_MOVABLETYPE() . "'>\n";
            $header = "<?xml version='1.0' encoding='$enc'?>\n$header" if $enc !~ m/utf-?8/i;
            print $fh $header;
        };
        $finisher = sub {
            my ($asset_files) = @_;
            close $fh;
            my $filename = File::Spec->catfile($temp_dir, "$file.manifest");
            $fh = gensym();
            open $fh, ">$filename";
            print $fh "<manifest xmlns='" . MT::BackupRestore::NS_MOVABLETYPE() . "'>\n";
            for my $file (@files) {
                my $name = $file->{filename};
                print $fh "<file type='backup' name='$name' />\n";
            }
            for my $id (keys %$asset_files) {
                print $fh "<file type='asset' name='$asset_files->{$id}->[2]' asset_id='" . $id . "' />\n";
                push @files, {
                    filename => $asset_files->{$id}->[2], 
                    url=> $asset_files->{$id}->[0], 
                    path => $asset_files->{$id}->[1],
                    asset_id => $id,
                };
            }
            print $fh "</manifest>\n";
            close $fh;
            push @files, {
                url => $app->uri . "?__mode=backup_download&name=$file.manifest&magic_token=" . $app->current_magic,
                filename => "$file.manifest"
            };
            if ('0' eq $archive) {
                $param->{files_loop} = \@files;
                $param->{tempdir} = $temp_dir;
                $app->_backup_finisher($fname, $param);
            } elsif ('1' eq $archive) { # tar.gz
                require Archive::Tar;
                my $arc = Archive::Tar->new;
                for my $f (@files) {
                    if (defined $f->{path}) {
                        my @arc_files = $arc->add_files($f->{path});
                        $arc_files[0]->rename($f->{asset_id} . '-' . $f->{filename}) if scalar(@arc_files);
                    } else {
                        my $tmp_filename = File::Spec->catfile($temp_dir, $f->{filename});
                        my @arc_files = $arc->add_files($tmp_filename);
                        $arc_files[0]->rename($f->{filename});
                        unlink $tmp_filename;
                    }
                }
                my ($fh_arc, $filepath) = File::Temp::tempfile('tar.XXXXXXXX', DIR => $temp_dir);
                (my $vol, my $dir, $fname) = File::Spec->splitpath($filepath);
                require IO::Compress::Gzip;
                my $z = IO::Compress::Gzip->new($fh_arc);
                $arc->write($z);
                $z->close;
                $app->_backup_finisher($fname, $param);
            } elsif ('2' eq $archive) { # zip
                require Archive::Zip;
                my $arc = Archive::Zip->new;
                for my $f (@files) {
                    if (defined $f->{path}) {
                        $arc->addFile($f->{path}, $f->{asset_id} . '-' . $f->{filename});
                    } else {
                        my $tmp_filename = File::Spec->catfile($temp_dir, $f->{filename});
                        $arc->addFile($tmp_filename, $f->{filename});
                    }
                }
                my ($fh_arc, $filepath) = File::Temp::tempfile('zip.XXXXXXXX', DIR => $temp_dir);
                (my $vol, my $dir, $fname) = File::Spec->splitpath($filepath);
                $arc->writeToFileHandle($fh_arc);
                close $fh_arc;
                $app->_backup_finisher($fname, $param);
            }
        };
    }

    MT::BackupRestore->backup(
        \@blog_ids, $printer, $splitter, $finisher, $size * 1024, $enc);
}

sub backup_download {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;
    $app->validate_magic() or return;
    my $filename = $app->param('filename');
    my $temp_dir = $app->config('TempDir');
    my $newfilename;
    if (defined($filename)) {
        my $sess = MT::Session->load( { kind => 'BU', name => $filename } );
        if (!defined($sess) || !$sess) {
            return $app->errtrans("Specified file was not found.");
        }
        my @ts = gmtime($sess->start);
        my $ts = sprintf "%04d-%02d-%02d-%02d-%02d-%02d",
            $ts[5]+1900, $ts[4]+1, @ts[3,2,1,0];
        $newfilename = "Movable_Type-$ts" . '-Backup';
        $sess->remove;
    } else {
        $newfilename = $app->param('name');
        return if $newfilename !~ 
            /Movable_Type-\d{4}-\d{2}-\d{2}-\d{2}-\d{2}-\d{2}-Backup(?:-\d+)?\.\w+/;
        $filename = $newfilename;
    }

    require File::Spec;
    my $fname = File::Spec->catfile($temp_dir, $filename);

    my $contenttype;
    if ($filename =~ m/^xml\..+$/i) {
        my $enc = $app->config('PublishCharset') || 'utf-8';
        $contenttype = "text/xml; charset=$enc";
        $newfilename .= '.xml';
    } elsif ($filename =~ m/^tar\..+$/i) {
        $contenttype = 'application/x-tar-gz';
        $newfilename .= '.tar.gz';
    } elsif ($filename =~ m/^zip\..+$/i) {
        $contenttype = 'application/zip';
        $newfilename .= '.zip';
    } else {
        $contenttype = 'application/octet-stream';
    }
    
    if (open(my $fh, "<$fname")) {
        $app->{no_print_body} = 1;
        $app->set_header("Content-Disposition" => "attachment; filename=$newfilename");
        $app->send_http_header($contenttype);
        my $data;
        while (read $fh, my($chunk), 8192) {
            $data .= $chunk;
        }
        close $fh;
        $app->print($data);
        unlink $fname;
    } else {
        $app->errtrans('Specified file was not found.');
    }
}

sub restore {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;
    $app->validate_magic() or return;

    my $q = $app->param;

    my($fh, $no_upload);
    if ($ENV{MOD_PERL}) {
        my $up = $q->upload('file');
        $no_upload = !$up || !$up->size;
        $fh = $up->fh if $up;
    } else {
        ## Older versions of CGI.pm didn't have an 'upload' method.
        eval { $fh = $q->upload('file') };
        if ($@ && $@ =~ /^Undefined subroutine/) {
            $fh = $q->param('file');
        }
        $no_upload = !$fh;
    }

    my $param = {};

    $app->add_breadcrumb($app->translate('Backup & Restore'), $app->uri(mode => 'backup_restore'));
    $app->add_breadcrumb($app->translate('Restore'));
    $param->{system_overview_nav} = 1;
    $param->{nav_backup} = 1;

    $app->{no_print_body} = 1;

    local $| = 1;
    my $charset = MT::ConfigMgr->instance->PublishCharset;
    $app->send_http_header('text/html' .
        ($charset ? "; charset=$charset" : ''));

    $app->print($app->build_page('restore_start.tmpl', $param));

    my $error = '';
    my $result;
    if ($no_upload) {
        $param->{restore_upload} = 0;
        my $dir = $app->config('ImportPath');
        $result = $app->restore_directory($dir, \$error);
    } else {
        my $uploaded = $q->param('file');
        my ($volume, $directories, $uploaded_filename) = File::Spec->splitpath($uploaded) if defined($uploaded);
        if ($uploaded_filename =~ /^.+\.xml$/i) {
            $param->{restore_upload} = 1;
            $result = $app->restore_file($fh, \$error);
        } elsif ($uploaded_filename =~ /^.+\.tar(\.gz)?$/i) {
            my $e = '';
            eval "require Archive::Tar;";
            $e = $@;
            if ($1) {
                eval "require IO::Uncompress::Gunzip;";
                $e = $@;
            }
            if ($e) {
                $result = 0;
                $error = 'Required modules (Archive::Tar and/or IO::Uncompress::Gunzip) are missing.';
            } else {
                my $temp_dir = $app->config('TempDir');
                require File::Temp;
                my $tmp = File::Temp::tempdir($uploaded_filename . 'XXXX', DIR => $temp_dir, CLEANUP => 1);
                my $z;
                my $tar;
                if ($1) {
                    # it's a gz file
                    eval {
                        bless $fh, 'IO::File';
                        $z = new IO::Uncompress::Gunzip $fh or die $@;
                    };
                    if ($e = $@) {
                        $result = 0;
                        $app->print($e);
                        $param->{restore_success} = 0;
                        $param->{error} = $e;
                        $app->print($app->build_page("restore_end.tmpl", $param));
                        close $fh if !$no_upload;
                        return 1;
                    }
                } else {
                    $z = bless $fh, 'IO::File';
                }
                eval {
                    $tar = Archive::Tar->new($z) or die $@;
                };
                if ($e = $@) {
                    $result = 0;
                    $error = $e;
                    $app->print($app->translate("Uploaded file was invalid. $1"));
                } else {
                    for my $file ($tar->list_files) {
                        my $f = File::Spec->catfile($tmp, $file);
                        $tar->extract_file($file, $f);
                    }
                    close $z;
                    $result = $app->restore_directory($tmp, \$error);
                }
            }
        } elsif ($uploaded_filename =~ /^.+\.zip$/i) {
            eval "require Archive::Zip;";
            if ($@) {
                $result = 0;
                $error = 'Required module (Archive::Zip) is missing.';
            } else {
                my $temp_dir = $app->config('TempDir');
                require File::Temp;;
                my $tmp = File::Temp::tempdir($uploaded_filename . 'XXXX', DIR => $temp_dir, CLEANUP => 1);
                bless $fh, 'IO::File';
                my $zip = Archive::Zip->new;
                my $s = $zip->readFromFileHandle($fh);
                for my $member ($zip->memberNames) {
                    my $f = File::Spec->catfile($tmp, $member);
                    $zip->extractMember($member, $f);
                }
                $result = $app->restore_directory($tmp, \$error);
            }
        } elsif ($uploaded_filename =~ /^.+\.manifest$/i) {
            $result = 0;
            $error = $app->translate('Upload manifest file via the other form.');
        }
    }
    $param->{restore_success} = $result;
    $param->{error} = $error if !$result;
    $app->print($app->build_page("restore_end.tmpl", $param));
    close $fh if !$no_upload;
    1;
}

sub restore_file {
    my $app = shift;
    my ($fh, $errormsg) = @_;
    my $q = $app->param;

    require MT::BackupRestore;
    my $deferred = MT::BackupRestore->restore_file($fh, $errormsg, sub { $app->print(@_); });

    if (!defined($deferred) || scalar(keys %$deferred)) {
        my @names = keys %$deferred;
        my $data = '';
        $data .= join(',', splice(@names, 0, 5)) . "\n" while @names;
        $data = "Objects which were not restored are listed below (#ID is the id value in the backup file):\n" . $data;
        my $message = $app->translate('Some objects were not restored because their parent objects were not restored.');
        $app->log({
            message => $message,
            level => MT::Log::WARNING(),
            class => 'system',
            category => 'restore',
            metadata => $data,
        });
        my $log_url = $app->uri(mode => 'view_log', args => {});
        $$errormsg = $message . '  '
            . $app->translate('Detailed information is in the <a href="[_1]">activity log</a>.', $log_url);
        return 0;
    }

    $app->log({
        message => $app->translate("Successfully restored objects to Movable Type system by user '[_1]'", $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'restore'
    });

    1;
}

sub restore_directory {
    my $app = shift;
    my ($dir, $error) = @_;

    if (!-d $dir) {
        $$error = $app->translate('[_1] is not a directory.', $dir);
        return 0;
    }

    my %error_assets;
    require MT::BackupRestore;
    my $deferred = MT::BackupRestore->restore_directory(
        $dir, $error, \%error_assets, sub { $app->print(@_); });

    if (!defined($deferred) && $$error) {
        return 0;
    }

    if (scalar(keys %error_assets)) {
        my $data;
        while (my ($key, $value) = each %error_assets) {
            $data .= $app->translate('MT::Asset#[_1]: ', $key) . $value . "\n";
        }
        my $message = $app->translate('Some of the actual files for assets could not be restored.');
        $app->log({
            message => $message,
            level => MT::Log::WARNING(),
            class => 'system',
            category => 'restore',
            metadata => $data,
        });
        $$error .= $message;
    }

    if (scalar(keys %$deferred)) {
        my @names = keys %$deferred;
        my $data = '';
        $data .= join(',', splice(@names, 0, 5)) . "\n" while @names;
        $data = "Objects which were not restored are listed below (#ID is the id value in the backup file):\n" . $data;
        my $message = $app->translate('Some objects were not restored because their parent objects were not restored.');
        $app->log({
            message => $message,
            level => MT::Log::WARNING(),
            class => 'system',
            category => 'restore',
            metadata => $data,
        });
        my $log_url = $app->uri(mode => 'view_log', args => {});
        $$error .= $message . '  '
            . $app->translate('Detailed information is in the <a href="[_1]">activity log</a>.', $log_url);
    }

    return 0 if $$error;

    $app->log({
        message => $app->translate("Successfully restored objects to Movable Type system by user '[_1]'", $app->user->name),
        level => MT::Log::INFO(),
        class => 'system',
        category => 'restore'
    });
    1;
}

sub restore_upload_manifest {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;
    $app->validate_magic() or return;

    my $q = $app->param;

    my($fh, $no_upload);
    if ($ENV{MOD_PERL}) {
        my $up = $q->upload('file');
        $no_upload = !$up || !$up->size;
        $fh = $up->fh if $up;
    } else {
        ## Older versions of CGI.pm didn't have an 'upload' method.
        eval { $fh = $q->upload('file') };
        if ($@ && $@ =~ /^Undefined subroutine/) {
            $fh = $q->param('file');
        }
        $no_upload = !$fh;
    }
    return $app->errtrans("No manifest file was uploaded.") if $no_upload;

    my $param = {};

    require MT::BackupRestore;
    my $error = MT::BackupRestore->restore_upload_manifest($fh, $param);
    return $app->error($error) if $error;
    
    $param->{open_dialog} = 1;
    $app->build_page('backup_restore.tmpl', $param);
    #close $fh if !$no_upload;
}

sub dialog_restore_upload {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;
    $app->validate_magic() or return;

    my $q = $app->param;

    my $current = $q->param('current_file');
    my $last = $q->param('last');
    my $files = $q->param('files');
    my $assets_json = $q->param('assets');
    my $is_asset = $q->param('is_asset') || 0;

    my $objects = {};
    my $deferred = {}; 
    require JSON;
    my $objects_json = $q->param('objects_json') if $q->param('objects_json');
    $deferred = JSON::jsonToObj($q->param('deferred_json')) if $q->param('deferred_json');
    
    my($fh, $no_upload);
    if ($ENV{MOD_PERL}) {
    my $up = $q->upload('file');
        $no_upload = !$up || !$up->size;
        $fh = $up->fh if $up;
    } else {
        ## Older versions of CGI.pm didn't have an 'upload' method.
        eval { $fh = $q->upload('file') };
        if ($@ && $@ =~ /^Undefined subroutine/) {
            $fh = $q->param('file');
        }
        $no_upload = !$fh;
    }

    my $param = {};
    $param->{is_asset} = $is_asset;
    $param->{name} = $current;
    $param->{files} = $files;
    $param->{assets} = $assets_json;
    $param->{last} = $last;
    $param->{redirect} = 1;
    $param->{is_dirty} = $q->param('is_dirty');
    $param->{objects_json} = $objects_json if defined($objects_json);
    $param->{deferred_json} = JSON::objToJson($deferred) if defined($deferred);

    my $uploaded = $q->param('file');
    $uploaded =~ s!\\!/!g;   ## Change backslashes to forward slashes
    my ($volume, $directories, $uploaded_filename) = File::Spec->splitpath($uploaded) if defined($uploaded);
    if (defined($uploaded) && ($current ne $uploaded_filename)) {
        close $fh;
        $param->{error} = $app->translate('Please upload [_1] in this page.', $current);
        return $app->build_page('dialog_restore_upload.tmpl', $param);
    }

    if ($no_upload) {
        $param->{error} = $app->translate('File was not uploaded.') if !($q->param('redirect'));
        return $app->build_page('dialog_restore_upload.tmpl', $param);
    }

    my $error;
    my @obj_to_restore = (    ## Beware the order of keys is important.
        {tag => 'MT::Tag'},
        {author => 'MT::Author'},
        {blog => 'MT::Blog'},
        {template => 'MT::Template'},
        {role => 'MT::Role'},
        {category => 'MT::Category'},
        {asset => 'MT::Asset'},
        {entry => 'MT::Entry'},
        {trackback => 'MT::Trackback'},
        {comment => 'MT::Comment'},
    );
 
    $app->{no_print_body} = 1;

    local $| = 1;
    my $charset = MT::ConfigMgr->instance->PublishCharset;
    $app->send_http_header('text/html' .
        ($charset ? "; charset=$charset" : ''));

    $app->print($app->build_page('dialog_restore_start.tmpl', $param));

    if (defined $objects_json) {
        my $objects_tmp = JSON::jsonToObj($objects_json);
        my %class2ids;
        # { MT::CLASS#OLD_ID => NEW_ID }
        for my $key (keys %$objects_tmp) {
            my ($class, $old_id) = split '#', $key;
            if (exists $class2ids{$class}) {
                my $newids = $class2ids{$class}->{newids};
                push @$newids, $objects_tmp->{$key};
                my $keymaps = $class2ids{$class}->{keymaps};
                push @$keymaps, { newid => $objects_tmp->{$key}, oldid => $old_id };
            } else {
                $class2ids{$class} = { newids => [ $objects_tmp->{$key} ], keymaps => [ { newid => $objects_tmp->{$key}, oldid => $old_id } ] };
            }
        }
        for my $class (keys %class2ids) {
            eval "require $class;";
            next if $@;
            my $newids = $class2ids{$class}->{newids};
            my $keymaps = $class2ids{$class}->{keymaps};
            my @objs = $class->load({ id => $newids });
            for my $obj (@objs) {
                my @old_ids = grep { $_->{newid} eq $obj->id } @$keymaps;
                my $old_id = $old_ids[0]->{oldid};
                $objects->{"$class#$old_id"} = $obj;
            }
        }
    }

    my $assets = JSON::jsonToObj(MT::Util::decode_html($assets_json)) if defined($assets_json);
    my $asset;
    require MT::BackupRestore;
    if ($is_asset) {
        $asset = shift @$assets;
        my $error_assets = {};
        $asset->{fh} = $fh;
        MT::BackupRestore->restore_asset(undef, $asset, $objects, $error_assets, sub { $app->print(@_); });
        if (defined($error_assets->{$asset->{asset_id}})) {
            $app->log({
                message => $app->translate('Restoring an actual file for an asset failed: [_1]', $error_assets->{$asset->{asset_id}}),
                level => MT::Log::WARNING(),
                class => 'system',
                category => 'restore',
            });
        }
    } else {
        MT::BackupRestore->restore_process_single_file(
            $fh, \@obj_to_restore, $objects, $deferred, \$error, sub { $app->print(@_) });
    }

    my @files = split(',', $files);
    my $file_next = shift @files if scalar(@files);
    if (!defined($file_next)) {
        if (scalar(@$assets)) {
            $asset = $assets->[0];
            $file_next = $asset->{asset_id} . '-' . $asset->{name};
            $param->{is_asset} = 1;
        }
    }

    $param->{files} = join(',', @files);
    $param->{assets} = MT::Util::encode_html(JSON::objToJson($assets));
    $param->{name} = $file_next;
    $param->{last} = (scalar(@files) || (scalar(@$assets) - 1)) ? 0 : 1;
    $param->{is_dirty} = scalar(keys %$deferred);
    if ($last) {
        $param->{restore_end} = 1;
        if ($param->{is_dirty}) {
            my @names = keys %$deferred;
            my $data = '';
            $data .= join(',', splice(@names, 0, 5)) . "\n" while @names;
            $data = "Objects which were not restored are listed below (#ID is the id value in the backup file):\n" . $data;
            my $message = $app->translate('Some objects were not restored because their parent objects were not restored.');
            $app->log({
                message => $message,
                level => MT::Log::WARNING(),
                class => 'system',
                category => 'restore',
                metadata => $data,
            });
            my $log_url = $app->uri(mode => 'view_log', args => {});
            $param->{error} = $message;
            $param->{error_url} = $log_url;
        } else {
            $app->log({
                message => $app->translate("Successfully restored objects to Movable Type system by user '[_1]'", $app->user->name),
                level => MT::Log::INFO(),
                class => 'system',
                category => 'restore'
            });
        }
    } else {
        my %objects_json;
        %objects_json = map { $_ => $objects->{$_}->id } keys %$objects;
        $param->{objects_json} = JSON::objToJson(\%objects_json);
        $param->{deferred_json} = JSON::objToJson($deferred);
    
        $param->{error} = $error if $error;
        $param->{next_mode} = 'dialog_restore_upload';
    }

    $app->print($app->build_page('dialog_restore_end.tmpl', $param));
    close $fh if !$no_upload;
}

sub restore_premature_cancel {
    my $app = shift;
    my $user = $app->user;
    return $app->errtrans("Permission denied.") if !$user->is_superuser;
    $app->validate_magic() or return;
    
    require JSON;
    my $deferred = JSON::jsonToObj($app->param('deferred_json')) if $app->param('deferred_json');
    my $param = { restore_success => 1 };
    if (defined $deferred && (scalar(keys %$deferred))) {
        my @names = keys %$deferred;
        my $data = '';
        $data .= join(',', splice(@names, 0, 5)) . "\n" while @names;
        $data = "Objects which were not restored are listed below (#ID is the id value in the backup file):\n" . $data;
        my $message = $app->translate('Some objects were not restored because their parent objects were not restored.');
        $app->log({
            message => $message,
            level => MT::Log::WARNING(),
            class => 'system',
            category => 'restore',
            metadata => $data,
        });
        my $log_url = $app->uri(mode => 'view_log', args => {});
        $param->{restore_success} = 0;
        $param->{error} = $message . '  '
            . $app->translate("Detailed information is in the <a href='javascript:void(0)' onclick='closeDialog(\"[_1]\")'>activity log</a>.", $log_url);
    } else {
        $app->log({
            message => $app->translate('[_1] has canceled the multiple files restore operation prematurely.', $app->user->name),
            level => MT::Log::WARNING(),
            class => 'system',
            category => 'restore',
        });
    }
    $app->redirect($app->uri( mode => 'view_log', args => {} ));
}

sub dialog_select_weblog {
    my $app = shift;
    return $app->errtrans("Permission denied.")
        unless $app->user->is_superuser;

    my $hasher = sub {
        my ($obj, $row) = @_;
        $row->{label} = $row->{name};
        $row->{'link'} = $row->{site_url};
    };

    $app->listing({
        Type => 'blog',
        Code => $hasher,
        Template => 'dialog_select_weblog.tmpl',
        Params => {
            dialog_title => $app->translate("Select Weblog"),
            items_prompt => $app->translate("Selected Weblog"),
            search_prompt => $app->translate("Type a weblog name to filter the choices below."),
            panel_label => $app->translate("Weblog Name"),
            panel_description => $app->translate("Description"),
            panel_type => 'blog',
            panel_multi => 1,
            panel_searchable => 1,
            panel_first => 1,
            panel_last => 1,
            list_noncron => 1,
        },
    });
}

1;
__END__

=head1 NAME

MT::App::CMS

=head1 SYNOPSIS

The I<MT::App::CMS> module is the primary application module for
Movable Type. It is the administrative interface that is used to
manage blogs, entries, comments, trackbacks, templates, etc.

=head1 METHODS

=head2 $app->init

Initializes the application, defining the modes that are serviced and
core callbacks and itemset actions.

=head2 $app->init_request

Initializes the application to handle the request. The CMS also does a
schema version check to make certain the schema is up-to-date. If it is
not, it forces a direct to the configured UpgradeScript application
(typically mt-upgrade.cgi).

=head2 $app->init_plugins

Overrides I<MT::init_plugins> to call L<init_core_callbacks> before other
plugins are run (since init_core_callbacks defines some remapped callback
names plugins may rely on).

=head2 $app->init_core_callbacks

Registers a set of application callbacks that are unique to the CMS.

=head2 $app->init_core_itemset_actions

Registers the core application itemset actions.

=head2 $app->add_itemset_action(\%param)

Registers an itemset action with the CMS. The parameters accepted are:

=over 4

=item * type

Specifies a data type to associate this action with. This is one of the types
registered with the application (see the L<register_type> method). Standard
types include: C<blog>, C<entry>, C<author>, C<comment>, C<ping>, C<template>,
C<notification>, C<templatemap>, C<commenter>, C<banlist>, C<category>,
C<ping_cat>, C<log>, C<tag>, C<role>, C<association>.

=item * key

A unique identifier for this action. If you are registering a plugin itemset
action, please prefix all your action 'key' names with a common prefix that
will be unique itself.

=item * label

The name to display for this action. It should be an active verb and should
not be wrapped in a "translate" call. These actions are registered at the
start of the application and at that time, the active user's language is
unknown. This text will be translated at the time it is used.

=item * continue_prompt

For actions that require a form of confirmation, the continue_prompt
parameter allows you to prompt the user before the action is invoked.
This text should be in the form of a question, where an affirmative response
will invoke the action. The text of this parameter should not be wrapped in a
"translate" call. These actions are registered at the start of the application
and at that time, the active user's language is unknown. This text will be
translated at the time it is used.

=item * input_label

For actions that require textual input, this parameter can be given to
prompt the user to input something into a text field. This value is then
communicated to the server in the 'itemset_action_input' parameter.

=item * code

This is a coderef that is invoked when the action is taken. The coderef
is passed the application instance as the only parameter.

=item * condition

This is a coderef that is used to condition the inclusion of the itemset
action. This coderef is invoked at the time the list of actions are gathered
for display, so the current user and other contextual information is available
for the condition routine to use to determine if the action can be displayed
or not. The active user can be retrieved using the $app-E<gt>user method
and the active mode is available from $app-E<gt>mode. The condition routine
should return 1 to include the action or 0 or undef to exclude it.

=item * min

This parameter lets you specify the minimum number of items that must be
selected on the listing page to allow the action to be invoked. For instance,
if your action requires 2 and only 2 items to be selected, you can specify a
'min' of 2 and a 'max' of 2.

=item * max

This parameter lets you specify the maximum number of items that must be
selected on the listing page to allow the action to be invoked. For instance,
if your action only operates on single items, you could specify a 'max'
of 1 to enforce this rule.

=back

Itemset actions are rendered using the itemset_action_widget.tmpl
application template.

=head2 $app->apply_log_filter(\%param)

Returns terms suitable for filtering L<MT::Log> based on the parameters
given. 'filter', 'filter_val' and 'blog_id' are recognized parameters.
'filter' may be one of 'level' or 'class'. Valid 'filter_val' values for
a 'filter' of 'level' is any number between 1 and 2^16, being a bitmask.
Valid 'filter_val' values for a 'filter' of 'class' include any of the
register L<MT::Log> class names. See L<MT::Log> for further information.

=head2 $app->build_author_table(%args)

=head2 $app->build_blog_table(%args)

=head2 $app->build_comment_table(%args)

=head2 $app->build_commenter_table(%args)

=head2 $app->build_entry_table(%args)

=head2 $app->build_junk_table(%args)

=head2 $app->build_log_table(%args)

=head2 $app->build_ping_table(%args)

=head2 $app->build_tag_table(%args)

=head2 $app->build_template_table(%args)

Each of these routines have a similar interface and function. They
load data for the E<lt>typeE<gt>_table.tmpl application template.
Parameters for these routine are:

=over 4

=item * param

The parameter hash to populate. This is eventually applied to
the application template.

=item * load_args

An array reference containing the terms and arguments that are to be passed
on to Class-E<gt>load_iter method to load the data.

=item * iter

An existing iterator that can be used to load the records.

=item * items

An array of objects used to populate the listing.

=back

Only one of these arguments is allowed: param, load_args, iter. Upon return,
the hashref provided in the 'param' element is populated with the data
necessary to build the template.

These routines are called by their listing modes (where a 'load_args'
parameter is given) and also from the search_replace mode when displaying
search results (where it passes an 'items' element).

=head2 $app->build_page($tmpl_file, \%param)

Overridden method for L<MT::App::build_page> that adds additional
template parameters that are common to CMS application templates.

=head2 $app->build_plugin_table(%opt)

Populates template parameters necessary for rendering the list_plugin.tmpl
for the blog-centric and system-overview views.

=head2 $app->core_itemset_actions($type, @param)

Returns an array reference of core itemset actions appropriate for the
C<$type> requested. Any @param data given here is passed through to
the itemset action's "condition" coderef, if registered.

=head2 $app->do_search_replace

Utility method used to do the physical search and replace operation
invoked with the 'search_replace' application mode. This method is also
used by the 'listing' method when a 'search' parameter is sent in the
request.

=head2 $app->get_newsbox_content

Handles the task of retrieving the "Movable Type News" from sixapart.com.
This request is done at most once per day since the data is cached
after retrieval. This operation can be disabled by setting the
C<NewsboxURL> to "disable".

=head2 $app->is_authorized

Determines if the active user is authorized to access the blog being
requested. If a blog-level request is active, this method sets the
$app-E<gt>{perms} member which is used to query active permissions for
the blog.

=head2 $app->itemset_actions($which, $type, @param)

Utility method to handle the selection of itemset actions for a given
C<$type>. Any @param data given here is passed through to the itemset
action's "condition" coderef, if registered.

=head2 $app->languages_list($lang)

Returns a list of supported languages in a format suitable for the
edit_author.tmpl, edit_profile.tmpl and cfg_system_general.tmpl application
templates. The C<$lang> parameter pre-selects that language in the
list.

=head2 $app->list_tags_for(%param)

Generates a listing screen for L<MT::Tag> objects that are attached
to a given 'taggable' package. The parameters for this method are:

=over 4

=item * Package

The Perl package name of a class that supports the L<MT::Taggable>
interface that the listing is for.

=item * TagObjectType

The registered type (see the 'register_type' method) of data these
tags are associated with.

=item * TagObjectTypePlural

The plural form of the associated data type.

=back

To list tags for the L<MT::Entry> package, you would use this:

    $app->list_tags_for(
        Package => 'MT::Entry',
        TagObjectType => 'entry',
        TagObjectTypePlural => $app->translate("entries")
    );

This method uses the list_tags.tmpl application template to
render the tag listing view.

=head2 $app->load_default_entry_prefs

=head2 $app->load_entry_prefs

=head2 $app->load_itemset_actions

=head2 $app->list_pref($type)

Returns a hashref of listing preferences suitable for the pager.tmpl
application template. It will also update new listing preference settings
if it sees the current request is posting them.

=head2 $app->listing(\%param)

This is a method for generating a typical listing screen. It is configured
through the parameter hash passed to it. The accepted parameters include:

=over 4

=item * Type

Specifies a data type to be processed. This is one of the types registered
with the application (see the L<register_type> method). Standard types
include: C<blog>, C<entry>, C<author>, C<comment>, C<ping>, C<template>,
C<notification>, C<templatemap>, C<commenter>, C<banlist>, C<category>,
C<ping_cat>, C<log>, C<tag>, C<role>, C<association>.

The Type parameter provides a reference to the actual Perl package to be
used for loading the data for the listing. L<MT::App::CMS> uses it's
C<_load_driver_for> method to retrieve the package name and load the
module if necessary. The module provided should be a MT::Object descendant.

=item * Template

The application template filename to be used to generate the page.
If unspecified, the default is named after the 'Type' parameter:
"list_E<lt>typeE<gt>.tmpl". Note that this parameter is not used when
the 'NoHTML' parameter is specified.

=item * Params

A hashref of parameters that will be passed to the application template
without further modification.

=item * Code

A coderef that is invoked for each row data displayed. This routine is passed
two parameters: the object being processed and a hashref of parameter data
for that row. This is typically used to further customize the row-level
parameter data before the application template is processed.

=item * Terms

This is a hashref that is passed to the C<load_iter> method of the package
that is providing the data for the listing. The Terms parameter provides a
way of filtering the data retrieved. Refer to the L<MT::Object> documentation
of the C<load> and C<load_iter> methods for more information about this
parameter.

=item * Args

This is a hashref that is passed to the C<load_iter> method of the package
that is providing the data for the listing. The Args parameter can be used
to specify a sort order, a join operation and other operations that are
applied upon loading the data for the listing. Refer to the L<MT::Object>
documentation of the C<load> and C<load_iter> methods for more information
about this parameter.

=item * Iterator

The default value for this parameter is 'load_iter'. This is a standard
method for all L<MT::Object> type packages. So, for instance, if your 'Type'
parameter is 'author', the package that will be used is 'MT::Author',
so the listing method will call MT::Author-E<gt>load_iter to fetch the data.
But the L<MT::Author> package provides some convenient iterators for fetching
other things that are related to the author, such as roles they are assigned.
So, for invoking the 'role_iter' iterator method, you'd specify 'role_iter' as
the value for the Iterator parameter.

=item * NoHTML

Specify this parameter (with a true value, such as '1') to cause the
listing method to simply return the hashref of data it would have given
to the application template to return.

=back

The listing method is also aware of many of the query parameters common to
the Movable Type CMS listings. It will automatically recognize the following
query parameters:

=over 4

=item * offset

A number specifying the number of rows to skip when displaying the listing.

=item * search

A string to use for a search query of the data displayed. This parameter
is only useful for data types supported by the CMS search function: currently,
C<blog>, C<author>, C<entry>, C<comment>, C<template>, C<ping>.

=item * filter, filter_val

Used to filter the listing for a particular value. This will supplement
the Terms parameter given to the listing method, adding a term for
C<filter>=C<filter_val>.

=back

The listing method is also aware of the list preferences saved for the
'Type' identified.

=head3 Examples

This will produce a listing page (using the "list_entry.tmpl" application
template) of all entries created by the currently logged-in user.

    return $app->listing({
        Type => 'entry',
        Terms => {
            author_id => $app->user->id,
        },
    });


=head2 $app->load_template_prefs

Returns as hashref of the template edit screen preferences for the active
user.

=head2 $app->make_blog_list(\@blogs)

Takes an array of blogs and returns an array reference of data that is
suitable for the list_blog.tmpl and system_list_blog.tmpl application
templates.

=head2 $app->object_edit_uri($type, $id)

A convenience method for returning an application URI that can be used
to direct the user to an edit operation for the C<$type> and object C<$id>
given. This method assumes the type given is serviced through the 'view'
application mode.

=head2 $app->plugin_itemset_actions($type, @param)

Returns an array reference of plugin itemset actions appropriate for the
C<$type> requested. Any @param data given here is passed through to
the itemset action's "condition" coderef, if registered.

=head2 $app->pre_run

Handles the menial task of localizing the stock "Convert Line Breaks" text
filter for the current user.

=head2 $app->update_dynamicity($blog)

When saving the weblog's configuration settings regarding dynamic publishing,
this method is called to update the blog's templates to match the dynamic
configuration (if specifying no dynamic publishing, all templates are
configured to be statically published, when specifying 'dynamic archives',
archive templates are configured to be dynamically published and all
other templates are set to static).

Also, the '.htaccess' file in the blog's root path is updated to include
rules that invoke the dynamic publishing engine. If this file cannot be
written or updated, the user is notified of this problem.

=head2 $app->user_blog_prefs

Returns a hashref of the current user's blog preferences (such as their
tag delimiter choice).

=head2 $app->user_can_admin_commenters

A utility method used by commenter-based itemset actions to condition
their display based on whether or not the active user has permissions
to administer commenters for the current blog.

=head2 $app->validate_magic

Verifies the 'magic_token' POST parameter that is placed in forms that
are submitted to the application. This token is used as a safety device
to protect against CSRF (cross-site request forgery) style attacks.

=head1 MODE HANDLERS

The CMS mode handlers typically do a permission test to verify the user
has permission to invoke the mode, then process the request and return
the response using an application template.

=over 4

=item * add_tags_to_entries

Applies a set of tags to one or more entries.

=item * approve_item

Approves a comment or trackback for publication.

=item * ban_commenter

Bans a commenter for a particular blog.

=item * ban_commenter_by_comment

Bans commenters on a blog based on a selection of one or more comments.

=item * bookmarklets

Displays the QuickPost bookmarklet creation screen.

=item * category_add

Displays the popup window (used on the entry composition screen) for
adding a new category.

=item * category_do_add

Processes the creation of a new category and returns the JavaScript that
adds the category to the category drop down list on the entry composition
screen.

=item * cc_return

Handles the Creative Commons license data returned from their license
selection process.

=item * cfg_archives

Handler for the Weblog Archives configuration screen.

=item * cfg_archives_do_add

Handles the creation of a new template archive map.

=item * cfg_archives_save

Invoked from the save button of the Weblog Archives configuration screen.

=item * cfg_blog

Handles the display of the general settings for the weblog.

=item * cfg_entries

Handles the display of the "New Entry Defaults" tab of the weblog settings
screen.

=item * cfg_feedback

Handles the display of the "Feedback" tab of the weblog setting screen.

=item * cfg_plugins

Handles the display of the "Plugins" tab of the weblog setting screen.

=item * cfg_prefs

Handles the display of the "Customize Entry display preferences" screen.

=item * cfg_system_feedback

Handles the display of the "System-Wide Feedback Settings" screen.

=item * cfg_system_general

Handles the display of the "System-Wide: General Settings" screen.

=item * delete

Handles the deletion of registered data types.

=item * delete_confirm

Deprecated routine to confirm the deletion of an object.

=item * dialog_grant_role

Handles display of the modal dialog for granting roles.

=item * disable_object

Handles the request to disable a user.

=item * do_import

Handles the request to process entry import file(s).

=item * draft_entries

Handles the request to unpublish existing entries.

=item * edit_object

Handles the display of editing registered data types.

=item * edit_placements

Deprecated routine used to edit secondary categories for an entry.

=item * edit_role

Handles the display of editing a particular role.

=item * empty_junk

Handles the request to empty the junk folder for comments or trackbacks.

=item * enable_object

Handles the request to enable a user.

=item * export

Handles the request to export the data for a weblog.

=item * export_authors

Handles the request to export the MT authors in a CSV format.

=item * export_log

Handles the request to export activity log data in a CSV format.

=item * grant_role

Handles the request from the "Grant Role" modal dialog to grant a role
to a user.

=item * handle_junk

Handles the request to junk a given comment or trackback.

=item * handshake

Handles the response from TypeKey for assigning the TypeKey token to
a particular blog.

=item * itemset_action

Generic application mode handler used by all itemset actions. This handler
will locate the actual coderef to be run to service the itemset action and
if found, calls it.

=item * js_tag_check

Ajax-style handler for testing whether a particular tag name exists or not.

=item * js_tag_list

Ajax-style handler for returning the tags that exist on a particular blog.

=item * list_assets

Handler for displaying a list of blog-level assets.

=item * list_associations

Handler for displaying the associations listing (either all associations,
associations for a particular user, role or blog).

=item * list_authors

Handler for displaying a list of authors.

=item * list_blogs

Handler for the front screen of MT, where the user's associated blogs
are listed.

=item * list_categories

Handler for displaying the categories for a particular blog.

=item * list_commenters

Handler for displaying a list of authenticated commenters for a particular
blog.

=item * list_comments

Handler for displaying a list of comments (either blog-level or system-wide).

=item * list_entries

Handler for displaying a list of entries (either blog-level or system-wide).

=item * list_objects

Handler for displaying the installed templates for a particular blog (this
used to be a routine called for most listings, but they have been broken out
into separate handlers).

=item * list_pings

Handler for displaying a list of trackbacks (either blog-level or
system-wide).

=item * list_plugins

Handler for displaying all installed plugins (the system-overview view of
plugins).

=item * list_roles

Handler for displaying the role listing.

=item * list_tags

Handler for displaying a list of tags (either blog-level or system-wide).

=item * logout

Handler for logging the active user out of the application, ending their
session.

=item * make_bm_link

Handler for displaying the QuickPost bookmarklet that the user has created.

The parameters that control which elements of the form are displayed are:

=item * move_category

Handles the request for moving a category from one parent to another (or
to the top level).

=item * not_junk

Handler for approving previously junked comments or TrackBack objects.

=item * pinged_urls

Handler for displaying the list of URLs that have been pinged for
a particular entry.

=item * plugin_control

Handler for the request to enable/disable a particular plugin or all
plugins.

=item * preview_entry

Handler for displaying an entry preview (invoked from the entry
composition screen).

=item * publish_entries

Itemset handler for the request to publish a selection of entries.

=item * rebuild_confirm

Handler for displaying the list of rebuild options in the rebuild site
popup window.

=item * rebuild_new_phase

Displays the "rebuilding.tmpl" page and invokes a "rebuild_phase"
mode request to process the rebuild of a set of entries/templates.

=item * rebuild_pages

Primary rebuild handler for the rebuild site process.

=item * rebuild_phase

Handler for rebuilding entries/templates selected from the listings. Rebuilds
the requested set of items and returns to the originally viewed listing.

=item * recover_password

Handler for displaying the password recovery screen.

=item * recover_passwords

Handler for resetting the passwords for one or more users.

=item * recover_profile_password

Handler for the password reset request invoked by a system administrator
from the user profile screen.

=item * reg_bm_js

Handler for returning the JavaScript code for displaying the QuickPost
composition page for Internet Explorer users that have installed the
QuickPost Windows registry file.

=item * reg_file

Handler that returns the "mt.reg" for enabling a conext-menu QuickPost item
that is suitable for Internet Explorer.

=item * remove_tags_from_entries

Itemset handler for removing a list of tags from one or more entries.

=item * rename_tag

Handler for renaming a I<MT::Tag>, or merging with another tag if one
exists by that name.

=item * reset_blog_templates

Handler for resetting a given blogs templates back to their default
configuration.

=item * reset_log

Handler for resetting the system-wide activity log.

=item * reset_password

=item * reset_plugin_config

=item * save_category

=item * save_cfg_system_feedback

=item * save_cfg_system_general

=item * save_commenter_perm

=item * save_entries

=item * save_entry

=item * save_entry_prefs

=item * save_object

=item * save_placements

=item * save_plugin_config

=item * save_role

=item * search_replace

=item * send_notify

=item * send_pings

=item * set_item_visible

=item * set_object_status

=item * show_admin

=item * show_entry_prefs

=item * show_menu

=item * show_status

=item * start_import

=item * start_rebuild_pages

=item * start_recover

=item * start_upload

=item * asset_insert

=item * start_upload_entry

=item * system_list_blogs

Handler for the display of the system-wide list of blogs.

=item * trust_commenter

=item * trust_commenter_by_comment

=item * unapprove_item

=item * unban_commenter

=item * unban_commenter_by_comment

=item * untrust_commenter

=item * untrust_commenter_by_comment

=item * update_list_prefs

Handler for saving changes to the user's list preferences.

=item * update_welcome_message

Handler for saving the change to the blog's welcome message.

=item * upgrade

Transient mode handler used to redirect user to the mt-upgrade script
for either installation of upgrade of their database.

=item * upload_file

=item * view_log

Handler for viewing the activity log (either blog-level or system-wide).

=item * backup_restore

Handler for the display of the backup/restore screen.

=item * backup

Handler for the system backup function.

=item * restore

Handler for the system backup function.

=back

=head1 UTILITY FUNCTIONS

=head2 listify(\@array)

Utility function that takes an array reference of strings and returns
an array reference of hashes. So this:

    listify(['a','b','c'])

yields this:

    [{name => 'a'},{name => 'b'},{name => 'c'}]

This is handy for presenting a simple list of things in an HTML::Template
template.

=head2 $app->make_feed_link($view, $params)

Utility method for constructing an Activity Feed link based on the current
view. This routine requires the user have an API password assigned to
their profile.

=head2 $app->map_comment_to_commenter(\@comments)

Utility method for retrieving the unique set of commenter_id and blog_id
values for the set of comments given. The return value from this method
is an list of array references that each have the commenter_id and blog_id
in them.

=head2 $app->ping_continuation

Utility method that returns a response to show the "Pinging..." status
page (pinging.tmpl application template).

=head2 $app->rebuild_these(\%rebuild_set, %options)

Utility method for rebuilding a set of entries. If C<$options{how}> is
passed and it is set to the C<NEW_PHASE> constant, the handler returns
the 'rebuilding.tmpl' application template to kick off the actual
rebuild operation with a separate request. Otherwise, the entries
are rebuilt immediately.

=head2 $app->register_type($type, $package)

Registers a new "API" type that goes into the C<%API> hash. This registry
is used by the C<_load_driver_for> method and other generic handlers
that expect a '_type' parameter to be passed in the request.

=head2 RegistrationAffectsArchives($blog_id, $archive_type)

Private utility routine to test if a particular archive type is affected
by changes to commenter registration settings. Returns true if particular
tags are in use (namely, MTIfRegistrationRequired,
MTIfRegistrationNotRequired, MTIfRegistrationAllowed).

=head2 $app->update_entry_status($new_status, @id_list)

Called by the draft_entries and publish_entries handlers to actually
apply the updates to the entries identified and republish pages that
are necessary.

=head1 CUSTOM REBUILD OPTIONS

The pop-up rebuild dialog that you see in Movable Type has a drop-down
list of rebuild options. This list can be populated with custom options
provided through a plugin. For example, a plugin might want to provide
the user with an option to rebuild a template identified for creating
user archives.

=head2 $app->add_rebuild_option(\%param)

=over 4

=item label

The label to display in the list of rebuild options.

=item code

The code to execute when running the custom rebuild option.

=item key

An identifier unique to this option (optional, will derive from the label if
unavailable).

=back

In addition to this application method, there is also a C<RebuildOptions>
callback that can be used to further customize the list of extra rebuild
options. This callback is useful when needing to add items to the list
that are unique to the active user or weblog.

=head1 CALLBACKS

The application-level callbacks of the C<MT::App::CMS> application are
documented here.

=over 4

=item RebuildOptions

    callback($cb, $app, \@options)

The RebuildOptions callback provides control over an array of additional
custom rebuild options that are displayed in MT's rebuild window. The array
is populated with hashrefs, each containing:

=over 4

=item code

The code to execute when running the custom rebuild option.

=item name

The label to display in the list of rebuild options.

=item key

An identifier unique to this option (optional, will derive from the label
if unavailable).

=back

=item CMSPostSave.entry

Called when an entry has been saved, after all of its constituent
parts (for example, category placements) have been saved. An 
CMSPostEntrySave callback would have the following signature:

    sub cms_post_entry_save($cb, $app, $entry, $original)
    {
        ...
    }

=back

For backward compatibility, C<CMSPostEntrySave> and C<AppPostEntrySave> are
aliases to C<CMSPostSave.entry>.

=head2 Parametric Calllbacks

Every object "type" has a suite of callbacks defined for that type, as
below. Each item in the list below forms a callback name by appending
the object "type" after a period,
e.g. C<CMSViewPermissionFilter.blog>, C<CMSPostSave.template>,
etc. The "type" values come from the same space as passed to the CMS
app's C<_type> query parameter. If you're not sure what C<_type>
corresponds to a certain MT::Object subclass, consult the following list:

=over 4

=item author           => MT::Author

=item comment          => MT::Comment

=item entry            => MT::Entry

=item template         => MT::Template

=item blog             => MT::Blog

=item notification     => MT::Notification

=item templatemap      => MT::TemplateMap

=item category         => MT::Category

=item banlist          => MT::IPBanList

=item ping             => MT::TBPing

=item ping_cat         => MT::TBPing

=item role             => MT::Role

=item association      => MT::Association

=back

Callbacks that apply to these object types are as follows:

=over 4

=item CMSViewPermissionFilter
    
Calling convention is:

    callback($cb, $app, $id, $obj_promise)

Where C<$id> is the ID of an object, if it already exists, or
C<undef> if the user will be creating a new object of this type.

C<$obj_promise> is a promise for the object itself. You can use
C<$obj_promise->force> to get ahold of the object, if you need it, but
typically you won't need it. (See L<MT::Promise>)

Return a false value to abort the operation and display a message to
the user that s/he doesn't have permission to view the object.

=item CMSDeletePermissionFilter

    callback($cb, $app, $obj)

=item CMSSavePermissionFilter
    
Calling convention is:

    callback($cb, $app, $id)
    
Where C<$id> is the ID of the object, if it already exists, or
C<undef> if it is a new object with this request.

Note that at this point, the object may not yet exist. The request can
be understood through the query parameters of the app, accessible
through C<$app-E<gt>param()>. A C<CMSSavePermissionFilter> callback
should be "safe"--it should not modify the database.

Return a false value to abort the operation and display a message to
the user that s/he doesn't have permission to modify the object. The
method is not called if the acting user is a superuser.

=item CMSSaveFilter

This callback gives you the chance to "decline" for reasons other than lack of permissions.

The routine is called as follows:
    
    callback($cb, $app)

Returning a false value will decline the request. It is advisibable to
return an error via the C<$cb> object in order to signal to the user
what went wrong.

Note that the new object has not been constructed yet. The operation
can be understood by examining the C<$app> object's query parameters
via C<$app-E<gt>param()>

A C<CMSSaveFilter> callback should be "safe"--it should not modify the
database.

=item CMSPreSave

    callback($cb, $app, $obj, $original)

C<$obj> and C<$original> hold the object which is about to be saved,
and the object as it was when this request began, respectively. This
allows the callback to determine what kind of changes are being
attempted in the user's request. If the request is to create a new
object, $original will be a valid object reference, but the object
will be "blank": it will be just what is returned by the C<new> method
on that class.

=item CMSPostSave

    callback($cb, $app, $obj, $original)

C<$obj> and C<$original> hold the object which is about to be saved,
and the object as it was when this request began, respectively. When
the callback routine is called, the new object as C<$obj> has already
been committed to the database. This is a convenient time to trigger
follow-up actions, such as notification and static-page rebuilds.

=item CMSPostDelete

    callback($cb, $app, $obj)

C<$obj> holds the object that has just been removed from the database.
This callback is useful when removing data that is associated with
the object being removed.

=item CMSUploadFile

    callback($cb, %params)

This callback is invoked for each file the user uploads to the weblog.
It is called for each file, regardless of type. If the user uploads an
image, both the C<CMSUploadFile> and C<CMSUploadImage> callbacks are invoked.

=head3 Parameters

=over 4

=item * File

The full file path of the file that has been saved into the weblog.

=item * Url

The URL of the file that has been saved into the weblog.

=item * Size

The length of the file in bytes.

=item * Type

Either 'image', 'file' or 'thumbnail'.

=item * Blog

The C<MT::Blog> object the uploaded file is associated with.

=back

=item CMSUploadImage

    callback($eh, %params)

This callback is invoked for each uploaded image. In the case the user
creates a thumbnail for their uploaded image, this callback will be
invoked twice-- once for the uploaded original image and a second time
for the thumbnail that was generated for it.

=over 4

=item * File

The full path and filename for the uploaded file.

=item * Url

The full URL for the uploaded file.

=item * Size

The length of the uploaded image in bytes.

=item * Type

Either "image" or "thumbnail" (for generated thumbnails).

=item * Height

The height of the image in pixels (available if C<Image::Size> module
is present).

=item * Width

The width of the image in pixels (available if C<Image::Size> module
is present).

=item * ImageType

The image identifier as reported by the C<Image::Size> module. Typically,
'GIF', 'JPG' or 'PNG'.

=item * Blog

The C<MT::Blog> object of the weblog the image is associated with.

=back

=back

=cut
