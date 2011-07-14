package MT::CMS::Tools;

use strict;
use Symbol;

use MT::I18N qw( encode_text wrap_text );
use MT::Util
  qw( encode_url encode_html decode_html encode_js trim remove_html );

sub system_info {
    my $app = shift;

    if ( my $blog_id = $app->query->param('blog_id') ) {
        return
          $app->redirect(
                          $app->uri(
                                     'mode' => 'view_log',
                                     args   => { blog_id => $blog_id }
                          )
          );
    }

    my %param;

    # licensed user count: someone who has logged in within 90 days
    my $sess_class = $app->model('session');
    my $from = time - ( 60 * 60 * 24 * 90 + 60 * 60 * 24 );
    $sess_class->remove( { kind => 'UA', start => [ undef, $from ] },
                         { range => { start => 1 } } );
    $param{licensed_user_count} = $sess_class->count( { kind => 'UA' } );

    my $author_class = $app->model('author');
    $param{user_count}
      = $author_class->count( { type => MT::Author::AUTHOR() } );

    $param{commenter_count} = q[N/A];
    $param{screen_id}       = "system-check";

    require MT::Memcached;
    if ( MT::Memcached->is_available ) {
        $param{memcached_enabled} = 1;
        my $inst = MT::Memcached->instance;
        my $key  = 'syscheck-' . $$;
        $inst->add( $key, $$ );
        if ( $inst->get($key) == $$ ) {
            $inst->delete($key);
            $param{memcached_active} = 1;
        }
    }

    $param{server_modperl} = 1 if $ENV{MOD_PERL};
    $param{server_fastcgi} = 1 if $ENV{FAST_CGI};

    $param{syscheck_html} = get_syscheck_content($app) || '';

    $app->load_tmpl( 'system_check.tmpl', \%param );
} ## end sub system_info

sub sanity_check {
    my $app = shift;

# Needed?
#    if ( my $blog_id = $app->param('blog_id') ) {
#        return $app->redirect(
#            $app->uri(
#                'mode' => 'view_log',
#                args => { blog_id => $blog_id }
#            )
#        );
#    }

    my %param;

    # licensed user count: someone who has logged in within 90 days
    $param{screen_id} = "system-check";

    $param{syscheck_html} = get_syscheck_content($app) || '';

    $app->load_tmpl( 'sanity_check.tmpl', \%param );
} ## end sub sanity_check

sub resources {
    my $app = shift;
    my $q   = $app->query;
    my %param;
    $param{screen_class} = 'settings-screen';

    my $cfg = $app->config;
    $param{can_config}  = $app->user->can_manage_plugins;
    $param{use_plugins} = $cfg->UsePlugins;
    build_resources_table( $app, param => \%param, scope => 'system' );
    $param{nav_config}   = 1;
    $param{nav_settings} = 1;
    $param{nav_plugins}  = 1;
    $param{mod_perl}     = 1 if $ENV{MOD_PERL};
    $param{screen_id}    = "list-plugins";
    $param{screen_class} = "plugin-settings";

    $app->load_tmpl( 'resources.tmpl', \%param );
}

sub get_syscheck_content {
    my $app = shift;

    my $syscheck_url
      = $app->base
      . $app->mt_path
      . $app->config('CheckScript')
      . '?view=tools&version='
      . MT->version_id;
    if ( $syscheck_url && $syscheck_url ne 'disable' ) {
        my $ua = $app->new_ua( { timeout => 20 } );
        return unless $ua;
        $ua->max_size(undef) if $ua->can('max_size');

        my $req = new HTTP::Request( GET => $syscheck_url );
        my $resp = $ua->request($req);
        return unless $resp->is_success();
        my $result = $resp->content();

        return $result;
    }
} ## end sub get_syscheck_content

sub start_recover {
    my $app     = shift;
    my $q       = $app->query;
    my ($param) = @_;
    my $cfg     = $app->config;
    $param ||= {};
    $param->{'email'} = $q->param('email');
    $param->{'return_to'} = $q->param('return_to') || $cfg->ReturnToURL || '';
    if ( $param->{recovered} ) {
        $param->{return_to} = MT::Util::encode_js( $param->{return_to} );
    }
    $param->{'can_signin'} = ( ref $app eq 'MT::App::CMS' ) ? 1 : 0;
    $app->add_breadcrumb( $app->translate('Password Recovery') );

    my $blog_id = $q->param('blog_id');
    $param->{'blog_id'} = $blog_id;
    my $tmpl = $app->load_global_tmpl( {
                          identifier => 'new_password_reset_form',
                          $blog_id ? ( blog_id => $q->param('blog_id') ) : ()
                        }
    );
    if ( !$tmpl ) {
        $tmpl = $app->load_tmpl('cms/dialog/recover.tmpl');
    }
    $param->{system_template} = 1;
    $tmpl->param($param);
    return $tmpl;
} ## end sub start_recover

sub recover_password {
    my $app      = shift;
    my $q        = $app->query;
    my $email    = $q->param('email') || '';
    my $username = $q->param('name');

    $email = trim($email);
    $username = trim($username) if $username;

    if ( !$email ) {
        return
          $app->start_recover( {
                     error =>
                       $app->translate(
                          'Email Address is required for password recovery.'),
                   }
          );
    }

    # Searching user by email (and username)
    my $class
      = ref $app eq 'MT::App::Upgrader'
      ? 'MT::BasicAuthor'
      : $app->model('author');
    eval "use $class;";

    my @all_authors = $class->load(
            { email => $email, ( $username ? ( name => $username ) : () ) } );
    my @authors;
    my $user;
    foreach (@all_authors) {
        next unless $_->password && ( $_->password ne '(none)' );
        push( @authors, $_ );
    }
    if ( !@authors ) {
        return
          $app->start_recover( {
                              error => $app->translate('User not found'),
                              ( $username ? ( not_unique_email => 1 ) : () ),
                            }
          );
    }
    elsif ( @authors > 1 ) {
        return $app->start_recover( { not_unique_email => 1, } );
    }
    $user = pop @authors;

    # Generate Token
    require MT::Util::Captcha;
    my $salt = MT::Util::Captcha->_generate_code(8);
    my $expires = time + ( 60 * 60 );
    my $token = MT::Util::perl_sha1_digest_hex(
                               $salt . $expires . $app->config->SecretToken );

    $user->password_reset($salt);
    $user->password_reset_expires($expires);
    $user->password_reset_return_to( $q->param('return_to') )
      if $q->param('return_to');
    $user->save;

    # Send mail to user
    my %head = (
                 id      => 'recover_password',
                 To      => $email,
                 From    => $app->config('EmailAddressMain') || $email,
                 Subject => $app->translate("Password Recovery")
    );
    my $charset = $app->charset;
    my $mail_enc = uc( $app->config('MailEncoding') || $charset );
    $head{'Content-Type'} = qq(text/plain; charset="$mail_enc");

    my $blog_id = $q->param('blog_id');
    my $body = $app->build_email(
                                 'recover-password',
                                 {
                                       link_to_login => $app->base
                                     . $app->uri
                                     . "?__mode=new_pw&token=$token&email="
                                     . encode_url($email)
                                     . (
                                        $blog_id ? "&blog_id=$blog_id" : '' ),
                                 }
    );

    require MT::Mail;
    MT::Mail->send( \%head, $body )
      or return
      $app->error(
                $app->translate(
                    "Error sending mail ([_1]); please fix the problem, then "
                      . "try again to recover your password.",
                    MT::Mail->errstr
                )
      );

    return $app->start_recover( { recovered => 1, } );
} ## end sub recover_password

sub new_password {
    my $app     = shift;
    my $q       = $app->query;
    my ($param) = @_;
    $param ||= {};
    my $token = $q->param('token');
    if ( !$token ) {
        return $app->start_recover(
            { error => $app->translate('Password reset token not found'), } );
    }

    my $email = $q->param('email');
    if ( !$email ) {
        return $app->start_recover(
                   { error => $app->translate('Email address not found'), } );
    }

    my $class = $app->model('author');
    my @users = $class->load( { email => $email } );
    if ( !@users ) {
        return $app->start_recover(
                            { error => $app->translate('User not found'), } );
    }

    # comparing token
    require MT::Util::Captcha;
    my $user;
    for my $u (@users) {
        my $salt    = $u->password_reset;
        my $expires = $u->password_reset_expires;
        my $compare = MT::Util::perl_sha1_digest_hex(
                               $salt . $expires . $app->config->SecretToken );
        if ( $compare eq $token ) {
            if ( time > $u->password_reset_expires ) {
                return
                  $app->start_recover( {
                       error =>
                         $app->translate(
                           'Your request to change your password has expired.'
                         ),
                    }
                  );
            }
            $user = $u;
            last;
        }
    } ## end for my $u (@users)

    if ( !$user ) {
        return $app->start_recover(
            { error => $app->translate('Invalid password reset request'), } );
    }

    # Password reset
    my $new_password = $q->param('password');
    if ($new_password) {
        my $again = $q->param('password_again');
        if ( !$again ) {
            $param->{'error'}
              = $app->translate('Please confirm your new password');
        }
        elsif ( $new_password ne $again ) {
            $param->{'error'} = $app->translate('Passwords do not match');
        }
        else {
            my $redirect = $user->password_reset_return_to || '';

            $user->set_password($new_password);
            $user->password_reset(undef);
            $user->password_reset_expires(undef);
            $user->password_reset_return_to(undef);
            $user->save;
            $q->param( 'username', $user->name )
              if $user->type == MT::Author::AUTHOR();

            if ( ref $app eq 'MT::App::CMS' && !$redirect ) {
                $app->login;
                return $app->return_to_dashboard( redirect => 1 );
            }
            else {
                if ( !$redirect ) {
                    my $cfg = $app->config;
                    $redirect = $cfg->ReturnToURL || '';
                }
                $app->make_commenter_session($user);
                if ($redirect) {
                    return $app->redirect( MT::Util::encode_html($redirect) );
                }
                else {
                    return $app->redirect_to_edit_profile();
                }
            }
        } ## end else [ if ( !$again ) ]
    } ## end if ($new_password)

    $param->{'email'}          = $email;
    $param->{'token'}          = $token;
    $param->{'password'}       = $q->param('password');
    $param->{'password_again'} = $q->param('password_again');
    $app->add_breadcrumb( $app->translate('Password Recovery') );

    my $blog_id = $q->param('blog_id');
    $param->{'blog_id'} = $blog_id if $blog_id;
    my $tmpl = $app->load_global_tmpl( {
                          identifier => 'new_password',
                          $blog_id ? ( blog_id => $q->param('blog_id') ) : ()
                        }
    );
    if ( !$tmpl ) {
        $tmpl = $app->load_tmpl('cms/dialog/new_password.tmpl');
    }
    $param->{system_template} = 1;
    $tmpl->param($param);
    return $tmpl;
} ## end sub new_password

sub do_list_action {
    my $app = shift;
    my $q   = $app->query;
    $app->validate_magic or return;

    # plugin_action_selector should always (?) be in the query; use it?
    my $action_name = $q->param('action_name');
    my $type        = $q->param('_type');
    my ($the_action)
      = ( grep { $_->{key} eq $action_name } @{ $app->list_actions($type) } );
    return
      $app->errtrans( "That action ([_1]) is apparently not implemented!",
                      $action_name )
      unless $the_action;

    unless ( ref( $the_action->{code} ) ) {
        if ( my $plugin = $the_action->{plugin} ) {
            $the_action->{code}
              = $app->handler_to_coderef(    $the_action->{handler}
                                          || $the_action->{code} );
        }
    }

    if ( $q->param('all_selected') ) {
        my $blog_id = $q->param('blog_id');
        my $blog    = $app->blog;
        my $debug   = {};
        my $filteritems;
        ## TBD: use decode_js or something for decode js_string generated by jQuery.json.
        if ( my $items = $q->param('items') ) {
            if ( $items =~ /^".*"$/ ) {
                $items =~ s/^"//;
                $items =~ s/"$//;
                $items =~ s/\\"/"/g;
            }
            require JSON;
            my $json = JSON->new->utf8(0);
            $filteritems = $json->decode($items);
        }
        else {
            $filteritems = [];
        }
        my $filter = MT->model('filter')->new;
        $filter->set_values( {
                               object_ds => $type,
                               items     => $filteritems,
                               author_id => $app->user->id,
                               blog_id   => $blog->id,
                             }
        );
        my @objs = $filter->load_objects(

#            blog_id   => $blog->is_blog ? $blog_id : [ $blog->id, map { $_->id } @{$blog->blogs} ],
            blog_id => $blog ? $blog_id : 0,
        );
        $q->param( 'id', map { $_->id } @objs );
    } ## end if ( $q->param('all_selected'...))
    $the_action->{code}->($app);
} ## end sub do_list_action

sub do_page_action {
    my $app = shift;
    my $q   = $app->query;

    # plugin_action_selector should always (?) be in the query; use it?
    my $action_name = $q->param('action_name');
    my $type        = $q->param('_type');
    my ($the_action)
      = ( grep { $_->{key} eq $action_name } @{ $app->page_actions($type) } );
    return
      $app->errtrans( "That action ([_1]) is apparently not implemented!",
                      $action_name )
      unless $the_action;

    unless ( ref( $the_action->{code} ) ) {
        if ( my $plugin = $the_action->{plugin} ) {
            $the_action->{code}
              = $app->handler_to_coderef(    $the_action->{handler}
                                          || $the_action->{code} );
        }
    }
    $the_action->{code}->($app);
} ## end sub do_page_action

sub upgrade {
    my $app = shift;

    # check for an empty database... no author table would do it...
    my $driver         = MT::Object->driver;
    my $upgrade_script = $app->config('UpgradeScript');
    my $user_class     = MT->model('author');
    if ( !$driver || !$driver->table_exists($user_class) ) {
        return $app->redirect(   $app->path
                               . $upgrade_script
                               . $app->uri_params( mode => 'install' ) );
    }

    return $app->redirect( $app->path . $upgrade_script );
}

sub recover_profile_password {
    my $app = shift;
    $app->validate_magic or return;
    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();

    my $q = $app->query;

    require MT::Auth;
    require MT::Log;
    if ( !MT::Auth->can_recover_password ) {
        $app->log( {
               message =>
                 $app->translate(
                   "Invalid password recovery attempt; can't recover password in this configuration"
                 ),
               level    => MT::Log::SECURITY(),
               class    => 'system',
               category => 'recover_profile_password',
            }
        );
        return $app->error("Can't recover password in this configuration");
    }

    my $author_id = $q->param('author_id');
    my $author    = MT::Author->load($author_id);

    return $app->error( $app->translate("Invalid author_id") )
      if !$author || $author->type != MT::Author::AUTHOR() || !$author_id;

    my ( $rc, $res )
      = reset_password( $app, $author, $author->hint, $author->name );

    if ($rc) {
        my $url = $app->uri(
               'mode' => 'view',
               args => { _type => 'author', recovered => 1, id => $author_id }
        );
        $app->redirect($url);
    }
    else {
        $app->error($res);
    }
} ## end sub recover_profile_password

sub convert_to_html {
    my $app       = shift;
    my $q         = $app->query;
    my $format    = $q->param('format') || '';
    my @formats   = split /\s*,\s*/, $format;
    my $text      = $q->param('text') || '';
    my $text_more = $q->param('text_more') || '';
    my $result = {
               text      => $app->apply_text_filters( $text,      \@formats ),
               text_more => $app->apply_text_filters( $text_more, \@formats ),
               format    => $formats[0],
    };
    return $app->json_result($result);
}

sub update_list_prefs {
    my $app   = shift;
    my $prefs = $app->list_pref( $app->query->param('_type') );
    $app->call_return;
}

sub recover_passwords {
    my $app = shift;
    my @id  = $app->query->param('id');

    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();

    my $class
      = ref $app eq 'MT::App::Upgrader'
      ? 'MT::BasicAuthor'
      : $app->model('author');
    eval "use $class;";

    my @msg_loop;
    foreach (@id) {
        my $author = $class->load($_) or next;
        my ( $rc, $res ) = reset_password( $app, $author, $author->hint );
        push @msg_loop, { message => $res };
    }

    $app->load_tmpl(
                     'recover_password_result.tmpl',
                     {
                        message_loop => \@msg_loop,
                        return_url   => $app->return_uri
                     }
    );
} ## end sub recover_passwords

sub reset_password {
    my $app      = shift;
    my ($author) = $_[0];
    my $hint     = $_[1];
    my $name     = $_[2];

    require MT::Auth;
    require MT::Log;
    if ( !MT::Auth->can_recover_password ) {
        $app->log( {
               message =>
                 $app->translate(
                   "Invalid password recovery attempt; can't recover password in this configuration"
                 ),
               level    => MT::Log::SECURITY(),
               class    => 'system',
               category => 'recover_password',
            }
        );
        return (
                 0,
                 $app->translate(
                               "Can't recover password in this configuration")
        );
    }

    $app->log( {
           message =>
             $app->translate(
                "Invalid user name '[_1]' in password recovery attempt", $name
             ),
           level    => MT::Log::SECURITY(),
           class    => 'system',
           category => 'recover_password',
         }
      ),
      return ( 0,
               $app->translate("User name or password hint is incorrect.") )
      unless $author;
    return (
             0,
             $app->translate(
                     "User has not set pasword hint; cannot recover password")
    ) if ( $hint && !$author->hint );

    $app->log( {
           message =>
             $app->translate(
               "Invalid attempt to recover password (used hint '[_1]')", $hint
             ),
           level    => MT::Log::SECURITY(),
           class    => 'system',
           category => 'recover_password'
        }
      ),
      return ( 0,
               $app->translate("User name or password hint is incorrect.") )
      unless $author->hint eq $hint;

    return ( 0, $app->translate("User does not have email address") )
      unless $author->email;

    # Generate Token
    require MT::Util::Captcha;
    my $salt = MT::Util::Captcha->_generate_code(8);
    my $expires = time + ( 60 * 60 );
    my $token = MT::Util::perl_sha1_digest_hex(
                               $salt . $expires . $app->config->SecretToken );

    $author->password_reset($salt);
    $author->password_reset_expires($expires);
    $author->password_reset_return_to(undef);
    $author->save;

    my $message
      = $app->translate(
        "A password reset link has been sent to [_3] for user  '[_1]' (user #[_2]).",
        $author->name, $author->id, $author->email );
    $app->log( {
                 message  => $message,
                 level    => MT::Log::SECURITY(),
                 class    => 'system',
                 category => 'recover_password'
               }
    );

    # Send mail to user
    my $email = $author->email;
    my %head = (
                 id      => 'recover_password',
                 To      => $email,
                 From    => $app->config('EmailAddressMain') || $email,
                 Subject => $app->translate("Password Recovery")
    );
    my $charset = $app->charset;
    my $mail_enc = uc( $app->config('MailEncoding') || $charset );
    $head{'Content-Type'} = qq(text/plain; charset="$mail_enc");

    my $body = $app->build_email(
                                  'recover-password',
                                  {
                                        link_to_login => $app->base
                                      . $app->uri
                                      . "?__mode=new_pw&token=$token&email="
                                      . encode_url($email),
                                  }
    );

    require MT::Mail;
    MT::Mail->send( \%head, $body )
      or return
      $app->error(
                $app->translate(
                    "Error sending mail ([_1]); please fix the problem, then "
                      . "try again to recover your password.",
                    MT::Mail->errstr
                )
      );

    ( 1, $message );
} ## end sub reset_password

sub build_resources_table {
    my $app = shift;
    my (%opt) = @_;

    my $param = $opt{param};
    my $scope = $opt{scope} || 'system';
    my $cfg   = $app->config;
    my $data  = [];

    # we have to sort the plugin list in an odd fashion...
    #   PLUGINS
    #     (those at the top of the plugins directory and those
    #      that only have 1 .pl script in a plugin folder)
    #   PLUGIN SET
    #     (plugins folders with multiple .pl files)
    my %list;
    my %folder_counts;
    for my $sig ( keys %MT::Plugins ) {
        my $sub = $sig =~ m!/! ? 1 : 0;
        my $obj = $MT::Plugins{$sig}{object};

        # Prevents display of component objects
        next if $obj && !$obj->isa('MT::Plugin');

        my $err = $MT::Plugins{$sig}{error}   ? 0 : 1;
        my $on  = $MT::Plugins{$sig}{enabled} ? 0 : 1;
        my ( $fld, $plg );
        ( $fld, $plg ) = $sig =~ m!(.*)/(.*)!;
        $fld = '' unless $fld;
        $folder_counts{$fld}++ if $fld;
        $plg ||= $sig;
        $list{  $sub
              . sprintf( "%-100s", $fld )
              . ( $obj ? '1' : '0' )
              . $plg } = $sig;
    }
    my @keys = keys %list;
    foreach my $key (@keys) {
        my $fld = substr( $key, 1, 100 );
        $fld =~ s/\s+$//;
        if ( !$fld || ( $folder_counts{$fld} == 1 ) ) {
            my $sig = $list{$key};
            delete $list{$key};
            my $plugin = $MT::Plugins{$sig};
            my $name
              = $plugin && $plugin->{object} ? $plugin->{object}->name : $sig;
            $list{ '0' . ( ' ' x 100 ) . sprintf( "%-102s", $name ) } = $sig;
        }
    }

    my $last_fld = '*';
    my $next_is_first;
    my $id = 0;
    ( my $cgi_path = $cfg->AdminCGIPath || $cfg->CGIPath ) =~ s|/$||;
    for my $list_key ( sort keys %list ) {
        $id++;
        my $plugin_sig = $list{$list_key};
        next if $plugin_sig =~ m/^[^A-Za-z0-9]/;
        my $profile = $MT::Plugins{$plugin_sig};
        my ($plg);
        ($plg) = $plugin_sig =~ m!(?:.*)/(.*)!;
        my $fld = substr( $list_key, 1, 100 );
        $fld =~ s/\s+$//;

        my $row;

        if ( my $plugin = $profile->{object} ) {
            my $plugin_icon;
            my $plugin_name = remove_html( $plugin->name() );

            my $registry = $plugin->registry;

            my $doc_link = $plugin->doc_link;
            if ( $doc_link && ( $doc_link !~ m!^https?://! ) ) {
                $doc_link
                  = $app->static_path . $plugin->envelope . '/' . $doc_link;
            }

            my $row = {
                        first           => $next_is_first,
                        plugin_name     => $plugin_name,
                        plugin_desc     => $plugin->description(),
                        plugin_version  => $plugin->version(),
                        plugin_doc_link => $doc_link,
            };
            my $block_tags    = $plugin->registry( 'tags', 'block' );
            my $function_tags = $plugin->registry( 'tags', 'function' );
            my $modifiers     = $plugin->registry( 'tags', 'modifier' );
            my $junk_filters = $plugin->registry('junk_filters');
            my $text_filters = $plugin->registry('text_filters');

            $row->{plugin_tags} = MT::App::CMS::listify( [

                    # Filter out 'plugin' registry entry
                    grep { !/^<\$?MTplugin\$?>$/ } ( (

                          # Format all 'block' tags with <MT(name)>
                          map { s/\?$//; "<MT$_>" }
                            ( keys %{ $block_tags || {} } )
                        ),
                        (

                          # Format all 'function' tags with <$MT(name)$>
                          map {"<\$MT$_\$>"}
                            ( keys %{ $function_tags || {} } )
                        )
                    )
                ]
            ) if $block_tags || $function_tags;
            $row->{plugin_attributes} = MT::App::CMS::listify( [

                    # Filter out 'plugin' registry entry
                    grep { $_ ne 'plugin' } keys %{ $modifiers || {} }
                ]
            ) if $modifiers;
            $row->{plugin_junk_filters} = MT::App::CMS::listify( [

                    # Filter out 'plugin' registry entry
                    grep { $_ ne 'plugin' } keys %{ $junk_filters || {} }
                ]
            ) if $junk_filters;
            $row->{plugin_text_filters} = MT::App::CMS::listify( [

                    # Filter out 'plugin' registry entry
                    grep { $_ ne 'plugin' } keys %{ $text_filters || {} }
                ]
            ) if $text_filters;
            if (    $row->{plugin_tags}
                 || $row->{plugin_attributes}
                 || $row->{plugin_junk_filters}
                 || $row->{plugin_text_filters} )
            {
                $row->{plugin_resources} = 1;
            }
            push @$data, $row if $profile->{enabled};
        } ## end if ( my $plugin = $profile...)
        $next_is_first = 0;
    } ## end for my $list_key ( sort...)
    $param->{plugin_loop} = $data;
} ## end sub build_resources_table

1;
__END__

The following subroutines were removed by Byrne Reese for Melody.
They are rendered obsolete by the new MT::CMS::Blog::cfg_blog_settings 
handler.

sub cfg_system_general {
    my $app = shift;
    my %param;
    if ( $app->param('blog_id') ) {
        return $app->return_to_dashboard( redirect => 1 );
    }

    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();
    my $cfg = $app->config;
    $app->add_breadcrumb( $app->translate('General Settings') );
    $param{nav_config}   = 1;
    $param{nav_settings} = 1;
    $param{languages} =
      $app->languages_list( $app->config('DefaultUserLanguage') );
    my $tag_delim = $app->config('DefaultUserTagDelimiter') || 'comma';
    $param{"tag_delim_$tag_delim"} = 1;

    ( my $tz = $app->config('DefaultTimezone') ) =~ s![-\.]!_!g;
    $tz =~ s!_00$!!;
    $param{ 'server_offset_' . $tz } = 1;

    $param{default_site_root} = $app->config('DefaultSiteRoot');
    $param{default_site_url}  = $app->config('DefaultSiteURL');
    $param{personal_weblog_readonly} =
      $app->config->is_readonly('NewUserAutoProvisioning');
    $param{personal_weblog} = $app->config->NewUserAutoProvisioning ? 1 : 0;
    if ( my $id = $param{new_user_template_blog_id} =
        $app->config('NewUserTemplateBlogId') || '' )
    {
        my $blog = MT::Blog->load($id);
        if ($blog) {
            $param{new_user_template_blog_name} = $blog->name;
        }
        else {
            $app->config( 'NewUserTemplateBlogId', undef, 1 );
            $cfg->save_config();
            delete $param{new_user_template_blog_id};
        }
    }
    
    if ($app->param('to_email_address')) {
    	return $app->errtrans("You don't have a system email address configured.  Please set this first, save it, then try the test email again.")
    	  unless ($cfg->EmailAddressMain);
        return $app->errtrans("Please enter a valid email address") 
          unless (MT::Util::is_valid_email($app->param('to_email_address')));
       
        my %head = (
            To => $app->param('to_email_address'),
            From => $cfg->EmailAddressMain,
            Subject => $app->translate("Test email from Movable Type")
        );

        my $body = $app->translate(
            "This is the test email sent by your installation of Movable Type."
        );

        require MT::Mail;
        MT::Mail->send( \%head, $body ) or return $app->error( $app->translate("Mail was not properly sent") );
        
        $app->log({
            message => $app->translate('Test e-mail was successfully sent to [_1]', $app->param('to_email_address')),
            level    => MT::Log::INFO(),
            class    => 'system',
        });
        $param{test_mail_sent} = 1;
    }
    
    my @config_warnings;
    for my $config_directive ( qw( EmailAddressMain DebugMode PerformanceLogging 
                                   PerformanceLoggingPath PerformanceLoggingThreshold ) ) {
        push(@config_warnings, $config_directive) if $app->config->is_readonly($config_directive);
    }
    my $config_warning = join(", ", @config_warnings) if (@config_warnings);
    
    $param{config_warning} = $app->translate("These setting(s) are overridden by a value in the MT configuration file: [_1]. Remove the value from the configuration file in order to control the value on this page.", $config_warning) if $config_warning;
    $param{system_email_address} = $cfg->EmailAddressMain;
    $param{system_debug_mode}    = $cfg->DebugMode;        
    $param{system_performance_logging} = $cfg->PerformanceLogging;
    $param{system_performance_logging_path} = $cfg->PerformanceLoggingPath;
    $param{system_performance_logging_threshold} = $cfg->PerformanceLoggingThreshold;
    $param{track_revisions}      = $cfg->TrackRevisions;
    $param{saved}                = $app->param('saved');
    $param{error}                = $app->param('error');
    $param{screen_class}         = "settings-screen system-general-settings";
    $app->load_tmpl( 'cfg_system_general.tmpl', \%param );
}

sub save_cfg_system_general {
    my $app = shift;
    $app->validate_magic or return;
    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();
    my $cfg = $app->config;
    $app->config( 'TrackRevisions', $app->param('track_revisions') ? 1 : 0, 1 );

    # construct the message to the activity log
    my @meta_messages = (); 
    push(@meta_messages, $app->translate('Email address is [_1]', $app->param('system_email_address'))) 
        if ($app->param('system_email_address') =~ /\w+/);
    push(@meta_messages, $app->translate('Debug mode is [_1]', $app->param('system_debug_mode')))
        if ($app->param('system_debug_mode') =~ /\d+/);
    if ($app->param('system_performance_logging')) {
        push(@meta_messages, $app->translate('Performance logging is on'));
    } else {
        push(@meta_messages, $app->translate('Performance logging is off'));
    }
    push(@meta_messages, $app->translate('Performance log path is [_1]', $app->param('system_performance_logging_path')))
        if ($app->param('system_performance_logging_path') =~ /\w+/);
    push(@meta_messages, $app->translate('Performance log threshold is [_1]', $app->param('system_performance_logging_threshold')))
        if ($app->param('system_performance_logging_threshold') =~ /\d+/);
    
    # throw the messages in the activity log
    if (scalar(@meta_messages) > 0) {
        my $message = join(', ', @meta_messages);
        $app->log({
            message  => $app->translate('System Settings Changes Took Place'),
            level    => MT::Log::INFO(),
            class    => 'system',
            metadata => $message,
        });
    }

    # actually assign the changes
    $app->config( 'EmailAddressMain', $app->param('system_email_address') || undef, 1 );
    $app->config('DebugMode', $app->param('system_debug_mode'), 1)
        if ($app->param('system_debug_mode') =~ /\d+/);
    if ($app->param('system_performance_logging')) {
        $app->config('PerformanceLogging', 1, 1);
    } else {
        $app->config('PerformanceLogging', 0, 1);
    }
    $app->config('PerformanceLoggingPath', $app->param('system_performance_logging_path'), 1)
        if ($app->param('system_performance_logging_path') =~ /\w+/);
    $app->config('PerformanceLoggingThreshold', $app->param('system_performance_logging_threshold'), 1)
        if ($app->param('system_performance_logging_threshold') =~ /\d+/);
    $cfg->save_config();
    my $args = ();
    $args->{saved} = 1;
    $app->redirect(
        $app->uri(
            'mode' => 'cfg_system',
            args   => $args
        )
    );
}

__END__

=head1 NAME

MT::CMS::Tools

=head1 METHODS

=head2 build_resources_table

=head2 convert_to_html

=head2 do_list_action

=head2 do_page_action

=head2 get_syscheck_content

=head2 new_password

=head2 recover_password

=head2 recover_passwords

=head2 recover_profile_password

=head2 reset_password

=head2 resources

=head2 sanity_check

=head2 system_info

=head2 update_list_prefs

=head2 upgrade

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
