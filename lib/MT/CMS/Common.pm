package MT::CMS::Common;

use strict;

use MT::Util qw( format_ts offset_time_list relative_date );

sub save {
    my $app  = shift;
    my $q    = $app->query;
    my $type = $q->param('_type');

    return $app->errtrans("Invalid request.") unless $type;

    # being a general-purpose method, lets look for a mode handler
    # that is specifically for editing this type. if we find it,
    # reroute to it.

    my $save_mode = 'save_' . $type;
    if ( my $hdlrs = $app->handlers_for_mode($save_mode) ) {
        return $app->forward($save_mode);
    }

    my $id = $q->param('id');
    $q->param( 'allow_pings', 0 )
      if ( $type eq 'category' ) && !defined( $q->param('allow_pings') );

    $app->validate_magic() or return;
    my $author = $app->user;

    # Check permissions
    my $perms = $app->permissions;

    if ( !$author->is_superuser ) {
        if ( ( $type ne 'author' ) && ( $type ne 'template' ) )
        {    # for authors, blog-ctx $perms is not relevant
            return $app->errtrans("Permisison denied.") if !$perms && $id;
        }

        $app->run_callbacks( 'cms_save_permission_filter.' . $type,
                             $app, $id )
          || return $app->error(
               $app->translate( "Permission denied: [_1]", $app->errstr() ) );
    }

    my $param = {};
    if ( $type eq 'author' ) {
        if ( my $delim = $q->param('tag_delim') ) {
            $param->{ 'auth_pref_tag_delim_' . $delim } = 1;
            $param->{'auth_pref_tag_delim'} = $delim;
        }
        $param->{languages}
          = $app->languages_list( $q->param('preferred_language') )
          if $q->param('preferred_language');
        $param->{create_personal_weblog}
          = $q->param('create_personal_weblog') ? 1 : 0;
        require MT::Permission;
        my $sys_perms = MT::Permission->perms('system');
        foreach (@$sys_perms) {
            $param->{ 'perm_can_' . $_->[0] } = 1
              if $q->param( 'can_' . $_->[0] );
        }
    }

    my $filter_result
      = $app->run_callbacks( 'cms_save_filter.' . $type, $app );

    if ( !$filter_result ) {
        my %param = (%$param);
        $param{error}       = $app->errstr;
        $param{return_args} = $q->param('return_args');

        if ( $type eq 'notification' ) {
            return list( $app, \%param );
        }
        else {
            if ($type) {
                my $mode = 'view_' . $type;
                if ( $app->handlers_for_mode($mode) ) {
                    return $app->forward( $mode, \%param );
                }
            }
            return $app->forward( 'view', \%param );
        }
    }

    if ( $type eq 'template' ) {

        return $app->errtrans(
                     'The Template Name and Output File fields are required.')
          if !$q->param('name') && !$q->param('outfile');

        # check for autosave
        if ( $q->param('_autosave') ) {
            return $app->autosave_object();
        }
    }

    my $class = $app->model($type)
      or return $app->errtrans( "Invalid type [_1]", $type );
    my ($obj);
    if ($id) {
        $obj = $class->load($id)
          or return $app->error( $app->translate( "Invalid ID [_1]", $id ) );
    }
    else {
        $obj = $class->new;
    }

    my $original = $obj->clone();
    my $names    = $obj->column_names;
    my %values   = map { $_ => ( scalar $q->param($_) ) } @$names;

    if ( $type eq 'author' ) {

        #FIXME: Legacy columns - remove them
        my @cols
          = qw(is_superuser can_create_blog can_view_log can_edit_templates);
        if ( !$author->is_superuser ) {
            delete $values{$_} for @cols;
        }
        else {
            if ( !$id || ( $author->id != $id ) ) {

                # Assign the auth_type unless it was assigned
                # through the form.
                $obj->auth_type( $app->config->AuthenticationModule )
                  unless $obj->auth_type;
                if ( $values{'status'} == MT::Author::ACTIVE() ) {
                    my $sys_perms = MT::Permission->perms('system');
                    if ( defined( $q->param('is_superuser') )
                         && $q->param('is_superuser') )
                    {
                        $obj->is_superuser(1);
                    }
                    else {
                        foreach (@$sys_perms) {
                            my $name = 'can_' . $_->[0];
                            $name = 'is_superuser'
                              if $name eq 'can_administer';
                            if ( defined $q->param($name) ) {
                                $obj->$name( $q->param($name) );
                                delete $values{$name};
                            }
                            else {
                                $obj->$name(0);
                            }
                        }
                    }
                } ## end if ( $values{'status'}...)
            } ## end if ( !$id || ( $author...))
        } ## end else [ if ( !$author->is_superuser)]
        delete $values{'password'};
    } ## end if ( $type eq 'author')

    if ( $type eq 'entry' || $type eq 'page' ) {

        # This has to happen prior to callbacks since callbacks may
        # be affected by the translation...

        # translates naughty words when PublishCharset is NOT UTF-8
        $app->_translate_naughty_words($obj);
    }

    if ( $type eq 'template' ) {
        if ( $q->param('type') eq 'archive' && $q->param('archive_type') ) {
            $values{type} = $q->param('archive_type');
        }
    }

    delete $values{'id'} if exists( $values{'id'} ) && !$values{'id'};
    $obj->set_values( \%values );

    if ( $obj->properties->{audit} ) {
        $obj->created_by( $author->id ) unless $obj->id;
        $obj->modified_by( $author->id ) if $obj->id;
    }

    unless (
         $app->run_callbacks( 'cms_pre_save.' . $type, $app, $obj, $original )
      )
    {
        $param->{return_args} = $q->param('return_args');
        return
          edit(
                $app,
                {
                   %$param,
                   error =>
                     $app->translate( "Save failed: [_1]", $app->errstr )
                }
          );
    }

    # Done pre-processing the record-to-be-saved; now save it.

    $obj->save
      or return $app->error(
              $app->translate( "Saving object failed: [_1]", $obj->errstr ) );

    # Now post-process it.
    $app->run_callbacks( 'cms_post_save.' . $type, $app, $obj, $original )
      or return $app->error( $app->errstr() );

    my $blog_id = $q->param('blog_id');
    my $screen = $q->param('cfg_screen') || '';

    # if we are saving/publishing a template, make sure to log on activity log
    if ( $type eq 'template' ) {
        my $blog = $app->model('blog')->load( $obj->blog_id );
        if ($blog) {
            $app->log( {
                   message =>
                     $app->translate(
                       "'[_1]' edited the template '[_2]' in the blog '[_3]'",
                       $app->user->name, $obj->name, $blog->name
                     ),
                   level   => MT::Log::INFO(),
                   blog_id => $blog->id,
                }
            );
        }
        else {
            $app->log( {
                         message =>
                           $app->translate(
                                   "'[_1]' edited the global template '[_2]'",
                                   $app->user->name, $obj->name
                           ),
                         level => MT::Log::INFO(),
                       }
            );
        }
    } ## end if ( $type eq 'template')

    # TODO: convert this to use $app->call_return();
    # then templates can determine the page flow.
    if ( $type eq 'notification' ) {
        return
          $app->redirect(
                          $app->uri(
                                     'mode' => 'list',
                                     args   => {
                                               '_type' => 'notification',
                                               blog_id => $blog_id,
                                               saved   => $obj->email
                                     }
                          )
          );
    }
    elsif ( my $cfg_screen = $q->param('cfg_screen') ) {
        if ( $cfg_screen eq 'cfg_publish_profile' ) {
            my $dcty = $obj->custom_dynamic_templates || 'none';
            if ( ( $dcty eq 'all' ) || ( $dcty eq 'archives' ) ) {
                require MT::CMS::Blog;
                my %param = ();
                MT::CMS::Blog::_create_build_order( $app, $obj, \%param );
                $q->param( 'single_template', 1 );  # to show tmpl full-screen
                if ( $dcty eq 'all' ) {
                    $q->param( 'type', $param{build_order} );
                }
                elsif ( $dcty eq 'archives' ) {
                    my @ats = map { $_->{archive_type} }
                      @{ $param{archive_type_loop} };
                    $q->param( 'type', join( ',', @ats ) );
                }
                return MT::CMS::Blog::start_rebuild_pages($app);
            }
        }
        if ( $cfg_screen eq 'cfg_templatemaps' ) {
            $cfg_screen = 'cfg_archives';
        }
        my $site_path = $obj->site_path;
        my $fmgr      = $obj->file_mgr;
        unless ( $fmgr->exists($site_path) ) {
            $fmgr->mkpath($site_path);
        }
        $app->add_return_arg( no_writedir => 1 )
          unless $fmgr->exists($site_path) && $fmgr->can_write($site_path);
    } ## end elsif ( my $cfg_screen = ...)
    elsif ( $type eq 'template' && $q->param('rebuild') ) {
        if ( !$id ) {

            # add return argument for newly created templates
            $app->add_return_arg( id => $obj->id );
        }
        if ( $obj->build_type ) {
            if ( $obj->type eq 'index' ) {
                $q->param( 'type',            'index-' . $obj->id );
                $q->param( 'tmpl_id',         $obj->id );
                $q->param( 'single_template', 1 );
                return $app->forward('start_rebuild');
            }
            else {

                # archive rebuild support
                $q->param( 'id',     $obj->id );
                $q->param( 'reedit', $obj->id );
                return $app->forward('publish_archive_templates');
            }
        }
    } ## end elsif ( $type eq 'template'...)
    elsif ( $type eq 'template' ) {
        if (    $obj->type eq 'archive'
             || $obj->type eq 'category'
             || $obj->type eq 'page'
             || $obj->type eq 'individual' )
        {
            my $static_maps = delete $app->{static_dynamic_maps};
            require MT::TemplateMap;
            my $terms = {};
            if ( $static_maps && @$static_maps ) {
                $terms->{id} = $static_maps;
            }
            else {

                # all existing maps have been dynamic
                # do nothing
            }
            if (%$terms) {
                my @maps = MT::TemplateMap->load($terms);
                my @ats = map { $_->archive_type } @maps;
                if ( $#ats >= 0 ) {
                    $q->param( 'type', join( ',', @ats ) );
                    $q->param( 'with_indexes',    1 );
                    $q->param( 'no_static',       1 );
                    $q->param( 'template_id',     $obj->id );
                    $q->param( 'single_template', 1 );
                    require MT::CMS::Blog;
                    return MT::CMS::Blog::start_rebuild_pages($app);
                }
            }
        } ## end if ( $obj->type eq 'archive'...)
    } ## end elsif ( $type eq 'template')
    elsif ( $type eq 'author' ) {

        # Delete the author's userpic thumb (if any); it'll be regenerated.
        if ( $original->userpic_asset_id != $obj->userpic_asset_id ) {
            my $thumb_file = $original->userpic_file();
            my $fmgr       = MT::FileMgr->new('Local');
            if ( $fmgr->exists($thumb_file) ) {
                $fmgr->delete($thumb_file);
            }
        }
    }

    $app->add_return_arg( 'id' => $obj->id ) if !$original->id;
    $app->add_return_arg( 'saved' => 1 );
    $app->call_return;
} ## end sub save

sub edit {
    my $app  = shift;
    my $q    = $app->query;
    my $type = $q->param('_type');

    return $app->errtrans("Invalid request.") unless $type;

    # being a general-purpose method, lets look for a mode handler
    # that is specifically for editing this type. if we find it,
    # reroute to it.

    my $edit_mode = $app->mode . '_' . $type;
    if ( my $hdlrs = $app->handlers_for_mode($edit_mode) ) {
        return $app->forward( $edit_mode, @_ );
    }

    my %param = eval { $_[0] ? %{ $_[0] } : (); };
    die Carp::longmess if $@;
    my $class = $app->model($type) or return;
    my $blog_id = $q->param('blog_id');

    if ( defined($blog_id) && $blog_id ) {
        return $app->error( $app->translate("Invalid parameter") )
          unless ( $blog_id =~ m/\d+/ );
    }

    $app->remove_preview_file;

    my $enc = $app->config->PublishCharset;
    if ( $q->param('_recover') ) {
        my $sess_obj = $app->autosave_session_obj;
        if ($sess_obj) {
            my $data = $sess_obj->thaw_data;
            if ($data) {
                $q->param( $_, $data->{$_} ) for keys %$data;
                $param{'recovered_object'} = 1;
            }
            else {
                $param{'recovered_failed'} = 1;
            }
        }
        else {
            $param{'recovered_failed'} = 1;
        }
    }
    elsif ( $q->param('qp') ) {
        foreach (qw( title text )) {
            my $data = $q->param($_);
            my $encoded = MT::I18N::encode_text( $data, undef, $enc )
              if $data;
            $q->param( $_, $encoded );
        }
    }

    $param{autosave_frequency} = $app->config->AutoSaveFrequency;

    my $id     = $q->param('id');
    my $perms  = $app->permissions;
    my $author = $app->user;
    my $cfg    = $app->config;
    $param{styles} = '';
    if ( $type eq 'author' ) {
        if ( $perms || $blog_id ) {
            return $app->return_to_dashboard( redirect => 1 );
        }
    }
    else {
        if (
             ( !$perms || !$blog_id )
             && (    $type eq 'entry'
                  || $type eq 'page'
                  || $type eq 'category'
                  || $type eq 'folder'
                  || $type eq 'comment'
                  || $type eq 'commenter'
                  || $type eq 'ping' )
          )
        {
            return $app->return_to_dashboard( redirect => 1 );
        }
    }

    my $cols = $class->column_names;
    require MT::Promise;
    my $obj_promise = MT::Promise::delay(
        sub {
            return $class->load($id) || undef;
        }
    );

    if ( !$author->is_superuser ) {
        $app->run_callbacks( 'cms_view_permission_filter.' . $type,
                             $app, $id, $obj_promise )
          || return $app->error(
               $app->translate( "Permission denied: [_1]", $app->errstr() ) );
    }
    my $obj;
    my $blog;
    my $blog_class = $app->model('blog');
    if ($blog_id) {
        $blog = $blog_class->load($blog_id);
    }
    else {
        $blog_id = 0;
    }

    if ($id) {    # object exists, we're just editing it.
         # Stash the object itself so we don't have to keep forcing the promise
        $obj = $obj_promise->force();
        unless ($obj) {
            my $error;
            if ( $class->errstr ) {
                $error
                  = $app->translate( "Load failed: [_1]", $class->errstr );
            }
            elsif ( !MT->model($type)->exist($id) ) {
                $error = $app->translate( "[_1] does not exist.",
                                          MT->model($type)->class_label );
            }
            else {
                $error = $app->translate("(no reason given)");
            }
            return $app->error($error);
        }

        # Populate the param hash with the object's own values
        for my $col (@$cols) {
            $param{$col}
              = defined $q->param($col) ? $q->param($col) : $obj->$col();
        }

        # Populate meta data into template params
        # See http://bugs.movabletype.org/?86639
        my @meta_columns = MT::Meta->metadata_by_class( ref $obj );
        foreach (@meta_columns) {
            if ( $_->{name} !~ /^field\.(.*)/ ) {
                $param{ 'meta_' . $_->{name} } = $obj->meta( $_->{name} );
            }
        }

        # Make certain any blog-specific element matches the blog we're
        # dealing with. If not, call shenanigans.
        if (    ( exists $param{blog_id} )
             && ( $blog_id != ( $obj->blog_id || 0 ) ) )
        {
            return $app->return_to_dashboard( redirect => 1 );
        }

        if ( $class->properties->{audit} ) {
            my $creator = MT::Author->load(
                 { id => $obj->created_by(), type => MT::Author::AUTHOR() } );
            if ($creator) {
                $param{created_by} = $creator->name;
            }
            if ( my $mod_by = $obj->modified_by() ) {
                my $modified = MT::Author->load(
                            { id => $mod_by, type => MT::Author::AUTHOR() } );
                if ($modified) {
                    $param{modified_by} = $modified->name;
                }
                else {
                    $param{modified_by} = $app->translate("(user deleted)");
                }

                # Since legacy MT installs will still have a
                # timestamp type for their modified_on fields,
                # we cannot reliably disaply a modified on date
                # by default; we must only show the modification
                # date IF there is also a modified_by value.
                if ( my $ts = $obj->modified_on ) {
                    $param{modified_on_ts} = $ts;
                    $param{modified_on_formatted}
                      = format_ts(
                           MT::App::CMS::LISTING_DATETIME_FORMAT(),
                           $ts,
                           undef,
                           $app->user ? $app->user->preferred_language : undef
                      );
                }
            } ## end if ( my $mod_by = $obj...)
            if ( my $ts = $obj->created_on ) {
                $param{created_on_ts} = $ts;
                $param{created_on_formatted}
                  = format_ts(
                           MT::App::CMS::LISTING_DATETIME_FORMAT(),
                           $ts,
                           undef,
                           $app->user ? $app->user->preferred_language : undef
                  );
            }
        } ## end if ( $class->properties...)

        $param{new_object} = 0;
    } ## end if ($id)
    else {    # object is new
        $param{new_object} = 1;
        for my $col (@$cols) {
            $param{$col} = $q->param($col);
        }
    }

    my $res
      = $app->run_callbacks( 'cms_edit.' . $type, $app, $id, $obj, \%param );
    if ( !$res ) {
        return $app->error( $app->callback_errstr() );
    }

    if ( $param{autosave_support} ) {

        # autosave support, but don't bother if we're reediting
        if ( !$q->param('reedit') ) {
            my $sess_obj = $app->autosave_session_obj;
            if ($sess_obj) {
                $param{autosaved_object_exists} = 1;
                $param{autosaved_object_ts}
                  = MT::Util::epoch2ts( $blog, $sess_obj->start );
            }
        }
    }

    if ( ( $q->param('msg') || "" ) eq 'nosuch' ) {
        $param{nosuch} = 1;
    }
    for my $p ( $q->param ) {
        $param{$p} = $q->param($p) if $p =~ /^saved/;
    }
    $param{page_actions} = $app->page_actions( $type, $obj );
    if ( $class->can('class_label') ) {
        $param{object_label} = $class->class_label;
    }
    if ( $class->can('class_label_plural') ) {
        $param{object_label_plural} = $class->class_label_plural;
    }

    my $tmpl_file = $param{output} || "edit_${type}.tmpl";
    $param{object_type} ||= $type;
    $param{screen_id}   ||= "edit-$type";
    $param{screen_class} .= " edit-$type";
    return $app->load_tmpl( $tmpl_file, \%param );
} ## end sub edit

sub list {
    my $app  = shift;
    my $q    = $app->query;
    my $type = $q->param('_type');
    my $blog_id = $app->blog ? $app->blog->id : 0;
    my $scope = $app->blog ? 'blog' : !$blog_id ? 'system' : 'user';
    my $list_mode = 'list_' . $type;
    if ( my $hdlrs = $app->handlers_for_mode($list_mode) ) {
        return $app->forward($list_mode);
    }
    my %param;
    $param{list_type} = $type;
    my @messages;

    my @list_components = grep {
             $_->registry( list_properties => $type )
          || $_->registry( listing_screens => $type )
          || $_->registry( list_actions    => $type )
          || $_->registry( content_actions => $type )
          || $_->registry( system_filters  => $type )
    } MT::Component->select;

    my @list_headers;
    push @list_headers,
      File::Spec->catfile( MT->config->TemplatePath, $app->{template_dir},
        'listing', $type . '_list_header.tmpl' );
    for my $c (@list_components) {
        my $f = File::Spec->catfile( $c->path, 'tmpl', 'listing',
            $type . '_list_header.tmpl' );
        push @list_headers, $f if -e $f;
    }

    my $screen_settings = MT->registry( listing_screens => $type )
      or return $app->error(
        $app->translate( 'Unknown action [_1]', $list_mode ) );

    # Condition check
    if ( my $cond = $screen_settings->{condition} ) {
        $cond = MT->handler_to_coderef($cond)
          if 'CODE' ne ref $cond;
        $app->error();
        unless ( $cond->($app) ) {
            if ( $app->errstr ) {
                return $app->error( $app->errstr );
            }
            return $app->return_to_dashboard;
        }
    }

    # Validate scope
    if ( my $view = $screen_settings->{view} ) {
        print STDERR "View: ".join(',',@$view)."\n";
        $view = [$view] unless ref $view;
        my %view = map { $_ => 1 } @$view;
        if ( !$view{$scope} ) {
            return $app->return_to_dashboard( redirect => 1 );
        }
    }

#    my $screen_settings = MT->registry( 'listing_screens' => $type );
    my $initial_filter;

    my $list_prefs  = $app->user->list_prefs         || {};
    my $list_pref   = $list_prefs->{$type}{$blog_id} || {};
    my $rows        = $list_pref->{rows}             || 50;  ## FIXME: Hardcoded
    my $last_filter = $list_pref->{last_filter}      || '';
    $last_filter = '' if $last_filter eq '_allpass';
    my $last_items = $list_pref->{last_items} || [];
    my $initial_sys_filter = $q->param('filter_key');
    if ( !$initial_sys_filter && $last_filter =~ /\D/ ) {
        $initial_sys_filter = $last_filter;
    }
    $param{ 'limit_' . $rows } = 1;

    require MT::ListProperty;
    my $obj_type   = $screen_settings->{object_type} || $type;
    my $obj_class  = MT->model($obj_type);
    my $list_props = MT::ListProperty->list_properties($type);

    if ( $app->query->param('no_filter') ) {

        # Nothing to do.
    }
    elsif ( my @cols = $app->query->param('filter') ) {
        my @vals = $app->query->param('filter_val');
        my @items;
        my @labels;
        for my $col (@cols) {
            my $val = shift @vals;
            if ( my $prop = $list_props->{$col} ) {
                my ( $args, $label );
                if ( $prop->has('args_via_param') ) {
                    $args = $prop->args_via_param( $app, $val );
                    if ( !$args ) {
                        if ( my $errstr = $prop->errstr ) {
                            push @messages,
                              {
                                cls => 'alert',
                                msg => MT->translate(
                                    q{Invalid filter: [_1]}, $errstr
                                )
                              };
                        }
                        next;
                    }
                }
                if ( $prop->has('label_via_param') ) {
                    $label = $prop->label_via_param( $app, $val );
                    if ( !$label ) {
                        if ( my $errstr = $prop->errstr ) {
                            push @messages,
                              {
                                cls => 'alert',
                                msg => MT->translate(
                                    q{Invalid filter: [_1]}, $errstr,
                                )
                              };
                        }
                        next;
                    }
                }
                push @items,
                  {
                    type => $col,
                    args => ( $args || {} ),
                  };
                push @labels, ( $label || $prop->label );
            }
            else {
                push @messages,
                  {
                    cls => 'alert invalid-filter',
                    msg => MT->translate( q{Invalid filter: [_1]}, $col, )
                  };
            }
        }
        if ( scalar @items ) {
            $initial_filter = {
                label => join( ', ', @labels ),
                items => \@items,
            };
        }
        else {
            $initial_filter = undef;
        }
    }
    elsif ($initial_sys_filter) {
        require MT::CMS::Filter;
        $initial_filter =
          MT::CMS::Filter::filter( $app, $type, $initial_sys_filter );
    }
    elsif ($last_filter) {
        my $filter = MT->model('filter')->load($last_filter);
        $initial_filter = $filter->to_hash if $filter;
    }
    elsif ( scalar @$last_items && $app->query->param('does_act') ) {
        my $filter = MT->model('filter')->new;
        $filter->set_values(
            {
                object_ds => $obj_type,
                items     => $last_items,
                author_id => $app->user->id,
                blog_id   => $blog_id || 0,
                label     => $app->translate('New Filter'),
                can_edit  => 1,
            }
        );
        $initial_filter = $filter->to_hash if $filter;
        $param{open_filter_panel} = 1;
    }

    my $columns = $list_pref->{columns} || [];
    my %cols = map { $_ => 1 } @$columns;

    my $primary_col = $screen_settings->{primary};
    $primary_col ||= [ @{ $screen_settings->{columns} || [] } ]->[0];
    $primary_col = [$primary_col] unless ref $primary_col;
    my %primary_col = map { $_ => 1 } @$primary_col;
    my $default_sort =
      defined( $screen_settings->{default_sort_key} )
      ? $screen_settings->{default_sort_key}
      : '';

    my @list_columns;
    for my $prop ( values %$list_props ) {
        next if !$prop->can_display($scope);
        my $col;
        my $id = $prop->id;
        my $disp = $prop->display || 'optional';
        my $show =
            $disp eq 'force' ? 1
          : $disp eq 'none'  ? 0
          : scalar %cols ? $cols{$id}
          : $disp eq 'default' ? 1
          :                      0;
        my $force   = $disp eq 'force'   ? 1 : 0;
        my $default = $disp eq 'default' ? 1 : 0;
        my @subfields;

        if ( my $subfields = $prop->sub_fields ) {
            for my $sub (@$subfields) {
                my $disp = $sub->{display} || '';
                push @subfields,
                  {
                    display => $cols{ $id . '.' . $sub->{id} }
                      || $disp eq 'default',
                    class      => $sub->{id},
                    label      => $app->translate( $sub->{label} ),
                    is_default => $disp eq 'default' ? 1 : 0,
                  };
            }
        }
        push @list_columns,
          {
            id        => $prop->id,
            type      => $prop->type,
            label     => $prop->label,
            primary   => $primary_col{$id} ? 1 : 0,
            col_class => $prop->col_class,
            sortable  => $prop->can_sort($scope),
            sorted    => $prop->id eq $default_sort ? 1 : 0,
            display   => $show,
            is_default => $force || $default,
            force_display      => $force,
            default_sort_order => $prop->default_sort_order || 'ascend',
            order              => $prop->order,
            sub_fields         => \@subfields,
          };
    }
    @list_columns = sort {
            !$a->{order} ? 1
          : !$b->{order} ? -1
          : $a->{order} <=> $b->{order}
    } @list_columns;

    my @filter_types = map {
        {
            prop                  => $_,
            id                    => $_->id,
            type                  => $_->type,
            label                 => $_->filter_label || $_->label,
            field                 => $_->filter_tmpl,
            single_select_options => $_->single_select_options($app),
            verb                  => defined $_->verb ? $_->verb
            : $app->translate('__SELECT_FILTER_VERB'),
            singleton => $_->singleton ? 1
            : $_->has('filter_editable') ? !$_->filter_editable
            : 0,
            editable => $_->has('filter_editable') ? $_->filter_editable : 1,
            base_type => $_->base_type,
        }
      }
      sort {
        ( $a->item_order && $b->item_order ) ? $a->item_order <=> $b->item_order
          : ( !$a->item_order && $b->item_order )  ? 1
          : ( $a->item_order  && !$b->item_order ) ? -1
          : (
            defined $a->filter_label
            ? (
                ref $a->filter_label
                ? $a->filter_label->($screen_settings)
                : $a->filter_label
              )
            : ( ref $a->label ? $a->label->($screen_settings) : $a->label )
          ) cmp(
            defined $b->filter_label
            ? (
                ref $b->filter_label
                ? $b->filter_label->($screen_settings)
                : $b->filter_label
              )
            : ( ref $b->label ? $b->label->($screen_settings) : $b->label )
          );
      }
      grep { $_->can_filter($scope) } values %$list_props;

#for my $filter_type ( @filter_types ) {
#    if ( my $options = $filter_type->{single_select_options} ) {
#        require MT::Util;
#        if ( 'ARRAY' ne ref $options ) {
#            $options = MT->handler_to_coderef($options)
#                unless ref $options;
#            $filter_type->{single_select_options} = $options->( $filter_type->{prop} );
#        }
#        for my $option ( @{$filter_type->{single_select_options}} ) {
#            $option->{label} = MT::Util::encode_js($option->{label});
#        }
#    }
#}

    require MT::CMS::Filter;
    my $filters = MT::CMS::Filter::filters( $app, $type, encode_html => 1 );

    my $allpass_filter = {
        label => MT->translate(
            'All [_1]',
            $screen_settings->{object_label_plural}
            ? $screen_settings->{object_label_plural}
            : $obj_class->class_label_plural
        ),
        items    => [],
        id       => '_allpass',
        can_edit => 0,
        can_save => 0,
    };
    $initial_filter = $allpass_filter
      unless $initial_filter;
    ## Encode all HTML in complex structure.
    MT::Util::deep_do(
        $initial_filter,
        sub {
            my $ref = shift;
            $$ref = MT::Util::encode_html($$ref);
        }
    );

    require JSON;
    my $json = JSON->new->utf8(0);

    $param{common_listing}   = 1;
    $param{blog_id}          = $blog_id || '0';
    $param{filters}          = $json->encode($filters);
    $param{initial_filter}   = $json->encode($initial_filter);
    $param{allpass_filter}   = $json->encode($allpass_filter);
    $param{system_messages}  = $json->encode( \@messages );
    $param{filters_raw}      = $filters;
    $param{default_sort_key} = $default_sort;
    $param{list_columns}     = \@list_columns;
    $param{filter_types}     = \@filter_types;
    $param{object_type}      = $type;
    $param{page_title}       = $screen_settings->{screen_label};
    $param{list_headers}     = \@list_headers;
    $param{build_user_menus} = $screen_settings->{has_user_properties};
    $param{use_filters}      = 1;
    $param{use_actions}      = 1;
    $param{object_label}     = $screen_settings->{object_label}
      || $obj_class->class_label;
    $param{object_label_plural} =
        $screen_settings->{object_label_plural}
      ? $screen_settings->{object_label_plural}
      : $obj_class->class_label_plural;
    $param{action_label} = $screen_settings->{action_label}
      if $screen_settings->{action_label};
    $param{action_label_plural} = $screen_settings->{action_label_plural}
      if $screen_settings->{action_label_plural};
    $param{contents_label} = $screen_settings->{contents_label}
      || $obj_class->contents_label;
    $param{contents_label_plural} = $screen_settings->{contents_label_plural}
      || $obj_class->contents_label_plural;
    $param{container_label} = $screen_settings->{container_label}
      || $obj_class->container_label;
    $param{container_label_plural} = $screen_settings->{container_label_plural}
      || $obj_class->container_label_plural;
    $param{zero_state} =
        $screen_settings->{zero_state}
      ? $app->translate( $screen_settings->{zero_state} )
      : '',

      my $s_type = $screen_settings->{search_type} || $obj_type;
    if ( my $search_apis = $app->registry( search_apis => $s_type ) ) {
        $param{search_type}  = $s_type;
        $param{search_label} = $search_apis->{label};
    }
    else {
        $param{search_type}  = 'entry';
        $param{search_label} = MT->translate('Entries');
    }

    my $template = $screen_settings->{template} || 'list_common.tmpl';

    my $feed_link = $screen_settings->{feed_link};
    $feed_link = $feed_link->($app)
      if 'CODE' eq ref $feed_link;
    if ($feed_link) {
        $param{feed_url} =
          $app->make_feed_link( $type,
            $blog_id ? { blog_id => $blog_id } : undef );
        $param{object_type_feed} =
            $screen_settings->{feed_label}
          ? $screen_settings->{feed_label}
          : $app->translate( "[_1] Feed", $obj_class->class_label );
    }

    if ( $param{use_actions} ) {
        $app->load_list_actions( $type, \%param );
        $app->load_content_actions( $type, \%param );
    }

    push @{ $param{debug_panels} },
      {
        name      => 'CommonListing',
        title     => 'CommonListing',
        nav_title => 'CommonListing',
        content =>
'<pre id="listing-debug-block" style="border: 1px solid #000; background-color: #eee; font-family: Courier;"></pre>',
      }
      if $MT::DebugMode;

    my $tmpl = $app->load_tmpl( $template, \%param )
      or return;
    $app->run_callbacks( 'list_template_param.' . $type,
        $app, $tmpl->param, $tmpl );
    return $tmpl;
}

sub filtered_list {
    my $app  = shift;
    my ( %forward_params ) = @_;
    my $q    = $app->query;
    my $blog_id = $q->param('blog_id') || 0;
    my $filter_id        = $q->param('fid') || $forward_params{saved_fid};
    my $blog = $blog_id ? $app->blog : undef;
    my $scope
        = !$blog         ? 'system' : 'blog';
    my $blog_ids = !$blog         ? undef : $blog_id;
#                 : $blog->is_blog ? $blog_id
#                 :                  [ $blog->id, map { $_->id } @{$blog->blogs} ];
    my $debug = {};

    my @messages = @{ $forward_params{messages} || [] };

    if ($MT::DebugMode) {
        require Time::HiRes;
        $debug->{original_prof}      = $Data::ObjectDriver::PROFILE;
        $Data::ObjectDriver::PROFILE = 1;
        $debug->{sections}           = [];
        $debug->{out}                = '';
        $debug->{section}            = sub {
            my ($section) = @_;
            push @{ $debug->{sections} },
                [
                $section,
                Time::HiRes::tv_interval( $debug->{timer} ),
                Data::ObjectDriver->profiler->report_query_frequency(),
                ];
            $debug->{timer} = [ Time::HiRes::gettimeofday() ];
            Data::ObjectDriver->profiler->reset;
        };
        $debug->{print} = sub {
            $debug->{out} .= $_[0] . "\n";
        };
        $debug->{timer} = $debug->{total} = [ Time::HiRes::gettimeofday() ];
        Data::ObjectDriver->profiler->reset;
    }
    else {
        $debug->{section} = sub { };
    }

    my $ds = $q->param('datasource');
    my $setting = MT->registry( listing_screens => $ds )
        or return $app->json_error( $app->translate('Unknown list type') );

    if ( my $cond = $setting->{condition} ) {
        $cond = MT->handler_to_coderef($cond)
            if 'CODE' ne ref $cond;
        $app->error();
        unless ( $cond->($app) ) {
            if ( $app->errstr ) {
                return $app->json_error( $app->errstr );
            }
            return $app->json_error( $app->translate('Invalid request') );
        }
    }

    my $class = $setting->{datasource} || MT->model($ds);
    my $filteritems;
    my $allpass = 0;
    if ( my $items = $q->param('items') ) {
        if ( $items =~ /^".*"$/ ) {
            $items =~ s/^"//;
            $items =~ s/"$//;
            $items = MT::Util::decode_js($items);
        }
        $MT::DebugMode && $debug->{print}->($items);
        require JSON;
        my $json = JSON->new->utf8(0);
        $filteritems = $json->decode($items);
    }
    else {
        $allpass     = 1;
        $filteritems = [];
    }
    require MT::ListProperty;
    my $props = MT::ListProperty->list_properties($ds);
    if ( !$forward_params{validated} ) {
        for my $item (@$filteritems) {
            my $prop = $props->{ $item->{type} };
            if ( $prop->has('validate_item') ) {
                $prop->validate_item($item)
                    or return $app->json_error(
                    MT->translate(
                        'Invalid filter terms: [_1]',
                        $prop->errstr
                    )
                    );
            }
        }
    }

    my $filter = MT->model('filter')->new;
    $filter->set_values(
        {   object_ds => $ds,
            items     => $filteritems,
            author_id => $app->user->id,
            blog_id   => $blog_id || 0,
        }
    );
    my $limit = $q->param('limit') || 50;    # FIXME: hard coded.
    my $page = $q->param('page');
    $page = 1 if !$page || $page =~ /\D/;
    my $offset = ( $page - 1 ) * $limit;

    $MT::DebugMode
        && $debug->{print}->("LIMIT: $limit PAGE: $page OFFSET: $offset");
    $MT::DebugMode && $debug->{section}->('initialize');

    ## FIXME: take identifical column from column defs.
    my $cols = defined( $q->param('columns') ) ? $q->param('columns') : '';
    my @cols = ( '__id', grep {/^[^\.]+$/} split( ',', $cols ) );
    my @subcols = ( '__id', grep {/\./} split( ',', $cols ) );
    $MT::DebugMode && $debug->{print}->("COLUMNS: $cols");

    my $scope_mode = $setting->{scope_mode} || 'wide';
    my @blog_id_term = (
         !$blog_id ? ()
        : $scope_mode eq 'none' ? ()
        : $scope_mode eq 'this' ? ( blog_id => $blog_id )
        : ( blog_id => $blog_ids )
    );

    my %load_options = (
        terms      => {@blog_id_term},
        args       => {},
        sort_by    => $q->param('sort_by') || '',
        sort_order => $q->param('sort_order') || '',
        limit      => $limit,
        offset     => $offset,
        scope      => $scope,
        blog       => $blog,
        blog_id    => $blog_id,
        blog_ids   => $blog_ids,
    );

    my %count_options = (
        terms    => {@blog_id_term},
        args     => {},
        scope    => $scope,
        blog     => $blog,
        blog_id  => $blog_id,
        blog_ids => $blog_ids,
    );

    MT->run_callbacks( 'cms_pre_load_filtered_list.' . $ds,
        $app, $filter, \%count_options, \@cols );

    my $count_result = $filter->count_objects(%count_options);
    if ( !defined $count_result ) {
        return $app->error(
            MT->translate(
                "An error occured while counting objects: [_1]",
                $filter->errstr
            )
        );
    }
    my ( $count, $editable_count ) = @$count_result;

    $MT::DebugMode && $debug->{section}->('count objects');
    $load_options{total} = $count;

    my ( $objs, @data );
    if ($count) {
        MT->run_callbacks( 'cms_pre_load_filtered_list.' . $ds,
            $app, $filter, \%load_options, \@cols );

        $objs = $filter->load_objects(%load_options);
        if ( !defined $objs ) {
            return $app->error(
                MT->translate(
                    "An error occured while loading objects: [_1]",
                    $filter->errstr
                )
            );
        }

        $MT::DebugMode && $debug->{section}->('load objects');

        my %cols = map { $_ => 1 } @cols;
        my @results;

        ## FIXME: would like to build MTML if specified, but currently
        ## many of handlers can't run without blog_id. so commented
        ## out for these codes until the problem would be resolved.
        #my $tmpl;
        #if ( scalar grep { $props->{$_}->has('mtml') } @cols ) {
        #    $tmpl = MT::Template->new;
        #    $tmpl->blog_id($blog_id);
        #    $app->set_default_tmpl_params($tmpl);
        #    $tmpl->context->{__stash}{blog} = $blog;
        #    $tmpl->context->{__stash}{blog_id} = $blog_id;
        #}

        $MT::DebugMode && $debug->{section}->('prepare load cols');
        for my $col (@cols) {
            my $prop = $props->{$col};
            my @result;
            if ( $prop->has('bulk_html') ) {
                @result = $prop->bulk_html( $objs, $app, \%load_options );
            }

            #elsif ( $prop->has('mtml') ) {
            #    for my $obj ( @$objs ) {
            #        $tmpl->context->{__stash}{$ds} = $obj;
            #        my $out = $prop->html($obj, $app);
            #        $tmpl->text($out);
            #        $tmpl->reset_tokens;
            #        $out = $tmpl->output;
            #        push @result, $out;
            #    }
            #}
            elsif ( $prop->has('html') ) {
                for my $obj (@$objs) {
                    push @result, $prop->html( $obj, $app, \%load_options );
                }
            }
            elsif ( $prop->has('html_link') ) {
                for my $obj (@$objs) {
                    my $link = $prop->html_link( $obj, $app, \%load_options );
                    my $raw = MT::Util::encode_html($prop->raw( $obj, $app, \%load_options ));
                    push @result,
                        ( $link ? qq{<a href="$link">$raw</a>} : $raw );
                }
            }
            elsif ( $prop->has('raw') ) {
                for my $obj (@$objs) {
                    my $out = $prop->raw( $obj, $app, \%load_options );
                    push @result, MT::Util::encode_html($out);
                }
            } else {
            }

            push @results, \@result;
            $MT::DebugMode && $debug->{section}->("prepare col $col");
        }

        for my $i ( 0 .. scalar @$objs - 1 ) {
            push @data, [ map { $_->[$i] } @results ];
        }
    }

    ## Save user list prefs.
    my $list_prefs = $app->user->list_prefs || {};
    my $list_pref = $list_prefs->{$ds}{$blog_id} ||= {};
    $list_pref->{rows} = $limit;
    $list_pref->{columns} = [ split ',', $cols ];
    $list_pref->{last_filter}
        = $filter_id ? $filter_id : $allpass ? '_allpass' : '';
    $list_pref->{last_items} = $filteritems;
    $app->user->list_prefs($list_prefs);
    ## FIXME: should handle errors..
    $app->user->save;

    require MT::CMS::Filter;
    my $filters = MT::CMS::Filter::filters( $app, $ds, encode_html => 1 );

    require POSIX;
    my %res;
    $res{objects}        = \@data;
    $res{columns}        = $cols;
    $res{count}          = $count;
    $res{editable_count} = $editable_count;
    $res{page}           = $page;
    $res{page_max}       = POSIX::ceil( $count / $limit );
    $res{id}             = $filter_id;
    $res{label} = MT::Util::encode_html( $forward_params{saved_label} )
        if $forward_params{saved_label};
    $res{filters}  = $filters;
    $res{messages} = \@messages;
    %res = ( %forward_params, %res );
    $MT::DebugMode && $debug->{section}->('finalize');
    MT->run_callbacks( 'cms_filtered_list_param.' . $ds, $app, \%res, $objs );

    if ($MT::DebugMode) {
        my $total = Time::HiRes::tv_interval( $debug->{total} );
        my $out   = $debug->{out};
        for my $section ( @{ $debug->{sections} } ) {
            $out .= sprintf(
                "%s  : %0.2f ms ( %0.2f %% )\n%s\n",
                $section->[0],
                $section->[1] * 1000,
                $section->[1] / $total * 100,
                $section->[2],
            );
        }
        $out .= sprintf "TOTAL: %0.2f ms\n",    $total * 1000;
        $out .= sprintf "Matched %i Objects\n", $count;
        $res{debug} = $out;
        $Data::ObjectDriver::PROFILE = $debug->{original_prof};
    }
    return $app->json_result( \%res );
}

sub _list {
    my $app  = shift;
    my $q    = $app->query;
    my $type = $q->param('_type');
    return $app->errtrans("Invalid request.") unless $type;

    # being a general-purpose method, lets look for a mode handler
    # that is specifically for editing this type. if we find it,
    # reroute to it.

    my $list_mode = 'list_' . $type;
    if ( my $hdlrs = $app->handlers_for_mode($list_mode) ) {
        return $app->forward($list_mode);
    }

    my %param = $_[0] ? %{ $_[0] } : ();

    my $perms = $app->permissions;
    return $app->return_to_dashboard( redirect => 1 ) unless $perms;

    if (
         $perms
         && (   ( $type eq 'blog' && !$perms->can_edit_config )
             || ( $type eq 'template'     && !$perms->can_edit_templates )
             || ( $type eq 'notification' && !$perms->can_edit_notifications )
         )
      )
    {
        return $app->return_to_dashboard( permission => 1 );
    }
    my $id        = $q->param('id');
    my $class     = $app->model($type) or return;
    my $blog_id   = $q->param('blog_id');
    my $list_pref = $app->list_pref($type);
    my ( %terms, %args );
    %param = ( %param, %$list_pref );
    my $cols   = $class->column_names;
    my $limit  = $list_pref->{rows};
    my $offset = $q->param('offset') || 0;

    for my $name (@$cols) {
        $terms{blog_id} = $blog_id, last if $name eq 'blog_id';
    }
    if ( $type eq 'notification' ) {
        $args{direction} = 'descend';
        $args{offset}    = $offset;
        $args{limit}     = $limit + 1;
    }
    my $iter = $class->load_iter( \%terms, \%args );

    my (
         @data,         @index_data,  @custom_data,
         @archive_data, @system_data, @widget_data
    );
    my (%authors);
    my $blog_class = $app->model('blog');
    my $blog       = $blog_class->load($blog_id);
    my $set        = $blog ? $blog->template_set : undef;
    require MT::DefaultTemplates;
    my $dtmpl = MT::DefaultTemplates->templates($set) || [];
    my %dtmpl = map { $_->{type} => $_ } @$dtmpl;

    while ( my $obj = $iter->() ) {
        my $row = $obj->get_values;
        if ( my $ts = $obj->created_on ) {
            $row->{created_on_formatted}
              = format_ts( MT::App::CMS::LISTING_DATE_FORMAT(),
                        $ts, $blog,
                        $app->user ? $app->user->preferred_language : undef );
            $row->{created_on_time_formatted}
              = format_ts(
                           MT::App::CMS::LISTING_DATETIME_FORMAT(),
                           $ts,
                           $blog,
                           $app->user ? $app->user->preferred_language : undef
              );
            $row->{created_on_relative} = relative_date( $ts, time, $blog );
        }
        if ( $type eq 'template' ) {
            $row->{name} = '' if !defined $row->{name};
            $row->{name} =~ s/^\s+|\s+$//g;
            $row->{name} = "(" . $app->translate("No Name") . ")"
              if $row->{name} eq '';

            if ( $obj->type eq 'index' ) {
                push @index_data, $row;
                $row->{rebuild_me}
                  = defined $row->{rebuild_me} ? $row->{rebuild_me} : 1;
                my $published_url = $obj->published_url;
                $row->{published_url} = $published_url if $published_url;
            }
            elsif ( $obj->type eq 'custom' ) {
                push @custom_data, $row;
            }
            elsif ( $obj->type eq 'widget' ) {
                push @widget_data, $row;
            }
            elsif (    $obj->type eq 'archive'
                    || $obj->type eq 'category'
                    || $obj->type eq 'page'
                    || $obj->type eq 'individual' )
            {

                # FIXME: enumeration of types
                push @archive_data, $row;
            }
            else {
                if ( my $def_tmpl = $dtmpl{ $obj->type } ) {
                    $row->{description} = $def_tmpl->{description_label};
                }
                else {

                    # unknown system template; skip over it
                    # or should we change it to a custom template
                    # right now?
                    next;
                }
                push @system_data, $row;
            }
            $param{search_label} = $app->translate('Templates');
        } ## end if ( $type eq 'template')
        else {
            if ( $limit && ( scalar @data == $limit ) ) {
                $param{next_offset} = 1;
                last;
            }
            push @data, $row;
        }
        if ( $type eq 'ping' ) {
            return $app->list_pings();
            require MT::Trackback;
            require MT::Entry;
            my $tb_center = MT::Trackback->load( $obj->tb_id );
            my $entry     = MT::Entry->load( $tb_center->entry_id )
              or return
              $app->error(
                           $app->translate(
                                            'Can\'t load entry #[_1].',
                                            $tb_center->entry_id
                           )
              );
            if ( my $ts = $obj->created_on ) {
                $row->{created_on_time_formatted}
                  = format_ts(
                           MT::App::CMS::LISTING_DATETIME_FORMAT(),
                           $ts,
                           $blog,
                           $app->user ? $app->user->preferred_language : undef
                  );
                $row->{has_edit_access} = $perms->can_edit_all_posts
                  || $app->user->id == $entry->author_id;
            }
        } ## end if ( $type eq 'ping' )
    }    # end loop over the set of objects;
         # NOW transform the @data array
    if ( $type eq 'notification' ) {
        $app->add_breadcrumb( $app->translate('Notification List') );
        $param{nav_notifications} = 1;

        #@data = sort { $a->{email} cmp $b->{email} } @data;
        $param{object_type}        = 'notification';
        $param{list_noncron}       = 1;
        $param{notification_count} = scalar @data;
        $param{search_type}        = 'entry';
    }
    if ( $type eq 'template' ) {
        $app->add_breadcrumb( $app->translate('Templates') );
        $param{nav_templates} = 1;
        for my $ref ( \@index_data, \@custom_data, \@archive_data ) {
            @$ref = sort { $a->{name} cmp $b->{name} } @$ref;
        }
        my $tab = $q->param('tab') || 'index';
        $param{template_group}      = $tab;
        $param{"tab_$tab"}          = 1;
        $param{object_index_loop}   = \@index_data;
        $param{object_custom_loop}  = \@custom_data;
        $param{object_widget_loop}  = \@widget_data;
        $param{object_archive_loop} = \@archive_data;
        $param{object_system_loop}  = \@system_data;
        $param{object_type}         = 'template';
    }
    else {
        $param{object_loop} = \@data;
    }

    # add any breadcrumbs
    if ( $type eq 'ping' ) {
        $app->add_breadcrumb( $app->translate('TrackBacks') );
        $param{nav_trackbacks} = 1;
        $param{object_type}    = 'ping';
    }
    $param{object_count} = scalar @data;

    if ( $type ne 'template' ) {
        $param{offset}     = $offset;
        $param{list_start} = $offset + 1;
        delete $args{limit};
        delete $args{offset};
        $param{list_total} = $class->count( \%terms, \%args );
        $param{list_end}        = $offset + ( scalar @data );
        $param{next_offset_val} = $offset + ( scalar @data );

        #$param{next_offset} = $param{next_offset_val} < $param{list_total} ? 1 : 0;
        $param{next_max} = $param{list_total} - $limit;
        $param{next_max} = 0 if ( $param{next_max} || 0 ) < $offset + 1;
        if ( $offset > 0 ) {
            $param{prev_offset}     = 1;
            $param{prev_offset_val} = $offset - $limit;
            $param{prev_offset_val} = 0 if $param{prev_offset_val} < 0;
        }
    }

    $app->load_list_actions( $type, \%param );

    $param{saved}         = $q->param('saved');
    $param{saved_deleted} = $q->param('saved_deleted');
    $param{page_actions}  = $app->page_actions( 'list_' . $type );
    $param{screen_class} ||= "list-$type";
    $param{screen_id}    ||= "list-$type";
    $param{listing_screen} = 1;
    $app->load_tmpl( "list_${type}.tmpl", \%param );
} ## end sub list

sub save_list_prefs {
    my $app     = shift;
    my $q       = $app->query;
    my $ds      = $q->param('datasource');
    my $blog_id = $q->param('blog_id') || 0;
    my $blog    = $blog_id ? $app->blog : undef;
    my $scope
        = !$blog         ? 'system'
        : $blog->is_blog ? 'blog'
        :                  'website';
    my $limit      = $q->param('limit')   || 50;    # FIXME: hard coded.
    my $cols       = $q->param('columns') || '';
    my $list_prefs = $app->user->list_prefs || {};
    my $list_pref = $list_prefs->{$ds}{$blog_id} ||= {};
    $list_pref->{rows} = $limit;
    $list_pref->{columns} = [ split ',', $cols ];

#$list_pref->{last_filter} = $filter_id ? $filter_id : $allpass ? '_allpass' : '';
#$list_pref->{last_items} = $filteritems;
    $app->user->list_prefs($list_prefs);
    $app->user->save
        or return $app->json_error( $app->user->errstr );
    return $app->json_result( { success => 1 } );
}

sub delete {
    my $app  = shift;
    my $q    = $app->query;
    my $type = $q->param('_type');

    return $app->errtrans("Invalid request.") unless $type;

    return $app->error( $app->translate("Invalid request.") )
      if $app->request_method() ne 'POST';

    # being a general-purpose method, lets look for a mode handler
    # that is specifically for editing this type. if we find it,
    # reroute to it.

    my $delete_mode = 'delete_' . $type;
    if ( my $hdlrs = $app->handlers_for_mode($delete_mode) ) {
        return $app->forward($delete_mode);
    }

    my $parent  = $q->param('parent');
    my $blog_id = $q->param('blog_id');
    my $class   = $app->model($type) or return;
    my $perms   = $app->permissions;
    my $author  = $app->user;

    $app->validate_magic() or return;

    my ( $entry_id, $cat_id, $author_id ) = ( "", "", "" );
    my %rebuild_entries;
    my @rebuild_cats;
    my $required_items = 0;
    for my $id ( $q->param('id') ) {
        next unless $id;    # avoid 'empty' ids
        if ( ( $type eq 'association' ) && ( $id =~ /PSEUDO-/ ) ) {
            require MT::CMS::User;
            MT::CMS::User::_delete_pseudo_association( $app, $id );
            next;
        }

        my $obj = $class->load($id);
        next unless $obj;
        $app->run_callbacks( 'cms_delete_permission_filter.' . $type,
                             $app, $obj )
          || return $app->error(
               $app->translate( "Permission denied: [_1]", $app->errstr() ) );

        if ( $type eq 'comment' ) {
            $entry_id = $obj->entry_id;
            $rebuild_entries{$entry_id} = 1 if $obj->visible;
        }
        elsif ( $type eq 'ping' || $type eq 'ping_cat' ) {
            require MT::Trackback;
            my $tb = MT::Trackback->load( $obj->tb_id );
            if ($tb) {
                $entry_id = $tb->entry_id;
                $cat_id   = $tb->category_id;
                if ( $obj->visible ) {
                    $rebuild_entries{$entry_id} = 1 if $entry_id;
                    push @rebuild_cats, $cat_id if $cat_id;
                }
            }
        }
        elsif ( $type eq 'tag' ) {

            # if we're in a blog context, remove ONLY tags from that weblog
            if ($blog_id) {
                my $ot_class  = $app->model('objecttag');
                my $obj_type  = $q->param('__type') || 'entry';
                my $obj_class = $app->model($obj_type);
                my $iter =
                  $ot_class->load_iter( {
                              blog_id           => $blog_id,
                              object_datasource => $obj_class->datasource,
                              tag_id            => $id
                            },
                            {
                              'join' =>
                                $obj_class->join_on(
                                   undef,
                                   {
                                     id => \'= objecttag_object_id',
                                     (
                                       $obj_class =~ m/asset/i
                                       ? ()
                                       : ( class => $obj_class->class_type )
                                     )
                                   }
                                )
                            }
                  );

                if ($iter) {
                    my @ot;
                    while ( my $obj = $iter->() ) {
                        push @ot, $obj->id;
                    }
                    foreach (@ot) {
                        my $obj = $ot_class->load($_);
                        next unless $obj;
                        $obj->remove
                          or return
                          $app->errtrans( 'Removing tag failed: [_1]',
                                          $obj->errstr );
                    }
                }

                $app->run_callbacks( 'cms_post_delete.' . $type, $app, $obj );
                next;

            } ## end if ($blog_id)
        } ## end elsif ( $type eq 'tag' )
        elsif ( $type eq 'category' ) {
            if ( $app->config('DeleteFilesAtRebuild') ) {
                require MT::Blog;
                require MT::Entry;
                require MT::Placement;
                my $blog = MT::Blog->load($blog_id)
                  or return $app->error(
                     $app->translate( 'Can\'t load blog #[_1].', $blog_id ) );
                my $at = $blog->archive_type;
                if ( $at && $at ne 'None' ) {
                    my @at = split /,/, $at;
                    for my $target (@at) {
                        my $archiver = $app->publisher->archiver($target);
                        next unless $archiver;
                        if ( $archiver->category_based ) {
                            if ( $archiver->date_based ) {
                                my @entries
                                  = MT::Entry->load(
                                           { status => MT::Entry::RELEASE() },
                                           {
                                             join =>
                                               MT::Placement->join_on(
                                                       'entry_id',
                                                       { category_id => $id },
                                                       { unique      => 1 }
                                               )
                                           }
                                  );
                                for (@entries) {
                                    $app->publisher
                                      ->remove_entry_archive_file(
                                                       Category    => $obj,
                                                       ArchiveType => $target,
                                                       Entry       => $_
                                      );
                                }
                            } ## end if ( $archiver->date_based)
                            else {
                                $app->publisher->remove_entry_archive_file(
                                                        Category    => $obj,
                                                        ArchiveType => $target
                                );
                            }
                        } ## end if ( $archiver->category_based)
                    } ## end for my $target (@at)
                } ## end if ( $at && $at ne 'None')
            } ## end if ( $app->config('DeleteFilesAtRebuild'...))
        } ## end elsif ( $type eq 'category')
        elsif ( $type eq 'page' ) {
            if ( $app->config('DeleteFilesAtRebuild') ) {
                $app->publisher->remove_entry_archive_file(
                                                         Entry       => $obj,
                                                         ArchiveType => 'Page'
                );
            }
        }
        elsif ( $type eq 'author' ) {
            if ( $app->config->ExternalUserManagement ) {
                require MT::LDAP;
                my $ldap = MT::LDAP->new
                  or return
                  $app->error(
                               MT->translate(
                                             "Loading MT::LDAP failed: [_1].",
                                             MT::LDAP->errstr
                               )
                  );
                my $dn = $ldap->get_dn( $obj->name );
                if ($dn) {
                    $app->add_return_arg( author_ldap_found => 1 );
                }
            }
        }

        # FIXME: enumeration of types
        if (   $type eq 'template'
            && $obj->type
            !~ /(custom|index|archive|page|individual|category|widget|backup)/o
          )
        {
            $required_items++;
        }
        else {
            $obj->remove
              or return
              $app->errtrans( 'Removing [_1] failed: [_2]',
                              $app->translate($type),
                              $obj->errstr );
            $app->run_callbacks( 'cms_post_delete.' . $type, $app, $obj );
        }
    } ## end for my $id ( $q->param(...))
    require MT::Entry;
    for my $entry_id ( keys %rebuild_entries ) {
        my $entry = MT::Entry->load($entry_id);
        $app->rebuild_entry( Entry => $entry, BuildDependencies => 1 )
          or return $app->publish_error();
    }
    for my $cat_id (@rebuild_cats) {

        # FIXME: What about other category-based archives?
        # What if user is not publishing category archives?
        my $cat = MT::Category->load($cat_id);
        $app->rebuild(
                       Category    => $cat,
                       BlogID      => $blog_id,
                       ArchiveType => 'Category'
        ) or return $app->publish_error();
    }
    $app->run_callbacks( 'rebuild', MT::Blog->load($blog_id) );
    $app->add_return_arg( $type eq 'ping'
                          ? ( saved_deleted_ping => 1 )
                          : ( saved_deleted => 1 ) );
    if ( $q->param('is_power_edit') ) {
        $app->add_return_arg( is_power_edit => 1 );
    }
    if ($required_items) {
        $app->add_return_arg(
              error => $app->translate("System templates can not be deleted.")
        );
    }
    $app->call_return;
} ## end sub delete

sub clone_blog {
    my $app     = shift;
    my $q       = $app->query;
    my ($param) = {};
    my $user    = $app->user;

    return $app->error( $app->translate("Permission denied.") )
      unless $user->is_superuser;

    my @id = $q->param('blog_id') || $q->param('id');

    if ( !@id ) {
        return $app->error(
                          $app->translate("No blog was selected to clone.") );
    }

    if ( scalar @id > 1 ) {
        return
          $app->error(
                $app->translate(
                    "This action can only be run on a single blog at a time.")
          );
    }

    # Get blog_id from params and validate
    require MT::Blog;
    my $blog_id = shift @id;
    my $blog    = MT::Blog->load($blog_id)
      or return $app->error( $app->translate("Invalid blog_id") );

    my $base 
      = $blog->site_url
      || $app->config('DefaultSiteURL')
      || $app->base;
    $base =~ s/\/$//;

    $param->{'blog_id'}       = $blog->id;
    $param->{'new_blog_name'} = $q->param('new_blog_name')
      || 'Clone of ' . MT::Util::encode_html( $blog->name );
    $param->{'site_url'} = $q->param('site_url') || $base . '_clone';
    $param->{'site_path'} = $q->param('site_path')
      || $blog->site_path . '_clone';

    if ( $q->param('clone_prefs_entries_pages') ) {
        $param->{'clone_prefs_entries_pages'}
          = $q->param('clone_prefs_entries_pages');
    }

    if ( $q->param('clone_prefs_comments') ) {
        $param->{'clone_prefs_comments'} = $q->param('clone_prefs_comments');
    }

    if ( $q->param('clone_prefs_trackbacks') ) {
        $param->{'clone_prefs_trackbacks'}
          = $q->param('clone_prefs_trackbacks');
    }

    if ( $q->param('clone_prefs_categories') ) {
        $param->{'clone_prefs_categories'}
          = $q->param('clone_prefs_categories');
    }

    my $clone = $q->param('back_to_form') ? 0 : $q->param('clone');
    $param = _has_valid_form( $app, $blog, $param );

    if ( $blog_id && $clone && $param->{'isValidForm'} ) {
        print_status_page( $app, $blog, $param );
        return;
    }
    elsif ( $q->param('verify') ) {

        # build form
        $param->{'verify'}     = 1;
        $param->{'system_msg'} = 1;
    }

    my $tmpl = $app->load_tmpl( "dialog/clone_blog.tmpl", $param );

    return $tmpl;
} ## end sub clone_blog

sub _has_valid_form {
    my ($app)   = $_[0];
    my ($blog)  = $_[1];
    my ($param) = $_[2];

    if ( $blog->site_url eq $param->{'site_url'} ) {
        $param->{'site_url_warning'} = 1;
    }
    elsif ( !$param->{'site_url'} ) {
        push(
              @{ $param->{'errors'} },
              $app->translate("You need to specify a Site URL")
        );
    }

    if ( $blog->site_path eq $param->{'site_path'} ) {
        $param->{'site_path_warning'} = 1;
    }
    elsif ( !$param->{'site_path'} ) {
        push(
              @{ $param->{'errors'} },
              $app->translate("You need to specify a Site Path")
        );
    }

    if ( (
              !$param->{'clone_prefs_comments'}
           || !$param->{'clone_prefs_trackbacks'}
         )
         && $param->{'clone_prefs_entries_pages'}
      )
    {
        if (    !$param->{'clone_prefs_comments'}
             && !$param->{'clone_prefs_trackbacks'} )
        {
            push(
                  @{ $param->{'errors'} },
                  $app->translate(
                      "Entries must be cloned if comments and trackbacks are cloned"
                  )
            );
        }
        elsif ( $param->{'clone_prefs_comments'} ) {
            push(
                  @{ $param->{'errors'} },
                  $app->translate(
                              "Entries must be cloned if comments are cloned")
            );
        }
        elsif ( $param->{'clone_prefs_trackbacks'} ) {
            push(
                  @{ $param->{'errors'} },
                  $app->translate(
                            "Entries must be cloned if trackbacks are cloned")
            );
        }
    } ## end if ( ( !$param->{'clone_prefs_comments'...}))

    $param->{'isValidForm'} = $param->{'errors'} ? 0 : 1;

    return $param;
} ## end sub _has_valid_form

sub print_status_page {
    my ($app)           = $_[0];
    my ($blog)          = $_[1];
    my ($param)         = $_[2];
    my ($cloning_prefs) = {};
    $| = 1;
    my $q = $app->query;

    if ( $q->param('clone_prefs_comments') ) {
        $cloning_prefs->{'MT::Comment'} = 0;
    }

    if ( $q->param('clone_prefs_trackbacks') ) {

        # need to exclude both Trackbacks and Pings
        $cloning_prefs->{'MT::Trackback'} = 0;
        $cloning_prefs->{'MT::TBPing'}    = 0;
    }

    if ( $q->param('clone_prefs_categories') ) {
        $cloning_prefs->{'MT::Category'} = 0;
    }

    if ( $q->param('clone_prefs_entries_pages') ) {
        $cloning_prefs->{'MT::Entry'} = 0;
    }

    my $blog_name = $param->{'new_blog_name'};

    # Set up and commence app output
    $app->{no_print_body} = 1;
    $app->send_http_header;
    my $html_head = <<'SCRIPT';
<script type="text/javascript">
function progress(str, id) {
    var el = getByID(id);
    if (el) el.innerHTML = str;
}
</script>
SCRIPT

    $app->print(
             $app->build_page(
                               'dialog/header.tmpl',
                               {
                                 page_title => $app->translate("Clone Blog"),
                                 html_head  => $html_head
                               }
             )
    );
    $app->print( $app->translate_templatized(<<"HTML") );
<h2><__trans phrase="Cloning blog '[_1]'..." params="$blog_name"></h2>

<div class="modal_width" id="dialog-clone-weblog">

<div id="msg-container" style="height: 310px; overflow: auto; overflow-x: auto">
<ul>
HTML

    my $new_blog;
    eval {
        $new_blog = $blog->clone( {
                             BlogName => ($blog_name),
                             Children => 1,
                             Except => ( { site_path => 1, site_url => 1 } ),
                             Callback => sub { _progress( $app, @_ ) },
                             Classes => ($cloning_prefs)
                           }
        );

        $new_blog->site_path( $param->{'site_path'} );
        $new_blog->site_url( $param->{'site_url'} );
        $new_blog->save();
    };
    if ( my $err = $@ ) {
        $app->print(
            $app->translate_templatized(
                qq{<p class="error-message"><MT_TRANS phrase="Error">: $err</p>}
            )
        );
    }
    else {
        $app->add_return_arg( '__mode' => 'list_blog' );
        my $return_url = $app->return_uri;
        my $blog_url = $app->uri( mode => 'dashboard',
                                  args => { blog_id => $new_blog->id } );
        my $setting_url = $app->uri(
                                     mode => 'view',
                                     args => {
                                               blog_id => $new_blog->id,
                                               _type   => 'blog',
                                               id      => $new_blog->id
                                     }
        );

        $app->print( $app->translate_templatized(<<"HTML") );
</ul>
</div>

<p><strong><__trans phrase="Finished! You can <a href=\"javascript:void(0);\" onclick=\"closeDialog('[_1]');\">return to the blog listing</a> or <a href=\"javascript:void(0);\" onclick=\"closeDialog('[_2]');\">configure the Site root and URL of the new blog</a>." params="$return_url%%$setting_url"></strong></p>

<form method="GET">
  <div class="actions-bar">
    <div class="actions-bar-inner pkg actions">
    <button
      onclick="closeDialog('$return_url'); return false"
      type="submit"
      accesskey="x"
      class="primary-button"
      ><__trans phrase="Close"></button>
    </div>
  </div>
</form>

</div>

HTML
    } ## end else [ if ( my $err = $@ ) ]

    $app->print( $app->build_page('dialog/footer.tmpl') );
} ## end sub print_status_page

sub _progress {
    my $app = shift;
    my $ids = $app->request('progress_ids') || {};

    my ( $str, $id ) = @_;
    if ( $id && $ids->{$id} ) {
        require MT::Util;
        my $str_js = MT::Util::encode_js($str);
        $app->print(
            qq{<script type="text/javascript">progress('$str_js', '$id');</script>\n}
        );
    }
    elsif ($id) {
        $ids->{$id} = 1;
        $app->print(qq{<li id="$id">$str</li>\n});
    }
    else {
        $app->print("<li>$str</li>");
    }

    $app->request( 'progress_ids', $ids );
} ## end sub _progress

sub not_junk_test {
    my ( $eh, $app, $obj ) = @_;
    require MT::JunkFilter;
    MT::JunkFilter->filter($obj);
    $obj->is_junk ? 0 : 1;
}

sub build_revision_table {
    my $app = shift;
    my (%args) = @_;

    my $q     = $app->query;
    my $type  = $q->param('_type');
    my $class = $app->model($type);
    my $param = $args{param};
    my $obj   = $args{object};
    my $blog 
      = $obj->blog
      || MT->model('blog')->load( $q->param('blog_id') )
      || undef;
    my $lang = $app->user ? $app->user->preferred_language : undef;

    my $js = $param->{rev_js};
    unless ($js) {
        $js
          = "location.href='" . $app->uri . '?__mode=view&amp;_type=' . $type;
        if ( my $id = $obj->id ) {
            $js .= '&amp;id=' . $id;
        }
        if ( defined $blog ) {
            $js .= '&amp;blog_id=' . $blog->id;
        }
    }
    my %users;
    my $hasher = sub {
        my ( $rev, $row ) = @_;
        if ( my $ts = $rev->created_on ) {
            $row->{created_on_formatted}
              = format_ts( MT::App::CMS::LISTING_DATE_FORMAT(),
                           $ts, $blog, $lang );
            $row->{created_on_time_formatted}
              = format_ts( MT::App::CMS::LISTING_TIMESTAMP_FORMAT(),
                           $ts, $blog, $lang );
            $row->{created_on_relative} = relative_date( $ts, time, $blog );
        }
        if ( $row->{created_by} ) {
            my $created_user = $users{ $row->{created_by} }
              ||= MT::Author->load( $row->{created_by} );
            if ($created_user) {
                $row->{created_by} = $created_user->nickname;
            }
            else {
                $row->{created_by} = $app->translate('(user deleted)');
            }
        }
        my $revision    = $obj->object_from_revision($rev);
        my $column_defs = $obj->column_defs;

        #my @changed = map {
        #    my $label = $column_defs->{$_}->{label};
        #    $label ||= $_;
        #    $app->translate( $label );
        #} @{ $revision->[1] };
        #$row->{changed_columns} = \@changed;
        if ( ( 'entry' eq $type ) || ( 'page' eq $type ) ) {
            $row->{rev_status} = $revision->[0]->status;
        }
        $row->{rev_js}     = $js . '&amp;r=' . $row->{rev_number} . "'";
        $row->{is_current} = $param->{revision} == $row->{rev_number};
    };
    return
      $app->listing( {
                       type   => "$type:revision",
                       code   => $hasher,
                       terms  => { $class->datasource . '_id' => $obj->id },
                       source => $type,
                       params => { dialog => $q->param('dialog'), },
                       %$param
                     }
      );
} ## end sub build_revision_table

sub list_revision {
    my $app   = shift;
    my $q     = $app->query;
    my $type  = $q->param('_type');
    my $class = $app->model($type);
    my $id    = $q->param('id');
    my $rn    = $q->param('r');
    $id =~ s/\D//g;
    my $obj = $class->load($id)
      or return
      $app->error(
          $app->translate(
                           'Can\'t load [_1] #[_1].', $class->class_label, $id
          )
      );
    my $blog = $obj->blog || MT::Blog->load( $q->param('blog_id') ) || undef;

    my $js
      = "parent.location.href='"
      . $app->uri
      . '?__mode=view&amp;_type='
      . $type
      . '&amp;id='
      . $obj->id;
    if ( defined $blog ) {
        $js .= '&amp;blog_id=' . $blog->id;
    }
    my $revision = $rn
      || (   $obj->has_meta('revision')
           ? $obj->revision || $obj->current_revision
           : $obj->current_revision || 0 );
    return
      build_revision_table(
          $app,
          object => $obj,
          param  => {
              template => 'dialog/list_revision.tmpl',
              args => { sort_order => 'rev_number', direction => 'descend', },
              rev_js   => $js,
              revision => $revision,
          }
      );
} ## end sub list_revision

sub save_snapshot {
    my $app   = shift;
    my $q     = $app->query;
    my $type  = $q->param('_type');
    my $id    = $q->param('id');
    my $param = {};

    return $app->errtrans("Invalid request.") unless $type;

    $app->validate_magic() or return;

    $app->run_callbacks( 'cms_save_permission_filter.' . "$type:revision",
                         $app, $id )
      || return $app->error(
               $app->translate( "Permission denied: [_1]", $app->errstr() ) );

    my $filter_result
      = $app->run_callbacks( 'cms_save_filter.' . "$type:revision", $app );
    if ( !$filter_result ) {
        my %param = (%$param);
        $param{error}       = $app->errstr;
        $param{return_args} = $q->param('return_args');
        my $mode = 'view_' . $type;
        if ( $app->handlers_for_mode($mode) ) {
            return $app->forward( $mode, \%param );
        }
        return $app->forward( 'view', \%param );
    }

    my $class = $app->model($type)
      or return $app->errtrans( "Invalid type [_1]", $type );
    my $obj;
    if ($id) {
        $obj = $class->load($id)
          or return $app->error( $app->translate( "Invalid ID [_1]", $id ) );
    }
    else {
        $obj = $class->new;
    }

    my $original = $obj->clone();
    my $names    = $obj->column_names;
    my %values   = map { $_ => ( scalar $q->param($_) ) } @$names;

    if ( ( 'entry' eq $type ) || ( 'page' eq $type ) ) {
        $app->_translate_naughty_words($obj);
    }
    delete $values{'id'} if exists( $values{'id'} ) && !$values{'id'};
    $obj->set_values( \%values );
    unless (
             $app->run_callbacks( 'cms_pre_save.' . "$type:revision", $app,
                                  $obj,                               undef )
      )
    {
        $param->{return_args} = $q->param('return_args');
        return
          edit(
                $app,
                {
                   %$param,
                   error =>
                     $app->translate(
                                      "Saving snapshot failed: [_1]",
                                      $app->errstr
                     )
                }
          );
    }
    $obj->gather_changed_cols($original);
    if ( exists $obj->{changed_revisioned_cols} ) {
        my $col = 'max_revisions_' . $obj->datasource;
        if ( my $blog = $obj->blog ) {
            my $max = $blog->$col;
            $obj->handle_max_revisions($max);
        }
        my $revision = $obj->save_revision( $q->param('revision-note') );
        $app->add_return_arg( r => $revision );
        if ($id) {
            my $obj_revision = $original->revision || 0;
            unless ($obj_revision) {
                $original->revision( $revision - 1 );

                # hack to bypass instance save method
                $original->{__meta}->save;
            }
            $original->current_revision($revision);

            # call update to bypass instance save method
            $original->update or return $original->error( $original->errstr );
        }

        $app->run_callbacks( 'cms_post_save.' . "$type:revision",
                             $app, $obj, undef )
          or return $app->error( $app->errstr() );

        $app->add_return_arg( 'saved_snapshot' => 1 );
    } ## end if ( exists $obj->{changed_revisioned_cols...})
    else {
        $app->add_return_arg( 'no_snapshot' => 1 );
    }

    $app->add_return_arg( 'id' => $obj->id ) if !$original->id;
    $app->call_return;
} ## end sub save_snapshot

sub empty_dialog {
    my $app = shift;
    $app->build_page('dialog/empty_dialog.tmpl');
}

1;

__END__

=head1 NAME

MT::CMS::Common

=head1 METHODS

=head2 clone_blog

=head2 delete

=head2 edit

=head2 list

=head2 not_junk_test

=head2 print_status_page

=head2 save

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
