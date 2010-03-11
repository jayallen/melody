package MultiBlog::Plugin;
use strict;
use base qw(MT::Plugin);
use MultiBlog::Util qw(action_loop trigger_loop);

sub load_config {
    my $plugin = shift;
    my ($args, $scope) = @_;

    $plugin->SUPER::load_config(@_);

    if ( $scope =~ /blog:(\d+)/ ) {
        my $blog_id = $1;

        require MT::Blog;

        $args->{multiblog_trigger_loop} = trigger_loop();
        my %triggers =
            map { $_->{trigger_key} => $_->{trigger_name} }
                @{ $args->{multiblog_trigger_loop}};

        $args->{multiblog_action_loop} = action_loop();
        my %actions =
            map { $_->{action_id} => $_->{action_name} }
                @{ $args->{multiblog_action_loop} };

        my $rebuild_triggers = $args->{rebuild_triggers};
        my @rebuilds = map {
            my ( $action, $id, $trigger ) = split ( /:/, $_ );
            if ($id eq '_all') {
                {
                    action_name   => $actions{$action},
                    action_value  => $action,
                    blog_name     => $plugin->translate('* All Weblogs'),
                    blog_id       => $id,
                    trigger_name  => $triggers{$trigger},
                    trigger_value => $trigger,
                };
            } elsif (my $blog = MT::Blog->load($id, { cached_ok => 1 })) {
                {
                    action_name   => $actions{$action},
                    action_value  => $action,
                    blog_name     => $blog->name,
                    blog_id       => $id,
                    trigger_name  => $triggers{$trigger},
                    trigger_value => $trigger,
                };
            } else {
                ();
            }
        } split ( /\|/, $rebuild_triggers );
        $args->{rebuilds_loop} = \@rebuilds;
    }
    my $app = MT->instance;
    if ($app->isa('MT::App')) {
        $args->{blog_id} = $app->blog->id if $app->blog;
    }
}

sub save_config {
    my $plugin = shift;
    my ($args, $scope) = @_;

    $plugin->SUPER::save_config(@_);

    my ($blog_id);
    if ( $scope =~ /blog:(\d+)/ ) {
        $blog_id = $1;

        # Save blog-level content aggregation policy to single 
        # system config hash for easy lookup
        my ($cfg_old, $cfg_new) = 0;
        my $override = 
            $plugin->get_config_value( 'access_overrides', "system" ) || {};
        $cfg_new = $args->{blog_content_accessible};
        if ( exists $override->{$blog_id} ) {
            $cfg_old = $override->{$blog_id};
        }
        if ( $cfg_old != $cfg_new ) {
            $override->{$blog_id} = $cfg_new 
                or delete $override->{$blog_id};
            $plugin->set_config_value( 'access_overrides'
                                     , $override
                                     , 'system' );
        }

        # Fiddle with rebuild triggers...
        my $rebuild_triggers = $args->{rebuild_triggers};
        my $old_triggers     = $args->{old_rebuild_triggers};

        # Check to see if the triggers changed
        if ( $old_triggers ne $rebuild_triggers ) {
            # If so, remove all references to the current blog from the triggers cached in other blogs
            foreach ( split ( /\|/, $old_triggers ) ) {
                my ( $action, $id, $trigger ) = split ( /:/, $_ );
                my $name = $id eq '_all' ? "all_triggers" : "other_triggers";
                my $scope = $id eq '_all' ? "system" : "blog:$id";
                my $d = $plugin->get_config_value($name, $scope);
                next unless exists $d->{$trigger}{$blog_id};
                delete $d->{$trigger}{$blog_id};
                $plugin->set_config_value($name, $d, $scope);
            }
        }
        foreach ( split ( /\|/, $rebuild_triggers ) ) {
            my ($action, $id, $trigger) = split ( /:/, $_ );
            my $name = $id eq '_all' ? "all_triggers" : "other_triggers";
            my $scope = $id eq '_all' ? "system" : "blog:$id";
            my $d = $plugin->get_config_value($name, $scope) || {};
            $d->{$trigger}{$blog_id}{$action} = 1;
            $plugin->set_config_value($name, $d, $scope);
        }
    }
}

sub reset_config {
    my $plugin = shift;
    my ($args, $scope) = @_;

    if ( $scope =~ /blog:(\d+)/ ) {
        my $blog_id = $1;

        # Get the blogs this one triggers from and update them
        # And then save the triggers this blog runs
        my $other_triggers =
            $plugin->get_config_value( 'other_triggers', $scope );
        my $rebuild_triggers =
            $plugin->get_config_value( 'rebuild_triggers', $scope );
        my $all_triggers =
            $plugin->get_config_value( 'all_triggers', 'system' );

        foreach ( split ( /\|/, $rebuild_triggers ) ) {
            my ( $action, $id, $trigger ) = split ( /:/, $_ );
            next if $id eq '_all';
            my $d = $plugin->get_config_value( 'other_triggers', "blog:$id" );
            delete $d->{$trigger}{$blog_id}
                if exists $d->{$trigger}{$blog_id};
            $plugin->set_config_value( 'other_triggers', $d, "blog:$id" );
        }
        # remove this blog from the 'all_triggers'
        if ($all_triggers) {
            my $changed = 0;
            foreach my $trigger (keys %$all_triggers) {
                if (exists $all_triggers->{$trigger}{$blog_id}) {
                    delete $all_triggers->{$trigger}{$blog_id};
                    $changed = 1;
                }
            }
            if ($changed) {
                $plugin->set_config_value('all_triggers', $all_triggers, 'system');
            }
        }
        $plugin->SUPER::reset_config(@_);
        $plugin->set_config_value( 'other_triggers', $other_triggers,
            "blog:$blog_id" );
    }
    else {
        # reset should not alter the 'all_triggers' element which is
        # configured through the blog-level settings
        my $all_triggers = $plugin->get_config_value('all_triggers');
        $plugin->SUPER::reset_config(@_);
        $plugin->set_config_value('all_triggers', $all_triggers, 'system');
    }
}

1;
