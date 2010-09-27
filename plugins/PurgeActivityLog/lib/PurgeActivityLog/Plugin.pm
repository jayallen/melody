# Copyright (C) 2010 Endevver, LLC.

package PurgeActivityLog::Plugin;

use strict;
use warnings;

use Carp qw( croak longmess confess );
use MT::Util qw( relative_date    offset_time format_ts days_in 
                 offset_time_list epoch2ts    ts2epoch  trim );

sub load_tasks {
    my $cfg = MT->config;
    return {
        'PurgeLog' => {
            'label' => 'Purge Old Activity Log Entries',
            'frequency' => 1,#(60 * 60 * 24),
            'code' => sub { 
                PurgeActivityLog::Plugin->task_purge; 
            },
            
        }
    };
}

sub task_purge {
    my $this = shift;
    require MT::Util;
    my $mt     = MT->instance;
    my $plugin = MT->component('PurgeActivityLog');
    my $n      = $plugin->get_config_value('purge_n_days','system');
    my $now    = epoch2ts(undef,time());
    my $epoch  = time() - (60 * 60 * 24 * $n);
    my $date   = epoch2ts(undef,$epoch);
    my $total_changed = 0;
#    print STDERR "Purging activity log entries older than $n days (now = $now; date = $date)\n";

    my $iter = MT->model('log')->load_iter( { created_on => [ undef, $date ] },
                                            { range => { created_on => 1 } } );

    while ( my $log = $iter->() ) {
#        print STDERR "Removing log entry with created on date of: ".$log->created_on." (less than ".$date."?)\n";
        $log->remove();
        $total_changed++;
    }
    $total_changed > 0 ? 1 : 0;
}

1;

__END__
