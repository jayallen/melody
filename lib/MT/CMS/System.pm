package MT::CMS::System;

use strict;
use Symbol;

use MT::I18N qw( encode_text wrap_text );
use MT::Util
  qw( encode_url encode_html decode_html encode_js trim remove_html is_valid_email );

sub cfg_system_settings {
    my $app = shift;
    my $q = $app->query();
    my %param;
    if ( $q->param('blog_id') ) {
        return $app->return_to_dashboard( redirect => 1 );
    }

    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();

    my $cfg = $app->config;
    $app->init_config()
      ;    # TODO - not sure why this is needed, but without it, not all
           #        config preferences are loaded (e.g. DefaultTimezone)

    $param{languages}
      = $app->languages_list( $app->config('DefaultUserLanguage') );
    my $tag_delim = $app->config('DefaultUserTagDelimiter') || 'comma';
    $param{"tag_delim_$tag_delim"} = 1;

    ( my $tz = $cfg->DefaultTimezone ) =~ s![-\.]!_!g;
    $tz =~ s!_00$!!;
    $param{ 'server_offset_' . $tz } = 1;

    $param{default_site_root} = $app->config('DefaultSiteRoot');
    $param{default_site_url}  = $app->config('DefaultSiteURL');
    $param{personal_weblog_readonly}
      = $app->config->is_readonly('NewUserAutoProvisioning');
    $param{personal_weblog} = $app->config->NewUserAutoProvisioning ? 1 : 0;
    if ( my $id = $param{new_user_template_blog_id}
         = $app->config('NewUserTemplateBlogId') || '' )
    {
        my $blog = MT->model('blog')->load($id);
        if ($blog) {
            $param{new_user_template_blog_name} = $blog->name;
        }
        else {
            $app->config( 'NewUserTemplateBlogId', undef, 1 );
            $cfg->save_config();
            delete $param{new_user_template_blog_id};
        }
    }

    $param{system_email_address} = $cfg->EmailAddressMain;
    $param{saved}                = $q->param('saved');
    $param{error}                = $q->param('error');
    $param{screen_class}         = "settings-screen system-general-settings";

    my $registration = $cfg->CommenterRegistration;
    if ( $registration->{Allow} ) {
        $param{registration} = 1;
        if ( my $ids = $registration->{Notify} ) {
            my @ids = split ',', $ids;
            my @sysadmins = MT->model('author')->load(
                                { id => \@ids, type => MT::Author::AUTHOR() },
                                {
                                  join =>
                                    MT::Permission->join_on(
                                         'author_id',
                                         {
                                           permissions => "\%'administer'\%",
                                           blog_id     => '0',
                                         },
                                         { 'like' => { 'permissions' => 1 } }
                                    )
                                }
            );
            my @names;
            foreach my $a (@sysadmins) {
                push @names, $a->name . '(' . $a->id . ')';
            }
            $param{notify_user_id} = $ids;
            $param{notify_user_name} = join ',', @names;
        } ## end if ( my $ids = $registration...)
    } ## end if ( $registration->{Allow...})

    $param{comment_disable}      = $cfg->AllowComments            ? 0 : 1;
    $param{ping_disable}         = $cfg->AllowPings               ? 0 : 1;
    $param{disabled_notify_ping} = $cfg->DisableNotificationPings ? 1 : 0;
    $param{system_no_email} = 1 unless $cfg->EmailAddressMain;
    my $send = $cfg->OutboundTrackbackLimit || 'any';

    if ( $send =~ m/^(any|off|selected|local)$/ ) {
        $param{ "trackback_send_" . $cfg->OutboundTrackbackLimit } = 1;
        if ( $send eq 'selected' ) {
            my @domains = $cfg->OutboundTrackbackDomains;
            my $domains = join "\n", @domains;
            $param{trackback_send_domains} = $domains;
        }
    }
    else {
        $param{"trackback_send_any"} = 1;
    }

    # TODO - move this to its own handler and forward back here
    if ( $q->param('to_email_address') ) {
        return $app->errtrans(
            "You don't have a system email address configured.  Please set this first, save it, then try the test email again."
        ) unless ( $cfg->EmailAddressMain );
        return $app->errtrans("Please enter a valid email address")
          unless ( is_valid_email( $q->param('to_email_address') ) );

        my %head = (
                    To      => $q->param('to_email_address'),
                    From    => $cfg->EmailAddressMain,
                    Subject => $app->translate("Test email from Movable Type")
        );

        my $body
          = $app->translate(
            "This is the test email sent by your installation of Movable Type."
          );

        require MT::Mail;
        MT::Mail->send( \%head, $body )
          or
          return $app->error( $app->translate("Mail was not properly sent") );

        $app->log( {
                     message =>
                       $app->translate(
                                  'Test e-mail was successfully sent to [_1]',
                                  $q->param('to_email_address')
                       ),
                     level => MT::Log::INFO(),
                     class => 'system',
                   }
        );
        $param{test_mail_sent} = 1;
    } ## end if ( $q->param('to_email_address'...))

    my @config_warnings;
    for my $config_directive (
                          qw( EmailAddressMain DebugMode PerformanceLogging
                          PerformanceLoggingPath PerformanceLoggingThreshold )
      )
    {
        push( @config_warnings, $config_directive )
          if $app->config->is_readonly($config_directive);
    }
    my $config_warning = join( ", ", @config_warnings ) if (@config_warnings);

    $param{config_warning} =
      $app->translate(
        "These setting(s) are overridden by a value in the MT configuration file: [_1]. Remove the value from the configuration file in order to control the value on this page.",
        $config_warning
      ) if $config_warning;
    $param{system_email_address}            = $cfg->EmailAddressMain;
    $param{system_debug_mode}               = $cfg->DebugMode;
    $param{system_performance_logging}      = $cfg->PerformanceLogging;
    $param{system_performance_logging_path} = $cfg->PerformanceLoggingPath;
    $param{system_performance_logging_threshold}
      = $cfg->PerformanceLoggingThreshold;
    $param{track_revisions}                 = $cfg->TrackRevisions;
    $param{saved}        = $q->param('saved');
    $param{error}        = $q->param('error');
    $param{screen_class} = "settings-screen system-general-settings";
    $app->load_tmpl( 'cfg_system_settings.tmpl', \%param );
} ## end sub cfg_system_settings

sub save_cfg_system {
    my $app = shift;
    my $q = $app->query();
    $app->validate_magic or return;
    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();

    my $cfg = $app->config;

    my @meta_messages = ();

    # BEGIN Save General Preferences
    # construct the message to the activity log
    push(
          @meta_messages,
          $app->translate(
                           'Email address is [_1]',
                           $q->param('system_email_address')
          )
    ) if ( $q->param('system_email_address') =~ /\w+/ );
    push(
          @meta_messages,
          $app->translate(
                           'Debug mode is [_1]',
                           $q->param('system_debug_mode')
          )
    ) if ( $q->param('system_debug_mode') =~ /\d+/ );
    if ( $q->param('system_performance_logging') ) {
        push( @meta_messages, $app->translate('Performance logging is on') );
    }
    else {
        push( @meta_messages, $app->translate('Performance logging is off') );
    }
    push(
          @meta_messages,
          $app->translate(
                           'Performance log path is [_1]',
                           $q->param('system_performance_logging_path')
          )
    ) if ( $q->param('system_performance_logging_path') =~ /\w+/ );
    push(
          @meta_messages,
          $app->translate(
                           'Performance log threshold is [_1]',
                           $q->param(
                                       'system_performance_logging_threshold')
          )
    ) if ( $q->param('system_performance_logging_threshold') =~ /\d+/ );

    # actually assign the changes
    $app->config( 'EmailAddressMain',
                  $q->param('system_email_address') || undef, 1 );
    $app->config( 'DebugMode', $q->param('system_debug_mode'), 1 )
      if ( $q->param('system_debug_mode') =~ /\d+/ );
    if ( $q->param('system_performance_logging') ) {
        $app->config( 'PerformanceLogging', 1, 1 );
    }
    else {
        $app->config( 'PerformanceLogging', 0, 1 );
    }
    $app->config( 'PerformanceLoggingPath',
                  $q->param('system_performance_logging_path'), 1 )
      if ( $q->param('system_performance_logging_path') =~ /\w+/ );
    $app->config( 'PerformanceLoggingThreshold',
                  $q->param('system_performance_logging_threshold'), 1 )
      if ( $q->param('system_performance_logging_threshold') =~ /\d+/ );
    if ($q->param('track_revisions')) {
        push( @meta_messages, 'Revision histories are enabled.' );
        $app->config('TrackRevisions', 1, 1);
    } else {
        push( @meta_messages, 'Revision histories will not be recorded.' );
        $app->config('TrackRevisions', 0, 1);
    }


    # END Save General Preferences

    # BEGIN Save Feedback Preferences
    if ( $q->param('comment_disable') ) {
        push( @meta_messages, 'Allow comments is on' );
    }
    else {
        push( @meta_messages, 'Allow comments is off' );
    }
    if ( $q->param('ping_disable') ) {
        push( @meta_messages, 'Allow trackbacks is on' );
    }
    else {
        push( @meta_messages, 'Allow trackbacks is off' );
    }
    if ( $q->param('disable_notify_ping') ) {
        push( @meta_messages, 'Allow outbound trackbacks is on' );
    }
    else {
        push( @meta_messages, 'Allow outbound trackbacks is off' );
    }
    push( @meta_messages,
          'Outbound trackback limit is ' . $q->param('trackback_send') )
      if ( $q->param('trackback_send') =~ /\w+/ );

    # actually assign the changes
    $cfg->AllowComments( ( $q->param('comment_disable') ? 0 : 1 ), 1 );
    $cfg->AllowPings( ( $q->param('ping_disable') ? 0 : 1 ), 1 );
    $cfg->DisableNotificationPings( (
                                       $q->param('disable_notify_ping')
                                       ? 1
                                       : 0
                                    ),
                                    1
    );
    my $send = $q->param('trackback_send') || 'any';
    if ( $send =~ m/^(any|off|selected|local)$/ ) {
        $cfg->OutboundTrackbackLimit( $send, 1 );
        if ( $send eq 'selected' ) {
            my $domains = $q->param('trackback_send_domains') || '';
            $domains =~ s/[\r\n]+/ /gs;
            $domains =~ s/\s{2,}/ /gs;
            my @domains = split /\s/, $domains;
            $cfg->OutboundTrackbackDomains( \@domains, 1 );
        }
    }

    # END Save Feedback Preferences

    # BEGIN Save User Preferences
    my $tmpl_blog_id = $q->param('new_user_template_blog_id') || '';
    if ( $tmpl_blog_id =~ m/^\d+$/ ) {
        MT->model('blog')->load($tmpl_blog_id)
          or return
          $app->error(
                    $app->translate(
                        "Invalid ID given for personal blog clone source ID.")
          );
    }
    else {
        if ( $tmpl_blog_id ne '' ) {
            return
              $app->error(
                    $app->translate(
                        "Invalid ID given for personal blog clone source ID.")
              );
        }
    }

    my $tz = $q->param('default_time_zone') || undef;
    $cfg->DefaultTimezone($tz);
    $cfg->DefaultSiteRoot( $q->param('default_site_root') || undef, 1 );
    $cfg->DefaultSiteURL( $q->param('default_site_url') || undef, 1 );
    $cfg->NewUserAutoProvisioning( $q->param('personal_weblog') ? 1 : 0,
                                   1 );
    $cfg->NewUserTemplateBlogId( $tmpl_blog_id || undef, 1 );
    $cfg->DefaultUserLanguage( $q->param('default_language'), 1 );
    $cfg->DefaultUserTagDelimiter( $q->param('default_user_tag_delimiter')
                                               || undef,
                                   1 );

    my $registration = $cfg->CommenterRegistration;
    if ( my $reg = $q->param('registration') ) {
        $registration->{Allow} = $reg ? 1 : 0;
        $registration->{Notify} = $q->param('notify_user_id');
        $cfg->CommenterRegistration( $registration, 1 );
    }
    elsif ( $registration->{Allow} ) {
        $registration->{Allow} = 0;
        $cfg->CommenterRegistration( $registration, 1 );
    }

    # END Save User Preferences

    # throw the messages in the activity log
    if ( scalar(@meta_messages) > 0 ) {
        my $message = join( ', ', @meta_messages );
        $app->log( {
                     message  => 'System Settings Changes Took Place',
                     level    => MT::Log::INFO(),
                     class    => 'system',
                     metadata => $message,
                   }
        );
    }

    $cfg->save_config();

    my $args = ();

    if ( $cfg->NewUserAutoProvisioning() ne
         ( $q->param('personal_weblog') ? 1 : 0 ) )
    {
        $args->{error}
          = $app->translate(
            'If personal blog is set, the default site URL and root are required.'
          );
    }
    else {
        $args->{saved} = 1;
    }

    $app->redirect(
                $app->uri( 'mode' => 'cfg_system_settings', args => $args ) );

} ## end sub save_cfg_system

1;

__END__

=head1 NAME

MT::CMS::System

=head1 METHODS

=head2 cfg_system_settings

=head2 save_cfg_system

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
