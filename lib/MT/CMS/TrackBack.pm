package MT::CMS::TrackBack;

use strict;
use MT::Util qw( format_ts relative_date encode_url encode_html );
use MT::I18N qw( const break_up_text substr_text );

sub edit {
    my $cb = shift;
    my ( $app, $id, $obj, $param ) = @_;
    my $q       = $app->query;
    my $perms   = $app->permissions;
    my $blog    = $app->blog;
    my $blog_id = $q->param('blog_id');
    my $type    = $q->param('_type');

    if ($id) {
        $param->{nav_trackbacks} = 1;
        $app->add_breadcrumb(
                              $app->translate('TrackBacks'),
                              $app->uri(
                                         'mode' => 'list_pings',
                                         args   => { blog_id => $blog_id }
                              )
        );
        $app->add_breadcrumb( $app->translate('Edit TrackBack') );
        $param->{approved}           = $q->param('approved');
        $param->{unapproved}         = $q->param('unapproved');
        $param->{has_publish_access} = 1 if $app->user->is_superuser;
        $param->{has_publish_access}
          = ( ( $perms->can_manage_feedback || $perms->can_edit_all_posts )
              ? 1
              : 0 )
          unless $app->user->is_superuser;
        require MT::Trackback;

        if ( my $tb = MT::Trackback->load( $obj->tb_id ) ) {
            if ( $tb->entry_id ) {
                $param->{entry_ping} = 1;
                require MT::Entry;
                if ( my $entry = MT::Entry->load( $tb->entry_id ) ) {
                    $param->{entry_title} = $entry->title;
                    $param->{entry_id}    = $entry->id;
                    unless ( $param->{has_publish_access} ) {
                        $param->{has_publish_access}
                          = ( $perms->can_publish_post
                              && ( $app->user->id == $entry->author_id ) )
                          ? 1
                          : 0;
                    }
                }
            }
            elsif ( $tb->category_id ) {
                $param->{category_ping} = 1;
                require MT::Category;
                if ( my $cat = MT::Category->load( $tb->category_id ) ) {
                    $param->{category_id}    = $cat->id;
                    $param->{category_label} = $cat->label;
                }
            }
        } ## end if ( my $tb = MT::Trackback...)

        $param->{"ping_approved"} = $obj->is_published
          or $param->{"ping_pending"} = $obj->is_moderated
          or $param->{"is_junk"}      = $obj->is_junk;

        ## Load next and previous entries for next/previous links
        if ( my $next = $obj->next ) {
            $param->{next_ping_id} = $next->id;
        }
        if ( my $prev = $obj->previous ) {
            $param->{previous_ping_id} = $prev->id;
        }
        my $parent = $obj->parent;
        if ( $parent && ( $parent->isa('MT::Entry') ) ) {
            if ( $parent->status == MT::Entry::RELEASE() ) {
                $param->{entry_permalink} = $parent->permalink;
            }
        }

        if ( $obj->junk_log ) {
            require MT::CMS::Comment;
            MT::CMS::Comment::build_junk_table(
                                                $app,
                                                param  => $param,
                                                object => $obj
            );
        }

        $param->{created_on_time_formatted}
          = format_ts(
                       MT::App::CMS::LISTING_DATETIME_FORMAT(),
                       $obj->created_on(),
                       $blog,
                       $app->user ? $app->user->preferred_language : undef
          );
        $param->{created_on_day_formatted}
          = format_ts(
                       MT::App::CMS::LISTING_DATE_FORMAT(),
                       $obj->created_on(),
                       $blog,
                       $app->user ? $app->user->preferred_language : undef
          );

        $param->{search_label} = $app->translate('TrackBacks');
        $param->{object_type}  = 'ping';

        $app->load_list_actions( $type, $param );

        # since MT::App::build_page clobbers it:
        $param->{source_blog_name} = $param->{blog_name};
    } ## end if ($id)
    1;
} ## end sub edit

sub can_view {
    my $eh = shift;
    my ( $app, $id, $objp ) = @_;
    my $obj = $objp->force() or return 0;
    require MT::Trackback;
    my $tb    = MT::Trackback->load( $obj->tb_id );
    my $perms = $app->permissions;
    if ($tb) {
        if ( $tb->entry_id ) {
            require MT::Entry;
            my $entry = MT::Entry->load( $tb->entry_id );
            return (   !$entry
                     || $entry->author_id == $app->user->id
                     || $perms->can_manage_feedback
                     || $perms->can_edit_all_posts );
        }
        elsif ( $tb->category_id ) {
            require MT::Category;
            my $cat = MT::Category->load( $tb->category_id );
            return $cat && $perms->can_edit_categories;
        }
    }
    else {
        return 0;    # no TrackBack center--no edit
    }
} ## end sub can_view

sub can_save {
    my ( $eh, $app, $id ) = @_;
    my $q = $app->query;
    return 0 unless $id;    # Can't create new pings here
    return 1 if $app->user->is_superuser();
    my $perms = $app->permissions;
    return 1
      if $perms
          && ( $perms->can_edit_all_posts || $perms->can_manage_feedback );
    my $p = MT::TBPing->load($id) or return 0;
    my $tbitem = $p->parent;

    if ( $tbitem->isa('MT::Entry') ) {
        if ( $perms && $perms->can_publish_post && $perms->can_create_post ) {
            return $tbitem->author_id == $app->user->id;
        }
        elsif ( $perms->can_create_post ) {
            return ( $tbitem->author_id == $app->user->id )
              && ( ( $p->is_junk && ( 'junk' eq $q->param('status') ) )
                   || ( $p->is_moderated
                        && ( 'moderate' eq $q->param('status') ) )
                   || ( $p->is_published
                        && ( 'publish' eq $q->param('status') ) ) );
        }
        elsif ( $perms && $perms->can_publish_post ) {
            return 0 unless $tbitem->author_id == $app->user->id;
            return 0
              unless ( $p->excerpt eq $q->param('excerpt') )
              && ( $p->blog_name  eq $q->param('blog_name') )
              && ( $p->title      eq $q->param('title') )
              && ( $p->source_url eq $q->param('source_url') );
        }
    } ## end if ( $tbitem->isa('MT::Entry'...))
    else {
        return $perms && $perms->can_edit_categories;
    }
} ## end sub can_save

sub can_delete {
    my ( $eh, $app, $obj ) = @_;
    my $author = $app->user;
    return 1 if $author->is_superuser();
    my $perms = $app->permissions;
    require MT::Trackback;
    my $tb = MT::Trackback->load( $obj->tb_id ) or return 0;
    if ( my $entry = $tb->entry ) {
        if ( !$perms || $perms->blog_id != $entry->blog_id ) {
            $perms ||= $author->permissions( $entry->blog_id );
        }

        # publish_post allows entry author to delete comment.
        return 1
          if $perms->can_edit_all_posts
              || $perms->can_manage_feedback
              || $perms->can_edit_entry( $entry, $author, 1 );
        return 0
          if $obj->visible;    # otherwise, visible comment can't be deleted.
        return $perms->can_edit_entry( $entry, $author );
    }
    elsif ( $tb->category_id ) {
        $perms ||= $author->permissions( $tb->blog_id );
        return ( $perms && $perms->can_edit_categories() );
    }
    return 0;
} ## end sub can_delete

sub pre_save {
    my $eh = shift;
    my ( $app, $obj, $original ) = @_;
    my $q     = $app->query;
    my $perms = $app->permissions;
    return 1
      unless $perms->can_publish_post
          || $perms->can_edit_categories
          || $perms->can_edit_all_posts
          || $perms->can_manage_feedback;

    unless ( $perms->can_edit_all_posts || $perms->can_manage_feedback ) {
        return 1
          unless $perms->can_publish_post || $perms->can_edit_categories;
        require MT::Trackback;
        my $tb = MT::Trackback->load( $obj->tb_id ) or return 0;
        if ($tb) {
            if ( $tb->entry_id ) {
                require MT::Entry;
                my $entry = MT::Entry->load( $tb->entry_id );
                return 1
                  if ( !$entry || $entry->author_id != $app->user->id )
                  && $perms->can_publish_post;
            }
        }
        elsif ( $tb->category_id ) {
            require MT::Category;
            my $cat = MT::Category->load( $tb->category_id );
            return 1 unless $cat && $perms->can_edit_categories;
        }
    } ## end unless ( $perms->can_edit_all_posts...)

    my $status = $q->param('status');
    if ( $status eq 'publish' ) {
        $obj->approve;
        if ( $original->junk_status != $obj->junk_status ) {
            $app->run_callbacks( 'handle_ham', $app, $obj );
        }
    }
    elsif ( $status eq 'moderate' ) {
        $obj->moderate;
    }
    elsif ( $status eq 'junk' ) {
        $obj->junk;
        if ( $original->junk_status != $obj->junk_status ) {
            $app->run_callbacks( 'handle_spam', $app, $obj );
        }
    }
    return 1;
} ## end sub pre_save

sub post_save {
    my $eh = shift;
    my ( $app, $obj, $original ) = @_;
    require MT::Trackback;
    require MT::Entry;
    require MT::Category;
    if ( my $tb = MT::Trackback->load( $obj->tb_id ) ) {
        my ( $entry, $cat );
        if ( $tb->entry_id && ( $entry = MT::Entry->load( $tb->entry_id ) ) )
        {
            if ( $obj->visible
                || ( ( $obj->visible || 0 ) != ( $original->visible || 0 ) ) )
            {
                $app->rebuild_entry( Entry => $entry, BuildIndexes => 1 )
                  or return $app->publish_error();
            }
        }
        elsif ( $tb->category_id
                && ( $cat = MT::Category->load( $tb->category_id ) ) )
        {

            # FIXME: rebuild single category
        }
    }
    1;
} ## end sub post_save

sub post_delete {
    my ( $eh, $app, $obj ) = @_;

    my ( $message, $title );
    my $obj_parent = $obj->parent();
    if ( $obj_parent->isa('MT::Category') ) {
        $title = $obj_parent->label
          || $app->translate('(Unlabeled category)');
        $message
          = $app->translate(
            "Ping (ID:[_1]) from '[_2]' deleted by '[_3]' from category '[_4]'",
            $obj->id, $obj->blog_name, $app->user->name, $title );
    }
    else {
        $title = $obj_parent->title || $app->translate('(Untitled entry)');
        $message
          = $app->translate(
             "Ping (ID:[_1]) from '[_2]' deleted by '[_3]' from entry '[_4]'",
             $obj->id, $obj->blog_name, $app->user->name, $title );
    }

    $app->log( {
                 message  => $message,
                 level    => MT::Log::INFO(),
                 class    => 'system',
                 category => 'delete'
               }
    );
} ## end sub post_delete

# takes param and one of load_args, iter, or items
sub build_ping_table {
    my $app = shift;
    my (%args) = @_;

    require MT::Entry;
    require MT::Trackback;
    require MT::Category;

    my $author    = $app->user;
    my $list_pref = $app->list_pref('ping');
    my $iter;
    if ( $args{load_args} ) {
        my $class = $app->model('ping');
        $iter = $class->load_iter( @{ $args{load_args} } );
    }
    elsif ( $args{iter} ) {
        $iter = $args{iter};
    }
    elsif ( $args{items} ) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $limit = $args{limit};
    my $param = $args{param};

    my @data;
    my ( %blogs, %entries, %cats, %perms );
    my $excerpt_max_len
      = const('DISPLAY_LENGTH_EDIT_PING_TITLE_FROM_EXCERPT');
    my $title_max_len = const('DISPLAY_LENGTH_EDIT_PING_BREAK_UP');
    while ( my $obj = $iter->() ) {
        my $row = $obj->get_values;
        my $blog = $blogs{ $obj->blog_id } ||= $obj->blog if $obj->blog_id;
        $row->{excerpt} = '[' . $app->translate("No Excerpt") . ']'
          unless ( $row->{excerpt} || '' ) ne '';
        if ( ( $row->{title} || '' ) eq ( $row->{source_url} || '' ) ) {
            $row->{title} = '[' . $app->translate("No Title") . ']';
        }
        if ( !defined( $row->{title} ) ) {
            $row->{title}
              = substr_text( $row->{excerpt} || "", 0, $excerpt_max_len )
              . '...';
        }
        $row->{excerpt} ||= '';
        $row->{title}   = break_up_text( $row->{title},   $title_max_len );
        $row->{excerpt} = break_up_text( $row->{excerpt}, $title_max_len );
        $row->{blog_name}
          = break_up_text( $row->{blog_name}, $title_max_len );
        $row->{object} = $obj;
        push @data, $row;

        my $entry;
        my $cat;
        if ( my $tb_center = MT::Trackback->load( $obj->tb_id ) ) {
            if ( $tb_center->entry_id ) {
                $entry = $entries{ $tb_center->entry_id }
                  ||= $app->model('entry')->load( $tb_center->entry_id );
                my $class = $entry->class || 'entry';
                if ($entry) {
                    $row->{target_title} = $entry->title;
                    $row->{target_link}
                      = $app->uri(
                                   'mode' => 'view',
                                   args   => {
                                             '_type' => $class,
                                             id      => $entry->id,
                                             blog_id => $entry->blog_id,
                                             tab     => 'pings'
                                   }
                      );
                }
                else {
                    $row->{target_title} = (
                        '* ' . $app->translate('Orphaned TrackBack') . ' *' );
                }
                $row->{target_type} = $app->translate($class);
            } ## end if ( $tb_center->entry_id)
            elsif ( $tb_center->category_id ) {
                $cat = $cats{ $tb_center->category_id }
                  ||= MT::Category->load( $tb_center->category_id );
                if ($cat) {
                    $row->{target_title} = (
                        '* ' . $app->translate('Orphaned TrackBack') . ' *' );
                    $row->{target_title} = $cat->label;
                    $row->{target_link}
                      = $app->uri(
                                   'mode' => 'view',
                                   args   => {
                                             '_type' => 'category',
                                             id      => $cat->id,
                                             blog_id => $cat->blog_id,
                                             tab     => 'pings'
                                   }
                      );
                }
                $row->{target_type} = $app->translate('category');
            } ## end elsif ( $tb_center->category_id)
        } ## end if ( my $tb_center = MT::Trackback...)
        if ( my $ts = $obj->created_on ) {
            $row->{created_on_time_formatted}
              = format_ts(
                           MT::App::CMS::LISTING_DATETIME_FORMAT(),
                           $ts,
                           $blog,
                           $app->user ? $app->user->preferred_language : undef
              );
            $row->{created_on_formatted}
              = format_ts( MT::App::CMS::LISTING_DATE_FORMAT(),
                        $ts, $blog,
                        $app->user ? $app->user->preferred_language : undef );
            $row->{created_on_relative} = relative_date( $ts, time, $blog );
        }
        if ($blog) {
            $row->{weblog_id}   = $blog->id;
            $row->{weblog_name} = $blog->name;
        }
        else {
            $row->{weblog_name}
              = '* ' . $app->translate('Orphaned TrackBack') . ' *';
        }
        if ( $author->is_superuser() ) {
            $row->{has_edit_access} = 1;
            $row->{has_bulk_access} = 1;
        }
        else {
            my $perms = $perms{ $obj->blog_id }
              ||= $author->permissions( $obj->blog_id );
            $row->{has_bulk_access} = ( (
                                 $perms
                                   && ( (
                                        $entry
                                        && (    $perms->can_edit_all_posts
                                             || $perms->can_manage_feedback )
                                      )
                                      || (
                                          $cat
                                          && (   $perms->can_edit_categories
                                              || $perms->can_manage_feedback )
                                      )
                                   )
                               )
                                 || ( $cat && $author->id == $cat->author_id )
                                 || (
                                     $entry
                                     && ( ( $author->id == $entry->author_id )
                                          && $perms->can_publish_post )
                                 )
            );
            $row->{has_edit_access} = ( (
                                 $perms
                                   && ( (
                                        $entry
                                        && (    $perms->can_edit_all_posts
                                             || $perms->can_manage_feedback )
                                      )
                                      || (
                                          $cat
                                          && (   $perms->can_edit_categories
                                              || $perms->can_manage_feedback )
                                      )
                                   )
                               )
                                 || ( $cat && $author->id == $cat->author_id )
                                 || (
                                     $entry
                                     && ( ( $author->id == $entry->author_id )
                                          && $perms->can_create_post )
                                 )
            );
        } ## end else [ if ( $author->is_superuser...)]
    } ## end while ( my $obj = $iter->...)
    return [] unless @data;

    $param->{ping_table}[0] = {%$list_pref};
    $param->{object_loop} = $param->{ping_table}[0]{object_loop} = \@data;
    $param->{ping_table}[0]{object_type} = 'ping';
    $app->load_list_actions( 'ping', $param );
    \@data;
} ## end sub build_ping_table

1;
__END__

=head1 NAME

MT::CMS::TrackBack

=head1 METHODS

=head2 build_ping_table

=head2 can_delete

=head2 can_save

=head2 can_view

=head2 edit

=head2 list

=head2 post_delete

=head2 post_save

=head2 pre_save

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
