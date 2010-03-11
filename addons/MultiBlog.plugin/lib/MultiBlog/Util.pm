package MultiBlog::Util;
use strict;
use base 'Exporter';

our @EXPORT_OK = qw( trigger_loop action_loop );
our $plugin = MT->component('MultiBlog');

sub trigger_loop {
    [
        {
            trigger_key  => 'entry_save',
            trigger_name => $plugin->translate('saves an entry'),
        },
        {
            trigger_key  => 'entry_pub',
            trigger_name => $plugin->translate('publishes an entry'),
        },
        {
            trigger_key  => 'comment_pub',
            trigger_name => $plugin->translate('publishes a comment'),
        },
        {
            trigger_key  => 'tb_pub',
            trigger_name => $plugin->translate('publishes a TrackBack'),
        },
    ];
}

sub action_loop {
    [
        {
            action_id   => 'ri',
            action_name => $plugin->translate('rebuild indexes.'),
        },
        {
            action_id   => 'rip',
            action_name => $plugin->translate('rebuild indexes and send pings.'),
        },
    ];
}

1;
