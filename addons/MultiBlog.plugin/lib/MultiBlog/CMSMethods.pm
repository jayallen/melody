package MultiBlog::CMSMethods;
use strict;
use MultiBlog::Util qw(action_loop trigger_loop);

sub add_trigger {
    my $app = shift;
    my $plugin = MT->component('MultiBlog');
    return $plugin->translate("Permission denied.")
        unless $app->user->is_superuser() ||
               ($app->blog && $app->user->permissions($app->blog->id)->can_administer_blog());

    my $blog_id = $app->blog->id;
    my $dialog_tmpl = $plugin->load_tmpl('dialog_create_trigger.tmpl');
    my $tmpl = $app->listing({
        template => $dialog_tmpl,
        type => 'blog',
        code => sub {
            my ($obj, $row) = @_;
            if ($obj) {
                $row->{label} = $obj->name;
                $row->{link} = $obj->site_url;
            }
        },
        terms => {
            id => [ $blog_id ],
        },
        args => {
            not => { id => 1 },
        },
        params => {
            panel_type => 'blog',
            dialog_title => $plugin->translate('MultiBlog'),
            panel_title => $plugin->translate('Create Trigger'),
            panel_label => $plugin->translate("Weblog Name"),
            search_prompt => $plugin->translate("Search Weblogs") . ':',
            panel_description => $plugin->translate("Description"),
            panel_multi => 0,
            panel_first => 1,
            panel_last => 1,
            panel_searchable => 1,
            multiblog_trigger_loop => trigger_loop(),
            multiblog_action_loop => action_loop(),
            list_noncron => 1,
            trigger_caption => $plugin->translate('When this'),
        },
    });
    if (!$app->param('search')) {
        if (my $loop = $tmpl->param('object_loop')) {
            unshift @$loop, {
                id => '_all',
                label => $plugin->translate('* All Weblogs'),
                description => $plugin->translate('Select to apply this trigger to all weblogs'),
            };
        }
    }
    return $app->build_page($tmpl);
}

1;
