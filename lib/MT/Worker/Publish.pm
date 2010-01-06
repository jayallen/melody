# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Worker::Publish;

use strict;
use base qw( TheSchwartz::Worker );

use TheSchwartz::Job;
use Time::HiRes qw(gettimeofday tv_interval);
use MT::FileInfo;
use MT::PublishOption;
use MT::Util qw( log_time );

sub keep_exit_status_for { 1 }

sub work {
    my $class = shift;
    my TheSchwartz::Job $job = shift;

    # Build this
    my $mt = MT->instance;

    # reset publish timer; don't republish a file if it has
    # this or a later timestamp.
    $mt->publisher->start_time( time );

    # We got triggered to build; lets find coalescing jobs
    # and process them in one pass.

    my @jobs = ($job);
    my $job_iter;
    if (my $key = $job->coalesce) {
        $job_iter = sub {
            shift @jobs || MT::TheSchwartz->instance->find_job_with_coalescing_value($class, $key);
        };
    }
    else {
        $job_iter = sub { shift @jobs };
    }

    my $task_workers = MT->registry('task_workers') || {};
    my $sync_task    = $task_workers->{mt_sync};
    my $sync         = MT->config('SyncTarget') if $sync_task;

    my $start = [gettimeofday];
    my $rebuilt = 0;

    while (my $job = $job_iter->()) {
        my $fi_id = $job->uniqkey;
        my $fi = MT::FileInfo->load($fi_id);

        # FileInfo record missing? Strange, but ignore and continue.
        unless ($fi) {
            $job->completed();
            next;
        }

        my $priority = $job->priority ? ", priority " . $job->priority : "";

        # Important: prevents requeuing!
        $fi->{from_queue} = 1;

        my $mtime = (stat($fi->file_path))[9];

        my $throttle = MT::PublishOption::get_throttle($fi);

        # think about-- throttle by archive type or by template
        if ($throttle->{type} == MT::PublishOption::SCHEDULED() ) {
            if (-f $fi->file_path) {
                my $time = time;
                if ($time - $mtime < $throttle->{interval}) {
                    # ignore rebuilding this file now; not enough
                    # time has elapsed for rebuilding this file...
                    $job->grabbed_until(0);
                    $job->driver->update($job);
                    next;
                }
            }
        }

        $job->debug("Publishing " . $fi->file_path . $priority);

        my $res = $mt->publisher->rebuild_from_fileinfo($fi);
        if (defined $res) {
            if ( $sync ) {
                my $sync_job = TheSchwartz::Job->new();
                $sync_job->funcname( $sync_task->{class} );
                $sync_job->uniqkey($fi_id);
                $sync_job->coalesce($job->coalesce) if $job->coalesce;
                $sync_job->priority($job->priority) if $job->priority;
                $job->replace_with($sync_job);
            } else {
                $job->completed();
            }
            $rebuilt++;
        } else {
            my $error = $mt->publisher->errstr;
            my $errmsg = $mt->translate("Error rebuilding file [_1]" . $fi->file_path . ": " . $error);
            MT::TheSchwartz->debug($errmsg);
            $job->permanent_failure($errmsg);
            require MT::Log;
            $mt->log({
                ($fi->blog_id ? ( blog_id => $fi->blog_id ) : () ),
                message => $errmsg,
                metadata => log_time() . ' ' . $errmsg . ":\n" . $error,
                category => "publish",
                level => MT::Log::ERROR(),
            });
        }
    }

    if ($rebuilt) {
        MT::TheSchwartz->debug($mt->translate("-- set complete ([quant,_1,file,files] in [_2] seconds)", $rebuilt, sprintf("%0.02f", tv_interval($start))));
    }

}

sub grab_for { 60 }
sub max_retries { 0 }
sub retry_delay { 60 }

1;
__END__

=head1 NAME

MT::Worker::Publish - The worker responsible for the publishing posts in the 
background, or "asynchronously."

=head1 DESCRIPTION

This class is a subclass of L<TheSchwartz::Worker>. To learn more about how the
periodic task system utilizes each of the subroutines below to control this 
worker's state on the job queue, please consult its documentation.

=head1 METHODS

=head2 grab_for

Returns 60, or 1 minute.

=head2 max_retries

Returns 0. 

=head2 retry_delay

Returns 60, or 1 minute.

=head2 keep_exit_status_for

Returns 1.

=head2 work

Performs the work for this periodic task, which in this case is to publish
any files found on the "Pubish Queue." For files to be placed on the publish
queue their corresponding template or archive mapping must have a publish type
of "Via Publish Queue."

This worker is dumb in that it just loads each file off the queue and
publishes it without much regard to optimization. The process of deduping
publishing requests, or in other words, the process by which no file is 
needlessly placed on the publish queue twice is handled by business logic 
elsewhere.

This worker is also responsible for creating a L<MT::Worker::Sync> job on the
job queueu if such an operation has been specified by the SyncTarget and 
RsyncOptions configuration directives.

=cut
