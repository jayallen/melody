package TypePadAntiSpam::Plugin;
use strict;
use base qw(MT::Plugin);

sub stats_widget {
    my $app = shift;
    my ( $tmpl, $param ) = @_;
    my $plugin = MT->component('TypePadAntiSpam');
    my $blog   = $app->blog;
    if ($blog) {
        $param->{'blog_blocked'} = $plugin->blocked($blog) || 0;
    }
    $param->{'system_blocked'} = $plugin->blocked();
    $param->{'language'} = lc substr( MT->instance->current_language, 0, 2 );
    $param->{'use_ssl'}  = $app->is_secure;
    $param->{'api_key'}  = $plugin->api_key;
    return;
}

sub default_widgets {

    # FIXME: This should come from the app
    return {
             'blog_stats' =>
               { param => { tab => 'entry' }, order => 1, set => 'main' },
             'this_is_you-1' => { order => 1, set => 'sidebar' },
             'mt_shortcuts'  => { order => 2, set => 'sidebar' },
             'mt_news'       => { order => 3, set => 'sidebar' },
    };
}

sub save_config {
    my $plugin = shift;
    my ( $args, $scope ) = @_;

    my $app = MT->instance;

    $scope ||= 'system';
    if ( $scope eq 'system' ) {
        my $existing_api_key = $plugin->api_key || '';
        my $new_api_key      = $args->{api_key} || '';
        if ( ( $new_api_key ne '' ) && ( $new_api_key ne $existing_api_key ) )
        {

            # user assigned a new API key
            $plugin->require_tpas;
            local $MT::TypePadAntiSpam::SERVICE_HOST = $args->{service_host}
              if $args->{service_host};
            my $url = $app->base . $app->mt_uri;
            my $res = MT::TypePadAntiSpam->verify( $new_api_key, $url );
            if ( $res->http_status >= 500 ) {
                return
                  $plugin->error(
                    $plugin->translate(
                        "Failed to verify your TypePad AntiSpam API key: [_1]",
                        $res->http_response->message
                    )
                  );
            }
            elsif ( $res->status != 1 ) {
                return
                  $plugin->error(
                      $plugin->translate(
                          "The TypePad AntiSpam API key provided is invalid.")
                  );
            }
        } ## end if ( ( $new_api_key ne...))
    } ## end if ( $scope eq 'system')

    my $result = $plugin->SUPER::save_config(@_);
    return $result if MT->version_number < 4;

    my $user = $app->user;
    my $blog_id = $app->blog->id if $app->blog;

    my $widget_store = $user->widgets();
    if ( $widget_store && %$widget_store ) {
        my $sys_db = $widget_store->{'dashboard:system'}
          ||= default_widgets();
        my $blog_db = $widget_store->{ 'dashboard:blog:' . $blog_id }
          ||= default_widgets()
          if $blog_id;

        my $changed = 0;
        if ( $blog_id && ( !exists $blog_db->{'typepadantispam'} ) ) {
            $blog_db->{'typepadantispam'} = {
                       order => 2.1,        # following mt shortcuts, if shown
                       set   => 'sidebar'
            };
            $changed++;
        }
        if ( !exists $sys_db->{'typepadantispam'} ) {
            $sys_db->{'typepadantispam'} = {
                       order => 2.1,        # following mt shortcuts, if shown
                       set   => 'sidebar'
            };
            $changed++;
        }
        if ($changed) {
            $user->widgets($widget_store);
            $user->save;
        }
    } ## end if ( $widget_store && ...)

    return $result;
} ## end sub save_config

sub typepadantispam_score {
    my $thing  = shift;
    my $plugin = MT->component('TypePadAntiSpam');
    $plugin->require_tpas;
    my $key = is_valid_key($thing) or return MT::JunkFilter::ABSTAIN();
    my $sig = package_signature( $thing, 1 )
      or return MT::JunkFilter::ABSTAIN();
    my $res = MT::TypePadAntiSpam->check( $sig, $key );
    my $http_resp = $res->http_response;
    if ( $http_resp && !$http_resp->is_success ) {
        MT->log( "TypePad AntiSpam error: " . $http_resp->message );
    }
    elsif ( !$http_resp ) {
        if ( MT::TypePadAntiSpam->errstr ) {
            MT->log(
                   "TypePad AntiSpam error: " . MT::TypePadAntiSpam->errstr );
        }
    }
    return MT::JunkFilter::ABSTAIN()
      unless $res && $res->http_response->is_success;
    my $weight
      = $plugin->get_config_value( 'weight', 'blog:' . $thing->blog_id ) || 1;
    my ( $score, $grade )
      = $res->status ? ( $weight, 'ham' ) : ( -$weight, 'spam' );
    ( $score, ["TypePad AntiSpam says $grade"] );
} ## end sub typepadantispam_score


sub description {
    my $plugin = shift;
    my $app    = MT->instance;
    my $blog;
    if ( $app->isa('MT::App::CMS') ) {
        $blog = $app->blog;
    }
    my $sys_blocked = $plugin->blocked();
    my $desc
      = '<p>'
      . $plugin->translate(
        'TypePad AntiSpam is a free service from Six Apart that helps protect your blog from comment and TrackBack spam. The TypePad AntiSpam plugin will send every comment or TrackBack submitted to your blog to the service for evaluation, and Movable Type will filter items if TypePad AntiSpam determines it is spam. If you discover that TypePad AntiSpam incorrectly classifies an item, simply change its classification by marking it as "Spam" or "Not Spam" from the Manage Comments screen, and TypePad AntiSpam will learn from your actions. Over time the service will improve based on reports from its users, so take care when marking items as "Spam" or "Not Spam."'
      ) . '</p>';

    if ($blog) {
        my $blog_blocked = $blog ? $plugin->blocked($blog) : 0;
        $desc .= '<p>'
          . $plugin->translate(
            'So far, TypePad AntiSpam has blocked [quant,_1,message,messages] for this blog, and [quant,_2,message,messages] system-wide.',
            $blog_blocked, $sys_blocked
          ) . '</p>';
    }
    else {
        $desc .= '<p>'
          . $plugin->translate(
            'So far, TypePad AntiSpam has blocked [quant,_1,message,messages] system-wide.',
            $sys_blocked
          ) . '</p>';
    }
    return $desc;
} ## end sub description

#--- utility

sub is_valid_key {
    my $thing  = shift;
    my $r      = MT->request;
    my $plugin = MT->component('TypePadAntiSpam');
    unless ( $r->stash('MT::Plugin::TypePadAntiSpam::api_key') ) {
        my $key = $plugin->api_key || return;
        $r->stash( 'MT::Plugin::TypePadAntiSpam::api_key', $key );
    }
    $r->stash('MT::Plugin::TypePadAntiSpam::api_key');
}

sub require_tpas {
    my $plugin = shift;
    require MT::TypePadAntiSpam;

    my $host = $plugin->get_config_value('service_host');
    if ($host) {
        $MT::TypePadAntiSpam::SERVICE_HOST = $host;
    }
}


sub cache {
    my $id    = shift;
    my $cache = MT->request->stash('MT::Plugin::TypePadAntiSpam::permalinks');
    unless ($cache) {
        $cache = {};
        MT->request->stash( 'MT::Plugin::TypePadAntiSpam::permalinks',
                            $cache );
    }
    unless ( $cache->{$id} ) {
        if ( $id =~ /^B/ ) {
            my $b = MT::Blog->load( substr( $id, 1 ) ) or return;
            $cache->{$id} = $b->site_url;
        }
        else {
            require MT::Entry;
            my $e = MT::Entry->load($id) or return;
            $cache->{$id} = $e->permalink;
        }
    }
    $cache->{$id};
} ## end sub cache


sub package_signature {
    my $thing              = shift;
    my ($include_referrer) = @_;
    my $sig                = MT::TypePadAntiSpam::Signature->new;
    if ($include_referrer) {
        $sig->user_agent( $ENV{HTTP_USER_AGENT} );
        $sig->referrer( $ENV{HTTP_REFERER} );
    }
    $sig->user_ip( $thing->ip );
    $sig->blog( cache( 'B' . $thing->blog_id ) );
    if ( ref $thing eq 'MT::Comment' ) {
        my $entry = $thing->entry;
        $sig->article_date( MT->version_number < 4
                            ? $entry->created_on
                            : $entry->authored_on );
        $sig->permalink( $entry->permalink );
        $sig->comment_type('comment');
        $sig->comment_author( $thing->author );
        $sig->comment_author_email( $thing->email );
        $sig->comment_author_url( $thing->url );
        $sig->comment_content( $thing->text );
    }
    elsif ( ref $thing eq 'MT::TBPing' ) {
        my $p = $thing->parent;
        if ( $p->isa('MT::Entry') ) {
            $sig->article_date(
                  MT->version_number < 4 ? $p->created_on : $p->authored_on );
            $sig->permalink( $p->permalink );
        }
        $sig->comment_type('trackback');
        $sig->comment_author( $thing->blog_name );
        $sig->comment_author_url( $thing->source_url );
        $sig->comment_content( join "\n", $thing->title, $thing->excerpt );
    }
    else {
        return;    # don't know what this is.
    }
    $sig;
} ## end sub package_signature

sub api_key {
    my $plugin = shift;
    my $blog   = shift;
    if (@_) {
        my $key = shift;
        $plugin->set_config_value( 'api_key', $key );
    }
    else {
        return $plugin->get_config_value('api_key');
    }
}


sub blocked {
    my $plugin = shift;
    my $blog   = shift;
    my $blog_id
      = ( ref($blog) && $blog->isa('MT::Blog') ) ? $blog->id : $blog;
    my $blocked =
      $plugin->get_config_value( 'blocked',
                                 $blog_id ? 'blog:' . $blog_id : 'system' );
    return $blocked || 0 unless @_;
    my ($count) = @_;
    $plugin->set_config_value( 'blocked', $count,
                               $blog_id ? 'blog:' . $blog_id : 'system' );
    return $count;
}

1;
