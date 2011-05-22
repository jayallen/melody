# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::App;

use strict;
use base qw( MT );

use File::Spec;
use Scalar::Util qw( blessed );
use MT::Request;
use MT::Util qw( encode_html offset_time_list decode_html encode_url
  is_valid_email is_url escape_unicode );
use MT::I18N qw( encode_text wrap_text );

my $COOKIE_NAME = 'mt_user';
sub COMMENTER_COOKIE_NAME () {"mt_commenter"}
use vars qw( %Global_actions );

sub core_menus {
    return {};
}

sub core_methods {
    return {};
}

sub core_page_actions {
    return {};
}

sub core_list_actions {
    return {};
}

sub core_list_filters {
    {};
}

sub core_widgets {
    {};
}

sub core_blog_stats_tabs {
    {};
}

sub core_search_apis {
    {};
}

sub __massage_page_action {
    my ( $app, $action, $type ) = @_;
    return if exists $action->{__massaged};

    # my $plugin_sig = $action->{plugin};
    my $plugin = $action->{plugin};

    if ( my $link = $action->{link} ) {
        my $envelope = $plugin->envelope;
        $link .= '?' unless $link =~ m.\?.;
        my $page = $app->config->AdminCGIPath || $app->config->CGIPath;
        $page .= '/' unless $page =~ m!/$!;
        $page .= $envelope . '/' if $envelope;
        $page .= $link;
        my $has_params = ( $page =~ m/\?/ ) && ( $page !~ m!(&|;|\?)$! );
        $action->{page}            = $page;
        $action->{page_has_params} = $has_params;
    }
    elsif ( $action->{mode} || $action->{dialog} ) {
        if ( $app->user->is_superuser ) {
            $action->{allowed} = 1;
        }
        else {
            my $perms = $app->permissions;
            if ( my $p = $action->{permission} ) {
                my @p = split( /,/, $p );
                foreach my $p (@p) {
                    my $perm = 'can_' . $p;
                    $action->{allowed} = 1, last
                      if ( $perms && $perms->$perm() );
                }
            }
        }
        if ( $action->{mode} ) {
            $action->{link}
              = $app->uri( mode => $action->{mode}, args => $action->{args} );
        }
        elsif ( $action->{dialog} ) {
            if ( $action->{args} ) {
                my @args = map { $_ . '=' . $action->{args}->{$_} }
                  keys %{ $action->{args} };
                $action->{dialog_args} .= join '&', @args;
            }
        }
    } ## end elsif ( $action->{mode} ||...)
    else {
        $action->{page} = $app->uri(
                   mode => 'page_action',
                   args => { action_name => $action->{key}, '_type' => $type }
        );
        $action->{page_has_params} = 1;
    }
    $action->{core} = $plugin->isa('MT::Plugin') ? 0 : 1;
    $action->{order} = -10000 + ( $action->{order} || 0 ) if $action->{core};
    $action->{label} = $action->{link_text} if exists $action->{link_text};
    if ( $plugin && !ref( $action->{label} ) ) {
        my $label = $action->{label};
        if ($plugin) {
            $action->{label} = sub { $plugin->translate($label) };
        }
        else {
            $action->{label} = sub { $app->translate($label) };
        }
    }

    $action->{__massaged} = 1;
} ## end sub __massage_page_action

sub filter_conditional_list {
    my ( $app, $list, @param ) = @_;

    # $list may either be an array of things or a hashref of things

    my $perms = $app->permissions;
    my $user  = $app->user;
    my $admin = ( $user && $user->is_superuser() )
      || ( $perms && $perms->blog_id && $perms->has('administer_blog') );
    my $system_perms = $user->permissions(0) unless $perms && $perms->blog_id;

    my $test = sub {
        my ($item) = @_;
        if ( $system_perms && ( my $sp = $item->{system_permission} ) ) {
            my $allowed = 0;
            my @sp = split(/,/, $sp);
            foreach my $sp (@sp) {
                my $perm = 'can_' . $sp;
                $allowed = 1, last
                  if $admin
                      || (    $system_perms
                           && $system_perms->can($perm)
                           && $system_perms->$perm() );
            }
            return 0 unless $allowed;
        }
        if ( my $p = $item->{permission} ) {
            my $allowed = 0;
            my @p = split(/,/, $p);
            foreach my $p (@p) {
                my $perm = 'can_' . $p;
                $allowed = 1, last
                  if $admin
                      || ( $perms && $perms->can($perm) && $perms->$perm() );
            }
            return 0 unless $allowed;
        }
        if ( my $cond = $item->{condition} ) {
            if ( !ref($cond) ) {
                $cond = $item->{condition} = $app->handler_to_coderef($cond);
            }
            return 0 unless $cond->(@param);
        }
        return 1;
    };

    if ( ref $list eq 'ARRAY' ) {
        my @list;
        if (@$list) {

            # translate the link text here...
            foreach my $item (@$list) {
                push @list, $item if $test->($item);
            }
        }
        return \@list;
    }
    elsif ( ref $list eq 'HASH' ) {
        my %list;
        if (%$list) {

            # translate the link text here...
            foreach my $item ( keys %$list ) {
                $list{$item} = $list->{$item} if $test->( $list->{$item} );
            }
        }
        return \%list;
    }
    return undef;
} ## end sub filter_conditional_list

sub page_actions {
    my $app = shift;
    my ( $type, @param ) = @_;
    my $actions = $app->registry( "page_actions", $type ) or return;
    foreach my $a ( keys %$actions ) {

        # The change below relates to http://bugs.movabletype.org/?80960
        if ( 'HASH' ne ref( $actions->{$a} ) || '' ) {
            $app->log( {    # Developer debug message...
                   message =>
                     $app->translate(
                       'Malformed page_action data found for mode "[_1]" (Key: [_2]). Skipping page_actions.',
                       $type,
                       $a
                     ),
                   level => 'ERROR',
                }
            );
            return;
        }
        $actions->{$a}{key} = $a;
        __massage_page_action( $app, $actions->{$a}, $type );
    }
    my @actions = values %$actions;
    $actions = $app->filter_conditional_list( \@actions, @param );
    no warnings;
    @$actions = sort { $a->{order} <=> $b->{order} } @$actions;
    return $actions;
} ## end sub page_actions

sub list_actions {
    my $app = shift;
    my ( $type, @param ) = @_;

    my $actions = $app->registry( "list_actions", $type ) or return;
    my @actions;
    foreach my $a ( keys %$actions ) {
        $actions->{$a}{key}  = $a;
        $actions->{$a}{core} = 1
          unless UNIVERSAL::isa( $actions->{$a}{plugin}, 'MT::Plugin' );
        if ( exists $actions->{$a}{continue_prompt_handler} ) {
            my $code = $app->handler_to_coderef(
                                    $actions->{$a}{continue_prompt_handler} );
            $actions->{$a}{continue_prompt} = $code->()
              if 'CODE' eq ref($code);
        }
        push @actions, $actions->{$a};
    }
    $actions = $app->filter_conditional_list( \@actions, @param );
    no warnings;
    @$actions = sort { $a->{order} <=> $b->{order} } @$actions;
    return $actions;
} ## end sub list_actions

sub content_actions {
    my $app = shift;
    my ( $type, @param ) = @_;
    my $actions = $app->registry( "content_actions", $type ) or return;
    my @actions;
    for my $key ( keys %$actions ) {
        my $action = $actions->{$key};
        $action->{key} = $key;
        my %args = %{ $action->{args} || {} };
        $args{_type} ||= $type;
        $args{return_args} = $app->make_return_args if $action->{return_args};
        $action->{url} = $app->uri(
            mode => $action->{mode},
            args => {
                %args,
                blog_id => ( $app->blog ? $app->blog->id : 0 ),
                magic_token => $app->current_magic,
            },
        ) if $action->{mode};
        $args{id} = $action->{id}
            if $action->{id};
        push @actions, $action;
    }
    $actions = $app->filter_conditional_list( \@actions, @param );
    no warnings;
    @$actions = sort { $a->{order} <=> $b->{order} } @$actions;
    return $actions;
}

sub list_filters {
    my $app = shift;
    my ( $type, @param ) = @_;

    my $filters = $app->registry( "list_filters", $type ) or return;
    my @filters;
    foreach my $a ( keys %$filters ) {
        $filters->{$a}{key} = $a;
        next if $a =~ m/^_/;    # not shown...
        push @filters, $filters->{$a};
    }
    $filters = $app->filter_conditional_list( \@filters, @param );
    no warnings;
    @$filters = sort { $a->{order} <=> $b->{order} } @$filters;
    return $filters;
}

sub search_apis {
    my $app = shift;
    my ( $view, @param ) = @_;

    my $apis = $app->registry("search_apis") or return;
    my @apis;
    foreach my $a ( keys %$apis ) {
        next if $apis->{$a}->{view} && $apis->{$a}->{view} ne $view;
        $apis->{$a}{key}  = $a;
        $apis->{$a}{core} = 1
          unless UNIVERSAL::isa( $apis->{$a}{plugin}, 'MT::Plugin' );
        push @apis, $apis->{$a};
    }
    $apis = $app->filter_conditional_list( \@apis, @param );
    no warnings;
    @$apis = sort { $a->{order} <=> $b->{order} } @$apis;
    return $apis;
}

sub listing {
    my $app   = shift;
    my $q     = $app->query;
    my ($opt) = @_;

    my $type = $opt->{type} || $opt->{Type} || $q->param('_type');
    my $tmpl 
      = $opt->{template}
      || $opt->{Template}
      || 'list_' . $type . '.tmpl';
    my $iter_method = $opt->{iterator} || $opt->{Iterator} || 'load_iter';
    my $param       = $opt->{params}   || $opt->{Params}   || {};
    $param->{listing_screen} = 1;
    my $add_pseudo_new_user = delete $param->{pseudo_new_user}
      if exists $param->{pseudo_new_user};
    my $hasher   = $opt->{code}     || $opt->{Code};
    my $terms    = $opt->{terms}    || $opt->{Terms} || {};
    my $args     = $opt->{args}     || $opt->{Args} || {};
    my $no_html  = $opt->{no_html}  || $opt->{NoHTML};
    my $no_limit = $opt->{no_limit} || 0;
    my $json     = $opt->{json}     || $q->param('json');
    my $pre_build = $opt->{pre_build} if ref( $opt->{pre_build} ) eq 'CODE';
    $param->{json} = 1 if $json;

    my $class = $app->model($type) or return;
    my $list_pref = $app->list_pref($type) if $app->can('list_pref');
    $param->{$_} = $list_pref->{$_} for keys %$list_pref;
    my $limit = $list_pref->{rows};
    $limit =~ s/\D//g;
    my $offset = $q->param('offset') || 0;
    $offset =~ s/\D//g;
    $args->{offset} = $offset if $offset && !$no_limit;
    $args->{limit} = $limit + 1 unless $no_limit;
    $param->{limit_none} = 1 if $no_limit;

    # handle search parameter
    if ( my $search = $q->param('search') ) {
        $q->param( 'do_search', 1 );
        if ( $app->can('do_search_replace') ) {
            my $search_param = $app->do_search_replace();
            if ($hasher) {
                my $data = $search_param->{object_loop};
                if ( $data && @$data ) {
                    foreach my $row (@$data) {
                        my $obj = $row->{object};
                        $row = $obj->get_values();
                        $hasher->( $obj, $row );
                    }
                }
            }
            $param->{$_} = $search_param->{$_} for keys %$search_param;
            $param->{limit_none} = 1;
        }
    }
    else {

        # handle filter options
        my $filter_key = $q->param('filter_key');
        if ( !$filter_key && !$q->param('filter') ) {
            $filter_key = 'default';
        }
        if ($filter_key) {

            # set filter based on type
            my $filter = $app->registry( "list_filters", $type, $filter_key );
            if ($filter) {
                if ( my $code = $filter->{code} || $filter->{handler} ) {
                    if ( ref($code) ne 'CODE' ) {
                        $code = $filter->{code}
                          = $app->handler_to_coderef($code);
                    }
                    if ( ref($code) eq 'CODE' ) {
                        $code->( $terms, $args );
                        $param->{filter}       = 1;
                        $param->{filter_key}   = $filter_key;
                        $param->{filter_label} = $filter->{label};
                    }
                }
            }
        }
        if (    ( my $filter_col = $q->param('filter') )
             && ( my $val = $q->param('filter_val') ) )
        {
            if ( (
                      ( $filter_col eq 'normalizedtag' )
                   || ( $filter_col eq 'exacttag' )
                 )
                 && ( $class->isa('MT::Taggable') )
              )
            {
                my $normalize   = ( $filter_col eq 'normalizedtag' );
                my $tag_class   = $app->model('tag');
                my $ot_class    = $app->model('objecttag');
                my $tag_delim   = chr( $app->user->entry_prefs->{tag_delim} );
                my @filter_vals = $tag_class->split( $tag_delim, $val );
                my @filter_tags = @filter_vals;
                if ($normalize) {
                    push @filter_tags, MT::Tag->normalize($_)
                      foreach @filter_vals;
                }
                my @tags = $tag_class->load( { name => [@filter_tags] },
                                             { binary => { name => 1 } } );
                my @tag_ids;
                foreach (@tags) {
                    push @tag_ids, $_->id;
                    if ($normalize) {
                        my @more = $tag_class->load(
                             { n8d_id => $_->n8d_id ? $_->n8d_id : $_->id } );
                        push @tag_ids, $_->id foreach @more;
                    }
                }
                @tag_ids = (0) unless @tags;
                $args->{'join'} =
                  $ot_class->join_on(
                                    'object_id',
                                    {
                                      tag_id            => \@tag_ids,
                                      object_datasource => $class->datasource
                                    },
                                    { unique => 1 }
                  );
            } ## end if ( ( ( $filter_col eq...)))
            elsif ( !exists( $terms->{$filter_col} ) ) {
                if ( $class->is_meta_column($filter_col) ) {
                    my @result
                      = $class->search_by_meta( $filter_col, $val, {},
                                                $args );
                    $iter_method = sub {
                        return shift @result;
                    };
                }
                elsif ( $class->has_column($filter_col) ) {
                    $terms->{$filter_col} = $val;
                }
            }
            $param->{filter}     = $filter_col;
            $param->{filter_val} = $val;
            my $url_val = encode_url($val);
            $param->{filter_args} = "&filter=$filter_col&filter_val=$url_val";
            $param->{"filter_col_$filter_col"} = 1;
        } ## end if ( ( my $filter_col ...))

        # automagic blog scoping
        my $blog = $app->blog;
        if ($blog) {

            # In blog context, class defines blog_id as a column,
            # so restrict listing to active blog:
            if ( $class->column_def('blog_id') ) {
                $terms->{blog_id} ||= $blog->id;
            }
        }

        $args->{sort} = 'id'
          unless exists $args->{sort};    # must always provide sort column

        $app->run_callbacks( 'app_pre_listing_' . $app->mode,
                             $app, $terms, $args, $param, \$hasher );

        my $iter
          = ref($iter_method) eq 'CODE'
          ? $iter_method
          : ( $class->$iter_method( $terms, $args )
              or return $app->error( $class->errstr ) );
        my @data;
        while ( my $obj = $iter->() ) {
            my $row = $obj->get_values();
            $hasher->( $obj, $row ) if $hasher;

            #$app->run_callbacks( 'app_listing_'.$app->mode,
            #                     $app, $obj, $row );
            push @data, $row;
            last if ( scalar @data == $limit ) && ( !$no_limit );
        }

        $param->{object_loop} = \@data;

        # handle pagination
        $limit  += 0;
        $offset += 0;
        my $pager = {
                      offset        => $offset,
                      limit         => $limit,
                      rows          => scalar @data,
                      listTotal     => $class->count( $terms, $args ) || 0,
                      chronological => $param->{list_noncron} ? 0 : 1,
                      return_args   => encode_html( $app->make_return_args ),
                      method        => $app->request_method,
        };
        $param->{object_type} ||= $type;
        $param->{pager_json} = $json ? $pager : MT::Util::to_json($pager);

        # pager.rows (number of rows shown)
        # pager.listTotal (total number of rows in datasource)
        # pager.offset (offset currently used)
        # pager.chronological (boolean, whether the listing is chronological or not)
    } ## end else [ if ( my $search = $q->param...)]

    my $plural = $type;

    # entry -> entries; user -> users
    if ( $class->can('class_label') ) {
        $param->{object_label} = $class->class_label;
    }
    if ( $class->can('class_label_plural') ) {
        $param->{object_label_plural} = $class->class_label_plural;
    }

    if ( $app->user->is_superuser() ) {
        $param->{is_superuser} = 1;
    }

    if ($json) {
        $pre_build->($param) if $pre_build;
        my $html = $app->build_page( $tmpl, $param );
        my $data = { html => $html, pager => $param->{pager_json}, };
        $app->send_http_header("text/javascript+json");
        $app->print( MT::Util::to_json($data) );
        $app->{no_print_body} = 1;
    }
    else {
        $app->load_list_actions( $type, $param );
        $pre_build->($param) if $pre_build;
        if ($no_html) {
            return $param;
        }
        if ( ref $tmpl ) {
            $tmpl->param($param);
            return $tmpl;
        }
        else {
            return $app->load_tmpl( $tmpl, $param );
        }
    }
} ## end sub listing

sub json_result {
    my $app = shift;
    my ($result) = @_;
    $app->send_http_header("text/javascript+json");
    $app->{no_print_body} = 1;
    $app->print( MT::Util::to_json( { error => undef, result => $result } ) );
    return undef;
}

sub json_error {
    my $app = shift;
    my ($error, $status) = @_;
    $app->response_code($status)
        if defined $status;
    $app->send_http_header("text/javascript+json");
    $app->{no_print_body} = 1;
    $app->print( MT::Util::to_json( { error => $error } ) );
    return undef;
}

sub response_code {
    my $app = shift;
    $app->{response_code} = shift if @_;
    $app->{response_code};
}

sub response_message {
    my $app = shift;
    $app->{response_message} = shift if @_;
    $app->{response_message};
}

sub response_content_type {
    my $app = shift;
    $app->{response_content_type} = shift if @_;
    $app->{response_content_type};
}

sub response_content {
    my $app = shift;
    $app->{response_content} = shift if @_;
    $app->{response_content};
}

sub send_http_header {
    my $app = shift;
    my ($type) = @_;
    $type ||= $app->{response_content_type} || 'text/html';
    if ( my $charset = $app->charset ) {
        $type .= "; charset=$charset"
          if ( $type =~ m!^text/! || $type =~ m!\+xml$! )
          && $type !~ /\bcharset\b/;
    }
    if ( $ENV{MOD_PERL} ) {
        if ( $app->{response_message} ) {
            $app->{apache}->status_line(
                                         ( $app->response_code || 200 )
                                         . (
                                             $app->{response_message}
                                             ? ' ' . $app->{response_message}
                                             : ''
                                         )
            );
        }
        else {
            $app->{apache}->status( $app->response_code || 200 );
        }
        $app->{apache}->send_http_header($type);
        if ( $MT::DebugMode & 128 ) {
            print "Status: "
              . ( $app->response_code || 200 )
              . ( $app->{response_message}
                  ? ' ' . $app->{response_message}
                  : '' )
              . "\n";
            print "Content-Type: $type\n\n";
        }
    } ## end if ( $ENV{MOD_PERL} )
    else {
        $app->{cgi_headers}{-status}
          = ( $app->response_code || 200 )
          . (
             $app->{response_message} ? ' ' . $app->{response_message} : '' );
        $app->{cgi_headers}{-type} = $type;
        $app->print( $app->query->header( %{ $app->{cgi_headers} } ) );
    }
} ## end sub send_http_header

sub print {
    my $app = shift;
    if ( $ENV{MOD_PERL} ) {
        $app->{apache}->print(@_);
    }
    else {
        CORE::print(@_);
    }
    if ( $MT::DebugMode & 128 ) {
        CORE::print STDERR @_;
    }
}

sub handler ($$) {
    my $class = shift;
    my ($r) = @_;
    require Apache::Constants;
    if ( lc( $r->dir_config('Filter') || '' ) eq 'on' ) {
        $r = $r->filter_register;
    }
    my $config_file = $r->dir_config('MTConfig');
    my $mt_dir      = $r->dir_config('MTHome');
    my %params = (
                   Config       => $config_file,
                   ApacheObject => $r,
                   ( $mt_dir ? ( Directory => $mt_dir ) : () )
    );
    my $app = $class->new(%params) or die $class->errstr;

    MT->set_instance($app);
    $app->init_request(%params);

    my $cfg = $app->config;
    if ( my @extra = $r->dir_config('MTSetVar') ) {
        for my $d (@extra) {
            my ( $var, $val ) = $d =~ /^\s*(\S+)\s+(.+)$/;
            $cfg->set( $var, $val );
        }
    }

    $app->run;
    return Apache::Constants::OK();
} ## end sub handler ($$)

sub init {
    my $app   = shift;
    my %param = @_;
    $app->{apache} = $param{ApacheObject} if exists $param{ApacheObject};

    # start tracing even prior to 'init'
    local $SIG{__WARN__} = sub { $app->trace( $_[0] ) };
    $app->SUPER::init(%param) or return;
    $app->{vtbl}                 = {};
    $app->{is_admin}             = 0;
    $app->{template_dir}         = 'cms';          #$app->id;
    $app->{user_class}           = 'MT::Author';
    $app->{plugin_template_path} = 'tmpl';

    # Temporary deprecation warning on access/retrieval
    # See POD documentation for $app->{query} for details
    tie $app->{query}, 'Melody::DeprecatedQueryUsage';

    $app->run_callbacks( 'init_app', $app, @_ );

    if ( $MT::DebugMode & 128 ) {
        MT->add_callback( 'pre_run',  1, $app, sub { $app->pre_run_debug } );
        MT->add_callback( 'takedown', 1, $app, sub { $app->post_run_debug } );
    }
    $app->{vtbl} = $app->registry("methods");
    $app->init_request(@_);
    return $app;
} ## end sub init

sub pre_run_debug {
    my $app = shift;
    my $q   = $app->query;
    if ( $MT::DebugMode & 128 ) {
        print STDERR "=====START: $$===========================\n";
        print STDERR "Package: " . ref($app) . "\n";
        print STDERR "Session: " . $app->session->id . "\n" if $app->session;
        print STDERR "Request: " . $q->request_method . "\n";
        my @param = $app->query;
        if (@param) {
            foreach my $key (@param) {
                my @val = $q->param($key);
                print STDERR "\t" . $key . ": " . $_ . "\n" for @val;
            }
        }
        print STDERR "-----Response:\n";
    }
}

sub post_run_debug {
    if ( $MT::DebugMode & 128 ) {
        print STDERR "\n=====END: $$=============================\n";
    }
}

sub run_callbacks {
    my $app = shift;
    my ( $meth, @param ) = @_;
    $meth = ( ref($app) || $app ) . '::' . $meth unless $meth =~ m/::/;
    return $app->SUPER::run_callbacks( $meth, @param );
}

sub init_callbacks {
    my $app = shift;
    $app->SUPER::init_callbacks(@_);
    MT->add_callback( 'post_save',             0, $app, \&_cb_mark_blog );
    MT->add_callback( 'MT::Blog::post_remove', 0, $app, \&_cb_unmark_blog );
    MT->add_callback( 'pre_build', 9, $app, sub { $app->touch_blogs() } );
    MT->add_callback( 'new_user_provisioning', 5, $app,
                      \&_cb_user_provisioning );
}

sub init_request {
    my $app   = shift;
    my %param = @_;

    return if $app->{init_request};

    if ($MT::DebugMode) {
        require Time::HiRes;
        $app->{start_request_time} = Time::HiRes::time();
    }

    if ( $app->{request_read_config} ) {
        $app->init_config( \%param ) or return;
        $app->{request_read_config} = 0;
    }

    # @req_vars: members of the app object which are request-specific
    # and are cleared at the beginning of each request.
    my @req_vars = qw(mode __path_info _blog redirect login_again
      no_print_body response_code response_content_type response_message
      author cgi_headers breadcrumbs goback cache_templates warning_trace
      cookies _errstr request_method requires_login __host );
    delete $app->{$_} foreach @req_vars;
    $app->user(undef);
    if ( $ENV{MOD_PERL} ) {
        require Apache::Request;
        $app->{apache} = $param{ApacheObject} || Apache->request;
        $app->query(
                    Apache::Request->instance(
                        $app->{apache}, POST_MAX => $app->config->CGIMaxUpload
                    )
        );
    }
    else {

        # Patched from http://bugs.movabletype.org/?81733
        require CGI;
        $CGI::POST_MAX = $app->config->CGIMaxUpload;

        if ( $param{CGIObject} ) {
            $app->query( $param{CGIObject} );
        }
        else {
            if ( my $path_info = $ENV{PATH_INFO} ) {
                if ( $path_info =~ m/\.cgi$/ ) {

                    # some CGI environments (notably 'sbox') leaves PATH_INFO
                    # defined which interferes with CGI.pm determining the
                    # request url.
                    delete $ENV{PATH_INFO};
                }
            }
            $app->query( CGI->new( $app->{no_read_body} ? {} : () ) );
        }
    } ## end else [ if ( $ENV{MOD_PERL} ) ]
    $app->init_query();

    $app->{return_args} = $app->query->param('return_args');
    $app->cookies;

    ## Initialize the MT::Request singleton for this particular request.
    $app->request->reset();
    $app->request( 'App-Class', ref $app );

    $app->run_callbacks( ref($app) . '::init_request', $app, @_ );

    $app->{init_request} = 1;
} ## end sub init_request

sub init_query {
    my $app = shift;
    my $q   = $app->query;

    # CGI.pm has this terrible flaw in that if a POST is in effect,
    # it totally ignores any query parameters.
    if ( $app->request_method eq 'POST' ) {
        if ( !$ENV{MOD_PERL} ) {
            my $query_string = $ENV{'QUERY_STRING'}
              if defined $ENV{'QUERY_STRING'};
            $query_string ||= $ENV{'REDIRECT_QUERY_STRING'}
              if defined $ENV{'REDIRECT_QUERY_STRING'};
            if ( defined($query_string) and $query_string ne '' ) {
                $q->parse_params($query_string);
            }
        }
    }
}

{
    my $has_encode;

    sub validate_request_params {
        my $app = shift;
        my $q   = $app->query;
        $has_encode = eval { require Encode; 1 } ? 1 : 0
          unless defined $has_encode;
        return 1 unless $has_encode;

        # validate all parameter data matches the expected character set.
        my @p       = $q->param();
        my $charset = $app->charset;
        require Encode;
        require MT::I18N::default;
        $charset = 'UTF-8' if $charset =~ m/utf-?8/i;
        my $request_charset = $charset;
        if ( my $content_type = $q->content_type() ) {
            if ( $content_type =~ m/;[ ]+charset=(.+)/i ) {
                $request_charset = lc $1;
                $request_charset =~ s/^\s+|\s+$//gs;
            }
        }
        my $transcode = $request_charset ne $charset ? 1 : 0;
        my %params;
        foreach my $p (@p) {
            if ( $p =~ m/[^\x20-\x7E]/ ) {

                # non-ASCII parameter name
                return $app->errtrans("Invalid request");
            }

            my @d = $q->param($p);
            my @param;
            foreach my $d (@d) {
                if (    ( !defined $d )
                     || ( $d eq '' )
                     || ( $d !~ m/[^\x20-\x7E]/ ) )
                {
                    push @param, $d if $transcode;
                    next;
                }
                $d =
                  MT::I18N::default->encode_text_encode( $d, $request_charset,
                                                         $charset )
                  if $transcode;
                my $saved = $d;
                eval { Encode::decode( $charset, $d, 1 ); };
                return
                  $app->errtrans(
                    "Invalid request: corrupt character data for character set [_1]",
                    $charset
                  ) if $@;
                push @param, $saved if $transcode;
            } ## end foreach my $d (@d)
            if ( $transcode && @param ) {
                if ( 1 == scalar(@param) ) {
                    $params{$p} = $param[0];
                }
                else {
                    $params{$p} = [@param];
                }
            }
        } ## end foreach my $p (@p)
        while ( my ( $key, $val ) = each %params ) {
            if ( ref $val ) {
                $q->param( $key, @{ $params{$key} } );
            }
            else {
                $q->param( $key, $val );
            }
        }

        return 1;
    } ## end sub validate_request_params
}

sub registry {
    my $app = shift;
    my $ar  = $app->SUPER::registry( "applications", $app->id, @_ );
    my $gr  = $app->SUPER::registry(@_) if @_;
    if ($ar) {
        MT::__merge_hash( $ar, $gr );
        return $ar;
    }
    return $gr;
}

sub _cb_unmark_blog {
    my ( $eh, $obj ) = @_;
    my $mt_req = MT->instance->request;
    if ( my $blogs_touched = $mt_req->stash('blogs_touched') ) {
        delete $blogs_touched->{ $obj->id };
        $mt_req->stash( 'blogs_touched', $blogs_touched );
    }
}

sub _cb_mark_blog {
    my ( $eh, $obj ) = @_;
    my $obj_type = ref $obj;

    if ( $obj_type eq 'MT::Author' ) {
        require MT::Touch;
        MT::Touch->touch( 0, 'author' );
        return;
    }

    return
      if (  $obj_type eq 'MT::Log'
         || $obj_type eq 'MT::Session'
         || $obj_type eq 'MT::Touch'
         || ( ( $obj_type ne 'MT::Blog' ) && !$obj->has_column('blog_id') ) );
    my $mt_req = MT->instance->request;
    my $blogs_touched = $mt_req->stash('blogs_touched') || {};

    # Issue MT::Touch touches for specific types we track
    my $type = $obj->datasource;
    if ( $obj->properties->{class_column} ) {
        $type = $obj->class_type;
    }
    if ( $type
        !~ m/^(entry|comment|page|folder|category|tbping|asset|author|template)$/
      )
    {
        undef $type;
    }

    if ( $obj_type eq 'MT::Blog' ) {
        delete $blogs_touched->{ $obj->id };
    }
    else {
        if ( $obj->blog_id ) {
            my $th = $blogs_touched->{ $obj->blog_id } ||= {};
            $th->{$type} = 1 if $type;
        }
    }
    $mt_req->stash( 'blogs_touched', $blogs_touched );
} ## end sub _cb_mark_blog

sub _cb_user_provisioning {
    my ( $cb, $user ) = @_;

    # Supply user with what they need...

    require MT::Blog;
    require MT::Util;
    my $new_blog;
    my $app = MT->instance;
    my $blog_name = $user->nickname || $app->translate("First Weblog");
    if ( my $blog_id = $app->config('NewUserTemplateBlogId') ) {
        my $blog = MT::Blog->load($blog_id);
        if ( !$blog ) {
            $app->log( {
                       message =>
                         $app->translate(
                            "Error loading blog #[_1] for user provisioning. "
                              . "Check your NewUserTemplateBlogId setting.",
                            $blog_id
                         ),
                       level => 'ERROR',
                     }
            );
            return;
        }
        $new_blog = $blog->clone( {
                Children => 1,
                Classes  => { 'MT::Permission' => 0, 'MT::Association' => 0 },
                BlogName => $blog_name,
              }
        );
        if ( !$new_blog ) {
            $app->log( {
                   message =>
                     $app->translate(
                       "Error provisioning blog for new user '[_1]' using template blog #[_2].",
                       $user->id,
                       $blog->id
                     ),
                   level => 'ERROR',
                }
            );
            return;
        }
    } ## end if ( my $blog_id = $app...)
    else {
        $new_blog = MT::Blog->create_default_blog($blog_name);
    }

    my $dir_name;
    if ( my $root = $app->config('DefaultSiteRoot') ) {
        my $fmgr = $new_blog->file_mgr;
        if ( -d $root ) {
            my $path;
            $dir_name = MT::Util::dirify( $new_blog->name );
            $dir_name = 'blog-' if ( $dir_name =~ /^_*$/ );
            my $sfx = 0;
            while (1) {
                $path = File::Spec->catdir( $root,
                                           $dir_name . ( $sfx ? $sfx : '' ) );
                $path =~ s/(.+)\-$/$1/;
                if ( !-d $path ) {
                    $fmgr->mkpath($path);
                    if ( !-d $path ) {
                        $app->log( {
                               message =>
                                 $app->translate(
                                   "Error creating directory [_1] for blog #[_2].",
                                   $path,
                                   $new_blog->id
                                 ),
                               level => 'ERROR',
                            }
                        );
                    }
                    last;
                }
                $sfx++;
            } ## end while (1)
            $dir_name .= $sfx ? $sfx : '';
            $dir_name =~ s/(.+)\-$/$1/;
            $new_blog->site_path($path);
        } ## end if ( -d $root )
    } ## end if ( my $root = $app->config...)
    if ( my $url = $app->config('DefaultSiteURL') ) {
        $url .= '/' unless $url =~ m!/$!;
        $url .= $dir_name ? $dir_name : MT::Util::dirify( $new_blog->name );
        $url .= '/';
        $new_blog->site_url($url);
    }
    my $offset = $app->config('DefaultTimezone');
    if ( defined $offset ) {
        $new_blog->server_offset($offset);
    }
    $new_blog->save
      or $app->log( {
               message =>
                 $app->translate(
                    "Error provisioning blog for new user '[_1] (ID: [_2])'.",
                    $user->id, $user->name
                 ),
               level => 'ERROR',
             }
      ),
      return;
    $app->log( {
           message =>
             $app->translate(
               "Blog '[_1] (ID: [_2])' for user '[_3] (ID: [_4])' has been created.",
               $new_blog->name, $new_blog->id, $user->name, $user->id
             ),
           level    => 'INFO',
           class    => 'system',
           category => 'new'
        }
    );

    require MT::Role;
    require MT::Association;
    my $role = MT::Role->load_by_permission('administer_blog');
    if ($role) {
        MT::Association->link( $user => $role => $new_blog );
    }
    else {
        $app->log( {
               message =>
                 $app->translate(
                   "Error assigning blog administration rights to user '[_1] (ID: [_2])' for blog '[_3] (ID: [_4])'. No suitable blog administrator role was found.",
                   $user->name, $user->id, $new_blog->name, $new_blog->id,
                 ),
               level    => 'ERROR',
               class    => 'system',
               category => 'new'
            }
        );
    }
    1;
} ## end sub _cb_user_provisioning

# Along with _cb_unmark_blog and _cb_mark_blog, this is an elaborate
# scheme to cause MT::Blog objects that are affected as a result of a
# change to a child class to be updated with respect to their
# 'last modification' timestamp which is used by the dynamic engine
# to determine when cached files are stale.
sub touch_blogs {
    my $blogs_touched = MT->instance->request('blogs_touched') or return;
    foreach my $blog_id ( keys %$blogs_touched ) {
        next unless $blog_id;
        my $blog = MT::Blog->load($blog_id);
        next unless ($blog);
        my $th = $blogs_touched->{$blog_id} || {};
        my @types = keys %$th;
        $blog->touch(@types);
        $blog->save() or die $blog->errstr;
    }
    MT->instance->request( 'blogs_touched', undef );
}

sub add_breadcrumb {
    my $app = shift;
    push @{ $app->{breadcrumbs} }, { bc_name => $_[0], bc_uri => $_[1], };
}

sub is_authorized {1}

sub commenter_cookie { COMMENTER_COOKIE_NAME() }

sub user_cookie {$COOKIE_NAME}

sub user {
    my $app = shift;
    $app->{author} = $app->{ $app->user_cookie } = $_[0] if @_;
    return $app->{author};
}

sub can_do {
    my $app = shift;
    my ( $action, $perms ) = @_;
    my $user = $app->user
        or die $app->error(
        $app->translate('Internal Error: Login user is not initialized.') );

    ##TODO: is this always good behavior?
    return 1 if $user->is_superuser;

    if ( $perms ||= $app->permissions ) {
        my $blog_result = $perms->can_do($action);
        return $blog_result if defined $blog_result;
    }
    ## if there were no result from blog permission,
    ## look for system level permission.
    my $sys_perms = MT::Permission->load(
        {   author_id => $user->id,
            blog_id   => 0,
        }
    );

    return $sys_perms ? $sys_perms->can_do($action) : undef;
}

sub permissions {
    my $app = shift;
    $app->{perms} = shift if @_;
    return $app->{perms};
}

sub session_state {
    my $app     = shift;
    my $blog    = $app->blog;
    my $blog_id = $blog ? $blog->id : 0;

    my ( $c, $commenter );
    ( my $sessobj, $commenter ) = $app->get_commenter_session();
    if ( $sessobj && $commenter ) {
        $c = {
            sid  => $sessobj->id,
            name => $commenter->nickname
              || $app->translate('(Display Name not set)'),
            url     => $commenter->url,
            email   => $commenter->email,
            userpic => scalar $commenter->userpic_url,
            profile => "",                               # profile link url
            is_authenticated => 1,
            is_author => ( $commenter->type == MT::Author::AUTHOR() ? 1 : 0 ),
            is_trusted   => 0,
            is_anonymous => 0,
            can_post     => 0,
            can_comment  => 0,
            is_banned    => 0,
        };
        if ( $blog_id && $blog ) {
            my $blog_perms = $commenter->blog_perm($blog_id);
            my $banned = $commenter->is_banned($blog_id) ? 1 : 0;
            $banned = 0 if $blog_perms && $blog_perms->can_administer;
            $banned ||= 1 if $commenter->status == MT::Author::BANNED();
            $c->{is_banned} = $banned;

            if ($banned) {
                $sessobj->remove;
                delete $c->{sid};
            }
            else {
                $sessobj->start( time + $app->config->CommentSessionTimeout )
                  ;    # extend by timeout
                $sessobj->save();
            }

            # FIXME: These may not be accurate in 'SingleCommunity' mode...
            my $can_comment = $banned ? 0 : 1;
            $can_comment = 0
              unless $blog->allow_unreg_comments || $blog->allow_reg_comments;
            $c->{can_comment} = $can_comment;
            $c->{can_post}
              = ( $blog_perms && $blog_perms->can_create_post ) ? 1 : 0;
            $c->{is_trusted} = ( $commenter->is_trusted($blog_id) ? 1 : 0 ),;
        } ## end if ( $blog_id && $blog)
    } ## end if ( $sessobj && $commenter)

    unless ($c) {
        my $can_comment = $blog && $blog->allow_anon_comments ? 1 : 0;
        $c = {
               is_authenticated => 0,
               is_trusted       => 0,
               is_anonymous     => 1,
               can_post         => 0,              # no anonymous posts
               can_comment      => $can_comment,
               is_banned        => 0,
        };
    }

    return ( $c, $commenter );
} ## end sub session_state

sub session {
    my $app  = shift;
    my $sess = $app->{session};
    return unless $sess;
    if (@_) {
        my $setting = shift;
        @_ ? $sess->set( $setting, @_ ) : $sess->get($setting);
    }
    else {
        $sess;
    }
}

sub make_magic_token {
    my @alpha = ( 'a' .. 'z', 'A' .. 'Z', 0 .. 9 );
    my $token = join '', map $alpha[ rand @alpha ], 1 .. 40;
    $token;
}

sub make_session {
    my ( $auth, $remember ) = @_;
    require MT::Session;
    my $sess = new MT::Session;
    $sess->id( make_magic_token() );
    $sess->kind('US');    # US == User Session
    $sess->start(time);
    $sess->set( 'author_id', $auth->id );
    $sess->set( 'remember', 1 ) if $remember;
    $sess->save;
    $sess;
}

# given credentials in the form of a username, optional password, and
# session ID ("token"), this returns the corresponding author object
# if the credentials are legit, 0 if insufficient credentials were there,
# or undef if they were actually incorrect
sub session_user {
    my $app = shift;
    my ( $author, $session_id, %opt ) = @_;
    return undef unless $author && $session_id;
    if ( $app->{session} ) {
        if ( $app->{session}->get('author_id') == $author->id ) {
            return $author;
        }
    }

    require MT::Session;
    my $timeout
      = $opt{permanent}
      ? ( 360 * 24 * 365 * 10 )
      : $app->config->UserSessionTimeout;
    my $sess = MT::Session::get_unexpired_value( $timeout,
                                        { id => $session_id, kind => 'US' } );
    $app->{session} = $sess;

    return undef if !$sess;
    if ( $sess && ( $sess->get('author_id') == $author->id ) ) {
        return $author;
    }
    else {
        return undef;
    }
} ## end sub session_user

sub get_commenter_session {
    my $app = shift;
    my $q   = $app->query;

    my $session_key;

    my $blog = $app->blog;
    if ($blog) {
        my $auths = $blog->commenter_authenticators || '';
        if ( $auths =~ /MovableType/ ) {

            # First, check for a real MT user login. If one exists,
            # return that as the commenter identity
            my ( $user, $first_time ) = $app->login();
            if ($user) {
                my $sess = $app->session;
                return ( $sess, $user );
            }
        }
    }

    my %cookies     = $app->cookies();
    my $cookie_name = $app->commenter_cookie;
    if ( !$cookies{$cookie_name} ) {
        return ( undef, undef );
    }
    $session_key = $cookies{$cookie_name}->value() || "";
    $session_key =~ y/+/ /;
    my $cfg = $app->config;
    require MT::Session;
    my $sess_obj = MT::Session->load( { id => $session_key, kind => 'SI' } );
    my $timeout  = $cfg->CommentSessionTimeout;
    my $user_id  = $sess_obj->get('author_id') if $sess_obj;
    my $user     = MT::Author->load($user_id) if $user_id;

    if (    !$sess_obj
         || ( $sess_obj->start() + $timeout < time )
         || ( !$user_id )
         || ( !$user ) )
    {
        $app->_invalidate_commenter_session( \%cookies );
        return ( undef, undef );
    }

    # session is valid!
    return ( $sess_obj, $user );
} ## end sub get_commenter_session

sub make_commenter {
    my $app    = shift;
    my %params = @_;

    # Strip any angle brackets from input, just to be safe
    foreach my $f (qw( name email nickname url )) {
        $params{$f} =~ s/[<>]//g if exists $params{$f};
    }

    require MT::Author;
    my $cmntr = MT::Author->load( {
                                    name      => $params{name},
                                    type      => MT::Author::COMMENTER(),
                                    auth_type => $params{auth_type},
                                  }
    );
    if ( !$cmntr ) {
        $cmntr = $app->model('author')->new();
        $cmntr->set_values( {
               email     => $params{email},
               name      => $params{name},
               nickname  => $params{nickname},
               password  => "(none)",
               type      => MT::Author::COMMENTER(),
               url       => $params{url},
               auth_type => $params{auth_type},
               (
                  $params{external_id}
                  ? ( external_id => $params{external_id} )
                  : ()
               ),
               (
                  $params{remote_auth_username}
                  ? ( remote_auth_username => $params{remote_auth_username} )
                  : ()
               ),
             }
        );
        $cmntr->save();
    } ## end if ( !$cmntr )
    else {
        $cmntr->set_values( {
                              email    => $params{email},
                              nickname => $params{nickname},
                              password => "(none)",
                              type     => MT::Author::COMMENTER(),
                              url      => $params{url},
                              (
                                $params{external_id}
                                ? ( external_id => $params{external_id} )
                                : ()
                              ),
                            }
        );
        $cmntr->save();
    }
    return $cmntr;
} ## end sub make_commenter

sub make_commenter_session {
    my $app = shift;
    my $q   = $app->query;
    my ( $session_key, $email, $name, $nick, $id, $url ) = @_;
    my $user;

    # support for old signature; new signature is $session_key, $user_obj
    if ( ref($session_key) && $session_key->isa('MT::Author') ) {
        $user        = $session_key;
        $session_key = $app->make_magic_token;
        $email       = $user->email;
        $name        = $user->name;
        $nick = $user->nickname || $app->translate('(Display Name not set)');
        $id   = $user->id;
        $url  = $user->url;
    }

    # test
    $session_key = $q->param('sig') if $user->auth_type eq 'TypeKey';

    require MT::Session;
    my $sess_obj = MT::Session->new();
    $sess_obj->id($session_key);
    $sess_obj->email($email);
    $sess_obj->name($name);
    $sess_obj->start(time);
    $sess_obj->kind("SI");
    $sess_obj->set( 'author_id', $user->id ) if $user;
    $sess_obj->save()
      or return
      $app->error(
        $app->translate(
            "The login could not be confirmed because of a database error ([_1])",
            $sess_obj->errstr
        )
      );

    my $enc = $app->charset;
    $nick = encode_text( $nick, $enc, 'utf-8' );
    my $nick_escaped = MT::Util::escape_unicode($nick);

    my $timeout;
    if ( $user->type == MT::Author::AUTHOR() ) {
        if ( $q->param('remember') ) {

            # 10 years, same as app sign-in 'remember me'
            $timeout = '+3650d';
        }
        else {
            $timeout = '+' . $app->config->UserSessionTimeout . 's';
        }
    }
    else {
        $timeout = '+' . $app->config->CommentSessionTimeout . 's';
    }

    my %kookee = (
                   -name  => COMMENTER_COOKIE_NAME(),
                   -value => $session_key,
                   -path  => '/',
                   ( $timeout ? ( -expires => $timeout ) : () )
    );
    $app->bake_cookie(%kookee);
    my %name_kookee = (
                        -name  => "commenter_name",
                        -value => $nick_escaped,
                        -path  => '/',
                        ( $timeout ? ( -expires => $timeout ) : () )
    );
    $app->bake_cookie(%name_kookee);

    return $session_key;
} ## end sub make_commenter_session

sub _invalidate_commenter_session {
    my $app = shift;
    my ($cookies) = @_;

    my $cookie_val
      = (   $cookies->{ COMMENTER_COOKIE_NAME() }
          ? $cookies->{ COMMENTER_COOKIE_NAME() }->value()
          : "" );
    my $session = $cookie_val;
    require MT::Session;
    my $sess_obj = MT::Session->load( { id => $session } );
    $sess_obj->remove() if ($sess_obj);

    my $timeout = $app->{cfg}->CommentSessionTimeout;

    my %kookee = (
                   -name    => COMMENTER_COOKIE_NAME(),
                   -value   => '',
                   -path    => '/',
                   -expires => "+${timeout}s"
    );
    $app->bake_cookie(%kookee);
    my %name_kookee = (
                        -name    => 'commenter_name',
                        -value   => '',
                        -path    => '/',
                        -expires => "+${timeout}s"
    );
    $app->bake_cookie(%name_kookee);
    my %id_kookee = (
                      -name    => 'commenter_id',
                      -value   => '',
                      -path    => '/',
                      -expires => "+${timeout}s"
    );
    $app->bake_cookie(%id_kookee);
} ## end sub _invalidate_commenter_session

sub start_session {
    my $app = shift;
    my ( $author, $remember ) = @_;
    if ( !defined $author ) {
        $author = $app->user;
        my ( $x, $y );
        ( $x, $y, $remember )
          = split( /::/, $app->cookie_val( $app->user_cookie ) );
    }
    my $session = make_session( $author, $remember );
    my %arg = (
               -name  => $app->user_cookie,
               -value => join( '::', $author->name, $session->id, $remember ),
               -path => $app->config->CookiePath || $app->mt_path
    );
    $arg{-expires} = '+10y' if $remember;
    $app->{session} = $session;
    $app->bake_cookie(%arg);
    \%arg;
} ## end sub start_session

sub _get_options_tmpl {
    my $self = shift;
    my ($authenticator) = @_;

    my $tmpl = $authenticator->{login_form};
    return q() unless $tmpl;
    return $tmpl->($authenticator) if ref $tmpl eq 'CODE';
    if ( $tmpl =~ /\s/ ) {
        return $tmpl;
    }
    else {    # no spaces in $tmpl; must be a filename...
        if ( my $plugin = $authenticator->{plugin} ) {
            return $plugin->load_tmpl($tmpl) or die $plugin->errstr;
        }
        else {
            return MT->instance->load_tmpl($tmpl);
        }
    }
}

sub _get_options_html {
    my $app           = shift;
    my $q             = $app->query;
    my ($key)         = @_;
    my $authenticator = MT->commenter_authenticator($key);
    return q() unless $authenticator;

    my $snip_tmpl = $app->_get_options_tmpl($authenticator);
    return q() unless $snip_tmpl;

    require MT::Template;
    my $tmpl;
    if ( ref $snip_tmpl ne 'MT::Template' ) {
        $tmpl = MT::Template->new(
                           type   => 'scalarref',
                           source => ref $snip_tmpl ? $snip_tmpl : \$snip_tmpl
        );
    }
    else {
        $tmpl = $snip_tmpl;
    }

    $app->set_default_tmpl_params($tmpl);
    my $entry_id = $q->param('entry_id') || '';
    $entry_id =~ s/\D//g;
    my $blog_id = $q->param('blog_id') || '';
    $blog_id =~ s/\D//g;
    my $static = MT::Util::remove_html(
                   $q->param('static')
                     || encode_url(
                       $q->param('return_to') || $q->param('return_url') || ''
                     )
                     || ''
    );
    if ( my $p = $authenticator->{login_form_params} ) {
        $p = $app->handler_to_coderef($p);
        if ($p) {
            my $params = $p->( $key, $blog_id, $entry_id || undef, $static, );
            $tmpl->param($params) if $params;
        }
    }
    my $html = $tmpl->output();
    if ( UNIVERSAL::isa( $authenticator, 'MT::Plugin' )
         && ( $html =~ m/<__trans / ) )
    {
        $html = $authenticator->translate_templatized($html);
    }
    $html;
} ## end sub _get_options_html

sub external_authenticators {
    my $app = shift;
    my ( $blog, $param ) = @_;
    return [] unless $blog;

    $param ||= {};

    my @external_authenticators;

    my %cas = map { $_->{key} => $_ } $app->commenter_authenticators;

    my @auths = split ',', $blog->commenter_authenticators;
    my %otherauths;
    foreach my $key (@auths) {
        if ( $key eq 'MovableType' ) {
            $param->{enabled_MovableType} = 1;
            $param->{default_signin}      = 'MovableType';
            my $cfg = $app->config;
            if ( my $registration = $cfg->CommenterRegistration ) {
                if ( $cfg->AuthenticationModule eq 'MT' ) {
                    $param->{registration_allowed} = $registration->{Allow}
                      && $blog->allow_commenter_regist ? 1 : 0;
                }
            }
            require MT::Auth;
            $param->{can_recover_password} = MT::Auth->can_recover_password;
            next;
        }

        my $auth = $cas{$key} or next;

        if ( $key ne 'TypeKey' && $key ne 'OpenID' && $key ne 'LiveJournal' )
        {
            push @external_authenticators,
              {
                name       => $auth->{label},
                key        => $auth->{key},
                login_form => $app->_get_options_html($key),
                exists( $auth->{logo} ) ? ( logo => $auth->{logo} ) : (),
              };
        }
        else {
            $otherauths{$key} = {
                     name       => $auth->{label},
                     key        => $auth->{key},
                     login_form => $app->_get_options_html($key),
                     exists( $auth->{logo} ) ? ( logo => $auth->{logo} ) : (),
            };
        }
    } ## end foreach my $key (@auths)

    unshift @external_authenticators, $otherauths{'TypeKey'}
      if exists $otherauths{'TypeKey'};
    unshift @external_authenticators, $otherauths{'LiveJournal'}
      if exists $otherauths{'LiveJournal'};
    unshift @external_authenticators, $otherauths{'OpenID'}
      if exists $otherauths{'OpenID'};

    \@external_authenticators;
} ## end sub external_authenticators

sub _is_commenter {
    my $app = shift;
    my ($author) = @_;

    return 0 if $author->is_superuser;

    # Check if the user is a commenter and keep them from logging in to the app
    my @author_perms
      = $app->model('permission')
      ->load( { author_id => $author->id, blog_id => '0' },
              { not => { blog_id => 1 } } );
    my $commenter = -1;
    my $commenter_blog_id;
    for my $perm (@author_perms) {
        my $permissions = $perm->permissions;
        next unless $permissions;
        if ( $permissions eq "'comment'" ) {
            $commenter_blog_id = $perm->blog_id unless $commenter_blog_id;
            $commenter = 1;
            next;
        }
        return 0;
    }
    if ( -1 == $commenter ) {

        # this user does not have any permission to any blog
        # check for system permission
        my $sys_perms             = MT::Permission->perms('system');
        my $has_system_permission = 0;
        foreach (@$sys_perms) {
            if ( $author->permissions(0)->has( $_->[0] ) ) {
                $has_system_permission = 1;
                last;
            }
        }
        return
          $app->error(
            $app->translate(
                'Our apologies, but you do not have permission to access any blogs within this installation. If you feel you have reached this message in error, please contact your Movable Type system administrator.'
            )
          ) unless $has_system_permission;
        return -1;
    } ## end if ( -1 == $commenter )
    return $commenter_blog_id;
} ## end sub _is_commenter

# virutal method overridden when pending user has special treatment
sub login_pending {q()}

# virutal method overridden when commenter needs special treatment
sub commenter_loggedin {
    my $app = shift;
    my ( $commenter, $commenter_blog_id ) = @_;
    my $blog = $app->model('blog')->load($commenter_blog_id)
      or return $app->error(
           $app->translate( "Can\'t load blog #[_1].", $commenter_blog_id ) );
    my $path = $app->config('CGIPath');
    $path .= '/' unless $path =~ m!/$!;
    my $url = $path . $app->config('CommentScript');
    $url .= '?__mode=edit_profile';
    $url .= '&commenter=' . $commenter->id;
    $url .= '&blog_id=' . $commenter_blog_id;
    $url .= '&static=' . $blog->site_url;
    $url;
}

# MT::App::login
#   Working from the query object, determine whether the session is logged in,
#   perform any session/cookie maintenance, and if we're logged in,
#   return a pair
#     ($author, $first_time)
#   where $author is an author object and $first_time is true if this
#   is the first request of a session. $first_time is returned just
#   for any plugins that might need it, since historically the logging
#   and session management was done by the calling code.

sub login {
    my $app       = shift;
    my $q         = $app->query;
    my $new_login = 0;

    require MT::Auth;
    my $ctx = MT::Auth->fetch_credentials( { app => $app } );
    unless ($ctx) {
        if ( $q->param('submit') ) {
            return $app->error( $app->translate('Invalid login.') );
        }
        return;
    }

    my $res = MT::Auth->validate_credentials($ctx) || MT::Auth::UNKNOWN();
    my $user = $ctx->{username};

    if ( $res == MT::Auth::UNKNOWN() ) {

        # Login invalid; auth layer knows nothing of user
        $app->log( {
                     message =>
                       $app->translate(
                          "Failed login attempt by unknown user '[_1]'", $user
                       ),
                     level    => 'WARNING',
                     category => 'login_user',
                   }
        ) if defined $user;
        MT::Auth->invalidate_credentials( { app => $app } );
        return $app->error( $app->translate('Invalid login.') );
    }
    elsif ( $res == MT::Auth::INACTIVE() ) {

        # Login invalid; auth layer reports user was disabled
        $app->log( {
                    message =>
                      $app->translate(
                         "Failed login attempt by disabled user '[_1]'", $user
                      ),
                    level    => 'WARNING',
                    category => 'login_user',
                  }
        );
        return
          $app->error(
            $app->translate(
                'This account has been disabled. Please see your system administrator for access.'
            )
          );
    }
    elsif ( $res == MT::Auth::PENDING() ) {

        # Login invalid; auth layer reports user was pending
        # Check if registration is allowed and if so send special message
        my $message;
        if ( my $registration = $app->config->CommenterRegistration ) {
            if ( $registration->{Allow} ) {
                $message = $app->login_pending();
            }
        }
        $message
          ||= $app->translate(
            'This account has been disabled. Please see your system administrator for access.'
          );
        $app->user(undef);
        $app->log( {
                     message =>
                       $app->translate(
                          "Failed login attempt by pending user '[_1]'", $user
                       ),
                     level    => 'WARNING',
                     category => 'login_user',
                   }
        );
        return $app->error($message);
    } ## end elsif ( $res == MT::Auth::PENDING...)
    elsif ( $res == MT::Auth::INVALID_PASSWORD() ) {

        # Login invlaid (password error, etc...)
        return $app->error( $app->translate('Invalid login.') );
    }
    elsif ( $res == MT::Auth::DELETED() ) {

        # Login invalid; auth layer says user record has been removed
        return
          $app->error(
            $app->translate(
                'This account has been deleted. Please see your system administrator for access.'
            )
          );
    }
    elsif ( $res == MT::Auth::REDIRECT_NEEDED() ) {

# The authentication driver is delegating authentication to another URL, follow the
# designated redirect.
        my $url = $app->config->AuthLoginURL;
        if ( $url && !$app->{redirect} ) {
            $app->redirect($url);
        }
        return
          0
          ; # Return undefined so the redirect (set by the Auth Driver) will be
            # followed by MT.
    }
    elsif ( $res == MT::Auth::NEW_LOGIN() ) {

        # auth layer reports valid user and that this is a new login. act accordingly
        my $author = $app->user;
        MT::Auth->new_login( $app, $author );
        $new_login = 1;
    }
    elsif ( $res == MT::Auth::NEW_USER() ) {

        # auth layer reports that a new user has been created by logging in.
        my $user_class = $app->user_class;
        my $author     = $user_class->new;
        $app->user($author);
        $author->name( $ctx->{username} ) if $ctx->{username};
        $author->type( MT::Author::AUTHOR() );
        $author->status( MT::Author::ACTIVE() );
        $author->auth_type( $app->config->AuthenticationModule );
        my $saved = MT::Auth->new_user( $app, $author );
        $saved = $author->save unless $saved;

        unless ($saved) {
            $app->log( {
                         message =>
                           $app->translate(
                                            "User cannot be created: [_1].",
                                            $author->errstr
                           ),
                         level    => 'ERROR',
                         class    => 'system',
                         category => 'create_user'
                       }
              ),
              $app->error(
                           $app->translate(
                                            "User cannot be created: [_1].",
                                            $author->errstr
                           )
              ),
              return undef;
        } ## end unless ($saved)

        $app->log( {
                     message =>
                       $app->translate(
                                        "User '[_1]' has been created.",
                                        $author->name
                       ),
                     level    => 'INFO',
                     class    => 'system',
                     category => 'create_user'
                   }
        );

        # provision user if configured to do so
        if ( $app->config->NewUserAutoProvisioning ) {
            MT->run_callbacks( 'new_user_provisioning', $author );
        }
        $new_login = 1;
    } ## end elsif ( $res == MT::Auth::NEW_USER...)
    my $author = $app->user;

# At this point the MT::Auth module should have initialized an author object. If
# it did then everything is cool and the MT session is initialized. If not, then
# an error is thrown

    if ($author) {

        # Login valid
        if ($new_login) {

            my $commenter_blog_id = $app->_is_commenter($author);
            return unless defined $commenter_blog_id;

            # $commenter_blog_id
            #  0: user has more permissions than comment
            #  N: user has only comment permission on some blog
            # -1: user has only system permissions
            # undef: user does not have any permission

            if ( $commenter_blog_id >= 0 ) {

                # Presence of 'password' indicates this is a login request;
                # do session/cookie management.
                $app->make_commenter_session($author);

                if ($commenter_blog_id) {
                    my $url = $app->commenter_loggedin( $author,
                                                        $commenter_blog_id );
                    return $app->redirect($url);
                }
            }
            ## commenter_blog_id can be -1 - user who has only system permissions

            $app->start_session( $author, $ctx->{permanent} ? 1 : 0 );
            $app->request( 'fresh_login', 1 );
            $app->log(
                       $app->translate(
                               "User '[_1]' (ID:[_2]) logged in successfully",
                               $author->name, $author->id
                       )
            );
        } ## end if ($new_login)
        else {
            $author = $app->session_user( $author, $ctx->{session_id},
                                          permanent => $ctx->{permanent} );
            if ( !defined($author) ) {
                $app->user(undef);
                $app->{login_again} = 1;
                return undef;
            }
        }

        # $author->last_login();
        # $author->save;

        ## update session so the user will be counted as active
        require MT::Session;
        my $sess_active
          = MT::Session->load( { kind => 'UA', name => $author->id } );
        if ( !$sess_active ) {
            $sess_active = MT::Session->new;
            $sess_active->id( make_magic_token() );
            $sess_active->kind('UA');    # UA == User Activation
            $sess_active->name( $author->id );
        }
        $sess_active->start(time);
        $sess_active->save;

        return ( $author, $new_login );
    } ## end if ($author)
    else {
        MT::Auth->invalidate_credentials( { app => $app } );
        if ( !defined($author) ) {

            # undef indicates *invalid* login as opposed to no login at all.
            $app->log( {
                         message =>
                           $app->translate(
                               "Invalid login attempt from user '[_1]'", $user
                           ),
                         level => 'WARNING',
                       }
            );
            return $app->errtrans('Invalid login.');
        }
        else {
            return undef;
        }
    }
} ## end sub login

sub logout {
    my $app = shift;

    require MT::Auth;

    my $ctx = MT::Auth->fetch_credentials( { app => $app } );
    if ( $ctx && $ctx->{username} ) {
        my $user_class = $app->user_class;
        my $user = $user_class->load(
                 { name => $ctx->{username}, type => MT::Author::AUTHOR() } );
        if ($user) {
            $app->user($user);
            $app->log(
                       $app->translate(
                              "User '[_1]' (ID:[_2]) logged out", $user->name,
                              $user->id
                       )
            );
        }
    }

    MT::Auth->invalidate_credentials( { app => $app } );
    my %cookies = $app->cookies();
    $app->_invalidate_commenter_session( \%cookies );

    # The login box should only be displayed in the event of non-delegated auth
    # right?
    my $delegate = MT::Auth->delegate_auth();
    if ($delegate) {
        my $url = $app->config->AuthLogoutURL;
        if ( $url && !$app->{redirect} ) {
            $app->redirect($url);
        }
        if ( $app->{redirect} ) {

            # Return 0 to force MT to follow redirects
            return 0;
        }
    }

    # Displaying the login box
    $app->show_login({
        logged_out => 1,
    });
} ## end sub logout

sub create_user_pending {
    my $app     = shift;
    my $q       = $app->query;
    my ($param) = @_;
    $param ||= {};

    my $cfg = $app->config;
    $param->{ 'auth_mode_' . $cfg->AuthenticationModule } = 1;

    my $blog;
    if ( exists $param->{blog_id} ) {
        $blog = $app->model('blog')->load( $param->{blog_id} )
          or return $app->error(
            $app->translate( "Can\'t load blog #[_1].", $param->{blog_id} ) );
    }

    my ( $password, $url );
    unless ( $q->param('external_auth') ) {
        $password = $q->param('password');
        unless ($password) {
            return $app->error( $app->translate("User requires password.") );
        }

        if ( $q->param('password') ne $q->param('pass_verify') ) {
            return $app->error( $app->translate('Passwords do not match.') );
        }

        $url = $q->param('url');
        if ( $url && ( !is_url($url) || ( $url =~ m/[<>]/ ) ) ) {
            return $app->error( $app->translate("URL is invalid.") );
        }
    }

    my $nickname = $q->param('nickname');
    if ( !$nickname && !( $q->param('external_auth') ) ) {
        return $app->error( $app->translate("User requires display name.") );
    }
    if ( $nickname && $nickname =~ m/([<>])/ ) {
        return
          $app->error(
                       $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Display Name"),
                                   encode_html($1)
                       )
          );
    }

    my $email = $q->param('email');
    if ($email) {
        unless ( is_valid_email($email) ) {
            delete $param->{email};
            return $app->error(
                               $app->translate("Email Address is invalid.") );
        }
        if ( $email =~ m/([<>])/ ) {
            return
              $app->error(
                           $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Email Address"),
                                   encode_html($1)
                           )
              );
        }
    }
    elsif ( !( $q->param('external_auth') ) ) {
        delete $param->{email};
        return
          $app->error(
                       $app->translate(
                           "Email Address is required for password recovery.")
          );
    }

    my $name = $q->param('username');
    if ( defined $name ) {
        $name =~ s/(^\s+|\s+$)//g;
        $param->{name} = $name;
    }
    unless ( defined($name) && $name ) {
        return $app->error( $app->translate("User requires username.") );
    }
    elsif ( $name =~ m/([<>])/ ) {
        return
          $app->error(
                       $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Username"),
                                   encode_html($1)
                       )
          );
    }
    if ( $name =~ m/([<>])/ ) {
        return
          $app->error(
                       $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Username"),
                                   encode_html($1)
                       )
          );
    }

    my $existing = MT::Author->exist( { name => $name } );
    return $app->error(
                $app->translate("A user with the same name already exists.") )
      if $existing;

    if ( $url && ( !is_url($url) || ( $url =~ m/[<>]/ ) ) ) {
        return $app->error( $app->translate("URL is invalid.") );
    }

    if (
         $blog
         && ( my $provider
              = MT->effective_captcha_provider( $blog->captcha_provider ) )
      )
    {
        unless ( $provider->validate_captcha($app) ) {
            return $app->error(
                     $app->translate("Text entered was wrong.  Try again.") );
        }
    }

    my $user = $app->model('author')->new;
    $user->name($name);
    $user->nickname($nickname);
    $user->email($email);
    unless ( $q->param('external_auth') ) {
        $user->set_password( $q->param('password') );
        $user->url($url) if $url;
    }
    else {
        $user->password('(none)');
    }
    $user->type( MT::Author::AUTHOR() );
    $user->status( MT::Author::PENDING() );
    $user->auth_type( $app->config->AuthenticationModule );

    unless ( $user->save ) {
        return
          $app->error(
            $app->translate(
                "Something wrong happened when trying to process signup: [_1]",
                $user->errstr
            )
          );
    }
    return $user;

} ## end sub create_user_pending

sub _send_comment_notification {
    my $app = shift;
    my ( $comment, $comment_link, $entry, $blog, $commenter ) = @_;

    return unless $blog->email_new_comments;

    my $cfg       = $app->config;
    my $attn_reqd = $comment->is_moderated;

    if ( $blog->email_attn_reqd_comments && !$attn_reqd ) {
        return;
    }

    require MT::Mail;
    my $author = $entry->author;
    $app->set_language( $author->preferred_language )
      if $author && $author->preferred_language;
    my $from_addr;
    my $reply_to;
    if ( $cfg->EmailReplyTo ) {
        $reply_to = $comment->email;
    }
    else {
        $from_addr = $comment->email;
    }
    $from_addr = undef if $from_addr && !is_valid_email($from_addr);
    $reply_to  = undef if $reply_to  && !is_valid_email($reply_to);
    if ( $author && $author->email )
    {    # } && is_valid_email($author->email)) {
        if ( !$from_addr ) {
            $from_addr = $cfg->EmailAddressMain || $author->email;
            $from_addr = $comment->author . ' <' . $from_addr . '>'
              if $comment->author;
        }
        my %head = (
                     id => 'new_comment',
                     To => $author->email,
                     $from_addr ? ( From       => $from_addr ) : (),
                     $reply_to  ? ( 'Reply-To' => $reply_to )  : (),
                     Subject => '['
                       . $blog->name . '] '
                       . $app->translate( "New Comment Added to '[_1]'",
                                          $entry->title )
        );
        my $charset = $cfg->MailEncoding || $cfg->PublishCharset;
        $head{'Content-Type'} = qq(text/plain; charset="$charset");
        my $base;
        {
            local $app->{is_admin} = 1;
            $base = $app->base . $app->mt_uri;
        }
        if ( $base =~ m!^/! ) {
            my ($blog_domain) = $blog->site_url =~ m|(.+://[^/]+)|;
            $base = $blog_domain . $base;
        }
        my $nonce
          = MT::Util::perl_sha1_digest_hex(   $comment->id
                                            . $comment->created_on
                                            . $blog->id
                                            . $cfg->SecretToken );
        my $approve_link = $base
          . $app->uri_params(
                              'mode' => 'approve_item',
                              args   => {
                                        blog_id => $blog->id,
                                        '_type' => 'comment',
                                        id      => $comment->id,
                                        nonce   => $nonce
                              }
          );
        my $spam_link = $base
          . $app->uri_params(
                              'mode' => 'handle_junk',
                              args   => {
                                        blog_id => $blog->id,
                                        '_type' => 'comment',
                                        id      => $comment->id,
                                        nonce   => $nonce
                              }
          );
        my $edit_link = $base
          . $app->uri_params(
                              'mode' => 'view',
                              args   => {
                                        blog_id => $blog->id,
                                        '_type' => 'comment',
                                        id      => $comment->id
                              }
          );

        my %param = (
             blog           => $blog,
             entry          => $entry,
             view_url       => $comment_link,
             approve_url    => $approve_link,
             spam_url       => $spam_link,
             edit_url       => $edit_link,
             comment        => $comment,
             unapproved     => !$comment->visible(),
             state_editable => (
                 $author->is_superuser()
                   || ( $author->permissions( $blog->id )->can_manage_feedback
                      || $author->permissions( $blog->id )->can_publish_post )
               ) ? 1 : 0,
        );
        my $body = MT->build_email( 'new-comment.tmpl', \%param );
        MT::Mail->send( \%head, $body )
          or return $app->error( MT::Mail->errstr() );
    } ## end if ( $author && $author...)
} ## end sub _send_comment_notification

sub _send_sysadmins_email {
    my $app = shift;
    my ( $ids, $email_id, $body, $subject, $from ) = @_;
    my $cfg = $app->config;

    my @ids = split ',', $ids;
    my @sysadmins = MT::Author->load(
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

    require MT::Mail;

    my $from_addr;
    my $reply_to;
    if ( $cfg->EmailReplyTo ) {
        $reply_to = $cfg->EmailAddressMain || $from;
    }
    else {
        $from_addr = $cfg->EmailAddressMain || $from;
    }
    $from_addr = undef if $from_addr && !is_valid_email($from_addr);
    $reply_to  = undef if $reply_to  && !is_valid_email($reply_to);

    unless ( $from_addr || $reply_to ) {
        $app->log( {
                message =>
                  $app->translate("System Email Address is not configured."),
                level    => 'ERROR',
                class    => 'system',
                category => 'email'
              }
        );
        return;
    }

    foreach my $a (@sysadmins) {
        next unless $a->email && is_valid_email( $a->email );
        my %head = (
            id => $email_id,
            To => $a->email,
            $from_addr ? ( From => $from_addr ) : (),
            $reply_to ? ( 'Reply-To' => $reply_to ) : (), Subject => $subject,
        );
        my $charset = $cfg->MailEncoding || $cfg->PublishCharset;
        $head{'Content-Type'} = qq(text/plain; charset="$charset");
        MT::Mail->send( \%head, $body );
    }
} ## end sub _send_sysadmins_email

sub clear_login_cookie {
    my $app = shift;
    $app->bake_cookie(
                       -name    => $app->user_cookie,
                       -value   => '',
                       -expires => '-1y',
                       -path    => $app->config->CookiePath || $app->mt_path
    );
}

sub request_content {
    my $app = shift;
    unless ( exists $app->{request_content} ) {
        if ( $ENV{MOD_PERL} ) {
            ## Read from $app->{apache}
            my $r   = $app->{apache};
            my $len = $app->get_header('Content-length');
            $r->read( $app->{request_content}, $len );
        }
        else {
            ## Read from STDIN
            my $len = $ENV{CONTENT_LENGTH} || 0;
            read STDIN, $app->{request_content}, $len;
        }
    }
    $app->{request_content};
}

sub get_header {
    my $app = shift;
    my ($key) = @_;
    if ( $ENV{MOD_PERL} ) {
        return $app->{apache}->header_in($key);
    }
    else {
        ( $key = uc($key) ) =~ tr/-/_/;
        return $ENV{ 'HTTP_' . $key };
    }
}

sub set_header {
    my $app = shift;
    my ( $key, $val ) = @_;
    if ( $ENV{MOD_PERL} ) {
        $app->{apache}->header_out( $key, $val );
    }
    else {
        unless ( $key =~ /^-/ ) {
            ( $key = lc($key) ) =~ tr/-/_/;
            $key = '-' . $key;
        }
        if ( $key eq '-cookie' ) {
            push @{ $app->{cgi_headers}{$key} }, $val;
        }
        else {
            $app->{cgi_headers}{$key} = $val;
        }
    }
}

sub request_method {
    my $app = shift;
    if (@_) {
        $app->{request_method} = shift;
    }
    elsif ( !exists $app->{request_method} ) {
        if ( $ENV{MOD_PERL} ) {
            $app->{request_method} = Apache->request->method;
        }
        else {
            $app->{request_method} = $ENV{REQUEST_METHOD} || '';
        }
    }
    $app->{request_method};
}

sub upload_info {
    my $app          = shift;
    my ($param_name) = @_;
    my $q            = $app->query;

    my ( $fh, $info, $no_upload );
    if ( $ENV{MOD_PERL} ) {
        if ( my $up = $q->upload($param_name) ) {
            $fh        = $up->fh;
            $info      = $up->info;
            $no_upload = !$up->size;
        }
        else {
            $no_upload = 1;
        }
    }
    elsif ( $fh = $q->upload($param_name) ) {
        $info = $q->uploadInfo($fh);
    }
    else {
        warn "upload failed: " . $q->cgi_error;
        $no_upload = 1;
    }

    return if $no_upload;
    return ( $fh, $info );
} ## end sub upload_info

sub cookie_val {
    my $app     = shift;
    my $cookies = $app->cookies;
    if ( $cookies && $cookies->{ $_[0] } ) {
        return $cookies->{ $_[0] }->value() || "";
    }
    return "";
}

sub bake_cookie {
    my $app   = shift;
    my %param = @_;
    my $cfg   = $app->config;
    if ( ( !exists $param{'-secure'} ) && $app->is_secure ) {
        $param{'-secure'} = 1;
    }
    unless ( $param{-path} ) {
        $param{-path} = $cfg->CookiePath || $app->path;
    }
    if ( !$param{-domain} && $cfg->CookieDomain ) {
        $param{-domain} = $cfg->CookieDomain;
    }
    if ( $ENV{MOD_PERL} ) {
        require Apache::Cookie;
        my $cookie = Apache::Cookie->new( $app->{apache}, %param );
        if ( $param{-expires} && ( $cookie->expires =~ m/%/ ) ) {

            # Fix for oddball Apache::Cookie error reported on Windows.
            require CGI::Util;
            $cookie->expires(
                           CGI::Util::expires( $param{-expires}, 'cookie' ) );
        }
        $cookie->bake;
    }
    else {
        require CGI::Cookie;
        my $cookie = CGI::Cookie->new(%param);
        $app->set_header( '-cookie', $cookie );
    }
} ## end sub bake_cookie

sub cookies {
    my $app = shift;
    unless ( $app->{cookies} ) {
        my $class = $ENV{MOD_PERL} ? 'Apache::Cookie' : 'CGI::Cookie';
        eval "use $class;";
        $app->{cookies} = $class->fetch;
    }
    if ( $app->{cookies} ) {
        return wantarray ? %{ $app->{cookies} } : $app->{cookies};
    }
    else {
        return wantarray ? () : undef;
    }
}

sub show_error {
    my $app     = shift;
    my $q       = $app->query;
    my ($param) = @_;
    my $tmpl;
    my $mode    = $app->mode;
    my $url     = $app->uri;
    my $blog_id = $q->param('blog_id');
    my $status  = $param->{status};
    $app->response_code($status)
        if defined $status;

    if ( ref $param ne 'HASH' ) {

        # old scalar signature
        $param = { error => $param };
    }

    my $error = $param->{error};

    # Only remove unnecessary paths when we aren't in DebugMode.

    if ( !$MT::DebugMode ) {
        if ( $error =~ m/^(.+?)( at .+? line \d+)(.*)$/s ) {

            # Hide any module path info from perl error message
            # Information could be revealing info about where MT app
            # resides on server, and what version is being used, which
            # may be helpful forensics to an attacker.
            $error = $1;
        }
        $error =~ s!(https?://\S+)!<a href="$1" target="_blank">$1</a>!g;
    }

    # $error = encode_html($error);
    $tmpl = $app->load_tmpl('error.tmpl');
    if ( !$tmpl ) {
        $error = '<pre>' . $error . '</pre>' unless $error =~ m/<pre>/;
        return
            "Can't load error template; got error '"
          . encode_html( $app->errstr )
          . "'. Giving up. Original error was: $error";
    }
    my $type = $q->param('__type') || '';
    if ( $type eq 'dialog' ) {
        $param->{name} ||= $app->{name} || 'dialog';
        $param->{goback}
          ||= $app->{goback}
          ? "window.location='" . $app->{goback} . "'"
          : 'closeDialog()';
        $param->{value} ||= $app->{value} || $app->translate("Close");
        $param->{dialog} = 1;
    }
    else {
        $param->{goback}
          ||= $app->{goback}
          ? "window.location='" . $app->{goback} . "'"
          : 'history.back()';
        $param->{value} ||= $app->{value} || $app->translate("Go Back");
    }
    local $param->{error} = $error;
    $tmpl->param($param);
    $app->run_callbacks( 'template_param.error', $app, $tmpl->param, $tmpl );
    my $out = $tmpl->output;
    if ( !defined $out ) {
        $error = '<pre>' . $error . '</pre>' unless $error =~ m/<pre>/;
        return
            "Can't build error template; got error '"
          . encode_html( $tmpl->errstr )
          . "'. Giving up. Original error was: $error";
    }
    $app->run_callbacks( 'template_output.error', $app, \$out, $tmpl->param,
                         $tmpl );
    return $app->l10n_filter($out);
} ## end sub show_error

sub show_login {
    my $app = shift;
    my ( $param ) = @_;
    $param ||= {};
    require MT::Auth;
    $app->build_page('login.tmpl', {
        error                => $app->errstr,
        no_breadcrumbs       => 1,
        login_fields         => MT::Auth->login_form($app),
        can_recover_password => MT::Auth->can_recover_password,
        delegate_auth        => MT::Auth->delegate_auth,
        %$param,
    });
}

sub pre_run {
    my $app = shift;
    my $q   = $app->query;
    if ( my $auth = $app->user ) {
        if ( my $lang = $q->param('__lang') ) {
            $app->set_language($lang);
        }
        else {
            $app->set_language( $auth->preferred_language )
              if $auth->has_column('preferred_language');
        }
    }

    # allow language override
    my $lang = $app->session ? $app->session('lang') : '';
    $app->set_language($lang) if ($lang);
    if ( $lang = $app->query->param('__lang') ) {
        $app->set_language($lang);
        if ( $app->session ) {
            $app->session( 'lang', $lang );
            $app->session->save;
        }
    }

    $app->{breadcrumbs} = [];
    MT->run_callbacks( ( ref $app ) . '::pre_run', $app );
    1;
} ## end sub pre_run

sub post_run { MT->run_callbacks( ( ref $_[0] ) . '::post_run', $_[0] ); 1 }

sub run {
    my $app = shift;
    my $q   = $app->query;

    my $timer;
    if ( $app->config->PerformanceLogging ) {
        $timer = $app->get_timer();
        $timer->pause_partial();
    }

    my ($body,$meth_info);
    eval {

        # line __LINE__ __FILE__

        $app->validate_request_params() or die;

        require MT::Auth;
        if ( $ENV{MOD_PERL} ) {
            unless ( $app->{no_read_body} ) {
                my $status = $q->parse;
                unless ( $status == Apache::Constants::OK() ) {
                    die $app->translate('The file you uploaded is too large.')
                      . "\n<!--$status-->";
                }
            }
        }
        else {
            my $err;
            eval { $err = $q->cgi_error };
            unless ($@) {
                if ( $err && $err =~ /^413/ ) {
                    die $app->translate('The file you uploaded is too large.')
                      . "\n";
                }
            }
        }

        my $mode = $app->mode || 'default';

      REQUEST:
        {

            # for Perl 5.6.x BugId:79755
            $mode = $app->{forward} unless $mode;

            my $requires_login = $app->{requires_login};

            my $code = $app->handlers_for_mode($mode);

            my @handlers = ref($code) eq 'ARRAY' ? @$code : ($code)
              if defined $code;

            $meth_info = {};
            $app->request( method_info => {} );
            foreach my $code (@handlers) {
                if ( ref $code eq 'HASH' ) {
                    $meth_info = $code;
                    $app->request( method_info => $meth_info );
                    $requires_login
                      = $requires_login & $meth_info->{requires_login}
                      if exists $meth_info->{requires_login};
                }
            }

            if ($requires_login) {
                my ($author) = $app->login;
                if ( !$author || !$app->is_authorized ) {
                    $body
                      = ref($author) eq $app->user_class
                      ? $app->show_error( { error => $app->errstr } )
                      : $app->show_login();
                    last REQUEST;
                }
            } ## end if ($requires_login)

            unless (@handlers) {
                my $meth = "mode_$mode";
                if ( $app->can($meth) ) {
                    no strict 'refs';
                    $code = \&{ *{ ref($app) . '::' . $meth } };
                    push @handlers, $code;
                }
            }

            if ( !@handlers ) {
                $app->error(
                            $app->translate( 'Unknown action [_1]', $mode ) );
                last REQUEST;
            }

            $app->response_content(undef);
            $app->{forward} = undef;

            $app->pre_run;

            foreach my $code (@handlers) {

                if ( ref $code eq 'HASH' ) {
                    my $meth_info = $code;
                    $code = $meth_info->{code} || $meth_info->{handler};

                    if ( my $set = $meth_info->{permission} ) {
                        my $user    = $app->user;
                        my $perms   = $app->permissions;
                        my $blog    = $app->blog;
                        my $allowed = 0;
                        if ($user) {
                            my $admin = $user->is_superuser()
                              || (    $blog
                                   && $perms
                                   && $perms->can_administer_blog() );
                            my @p = split(/,/, $set);
                            foreach my $p (@p) {
                                my $perm = 'can_' . $p;
                                $allowed = 1, last
                                  if $admin
                                      || $perms
                                      && (    $perms->can($perm)
                                           && $perms->$perm() );
                            }
                        }
                        unless ($allowed) {
                            $app->errtrans("Permission denied.");
                            last REQUEST;
                        }
                    } ## end if ( my $set = $meth_info...)
                } ## end if ( ref $code eq 'HASH')

                if ( ref $code ne 'CODE' ) {
                    $code = $app->handler_to_coderef($code);
                }

                if ($code) {
                    my @forward_params = @{ $app->{forward_params} }
                      if $app->{forward_params};
                    $app->{forward_params} = undef;
                    my $content = $code->( $app, @forward_params );
                    $app->response_content($content) if defined $content;
                }
            } ## end foreach my $code (@handlers)

            $app->post_run;

            if ( my $new_mode = $app->{forward} ) {
                $mode = $new_mode;
                goto REQUEST;
            }

            $body = $app->response_content();

            if ( ref($body) && ( $body->isa('MT::Template') ) ) {
                defined( my $out = $app->build_page($body) )
                  or die $body->errstr;
                $body = $out;
            }

            # Some browsers throw you to quirks mode if the doctype isn't
            # up front.
            $body =~ s/^\s+(<!DOCTYPE)/$1/s if defined $body;

            unless (    defined $body
                     || $app->{redirect}
                     || $app->{login_again}
                     || $app->{no_print_body} )
            {
                $body = $app->show_error( { error => $app->errstr } );
            }
            $app->error(undef);
        } ## end REQUEST:
    };

    if ( ( !defined $body ) && $app->{login_again} ) {

        # login again!
        require MT::Auth;
        $body = $app->show_login
            or $body = $app->show_error( { error => $app->errstr } );
    }
    elsif ( !defined $body ) {
        my $err = $app->errstr || $@;
        $body = $app->show_error( { error => $err } );
    }

    if ( ref($body) && ( $body->isa('MT::Template') ) ) {
        $body = $app->show_error( { error => $@ || $app->errstr } );
    }

    if ( my $url = $app->{redirect} ) {
        if ( $app->{redirect_use_meta} ) {
            $app->send_http_header();
            $app->print(   '<meta http-equiv="refresh" content="0;url='
                         . $app->{redirect}
                         . '">' );
        }
        else {
            if ( $ENV{MOD_PERL} ) {
                $app->{apache}->header_out( Location => $url );
                $app->response_code( Apache::Constants::REDIRECT() );
                $app->send_http_header;
            }
            else {
                $app->print(
                     $q->redirect( -uri => $url, %{ $app->{cgi_headers} } ) );
            }
        }
    }
    else {
        unless ( $app->{no_print_body} ) {
            $app->send_http_header;
            if ( $MT::DebugMode && !( $MT::DebugMode & 128 ) )
            {    # no need to emit twice
                if ( $body =~ m!</body>!i ) {
                    my $trace = '';
                    if ( $app->{trace} ) {
                        foreach ( @{ $app->{trace} } ) {
                            my $msg = encode_html($_);
                            $trace .= '<li>' . $msg . '</li>' . "\n";
                        }
                    }
                    $trace = "<li>"
                      . sprintf( "Request completed in %.3f seconds.",
                                 Time::HiRes::time()
                                   - $app->{start_request_time} )
                      . "</li>\n"
                      . $trace;
                    if ( $trace ne '' ) {
                        $trace = '<ul>' . $trace . '</ul>';
                        my $panel
                          = "<div class=\"debug-panel\">" . "<h3>"
                          . $app->translate("Warnings and Log Messages")
                          . "</h3>"
                          . "<div class=\"debug-panel-inner\">"
                          . $trace
                          . "</div></div>";
                        $body =~ s!(</body>)!$panel$1!i;
                    }
                } ## end if ( $body =~ m!</body>!i)
            } ## end if ( $MT::DebugMode &&...)
            $app->print($body);
        } ## end unless ( $app->{no_print_body...})
    } ## end else [ if ( my $url = $app->{...})]

    if ($timer) {
        $timer->mark( ref($app) . '::run' );
    }

    $app->takedown();
} ## end sub run

sub forward {
    my $app = shift;
    my ( $new_mode, @params ) = @_;
    $app->{forward}        = $new_mode;
    $app->{forward_params} = \@params;
    return undef;
}

sub handlers_for_mode {
    my $app = shift;
    my ($mode) = @_;

    my $code;

    if ( my $meths = $Global_actions{ ref($app) }
         || $Global_actions{ $app->id } )
    {
        $code = $meths->{$mode} if exists $meths->{$mode};
    }

    $code ||= $app->{vtbl}{$mode};

    return $code;
}

sub mode {
    my $app = shift;
    if (@_) {
        $app->{mode} = shift;
    }
    else {
        if ( my $mode = $app->query->param('__mode') ) {
            $mode =~ s/[<>"']//g;
            $app->{mode} ||= $mode;
        }
    }
    $app->{mode} || $app->{default_mode} || 'default';
}

sub assert {
    my $app = shift;
    my $x   = shift;
    return 1 if $x;
    return $app->errtrans(@_);
}

sub takedown {
    my $app = shift;
    my $cfg = $app->config;

    MT->run_callbacks( ref($app) . '::take_down', $app )
      ;    # arg is the app object

    $app->touch_blogs;

    my $sess = $app->session;
    $sess->save if $sess && $sess->is_dirty;

    $app->user(undef);
    delete $app->{$_}
      for qw( cookies perms session trace response_content _blog
      WeblogPublisher init_request );

    my $driver = $MT::Object::DRIVER;
    $driver->clear_cache if $driver && $driver->can('clear_cache');

    require MT::Auth;
    MT::Auth->release;

    if ( $cfg->PerformanceLogging ) {
        $app->log_times();
    }

    # save_config here so not to miss any dirty config change to persist
    if ( UNIVERSAL::isa( $app, 'MT::App::Upgrader' ) ) {

        # mt_config table doesn't exist during installation
        if ( my $cfg_pkg = $app->model('config') ) {
            my $driver = $cfg_pkg->driver;
            if ( $driver->table_exists($cfg_pkg) ) {
                $cfg->save_config();
            }
        }
    }
    else {
        $cfg->save_config();
    }

    $app->request->finish;
    delete $app->{request};

} ## end sub takedown

sub l10n_filter { $_[0]->translate_templatized( $_[1] ) }

sub load_widgets {
    my $app = shift;
    my ( $page, $param, $default_widgets ) = @_;

    my $user           = $app->user;
    my $blog           = $app->blog;
    my $blog_id        = $blog->id if $blog;
    my $scope          = $blog_id ? 'blog:' . $blog_id : 'system';
    my $resave_widgets = 0;
    my $widget_set     = $page . ':' . $scope;

    # TBD: Fetch list of widgets from user object, or
    # use a default list

    my $widget_store = $user->widgets;
    my $widgets = $widget_store->{$widget_set} if $widget_store;

    unless ($widgets) {
        $resave_widgets = 1;
        $widgets        = $default_widgets;

        # add the 'new_user' / 'new_install' widget...
        unless ($widget_store) {

            # Special case for the MT CMS dashboard and initial
            # widgets used there.
            if ( $page eq 'dashboard' ) {
                if ( $user->id == 1 ) {

                    # first user! good enough guess at this.
                    $widgets->{new_install} = { order => -2, set => 'main' };
                }
                else {
                    $widgets->{new_user} = { order => -2, set => 'main' };
                }

                # Do not show new_version widget for users without specific widgets
                #$widgets->{new_version} = { order => -1, set => 'main' }
                #    unless $app->query->param('installed');
            }
        }
    } ## end unless ($widgets)

    my $all_widgets = $app->registry("widgets");
    $all_widgets
      = $app->filter_conditional_list( $all_widgets, $page, $scope );

    my @loop;
    my @ordered_list;
    my %orders;
    my $order_num = 0;
    foreach my $widget_id ( keys %$widgets ) {
        my $widget_param = $widgets->{$widget_id} ||= {};
        my $order;
        if ( !( $order = $widget_param->{order} ) ) {
            $order                 = $all_widgets->{$widget_id}{order};
            $order                 = ++$order_num unless defined $order;
            $widget_param->{order} = $order_num;
            $resave_widgets        = 1;
        }
        push @ordered_list, $widget_id;
        $orders{$widget_id} = $order;
    }
    @ordered_list = sort { $orders{$a} <=> $orders{$b} } @ordered_list;

    $app->build_widgets(
                         set         => $widget_set,
                         param       => $param,
                         widgets     => $all_widgets,
                         widget_cfgs => $widgets,
                         order       => \@ordered_list,
    ) or return;

    if ($resave_widgets) {
        my $widget_store = $user->widgets();
        $widget_store->{$widget_set} = $widgets;
        $user->widgets($widget_store);
        $user->save;
    }
    return $param;
} ## end sub load_widgets

sub render_widget {
    my $app    = shift;
    my %params = @_;
    my ( $widget_id, $instance, $widget_set, $param, $widget, $widget_cfgs, $order,
         $passthru_param, $scope )
      = @params{qw( widget_id instance set param widget widget_cfgs order passthru_param scope )};
    my $blog = $app->blog;
    my $blog_id = $blog ? $blog->id : 0;
    my $widget_inst = $widget_id . '-' . $instance;
    my $widget_cfg = $widget_cfgs->{$widget_inst} || {};
    my $widget_param = { %$param, %{ $widget_cfg->{param} || {} } };
    foreach (@$passthru_param) {
        $widget_param->{$_} = '';
    }
    my $tmpl_name = $widget->{template};
    my $p = $widget->{plugin};
    my $tmpl;
        if ($p) {
            $tmpl = $p->load_tmpl($tmpl_name);
        }
    else {
        
        # This is probably never used since all
        # widgets in reality are provided through
        # some sort of component/plugin.
        $tmpl = $app->load_tmpl($tmpl_name);
    }
    next unless $tmpl;
    $tmpl_name = '.' . $tmpl_name;
    $tmpl_name =~ s/\.tmpl$//;
    
    my $set = $widget->{set} || $widget_cfg->{set} || 'main';
    local $widget_param->{blog_id}         = $blog_id;
    local $widget_param->{widget_block}    = $set;
    local $widget_param->{widget_id}       = $widget_inst;
    local $widget_param->{widget_scope}    = $scope;
    local $widget_param->{widget_singular} = $widget->{singular} || 0;
    local $widget_param->{magic_token}     = $app->current_magic;
    if ( my $h = $widget->{code} || $widget->{handler} ) {
        $h = $app->handler_to_coderef($h);
        $h->( $app, $tmpl, $widget_param );
    }
    my $ctx = $tmpl->context;
    if ($blog) {
        $ctx->stash( 'blog_id', $blog_id );
        $ctx->stash( 'blog',    $blog );
    }
    
    $app->run_callbacks( 'template_param' . $tmpl_name,
                         $app, $tmpl->param, $tmpl );
    
    my $content = $app->build_page( $tmpl, $widget_param );
    
    if ( !defined $content ) {
        return $app->error(
            "Error processing template for widget $widget_id: "
            . $tmpl->errstr );
    }
    
    $app->run_callbacks( 'template_output' . $tmpl_name,
                         $app, \$content, $tmpl->param, $tmpl );
    
    return ($content,$tmpl);
}

sub build_widgets {
    my $app    = shift;
    my %params = @_;
    my ( $widget_set, $param, $widgets, $widget_cfgs, $order,
         $passthru_param )
      = @params{qw( set param widgets widget_cfgs order passthru_param )};
    $widget_cfgs    ||= {};
    $order          ||= [ keys %$widgets ];
    $passthru_param ||= [qw( html_head js_include )];

    my $blog = $app->blog;
    my $blog_id = $blog->id if $blog;

    # The list of widgets in a user's record
    # is going to look like this:
    #    xxx-1
    #    xxx-2
    #    yyy-1
    #    zzz
    # Any numeric suffix is just a means to distinguish
    # the instance of the widget from other instances.
    # The actual widget id is this minus the instance number.
    foreach my $widget_inst (@$order) {
        my $widget_id = $widget_inst;
        $widget_id =~ s/-(\d+)$//;
        my $num = $1 || 1;
        my $widget = $widgets->{$widget_id};
        next unless $widget;
        my $widget_cfg = $widget_cfgs->{$widget_inst} || {};
        my $widget_param = { %$param, %{ $widget_cfg->{param} || {} } };
        foreach (@$passthru_param) {
            $widget_param->{$_} = '';
        }
        my $set = $widget->{set} || $widget_cfg->{set} || 'main';
        my ($content,$tmpl) = $app->render_widget(
            widget_id    => $widget_id,
            widget       => $widget,
            widget_cfgs  => $widget_cfg,
            set          => $set,
            scope        => $widget_set,
            instance     => $num,
            param        => $widget_param,
            );

        $param->{$set} ||= '';
        $param->{$set} .= $content;

        # Widgets often need to populate script/styles/etc into
        # the header; these are special app-template variables
        # that collect this content and display them in the
        # header. No other widget-parameters are to leak into the
        # parent template parameter namespace (ie, a widget cannot
        # set/alter the page_title).
        foreach (@$passthru_param) {
            $param->{$_} = ( $param->{$_} || '' ) . "\n" . $tmpl->param($_);
        }
    } ## end foreach my $widget_inst (@$order)

    return $param;
} ## end sub build_widgets

sub update_widget_prefs {
    my $app  = shift;
    my $q    = $app->query;
    my $user = $app->user;
    $app->validate_magic or return;

    my $blog          = $app->blog;
    my $blog_id       = $blog->id if $blog;
    my $widget_id     = $q->param('widget_id');
    my $action        = $q->param('widget_action');
    my $widget_scope  = $q->param('widget_scope');
    my $widgets       = $user->widgets || {};
    my $these_widgets = $widgets->{$widget_scope} ||= {};
    my $resave_widgets;
    my $result = {};

    if ( ( $action eq 'remove' ) && $these_widgets ) {
        $result->{message} = $app->translate( "Removed [_1].", $widget_id );
        if ( delete $these_widgets->{$widget_id} ) {
            $resave_widgets = 1;
        }
    }
    if ( $action eq 'add' ) {
        my $set = $q->param('widget_set') || 'main';
        my $all_widgets = $app->registry("widgets");
        if ( my $widget = $all_widgets->{$widget_id} ) {
            my $widget_inst = $widget_id;
            my $num = 1;
            unless ( $widget->{singular} ) {
                while ( exists $these_widgets->{$widget_inst} ) {
                    $widget_inst = $widget_id . '-' . $num;
                    $num++;
                }
            }
            $these_widgets->{$widget_inst} = { set => $set };
            my $param;
            eval { require MT::Image; MT::Image->new or die; };
            $param->{can_use_userpic} = $@ ? 0 : 1;
            $param->{widget_id} = $widget_id;
            $param->{widget_set} = $set;
            my ($content,$tmpl) = $app->render_widget(
                widget_id   => $widget_id,
                widget      => $widget,
                set         => $set,
                scope       => $blog_id ? 'dashboard:blog:' . $blog_id : 'dashboard:system',
                instance    => $num,
                param       => $param,
                ) or return;
            $result->{'widget_html'} = $content;
        }

        $result->{'widget_set'}  = $set;
        $resave_widgets = 1;
    }
    if ( ( $action eq 'save' ) && $these_widgets ) {
        my %all_params = $q->param;
        my $refresh = $all_params{widget_refresh} ? 1 : 0;
        delete $all_params{$_}
          for
          qw( json widget_id widget_action __mode widget_set widget_singular widget_refresh magic_token widget_scope return_args );
        $these_widgets->{$widget_id}{param} = {};
        $these_widgets->{$widget_id}{param}{$_} = $all_params{$_}
          for keys %all_params;
        $widgets->{$widget_scope} = $these_widgets;
        $resave_widgets = 1;
        if ($refresh) {
            $result->{html} = 'widget!';    # $app->render_widget();
        }
    }
    if ($resave_widgets) {
        $user->widgets($widgets);
        $user->save;
    }
    if ( $q->param('json') ) {
        return $app->json_result($result);
    }
    else {
        $app->add_return_arg( 'saved' => 1 );
        $app->call_return;
    }
} ## end sub update_widget_prefs

sub load_widget_list {
    my $app = shift;
    my ( $page, $param, $default_set ) = @_;

    my $blog    = $app->blog;
    my $blog_id = $blog->id if $blog;
    my $scope   = $page . ':' . ( $blog_id ? 'blog:' . $blog_id : 'system' );

    my $user_widgets = $app->user->widgets || {};
    $user_widgets = $user_widgets->{$scope} || $default_set || {};
    my %in_use;
    foreach my $uw ( keys %$user_widgets ) {
        $uw =~ s/-\d+$//;
        $in_use{$uw} = 1;
    }

    my $all_widgets = $app->registry("widgets");
    my $widgets     = [];

    # First, filter out any 'singular' widgets that are already
    # in the user's widget bag
    foreach my $id ( keys %$all_widgets ) {
        my $w = $all_widgets->{$id};
        if ( $w->{singular} ) {

            # don't allow multiple widgets
            next if exists $in_use{$id};
        }
        $w->{id} = $id;
        push @$widgets, $w;
    }

    # Now filter remaining widgets based on any permission
    # or declared condition
    $widgets = $app->filter_conditional_list( $widgets, $page, $scope );

    # Finally, build the widget loop, but don't include
    # any widgets that are unlabeled, since these are
    # added by the system and cannot be manually added.
    my @widget_loop;
    foreach my $w (@$widgets) {
        my $label = $w->{label} or next;
        $label = $label->() if ref($label) eq 'CODE';
        next unless $label;
        push @widget_loop,
          {
            widget_id => $w->{id},
            ( $w->{set} ? ( widget_set => $w->{set} ) : () ),
            widget_label => $label,
          };
    }
    @widget_loop
      = sort { $a->{widget_label} cmp $b->{widget_label} } @widget_loop;
    $param->{widget_scope}    = $scope;
    $param->{all_widget_loop} = \@widget_loop;
} ## end sub load_widget_list

sub load_list_actions {
    my $app = shift;
    my ( $type, $param, @p ) = @_;
    my $all_actions = $app->list_actions( $type, @p );
    if ( ref($all_actions) eq 'ARRAY' ) {
        my @plugin_actions;
        my @core_actions;
        my @button_actions;
        foreach my $a (@$all_actions) {
            if ( $a->{button} ) {
                push @button_actions, $a;
            }
            elsif ( $a->{core} ) {
                push @core_actions, $a;
            }
            else {
                push @plugin_actions, $a;
            }
        }
        $param->{more_list_actions} = \@plugin_actions;
        $param->{list_actions}      = \@core_actions;
        $param->{button_actions}    = \@button_actions;
        $param->{all_actions}       = $all_actions;
        $param->{has_pulldown_actions}
            = ( @plugin_actions || @core_actions ) ? 1 : 0;
        $param->{has_list_actions} = scalar @$all_actions;

    }
    my $filters = $app->list_filters( $type, @p );
    $param->{list_filters} = $filters if $filters;
    return $param;
} ## end sub load_list_actions

sub load_content_actions {
    my $app = shift;
    my ( $type, $param, @p ) = @_;
    my $all_actions = $app->content_actions( $type, @p );
    if ( ref($all_actions) eq 'ARRAY' ) {
        $param->{content_actions} = $all_actions;
    }
    return $param;
}

sub current_magic {
    my $app  = shift;
    my $sess = $app->session;
    return ( $sess ? $sess->id : undef );
}

sub validate_magic {
    my $app = shift;
    my $q   = $app->query;
    return 1
      if $q->param('username')
          && $q->param('password')
          && $app->request('fresh_login');
    $app->{login_again} = 1, return undef
      unless ( $app->current_magic || '' ) eq
      ( $q->param('magic_token') || '' );
    1;
}

sub delete_param {
    my $app   = shift;
    my $q     = $app->query;
    my ($key) = @_;
    return unless $q;
    if ( $ENV{MOD_PERL} ) {
        my $tab = $q->parms;
        $tab->unset($key);
    }
    else {
        $q->delete($key);
    }
}

######## DEPRECATED AND FUTURE BREAK ##########
# Please see this method's POD documentation  #
###############################################
sub param_hash {
    my $app = shift;
    my $q   = $app->query;
    return () unless $q;
    my @params = $q->param();
    my %result;
    foreach my $p (@params) {
        $result{$p} = $q->param($p);
    }
    %result;
}

## Path/server/script-name determination methods

sub query_string {
    my $app = shift;
    $ENV{MOD_PERL} ? $app->{apache}->args : $app->query->query_string;
}

sub return_uri {
    $_[0]->uri . '?' . $_[0]->return_args;
}

sub call_return {
    my $app = shift;
    $app->add_return_arg(@_) if @_;
    $app->redirect( $app->return_uri );
}

sub state_params {
    my $app = shift;
    return $app->{state_params} ? @{ $app->{state_params} } : ();
}

# make_return_args
# Creates a query string that refers to the same view as the one we're
# already rendering.
sub make_return_args {
    my $app  = shift;
    my $q    = $app->query;
    my @vars = $app->state_params;
    my %args;
    foreach my $v (@vars) {
        if ( my @p = $q->param($v) ) {
            $args{$v} = ( scalar @p > 1 && $v eq 'filter_val' ) ? \@p : $p[0];
        }
    }
    my $return = $app->uri_params( mode => $app->mode, 'args' => \%args );
    $return =~ s/^\?//;
    $return;
}

sub return_args {
    $_[0]->{return_args} = $_[1] if $_[1];
    $_[0]->{return_args};
}

sub add_return_arg {
    my $app = shift;
    if ( scalar @_ == 1 ) {
        $app->{return_args} .= '&' if $app->{return_args};
        $app->{return_args} .= shift;
    }
    else {
        my (%args) = @_;
        foreach my $a ( sort keys %args ) {
            $app->{return_args} .= '&' if $app->{return_args};
            if ( ref $args{$a} eq 'ARRAY' ) {
                $app->{return_args} .= $a . '=' . encode_url($_)
                  foreach @{ $args{$a} };
            }
            else {
                $app->{return_args} .= $a . '=' . encode_url( $args{$a} );
            }
        }
    }
} ## end sub add_return_arg

sub base {
    my $app = shift;
    return $app->{__host} if exists $app->{__host};
    my $cfg = $app->config;
    my $path
      = $app->{is_admin}
      ? ( $cfg->AdminCGIPath || $cfg->CGIPath )
      : $cfg->CGIPath;
    if ( $path =~ m!^(https?://[^/]+)!i ) {
        ( my $host = $1 ) =~ s!/$!!;
        return $app->{__host} = $host;
    }

    # determine hostname from environment (supports relative CGI paths)
    if ( my $host = $ENV{HTTP_HOST} ) {
        return $app->{__host}
          = 'http' . ( $app->is_secure ? 's' : '' ) . '://' . $host;
    }
    '';
} ## end sub base

*path = \&mt_path;

sub mt_path {
    my $app = shift;
    return $app->{__mt_path} if exists $app->{__mt_path};

    my $cfg = $app->config;
    my $path;
    $path
      = $app->{is_admin}
      ? ( $cfg->AdminCGIPath || $cfg->CGIPath )
      : $cfg->CGIPath;
    if ( $path =~ m!^https?://[^/]+(/?.*)$!i ) {
        $path = $1;
    }
    elsif ( !$path ) {
        $path = '/';
    }
    $path .= '/' unless substr( $path, -1, 1 ) eq '/';
    $app->{__mt_path} = $path;
}

sub app_path {
    my $app = shift;
    return $app->{__path} if exists $app->{__path};

    my $path;
    if ( $ENV{MOD_PERL} ) {
        $path = $app->{apache}->uri;
        $path =~ s!/[^/]*$!!;
    }
    elsif ( $app->query ) {
        $path = $app->query->url;
        $path =~ s!/[^/]*$!!;

        # '@' within path is okay; this is for Yahoo!'s hosting environment.
        $path =~ s/%40/@/;
    }
    else {
        $path = $app->mt_path;
    }
    if ( $path =~ m!^https?://[^/]+(/?.*)$!i ) {
        $path = $1;
    }
    elsif ( !$path ) {
        $path = '/';
    }
    $path .= '/' unless substr( $path, -1, 1 ) eq '/';
    $app->{__path} = $path;
} ## end sub app_path

sub envelope {''}

sub script {
    my $app = shift;
    return $app->{__script} if exists $app->{__script};
    my $script = $ENV{MOD_PERL} ? $app->{apache}->uri : $ENV{SCRIPT_NAME};
    if ( !$script ) {
        require File::Basename;
        import File::Basename qw(basename);
        $script = basename($0);
    }
    $script =~ s!/$!!;
    $script = ( split /\//, $script )[-1];
    $app->{__script} = $script;
}

sub uri {
    my $app = shift;
    $app->{is_admin} ? $app->mt_uri(@_) : $app->app_uri(@_);
}

sub app_uri {
    my $app = shift;
    $app->app_path . $app->script . $app->uri_params(@_);
}

# app_uri refers to the active app script
sub mt_uri {
    my $app = shift;
    $app->mt_path . $app->config->AdminScript . $app->uri_params(@_);
}

# mt_uri refers to mt's script even if we're in a plugin.
sub uri_params {
    my $app = shift;
    my (%param) = @_;
    my @params;
    push @params, '__mode=' . $param{mode} if $param{mode};
    if ( $param{args} ) {
        foreach my $p ( keys %{ $param{args} } ) {
            if ( ref $param{args}{$p} eq 'ARRAY' ) {
                push @params, ( $p . '=' . encode_url($_) )
                  foreach @{ $param{args}{$p} };
            }
            else {
                push @params, ( $p . '=' . encode_url( $param{args}{$p} ) )
                  if defined $param{args}{$p};
            }
        }
    }
    @params ? '?' . ( join '&', @params ) : '';
}

sub path_info {
    my $app = shift;
    return $app->{__path_info} if exists $app->{__path_info};
    my $path_info;
    if ( $ENV{MOD_PERL} ) {
        ## mod_perl often leaves part of the script name (Location)
        ## in the path info, for some reason. This should remove it.
        $path_info = $app->{apache}->path_info;
        if ($path_info) {
            my ($script_last) = $app->{apache}->location =~ m!/([^/]+)$!;
            $path_info =~ s!^/$script_last!!;
        }
    }
    else {
        return undef unless $app->query;
        $path_info = $app->query->path_info;
    }
    $app->{__path_info} = $path_info;
}

sub is_secure {
    my $app = shift;
    $ENV{MOD_PERL}
      ? $app->{apache}->subprocess_env('https')
      : $app->query->protocol() eq 'https';
}

sub redirect {
    my $app = shift;
    my ( $url, %options ) = @_;
    $url =~ s/[\r\n].*$//s;
    $app->{redirect_use_meta} = $options{UseMeta};
    unless ( $url =~ m!^https?://!i ) {
        $url = $app->base . $url;
    }
    $app->{redirect} = $url;
    return;
}

######## DEPRECATED AND FUTURE BREAK ##########
# Please see this method's POD documentation  #
###############################################
sub param {
    my $app = shift;
    my $q = $app->query or return;    # Hapless if not harmless...
    if (@_) {
        Melody::DeprecatedParamUsage->warn( $app, 'get_set' );
        return $q->param(@_);
    }
    else {
        if (wantarray) {
            Melody::DeprecatedParamUsage->warn( $app, 'param_hash' );
            return ( map { $_ => $q->param($_) } $q->param );
        }
        else {
            Melody::DeprecatedParamUsage->warn( $app, 'query_object' );
            return $q;
        }
    }
}

########### MT COMPATIBILITY NOTE #############
# Please see this method's POD documentation  #
# about cross-compatibility with Movable Type #
###############################################
# TODO: Under CGI::Application, forward call to cgiapp_get_query()
# Eventually upon switching to CGI::Application the query method would call
# cgiapp_get_query() and NOT set the query object as it does now in
# MT::App::init_request. Besides compatability, this would enable developers
# to do any special request handling.
sub query {
    my $app = shift;
    my ($query) = @_;
    return defined $query ? $app->{__query} = $query : $app->{__query};
}

sub blog {
    my $app = shift;
    $app->{_blog} = shift if @_;
    return $app->{_blog} if $app->{_blog};
    return undef unless $app->query;
    my $blog_id = $app->query->param('blog_id');
    if ($blog_id) {
        $app->{_blog} = MT->model('blog')->load($blog_id);
    }
    return $app->{_blog};
}

## Logging/tracing

sub log {
    my $app   = shift;
    my ($msg) = @_;
    my $blog  = $app->blog;
    my $user  = $app->user;
    my %defaults = (
                     message => '',
                     ip      => $app->remote_ip,
                     $blog ? ( blog_id   => $blog->id ) : (),
                     $user ? ( author_id => $user->id ) : (),
    );

    # If we are given a hash reference, simply assign the
    # default value to any key with an undefined value.
    if ( ref $msg eq 'HASH' ) {

        $msg->{$_} = $defaults{$_}
          foreach grep { !defined $msg->{$_} } keys %defaults;
    }

    # If we are given a log object, do the same but using
    # the normal MT::Object accessor/mutator syntax
    elsif ( blessed $msg and $msg->isa('MT::Log') ) {

        $msg->$_( $defaults{$_} )
          foreach grep { !defined $msg->$_ } keys %defaults;
    }

    # Otherwise, we've been given a simple string which
    # we will turn into a hash reference filling in the
    # defaults for undefined values
    else {
        $msg = { %defaults, message => $msg };
    }

    # Now, send it on up to the SUPER class
    $app->SUPER::log($msg);

} ## end sub log

sub trace {
    my $app = shift;
    $app->{trace} ||= [];
    if ( $MT::DebugMode & 2 ) {
        require Carp;
        local $Carp::CarpLevel = 1;
        my $msg = "@_";
        chomp $msg;
        push @{ $app->{trace} }, Carp::longmess($msg);
    }
    else {
        push @{ $app->{trace} }, "@_";
    }
    if ( $MT::DebugMode & 128 ) {
        my @caller = caller(1);
        my $place
          = $caller[0] . '::'
          . $caller[3] . ' in '
          . $caller[1]
          . ', line '
          . $caller[2];
        if ( $MT::DebugMode & 2 ) {
            local $Carp::CarpLevel = 1;
            my $msg = "@_";
            chomp $msg;
            print STDERR Carp::longmess("(warn from $place) $msg");
        }
        else {
            print STDERR "(warn from $place) @_\n";
        }
    }
} ## end sub trace

sub remote_ip {
    my $app = shift;

    my $trusted = $app->config->TransparentProxyIPs || 0;
    my $remote_ip
      = (   $ENV{MOD_PERL}
          ? $app->{apache}->connection->remote_ip
          : $ENV{REMOTE_ADDR} );
    $remote_ip ||= '127.0.0.1';
    my $ip = $trusted ? $app->get_header('X-Forwarded-For') : $remote_ip;
    if ($trusted) {
        if ( $trusted =~ m/^\d+$/ ) {

            # TransparentProxyIPs of 1, means to use the
            # right-most IP from X-Forwarded-For (remote_ip is the proxy)
            # TransparentProxyIPs of 2, means to use the
            # next-to-last IP from X-Forwarded-For.
            $trusted--;    # assumes numeric value
            my @iplist = reverse split /\s*,\s*/, $ip;
            if (@iplist) {
                do {
                    $ip = $iplist[ $trusted-- ];
                } while ( $trusted >= 0 && !$ip );
                $ip ||= $remote_ip;
            }
            else {
                $ip = $remote_ip;
            }
        }
        elsif ( $trusted =~ m/^\d+\./ ) {    # looks IP-ish
                # In this form, TransparentProxyIPs can be a list of
                # IP or subnet addresses to exclude as trusted IPs
                # TransparentProxyIPs 10.1.1., 12.34.56.78
            my @trusted = split /\s*,\s*/, $trusted;
            my @iplist = reverse split /\s*,\s*/, $ip;
            while ( @iplist && grep( { $iplist[0] =~ m/^\Q$_\E/ } @trusted ) )
            {
                shift @iplist;
            }
            $ip = @iplist ? $iplist[0] : $remote_ip;
        }
    } ## end if ($trusted)

    return $ip;
} ## end sub remote_ip

sub document_root {
    my $app = shift;
    my $cwd = '';
    if ( $ENV{MOD_PERL} ) {
        ## If mod_perl, just use the document root.
        $cwd = $app->{apache}->document_root;
    }
    else {
        $cwd = $ENV{DOCUMENT_ROOT} || $app->mt_dir;
    }
    $cwd = File::Spec->canonpath($cwd);
    $cwd =~ s!([\\/])cgi(?:-bin)?([\\/].*)?$!$1!;
    $cwd =~ s!([\\/])mt[\\/]?$!$1!i;
    return $cwd;
}

sub DESTROY {
    ## Destroy the Request object, which is used for caching
    ## per-request data. We have to do this manually, because in
    ## a persistent environment, the object will not go out of scope.
    ## Same with the ConfigMgr object and ObjectDriver.
    MT::Request->finish();
    undef $MT::Object::DRIVER;
    undef $MT::Object::DBI_DRIVER;
    undef $MT::ConfigMgr::cfg;
}

sub set_no_cache {
    my $app = shift;
    ## Add the Pragma: no-cache header.
    if ( $ENV{MOD_PERL} ) {
        $app->{apache}->no_cache(1);
    }
    else {
        $app->query->cache('no');
    }
}


package Melody::DeprecatedParamUsage;

# FIXME Move Melody::DeprecatedParamUsage to a Melody compatibility layer

sub warn {
    my $self = shift;
    my ( $app, $type ) = @_;
    my ( $package, $filename, $line ) = caller(1);

    my %usage = $self->usage();
    my $msg   = 'DEPRECATION WARNING: Use of $app->param to [_1] in [_2] '
      . 'at line [_3] will break in the future. Use [_4] instead.';

    my $transmsg = $app->translate( $msg, $usage{$type}{description},
                                    $package, $line,
                                    $usage{$type}{replacement} );
    print STDERR $transmsg . "\n";
    warn $transmsg . "\n";
}

# Mapping of each type of deprecated $app->param usage
# to an expanded description and replacement method.
# This is a separate method so that the warnings can be
# programmatically tested for.
sub usage {
    return (
             get_set => {
                          description => 'get/set query object properties',
                          replacement => '$app->query->param()',
             },
             param_hash => {
                            description => 'fetch a hash of query parameters',
                            replacement => '$app->query->Vars',
             },
             query_object => {
                               description => 'fetch the CGI query object',
                               replacement => '$app->query',
             },
    );
}

package Melody::DeprecatedQueryUsage;

sub TIESCALAR { return bless {}, $_[0]; }

sub FETCH {
    my $self = shift;
    my ( $package, $filename, $line ) = caller(1);
    my $msg
      = 'DEPRECATION WARNING: Direct access to $app->{query} '
      . "in $package at line $line will break in the near future. "
      . "Use \$app->query instead. See MT::App POD for details.\n";
    print STDERR $msg;
    warn $msg;
    my $app = MT->instance;
    return $app->query();
}

sub STORE {
    my $self = shift;
    my ( $package, $filename, $line ) = caller(1);
    my $msg
      = 'DEPRECATION WARNING: Direct assignment to $app->{query} in '
      . "$package at line $line will break in the near future. Use "
      . "\$app->query( OBJ ) instead. See MT::App POD for details.\n";
    print STDERR $msg;
    warn $msg;
    my $app = MT->instance;
    return $app->query(@_);
}

1;

__END__

=head1 NAME

MT::App - Movable Type base web application class

=head1 SYNOPSIS

    package MT::App::Foo;
    use MT::App;
    @MT::App::Foo::ISA = qw( MT::App );

    package main;
    my $app = MT::App::Foo->new;
    $app->run;

=head1 DESCRIPTION

L<MT::App> is the base class for Movable Type web applications. It provides
support for an application running using standard CGI, or under
L<Apache::Registry>, or as a L<mod_perl> handler. L<MT::App> is not meant to
be used directly, but rather as a base class for other web applications using
the Movable Type framework (for example, L<MT::App::CMS>).

=head1 USAGE

L<MT::App> subclasses the L<MT> class, which provides it access to the
publishing methods in that class.

=head1 CALLBACKS

=over 4

=item <package>::template_source

=item <package>::template_source.<filename>

    callback($eh, $app, \$tmpl)

Executed after loading the MT::Template file.  The E<lt>packageE<gt> portion
is the full package name of the application running. For example,

    MT::App::CMS::template_source.menu

Is the full callback name for loading the menu.tmpl file under the
L<MT::App::CMS> application. The "MT::App::CMS::template_source" callback is
also invoked for all templates loading by the CMS.  Finally, you can also hook
into:

    *::template_source

as a wildcard callback name to capture any C<MT::Template> files that are
loaded regardless of application.

=item <package>::template_param

=item <package>::template_param.<filename>

    callback($eh, $app, \%param, $tmpl)

This callback is invoked in conjunction with the MT::App-E<gt>build_page
method. The $param argument is a hashref of L<MT::Template> parameter
data that will eventually be passed to the template to produce the page.

=item <package>::template_output

=item <package>::template_output.<filename>

    callback($eh, $app, \$tmpl_str, \%param, $tmpl)

This callback is invoked in conjunction with the MT::App-E<gt>build_page
method. The C<$tmpl_str> parameter is a string reference for the page that
was built by the MT::App-E<gt>build_page method. Since it is a reference,
it can be modified by the callback. The C<$param> parameter is a hash reference to the parameter data that was given to build the page. The C<$tmpl>
parameter is the L<MT::Template> object used to generate the page.

=back

=head1 METHODS

Following are the list of methods specific to L<MT::App>:

=head2 MT::App->new

Constructs and returns a new L<MT::App> object.

=head2 $app->init_request

Invoked at the start of each request. This method is a good place to
initialize any settings that are request-specific. When overriding this
method, B<always> call the superclass C<init_request> method.

One such setting is the C<requires_login> member element that controls
whether the active application mode requires the user to login first.

Example:

    sub init_request {
        my $app = shift;
        $app->SUPER::init_request(@_);
        $app->{requires_login} = 1 unless $app->mode eq 'unprotected';
    }

=head2 $app->COMMENTER_COOKIE_NAME

This is a static constant/method representing the name of the cookie used for
commenters. It is analogous to C<commenter_cookie>.

=head2 $app->commenter_cookie

This is a static constant/method representing the name of the cookie used for
commenters. It is analogous to C<COMMENTER_COOKIE_NAME>.

=head2 $app->run

Runs the application. This gathers the input, chooses the method to execute,
executes it, and prints the output to the client.

If an error occurs during the execution of the application, L<run> handles all
of the errors thrown either through the L<MT::ErrorHandler> or through C<die>.

=head2 $app->login

Checks the user's credentials, first by looking for a login cookie, then by
looking for the C<username> and C<password> CGI parameters. In both cases,
the username and password are verified for validity. This method does not set
the user's login cookie, however--that should be done by the caller (in most
cases, the caller is the L<run> method).

On success, returns the L<MT::Author> object representing the author who logged
in, and a boolean flag; if the boolean flag is true, it indicates the the login
credentials were obtained from the CGI parameters, and thus that a cookie
should be set by the caller. If the flag is false, the credentials came from
an existing cookie.

On an authentication error, L<login> removes any authentication cookies that
the user might have on his or her browser, then returns C<undef>, and the
error message can be obtained from C<$app-E<gt>errstr>.

=head2 $app->logout

A handler method for logging the user out of the application.

=head2 $app->send_http_header([ $content_type ])

Sends the HTTP header to the client; if C<$content_type> is specified, the
I<Content-Type> header is set to C<$content_type>. Otherwise, C<text/html> is
used as the default.

In a L<mod_perl> context, this calls the L<Apache::send_http_header> method;
in a CGI context, the L<CGI::header> method is called.

=head2 $app->print(@data)

Sends data C<@data> to the client.

In a L<mod_perl> context, this calls the L<Apache::print> method; in a CGI
context, data is printed directly to STDOUT.

=head2 $app->bake_cookie(%arg)

Bakes a cookie to be sent to the client.

C<%arg> can contain any valid parameters to the C<new> methods of
L<CGI::Cookie> (or L<Apache::Cookie>--both take the same parameters). These
include C<-name>, C<-value>, C<-path>, C<-secure>, and C<-expires>.

If you do not include the C<-path> parameter in C<%arg>, it will be set
automatically to C<$app-E<gt>path> (below).

In a L<mod_perl> context, this method uses L<Apache::Cookie>; in a CGI context,
it uses L<CGI::Cookie>.

This method will automatically assign a "secure" flag for the cookie if it the current HTTP request is using the https protocol. To forcibly disable the secure flag, provide a C<-secure> argument with a value of 0.

=head2 $app->cookies

Returns a reference to a hash containing cookie objects, where the objects are
either of class L<Apache::Cookie> (in a L<mod_perl> context) or L<CGI::Cookie>
(in a CGI context).

=head2 $app->user_cookie

Returns the string of the cookie name used for the user login cookie.

=head2 $app->user

Returns the object of the logged in user. Typically a L<MT::Author>
object.

=head2 $app->clear_login_cookie

Sends a cookie back to the user's browser which clears their existing
authenication cookie.

=head2 $app->current_magic

Returns the active user's "magic token" which is used to validate posted data
with the C<validate_magic> method.

=head2 $app->make_magic_token

Creates a new "magic token" string which is a random set of characters.
The

=head2 $app->add_return_arg(%param)

Adds one or more arguments to the list of 'return' arguments that are
use to construct a return URL.

Example:

    $app->add_return_arg(finished_task => 1)
    $app->call_return;

This will redirect the user back to the URL they came from, adding a
new 'finished_task' query parameter to the URL.

=head2 $app->call_return

Invokes C<$app-E<gt>redirect> using the C<$app-E<gt>return_uri> method
as the address.

=head2 $app->make_return_args

Constructs the list of return arguments using the
data available from C<$app-E<gt>state_params> and C<$app->E<gt>mode>.

=head2 $app->mode([$mode])

Gets or sets the active application run mode.

=head2 $app->state_params

Returns a list of the parameter names that preserve the given state
of the application. These are declared during the application's C<init>
method, using the C<state_params> member element.

Example:

    $app->{state_params} = ['filter','page','blog_id'];

=head2 $app->return_args([$args])

Gets or sets a string containing query parameters which is used by
C<return_uri> in constructing a 'return' address for the current
request.

=head2 $app->return_uri

Returns a string composed of the C<$app-E<gt>uri> and the
C<$app-E<gt>return_args>.

=head2 $app->upload_info($param_name)

    ($fh,$info_href) = $app->upload_info('field_name');

Automatically selecting either Apache::Request or CGI.pm, returns
a file handle and a hashref of header details for a given field name.
If there is a problem with the upload, undef will be returned instead
and a warning may be logged with more detail.

=head2 $app->uri_params(%param)

A utility method that assembles the query portion of a URI, taking
a mode and set of parameters. The string returned does include the '?'
character if query parameters exist.

Example:

    my $query_str = $app->uri_params(mode => 'go',
                                     args => { 'this' => 'that' });
    # $query_str == '?__mode=go&this=that'

=head2 $app->session([$element[,$value]])

Returns the active user's session object. This also acts as a get/set
method for assigning arbitrary data into the user's session record.
At the end of the active request, any unsaved session data is written
to the L<MT::Session> record.

Example:

    # saves the value of a 'color' parameter into the user's session
    # this value will persist from one request to the next, but will
    # be cleared when the user logs out or has to reauthenicate.
    $app->session('color', $app->query->param('color'))

=head2 $app->start_session([$author, $remember])

Initializes a new user session by both calling C<make_session> and
setting the user's login cookie.

=head2 $app->make_session

Creates a new user session MT::Session record for the active user.

=head2 $app->session_user($user_obj, $session_id, %options)

Given an existing user object and a session ID ("token"), this returns the
user object back if the session's user ID matches the requested
$user_obj-E<gt>id, undef if the session can't be found or if the session's
user ID doesn't match the $user_obj-E<gt>id.

=head2 $app->show_error($error)

Handles the display of an application error.

=head2 $app->envelope

This method is deprecated.

=head2 $app->show_login(\%param)

Builds the log-in screen.

=head2 $app->takedown

Called at the end of the web request for cleanup purposes.

=head2 $app->add_breadcrumb($name, $uri)

Adds to the navigation history path that is displayed to the end user when
using the application.  The last breadcrumb should always be a reference to
the active mode of the application. Example:

    $app->add_breadcrumb('Edit Foo',
        $app->uri_params(mode => 'edit',
                         args => { '_type' => 'foo' }));

=head2 $app->add_methods(%arg)

Used to supply the application class with a list of available run modes and
the code references for each of them. C<%arg> should be a hash list of
methods and the code reference for it. Example:

    $app->add_methods(
        'one' => \&one,
        'two' => \&two,
        'three' => \&three,
    );

=head2 $app->add_plugin_action($where, $action_link, $link_text)

  $app->add_plugin_action($where, $action_link, $link_text)

Adds a link to the given plugin action from the location specified by
$where. This allows plugins to create actions that apply to, for
example, the entry which the user is editing. The type of object the
user was editing, and its ID, are passed as parameters.

Values that are used from the $where parameter are as follows:

=over 4

=item * list_entries

=item * list_commenter

=item * list_comments

=item * <type>
(Where <type> is any object that the user can already edit, such as
'entry,' 'comment,' 'commenter,' 'blog,' etc.)

=back

The C<$where> value will be passed to the given action_link as a CGI
parameter called C<from>. For example, on the list_entries page, a
link will appear to:

    <action_link>&from=list_entries

If the $where is a single-item page, such as an entry-editing page,
then the action_link will also receive a CGI parameter C<id> whose
value is the ID of the object under consideration:

    <action_link>&from=entry&id=<entry-id>

Note that the link is always formed by appending an ampersand. Thus,
if your $action_link is simply the name of a CGI script, such as
my-plugin.cgi, you'll want to append a '?' to the argument you pass:

    MT->add_plugin_action('entry', 'my-plugin.cgi?', \
                          'Touch this entry with MyPlugin')

Finally, the $link_text parameter specifies the text of the link; this
value will be wrapped in E<lt>a> tags that point to the $action_link.

=head2 $app->plugin_actions($type)

Returns a list of plugin actions that are registered for the C<$type>
specified. The return value is an array of hashrefs with the following
keys set for each: C<page> (the registered 'action link'),
C<link_text> (the registered 'link text'), C<plugin> (the plugin's envelope).
See the documentation for
L<$app-E<gt>add_plugin_action($where, $action_link, $link_text)>
for more information.

=head2 $app->app_path

Returns the path portion of the active URI.

=head2 $app->app_uri

Returns the current application's URI.

=head2 $app->mt_path

Returns the path portion of the URI that is used for accessing the MT CGI
scripts.

=head2 $app->mt_uri

Returns the full URI of the MT "admin" script (typically a reference to
index.cgi).

=head2 $app->blog

Returns the active blog, if available. The I<blog_id> query
parameter identifies this blog.

=head2 $app->touch_blogs

An internal routine that is used during the end of an application
request to update each L<MT::Blog> object's timestamp if any of it's
child objects were changed during the application request.

=head2 $app->tmpl_prepend(\$str, $section, $id, $content)

Adds text at the top of a MT marker tag identified by C<$section> and
C<$id>. If a template contains the following:

    <MT_HEAD:STYLE>
    <link ...>
    </MT_HEAD:STYLE>

A call to tmpl_prepend like this:

    $app->tmpl_prepend($tmpl_ref, 'HEAD', 'STYLE', "new link tag\n");

will result in this change in the template page:

    <MT_HEAD:STYLE>
    new link tag
    <link ...>
    </MT_HEAD:STYLE>

=head2 $app->tmpl_append(\$str, $section, $id, $content)

Adds text at the bottom of a MT marker tag identified by C<$section> and
C<$id>. If a template contains the following:

    <MT_HEAD:STYLE>
    <link ...>
    </MT_HEAD:STYLE>

A call to tmpl_append like this:

    $app->tmpl_append($tmpl_ref, 'HEAD', 'STYLE', "new link tag\n");

will result in this change in the template page:

    <MT_HEAD:STYLE>
    <link ...>
    new link tag
    </MT_HEAD:STYLE>

=head2 $app->tmpl_replace(\$str, $section, $id, $content)

Replaces text within a MT marker tag identified by C<$section> and
C<$id>. If a template contains the following:

    <MT_HEAD:STYLE>
    <link ...>
    </MT_HEAD:STYLE>

A call to tmpl_replace like this:

    $app->tmpl_prepend($tmpl_ref, 'HEAD', 'STYLE', "new style content\n");

will result in this change in the template page:

    <MT_HEAD:STYLE>
    new style content
    </MT_HEAD:STYLE>

=head2 $app->tmpl_select(\$str, $section, $id)

Returns the text found within a MT marker tag identified by C<$section> and
C<$id>. If a template contains the following:

    <MT_HEAD:STYLE>
    <link ...>
    </MT_HEAD:STYLE>

A call to tmpl_select like this:

    my $str = $app->tmpl_select($tmpl_ref, 'HEAD', 'STYLE');

will select the following and return it:

    <link ...>

=head2 $app->cookie_val($name)

Returns the value of a given cookie.

=head2 $app->delete_param($param)

Clears the value of a given CGI parameter.

=head2 $app->errtrans($msg[, @param])

Translates the C<$msg> text, passing through C<@param> for any parameters
within the message. This also sets the error state of the application,
assinging the translated text as the error message.

=head2 $app->get_header($header)

Returns the value of the specified HTTP header.

=head2 MT::App->handler

The mod_perl handler used when the application is run as a native
mod_perl handler.

=head2 $app->init(@param)

Initializes the application object, setting default values and establishing
the parameters necessary to run.  The @param values are passed through
to the parent class, the C<MT> package.

This method needs to be invoked by any subclass when the object is
initialized.

=head2 $app->is_authorized

Returns a true value if the active user is authorized to access the
application. By default, this always returns true; subclasses may
override it to check app-specific authorization. A login attempt will
be rejected with a generic error message at the MT::App level, if
is_authorized returns false, but MT::App subclasses may wish to
perform additional checks which produce more specific error messages.

Subclass authors can assume that $app->user is populated with the
authenticated user when this routine is invoked, and that CGI query object is
available through C<< $app->query >>. Note that the use of $app->{query} and
C<< $app->query->param >> to fetch the query object is deprecated.

=head2 $app->is_secure

Returns a boolean result based on whether the application request is
happening over a secure (HTTPS) connection.

=head2 $app->l10n_filter

Alias for C<MT-E<gt>translate_templatized>.

=head2 $app->param (DEPRECATED, FUTURE BREAK)

B<This method will soon change and break existing code. Please update your
calls to it with acceptable forward-compatible alternatives listed below.>

Historically, this method has served as a proxy for storing and accessing the
CGI request query object and its properties. Melody will be migrating to
CGI::Application which also provides a param() method but it's used for
storing and accessing I<application data>.

CGI::Application provides access to the query object and its data through the
C<query()> method and most of the C<param()> method's historical uses are
satisfied through C<< $app->query->param() >>.

This version of Melody maintains backwards compatibility but will issue a
deprecation warning (via C<Melody::DeprecatedParamUsage::warn()>) to allow
admins to upgrade their plugins. There is no guarantee that the next version
of Melody will do the same.

=head3 Forward-compatible alternatives

B<Developers:> Below is a list of historical calling signatures with their
forward-compatible replacements:

          OLD USAGE            |          NEW USAGE
    ---------------------------|---------------------------------------
    %param = $app->param;      |   @param_keys = $app->param;  # Array!
    $query = $app->param;      |   $query = $app->query;
    $app->param( KEY );        |   $app->query->param( KEY );
    $app->param( KEY, VALUE ); |   $app->query->param( KEY, VALUE )

B<Performance note:> If you need to store or access a number of parameters,
it's best to retrieve the query object once instead of repeatedly
calling C<< $app->query->param() >>:

    my $q    = $app->query;
    my $name = $q->param('name');
    my $rank = $q->param('rank');
    my $snum = $q->param('serial_number');

B<Further Reading>

=over 4

=item * CGI::Application's query() method

http://search.cpan.org/perldoc?CGI::Application#query()

=item * CGI::Application's param() method

http://search.cpan.org/perldoc?CGI::Application#param()

=item * The CGI module, C<< $app->query >>'s frequent base class

http://search.cpan.org/perldoc?CGI

=back

=head2 $app->param_hash (DEPRECATED, FUTURE BREAK)

B<This method will soon change and break existing code. See
L</"C<< $app->query->Vars >>"> for a forward-compatible replacement.>

=head2 $app->query([ $QUERY_OBJECT ])

Provides storage and retrieval access to the current request's query object
which is instantiated in C<MT::App::init_request()> as either a L<CGI> or
L<Apache::Request> (for C<mod_perl>) object.

You can access the query object at any time by calling $app->query with no
arguments. Modifying the query object is best done through its C<param()>
method described next.

=head3 $app->query->param([ $name[, $value ] ])

A method provided by the query object as an interface for storing and
retrieving CGI query parameters. Example:

    my $title = $app->query->param( 'entry_title' );    # Get
    $title    =~ s{Moveable}{Movable}g;                 # Thx a lot, Papa...
    $app->query->param( 'entry_title', $title )         # Set

Called with no arguments, returns a hash (or hash reference in a SCALAR
context) of all of the query parameter names and their values. Example:

    my %data = $app->query->param;
    my $title = $data{entry_title};
  OR
    my $data  = $app->query->param;
    my $title = $data->{entry_title};

=head3 Compatiblity with Movable Type

This method was introduced in Melody to provide forward compatibility with
CGI::Application's C<query()> method. If you are interested in writing plugins
which are cross-compatible with Movable Type, you should add the following in
an C<init_app> callback:

    sub init_app {
        my $cb  = shift;
        my $app = shift;
        return unless $app->isa('MT::App');
        unless ( $app->can('query') ) {
            *MT::App::query = sub {
                my $self    = shift;
                my ($query) = @_;
                return defined $query ? $self->{query} = $query
                                      : $self->{query};
            }
        }
    }

This will provide safe cross-compatible use of the C<MT::App::query()> in both
Melody and Movable Type until such time as a new version of Movable Type
includes the method natively.

=head2 $app->{query} (DEPRECATED, FUTURE BREAK)

Versions of Movable Type prior to v3.16 provided only hash-based access to the
query object (i.e. C<< $app->{query} >>) and some developers continue this
practice even today. Please note that this method of accessing the query
object is deprecated and I<will break in the future>. Please always use
B<only> C<< $app->query() >>.

    my $q = $app->{query};  # BAD! WARNING! WILL BREAK!
    my $q = $app->query();  # Good! Better! Excellent!

In this version of Melody, we will continue to maintain backwards compatiblity
with direct storage/retrieval access to C<< $app->{query} >> but the system
will issue a loud deprecation and future break warning (via a tie of the hash
value to C<Melody::DeprecatedQueryUsage>) informing the user of the strongly
recommended alterative.

=head2 $app->post_run

This method is invoked, with no parameters, immediately following the
execution of the requested C<__mode> handler. Its return value is ignored.

C<post_run> will be invoked whether or not the C<__mode> handler returns an
error state through the MT::ErrorHandler mechanism, but it will not be
invoked if the handler C<die>s.

App subclasses can override this method with tasks to be executed
after any C<__mode> handler but before the page is delivered to the
client. Such a method should invoke C<SUPER::post_run> to ensure that
MT's core post-run tasks are executed.

=head2 $app->pre_run

This method is invoked, with no parameters, before dispatching to the
requested C<__mode> handler. Its return value is ignored.

C<pre_run> is not invoked if the request could not be authenticated.
If C<pre_run> is invoked and does not C<die>, the C<__mode> handler
B<will> be invoked.

App subclasses can override this method with tasks to be executed
before, and regardless of, the C<__mode> specified in the
request. Such an overriding method should invoke C<SUPER::pre_run> to
ensure that MT's core pre-run tasks are executed.

=head2 $app->query_string

Returns the CGI query string of the active request.

=head2 $app->request_content

Returns a scalar containing the POSTed data of the active HTTP
request. This will force the request body to be read, even if
$app->{no_read_body} is true. TBD: document no_read_body.

=head2 $app->request_method

Returns the method of the active HTTP request, typically either "GET"
or "POST".

=head2 $app->response_content_type([$type])

Gets or sets the HTTP response Content-Type header.

=head2 $app->response_code([$code])

Gets or sets the HTTP response code: the numerical value that begins
the "status line." Defaults to 200.

=head2 $app->response_message([$message])

Gets or sets the HTTP response message, better known as the "reason
phrase" of the "status line." E.g., if these calls were executed:

   $app->response_code("404");
   $app->response_message("Thingy Not Found");

This status line might be returned to the client:

   404 Thingy Not Found

By default, the reason phrase is an empty string, but an appropriate
reason phrase may be assigned by the webserver based on the response
code.

=head2 $app->set_header($name, $value)

Adds an HTTP header to the response with the given name and value.

=head2 $app->validate_magic

Checks for a I<magic_token> HTTP parameter and validates it for the current
author.  If it is invalid, an error message is assigned to the application
and a false result is returned. If it is valid, it returns 1. Example:

    return unless $app->validate_magic;

To populate a form with a valid magic token, place the token value in a
hidden form field:

    <input type="hidden" name="magic_token" value="<TMPL_VAR NAME=MAGIC_TOKEN>" />

If you're protecting a hyperlink, add the token to the query parameters
for that link.

=head2 $app->redirect($url, [option1 => option1_val, ...])

Redirects the client to the URL C<$url>. If C<$url> is not an absolute
URL, it is prepended with the value of C<$app-E<gt>base>.

By default, the redirection is accomplished by means of a Location
header and a 302 Redirect response.

If the option C<UseMeta =E<gt> 1> is given, the request will be redirected
by issuing a text/html entity body that contains a "meta redirect"
tag. This option can be used to work around clients that won't accept
cookies as part of a 302 Redirect response.

=head2 $app->base

The protocol and domain of the application. For example, with the full URI
F<http://www.foo.com/m/index.cgi>, this method will return F<http://www.foo.com>.

=head2 $app->path

The path component of the URL of the application directory. For
example, with the full URL F<http://www.foo.com/m/index.cgi>, this
method will return F</mt/>.

=head2 $app->script

In CGI mode, the filename of the active CGI script. For example, with
the full URL F<http://www.foo.com/m/index.cgi>, this method will return
F<index.cgi>.

In mod_perl mode, the Request-URI without any query string.

=head2 $app->uri([%params])

The concatenation of C<$app-E<gt>path> and C<$app-E<gt>script>. For example,
with the full URI F<http://www.foo.com/m/index.cgi>, this method will return
F</m/index.cgi>. If C<%params> exist, they are passed to the
C<$app-E<gt>uri_params> method for processing.

Example:

    return $app->redirect($app->uri(mode => 'go', args => {'this'=>'that'}));

=head2 $app->path_info

The path_info for the request (that is, whatever is left in the URI
after removing the path to the script itself).

=head2 $app->log($msg)

Adds the message C<$msg> to the activity log. The log entry will be tagged
with the IP address of the client running the application (that is, of the
browser that made the HTTP request), using C<$app-E<gt>remote_ip>.

=head2 $app->trace(@msg)

Adds a trace message by concatenating all the members of C<@msg> to the
internal tracing mechanism; trace messages are then displayed at the
top of the output page sent to the client.  These messages are
displayed when the I<DebugMode> configuration parameter is
enabled. This is useful for debugging.

=head2 $app->remote_ip

The IP address of the client.

In a L<mod_perl> context, this calls L<Apache::Connection::remote_ip>; in a
CGI context, this uses C<$ENV{REMOTE_ADDR}>.

=head2 assert

=head2 build_widgets

=head2 commenter_loggedin

=head2 core_blog_stats_tabs

=head2 core_list_actions

=head2 core_list_filters

=head2 core_menus

=head2 core_methods

=head2 core_page_actions

=head2 core_search_apis

=head2 core_widgets

=head2 create_user_pending

=head2 document_root

=head2 external_authenticators

=head2 filter_conditional_list

=head2 forward

=head2 get_commenter_session

=head2 handlers_for_mode

=head2 init_callbacks

=head2 init_query

=head2 json_error

=head2 json_result

=head2 list_actions

=head2 list_filters

=head2 listing

=head2 load_list_actions

=head2 load_widget_list

=head2 load_widgets

=head2 login_pending

=head2 make_commenter

=head2 make_commenter_session

=head2 page_actions

=head2 permissions

=head2 post_run_debug

=head2 pre_run_debug

=head2 registry

=head2 response_content

=head2 run_callbacks

=head2 search_apis

=head2 session_state

=head2 set_no_cache

=head2 update_widget_prefs

=head2 validate_request_params

=head1 STANDARD APPLICATION TEMPLATE PARAMETERS

When loading an application template, a number of parameters are preset for
you. The following are some parameters that are assigned by C<MT::App> itself:

=over 4

=item * AUTHOR_ID

=item * AUTHOR_NAME

The MT::Author ID and username of the currently logged-in user.

=item * MT_VERSION

The value returned by MT->version_id. Typically just the release version
number, but for special releases such as betas, this may also include
an identifying suffix (ie "3.2b").

=item * MT_PRODUCT_CODE

A product code defined by Six Apart to identify the edition of Movable Type.
Currently, the valid values include:

    MT  - Movable Type Personal or Movable Type Commercial editions
    MTE - Movable Type Enterprise

=item * MT_PRODUCT_NAME

The name of the product in use.

=item * LANGUAGE_TAG

The active language identifier of the currently logged-in user (or default
language for the MT installation if there is no logged in user).

=item * LANGUAGE_xx

A parameter dynamically named for testing for particular languages.

Sample usage:

    <TMPL_IF NAME=LANGUAGE_FR>Parlez-vous Francias?</TMPL_IF>

Note that this is not a recommended way to localize your application. This
is intended for including or excluding portions of a template based on the
active language.

=item * LANGUAGE_ENCODING

Provides the character encoding that is configured for the application. This
maps to the "PublishCharset" MT configuration setting.

=item * STATIC_URI

This provides the config.cgi setting for "StaticWebPath" or "AdminCGIPath",
depending on whether the active CGI is an admin CGI script or not (most
likely it is, if it's meant to be used by an administrator (index.cgi) and not
an end user such as comments.cgi).

Sample usage:

    <TMPL_VAR NAME=STATIC_URI>images/image-name.gif

With a StaticWebPath of '/mt/', this produces:

    /mt/mt-static/images/image-name.gif

or, if StaticWebPath is 'http://example.com/mt-static/':

    http://example.com/mt-static/images/image-name.gif

=item * SCRIPT_URL

Returns the relative URL to the active CGI script.

Sample usage:

    <TMPL_VAR NAME=SCRIPT_URL>?__mode=blah

which may output:

    /mt/plugins/myplugin/myplugin.cgi?__mode=blah


=item * MT_URI

Yields the relative URL to the primary Movable Type application script
(index.cgi or the configured 'AdminScript').

Sample usage:

    <TMPL_VAR NAME=MT_URI>?__mode=view&_type=entry&id=1&blog_id=1

producing:

    /m/index.cgi?__mode=view&_type=entry&id=1&blog_id=1

=item * SCRIPT_PATH

The path portion of URL for script

Sample usage:

    <TMPL_VAR NAME=SCRIPT_PATH>check.cgi

producing:

    /m/check.cgi

=item * SCRIPT_FULL_URL

The complete URL to the active script. This is useful when needing to output
the full script URL, including the protocol and domain.

Sample usage:

    <TMPL_VAR NAME=SCRIPT_FULL_URL>?__mode=blah

Which produces something like this:

    http://example.com/mt/plugins/myplugin/myplugin.cgi?__mode=blah

=back

=head1 AUTHOR & COPYRIGHTS

Please see the L<MT> manpage for author, copyright, and license information.

=cut
