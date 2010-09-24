# Publish Queue Manager Plugin for Movable Type
# Author: Byrne Reese, byrne at majordojo dot com
# Copyright (C) 2008 Six Apart, Ltd.
package PQManager::Plugin;

use strict;
use MT::Util qw( relative_date epoch2ts iso2ts );
use warnings;
use Carp;

sub mode_delete {
    my $app = shift;
    $app->validate_magic or return;

    require MT::TheSchwartz::Job;
    my @jobs = $app->param('id');
    for my $job_id (@jobs) {
        my $job = MT::TheSchwartz::Job->load({jobid => $job_id}) or next;
        $job->remove();
    }
    $app->redirect(
            $app->uri(
                'mode' => 'PQManager.list',
                args   => {
                    deleted => 1,
                }
            )
        );
}

sub mode_priority {
    my $app = shift;
    $app->validate_magic or return;

    my $pri = $app->param('itemset_action_input');
    if ($pri !~ /^[0-9]+$/) {
        return $app->error("You must enter a number between 1 and 10.");
    }

    require MT::TheSchwartz::Job;
    my @jobs = $app->param('id');
    for my $job_id (@jobs) {
        my $job = MT::TheSchwartz::Job->load({jobid => $job_id}) or next;
        $job->priority($pri);
        $job->save();
    }
    $app->redirect(
            $app->uri(
                'mode' => 'PQManager.list',
                args => {
                    priority => $pri,
                }
            )
        );
}

sub mode_list_queue {
    my $app = shift;
    my %param = @_;
    my $q = $app->{query};

    if (my $blog = $app->blog) {
        $app->redirect(
            $app->uri(
                'mode' => 'dashboard',
                args   => {
                    blog_id => $blog->id,
                }
            )
        );
    }

    # This anonymous subroutine will process each row of data returned
    # by the database and map that data into a set of columns that will
    # be displayed in the table itself. The method takes as input:
    #   * the object associated with the current row
    #   * an empty hash for the row that should be populated with content
    #     from the $obj passed to it.
    require MT::FileInfo;
    require MT::Template;
    require MT::Blog;
    require MT::TheSchwartz::Error;
    my %blogs;
    my %tmpls;
    my $code = sub {
        my ($job, $row) = @_;

        $row->{'insert_time_raw'} = $job->insert_time;
        my $fi  = MT::FileInfo->load({ id => $job->uniqkey });
        my $err = MT::TheSchwartz::Error->load({ jobid => $job->jobid });

        $tmpls{$fi->template_id} ||= MT::Template->load({ id => $fi->template_id });
        my $tmpl                   = $tmpls{$fi->template_id};

        if ($tmpl) {
            my $blog = $blogs{$tmpl->blog_id}  
                   ||= MT::Blog->load({ id => $tmpl->blog_id });
            $row->{'blog'}     = $blog->name;
            $row->{'template'} = $tmpl->name;
            $row->{'path'}     = $fi->file_path;
        } else {
            $row->{'blog'}            = '<em>Deleted</em>';
            $row->{'template'}        = '<em>Deleted</em>';
            $row->{'path'}            = '<em>Deleted</em>';
        }
        my $ts                    = epoch2ts(undef, $job->insert_time);
        $row->{'id'}              = $job->jobid;
        $row->{'priority'}        = $job->priority;
        $row->{'claimed'}         = $job->grabbed_until ? 1 : 0;
        $row->{'insert_time'}     = relative_date( $ts, time );
        $row->{'insert_time_ts'}  = $ts;
        $row->{'has_error'}       = $err ? 1 : 0;
        $row->{'error_msg'}       = $err ? $err->message : undef;
    };

    require MT::TheSchwartz::FuncMap;
    my $fm = MT::TheSchwartz::FuncMap->load(
        {funcname => 'MT::Worker::Publish'});

    $fm or return $app->error(
        'It appears that your have never used publish queue before. '
        .'To enable publish queue, set any template to publish '
        .'"Via Publish Queue" and then save and publish that template. '
        .'Then return to this screen to see everything humming along.');

    # %terms is used in case you want to filter the query that will fetch
    # the items from the database that correspond to the rows of the table
    # being rendered to the screen
    my %terms = ( funcid => $fm->funcid );

    # %args is used in case you want to sort or otherwise modify the 
    # query arguments of the table, e.g. the sort order or direction of
    # the query associated with the data being displayed in the table.
    my $clause = ' = ts_job_uniqkey';
    my %args = (
        sort  => [
                   { column => "priority", desc => "DESC" },
                   { column => "insert_time", }
               ],
        direction => 'descend',
        join => MT::FileInfo->join_on( undef, { id => \$clause }),
    );

    # %params is an addition hash of input parameters into the template
    # and can be used to hold an arbitrary set of name/value pairs that
    # can be displayed in your template.
    my $params = {
        'is_deleted'  => $q->param('deleted')  ? 1 : 0,
        'is_priority' => $q->param('priority') ? 1 : 0,
        ($q->param('priority') ? ('priority' => $q->param('priority')) : ())
    };

    # Fetch an instance of the current plugin using the plugin's key.
    # This is done as a convenience only.
    my $plugin = MT->component('PQManager');

    # This is the main work horse of your handler. This subrotine will
    # actually conduct the query to the database for you, populate all
    # that is necessary for the pagination controls and more. The 
    # query is filtered and controlled using the %terms and %args 
    # parameters, with 'type' corresponding to the database table you
    # will query.
    return $app->listing({
        type           => 'ts_job', # the object's MT->model
        terms          => \%terms,
        args           => \%args,
        listing_screen => 1,
        code           => $code,
        template       => $plugin->load_tmpl('list.tmpl'),
        params         => $params,
    });
}

1;
