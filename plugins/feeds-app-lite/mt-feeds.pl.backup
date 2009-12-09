# Copyright 2002-2006 Appnel Internet Solutions, LLC
# This code is distributed with permission by Six Apart

package MT::Plugin::FeedsLite;

use strict;
use base qw( MT::Plugin );

our $VERSION = '1.03';

my $plugin = __PACKAGE__->new({
    id          => 'FeedsAppLite',
    name        => 'Feeds.App Lite',
    description => '<MT_TRANS phrase="Feeds.App Lite helps you republish feeds on your blogs. Want to do more with feeds in Movable Type? <a href="http://code.appnel.com/feeds-app" target="_blank">Upgrade to Feeds.App</a>.">',
    version     => $VERSION,
    author_name => 'Appnel Solutions',
    author_link => 'http://www.appnel.com/',
    doc_link    => 'docs/index.html',
    key         => __PACKAGE__,
    l10n_class  => 'FeedsLite::L10N',
});
MT->add_plugin($plugin);

sub instance { $plugin }

sub init {
    my $plugin = shift;
    $plugin->SUPER::init(@_);
    $plugin->{registry} = {
        applications => {
            cms => {
                methods => {
                    feedswidget_start => '$FeedsAppLite::FeedsWidget::CMS::start',
                    feedswidget_select => '$FeedsAppLite::FeedsWidget::CMS::select',
                    feedswidget_config   => '$FeedsAppLite::FeedsWidget::CMS::configuration',
                    feedswidget_save     => '$FeedsAppLite::FeedsWidget::CMS::save',
                },
                page_actions => {
                    list_templates => {
                        'feeds_app_lite' => {
                            label => 'Create a Feed Widget',
                            dialog  => 'feedswidget_start',
                            permission => 'edit_templates',
                            condition => sub { MT->instance->blog },
                        }
                    },
                },
            },
        },
        tags => {
            block => {
                Feed => 'MT::Feeds::Tags::feed',
                FeedEntries => 'MT::Feeds::Tags::entries',
            },
            function => {
                FeedTitle => 'MT::Feeds::Tags::feed_title',
                FeedLink => 'MT::Feeds::Tags::feed_link',
                FeedEntryTitle => 'MT::Feeds::Tags::entry_title',
                FeedEntryLink => 'MT::Feeds::Tags::entry_link',
                FeedInclude => 'MT::Feeds::Tags::include',
            },
        },
    };
}

sub load_config {
    my $plugin = shift;
    my ($param, $scope) = @_;
    $plugin->SUPER::load_config(@_);
    if ($scope =~ m/^blog:(\d+)$/) {
        $param->{blog_id} = $1;
    }
}

1;
