package MT::CMS::Category;

use strict;
use MT::Util qw( encode_url encode_js );

sub edit {
    my $cb = shift;
    my ($app, $id, $obj, $param) = @_;
    my $blog_id = $app->query->param('blog_id');
    my $blog = $app->blog;

    if ($id) {
        $param->{nav_categories} = 1;

        #$param{ "tab_" . ( $app->query->param('tab') || 'details' ) } = 1;

        # $app->add_breadcrumb($app->translate('Categories'),
        #                      $app->uri( 'mode' => 'list_cat',
        #                          args => { blog_id => $obj->blog_id }));
        # $app->add_breadcrumb($obj->label);
        my $parent   = $obj->parent_category;
        my $site_url = $blog->site_url;
        $site_url .= '/' unless $site_url =~ m!/$!;
        $param->{path_prefix} =
          $site_url . ( $parent ? $parent->publish_path : '' );
        $param->{path_prefix} .= '/' unless $param->{path_prefix} =~ m!/$!;
        require MT::Trackback;
        my $tb = MT::Trackback->load( { category_id => $obj->id } );

        my $tags_js = MT::Util::to_json(
            MT::Tag->cache(
                blog_id => $blog_id,
                class   => 'MT::Category',
                private => 1
            )
        );
        $tags_js =~ s!/!\\/!g;
        $param->{tags_js} = $tags_js;

    if ( $app->query->param('tags') ) {
        $param->{tags} = $app->query->param('tags');
    }
    else {
        if ($obj) {
            my $tag_delim = chr( $app->user->entry_prefs->{tag_delim} );
            require MT::Tag;
            my $tags = MT::Tag->join( $tag_delim, $obj->tags );
            $param->{tags} = $tags;
        }
    }
    $param->{auth_pref_tag_delim} = chr( $app->user->entry_prefs->{tag_delim} );

        if ($tb) {
            my $list_pref = $app->list_pref('ping');
            %$param = ( %$param, %$list_pref );
            my $path = $app->config('CGIPath');
            $path .= '/' unless $path =~ m!/$!;
            if ($path =~ m!^/!) {
                my ($blog_domain) = $blog->archive_url =~ m|(.+://[^/]+)|;
                $path = $blog_domain . $path;
            }

            my $script = $app->config('TrackbackScript');
            $param->{tb}     = 1;
            $param->{tb_url} = $path . $script . '/' . $tb->id;
            if ( $param->{tb_passphrase} = $tb->passphrase ) {
                $param->{tb_url} .= '/' . encode_url( $param->{tb_passphrase} );
            }
            $app->load_list_actions( 'ping', $param->{ping_table}[0],
                'pings' );
        }
    }
    1;
}

sub list {
    my $app   = shift;
    my $q     = $app->query;
    my $type  = $q->param('_type') || 'category';
    my $class = $app->model($type);

    my $perms = $app->permissions;
    my $entry_class;
    my $entry_type;
    if ( $type eq 'category' ) {
        $entry_type = 'entry';
        return $app->return_to_dashboard( redirect => 1 )
          unless $perms && $perms->can_edit_categories;
    }
    elsif ( $type eq 'folder' ) {
        $entry_type = 'page';
        return $app->return_to_dashboard( redirect => 1 )
          unless $perms && $perms->can_manage_pages;
    }
    $entry_class = $app->model($entry_type);
    my $blog_id = scalar $q->param('blog_id');
    require MT::Blog;
    my $blog = MT::Blog->load($blog_id)
      or return $app->errtrans("Invalid request.");
    my %param;
    my %authors;
    my $data = $app->_build_category_list(
        blog_id    => $blog_id,
        counts     => 1,
        new_cat_id => scalar $q->param('new_cat_id'),
        type       => $type
    );
    if ( $blog->site_url =~ /\/$/ ) {
        $param{blog_site_url} = $blog->site_url;
    }
    else {
        $param{blog_site_url} = $blog->site_url . '/';
    }
    $param{object_loop} = $param{category_loop} = $data;
    $param{saved} = $q->param('saved');
    $param{saved_deleted} = $q->param('saved_deleted');
    $app->load_list_actions( $type, \%param );

    #$param{nav_categories} = 1;
    $param{sub_object_label} =
        $type eq 'folder'
      ? $app->translate('Subfolder')
      : $app->translate('Subcategory');
    $param{object_label}        = $class->class_label;
    $param{object_label_plural} = $class->class_label_plural;
    $param{object_type}         = $type;
    $param{entry_label_plural}  = $entry_class->class_label_plural;
    $param{entry_label}         = $entry_class->class_label;
    $param{search_label}        = $param{entry_label_plural};
    $param{search_type}         = $entry_type;
    $param{screen_id} =
        $type eq 'folder'
      ? 'list-folder'
      : 'list-category';
    $param{listing_screen}      = 1;
    $app->add_breadcrumb( $param{object_label_plural} );

    $param{screen_class} = "list-${type}";
    $param{screen_class} .= " list-category"
      if $type eq 'folder';    # to piggyback on list-category styles
    my $tmpl_file = 'list_' . $type . '.tmpl';
    $app->load_tmpl( $tmpl_file, \%param );
}

sub save {
    my $app   = shift;
    my $q     = $app->query;
    my $perms = $app->permissions;
    my $type  = $q->param('_type');
    my $class = $app->model($type)
      or return $app->errtrans("Invalid request.");

    if ( $type eq 'category' ) {
        return $app->errtrans("Permission denied.")
          unless $perms && $perms->can_edit_categories;
    }
    elsif ( $type eq 'folder' ) {
        return $app->errtrans("Permission denied.")
          unless $perms && $perms->can_manage_pages;
    }

    $app->validate_magic() or return;

    my $blog_id = $q->param('blog_id');
    my $cat;
    if ( my $moved_cat_id = $q->param('move_cat_id') ) {
        $cat = $class->load( $q->param('move_cat_id') )
            or return;
        move_category($app) or return;
    }
    else {
        for my $p ( $q->param ) {
            my ($parent) = $p =~ /^category-new-parent-(\d+)$/;
            next unless ( defined $parent );

            my $label = $q->param($p);
            $label =~ s/(^\s+|\s+$)//g;
            next unless ( $label ne '' );

            $cat = $class->new;
            my $original = $cat->clone;
            $cat->blog_id($blog_id);
            $cat->label($label);
            $cat->author_id( $app->user->id );
            $cat->parent($parent);

            $app->run_callbacks( 'cms_pre_save.' . $type,
                $app, $cat, $original )
              || return $app->errtrans( "Saving [_1] failed: [_2]", $type,
                $app->errstr );

            $cat->save
              or return $app->error(
                $app->translate(
                    "Saving [_1] failed: [_2]",
                    $type, $cat->errstr
                )
              );

            # Now post-process it.
            $app->run_callbacks( 'cms_post_save.' . $type,
                $app, $cat, $original );
        }
    }

    return $app->errtrans( "The [_1] must be given a name!", $type )
      if !$cat;

    $app->redirect(
        $app->uri(
            'mode' => 'list_cat',
            args   => {
                _type      => $type,
                blog_id    => $blog_id,
                saved      => 1,
                new_cat_id => $cat->id
            }
        )
    );
}

sub category_add {
    my $app  = shift;
    my $q    = $app->query;
    my $type = $q->param('_type') || 'category';
    my $pkg  = $app->model($type);
    my $data = $app->_build_category_list(
        blog_id => scalar $q->param('blog_id'),
        type    => $type
    );
    my %param;
    $param{'category_loop'} = $data;
    $app->add_breadcrumb( $app->translate( 'Add a [_1]', $pkg->class_label ) );
    $param{object_type}  = $type;
    $param{object_label} = $pkg->class_label;
    $app->load_tmpl( 'popup/category_add.tmpl', \%param );
}

sub category_do_add {
    my $app    = shift;
    my $q      = $app->query;
    my $type   = $q->param('_type') || 'category';
    my $author = $app->user;
    my $pkg    = $app->model($type);
    $app->validate_magic() or return;
    my $name = $q->param('label')
      or return $app->error( $app->translate("No label") );
    $name =~ s/(^\s+|\s+$)//g;
    return $app->errtrans("Category name cannot be blank.")
      if $name eq '';
    my $parent   = $q->param('parent') || '0';
    my $cat      = $pkg->new;
    my $original = $cat->clone;
    $cat->blog_id( scalar $q->param('blog_id') );
    $cat->author_id( $app->user->id );
    $cat->label($name);
    $cat->parent($parent);

    if ( !$author->is_superuser ) {
        $app->run_callbacks( 'cms_save_permission_filter.' . $type,
            $app, undef )
          || return $app->error(
            $app->translate( "Permission denied: [_1]", $app->errstr() ) );
    }

    my $filter_result = $app->run_callbacks( 'cms_save_filter.' . $type, $app )
      || return;

    $app->run_callbacks( 'cms_pre_save.' . $type, $app, $cat, $original )
      || return;

    $cat->save or return $app->error( $cat->errstr );

    # Now post-process it.
    $app->run_callbacks( 'cms_post_save.' . $type, $app, $cat, $original )
      or return;

    my $id = $cat->id;
    $name = encode_js($name);
    my %param = ( javascript => <<SCRIPT);
    o.doAddCategoryItem('$name', '$id');
SCRIPT
    $app->load_tmpl( 'reload_opener.tmpl', \%param );
}

sub js_add_category {
    my $app = shift;
	my $q = $app->query;
    unless ( $app->validate_magic ) {
        return $app->json_error( $app->translate("Invalid request.") );
    }
    my $user    = $app->user;
    my $blog_id = $q->param('blog_id');
    my $perms   = $app->permissions;
    my $type    = $q->param('_type') || 'category';
    my $class   = $app->model($type);
    if ( !$class ) {
        return $app->json_error( $app->translate("Invalid request.") );
    }

    my $label = $q->param('label');
    my $basename = $q->param('basename');
    if ( !defined($label) || ( $label =~ m/^\s*$/ ) ) {
        return $app->json_error( $app->translate("Invalid request.") );
    }

    my $blog = $app->blog;
    if ( !$blog ) {
        return $app->json_error( $app->translate("Invalid request.") );
    }

    my $parent;
    if ( my $parent_id = $q->param('parent') ) {
        if ( $parent_id != -1 ) {    # special case for 'root' folder
            $parent = $class->load( { id => $parent_id, blog_id => $blog_id } );
            if ( !$parent ) {
                return $app->json_error( $app->translate("Invalid request.") );
            }
        }
    }

    my $obj      = $class->new;
    my $original = $obj->clone;

    if (
        !$app->run_callbacks(
            'cms_save_permission.' . $type,
            $app, $obj, $original
        )
      )
    {
        return $app->json_error( $app->translate("Permission denied.") );
    }

    $obj->label($label);
    $obj->basename($basename)   if $basename;
    $obj->parent( $parent->id ) if $parent;
    $obj->blog_id($blog_id);
    $obj->author_id( $user->id );
    $obj->created_by( $user->id );

    if (
        !$app->run_callbacks( 'cms_pre_save.' . $type, $app, $obj, $original ) )
    {
        return $app->json_error( $app->errstr );
    }

    $obj->save;

    $app->run_callbacks( 'cms_post_save.' . $type, $app, $obj, $original );

    return $app->json_result(
        {
            id       => $obj->id,
            basename => $obj->basename
        }
    );
}

sub can_view {
    my ( $eh, $app, $id ) = @_;
    my $perms = $app->permissions;
    return $perms->can_edit_categories();
}

sub can_save {
    my ( $eh, $app, $id ) = @_;
    my $perms = $app->permissions;
    return $perms->can_edit_categories();
}

sub can_delete {
    my ( $eh, $app, $obj ) = @_;
    return 1 if $app->user->is_superuser();
    my $perms = $app->permissions;
    return $perms && $perms->can_edit_categories();
}

sub pre_save {
    my $eh = shift;
    my ( $app, $obj ) = @_;
    my $pkg = $app->model('category');
    if ( defined( my $pass = $app->query->param('tb_passphrase') ) ) {
        $obj->{__tb_passphrase} = $pass;
    }
    my @siblings = $pkg->load(
        {
            parent  => $obj->parent,
            blog_id => $obj->blog_id
        }
    );
    foreach (@siblings) {
        next if $obj->id && ( $_->id == $obj->id );
        return $eh->error(
            $app->translate(
"The category name '[_1]' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.",
                $_->label
            )
        ) if $_->label eq $obj->label;
        return $eh->error(
            $app->translate(
"The category basename '[_1]' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique basenames.",
                $_->label
            )
        ) if $_->basename eq $obj->basename;
    }

    my $tags = $app->query->param('tags');
    if ( defined $tags )
    {
        my $blog = $app->blog;
        my $fields = $blog->smart_replace_fields;
        if ( $fields =~ m/tags/ig ) {
            $tags = MT::App::CMS::_convert_word_chars( $app, $tags );
        }

        require MT::Tag;
        my $tag_delim = chr( $app->user->entry_prefs->{tag_delim} );
        my @tags = MT::Tag->split( $tag_delim, $tags );
        if (@tags) {
            $obj->set_tags(@tags);
        }
        else {
            $obj->remove_tags();
        }
    }

    1;
}

sub post_save {
    my $eh = shift;
    my ( $app, $obj, $original ) = @_;

    if ( !$original->id ) {
        $app->log(
            {
                message => $app->translate(
                    "Category '[_1]' created by '[_2]'", $obj->label,
                    $app->user->name
                ),
                level    => MT::Log::INFO(),
                class    => 'category',
                category => 'new',
            }
        );
    }
    1;
}

sub save_filter {
    my $eh = shift;
    my ($app) = @_;
    return $app->errtrans( "The name '[_1]' is too long!",
        $app->query->param('label') )
      if ( length( $app->query->param('label') ) > 100 );
    return 1;
}

sub post_delete {
    my ( $eh, $app, $obj ) = @_;

    $app->log(
        {
            message => $app->translate(
                "Category '[_1]' (ID:[_2]) deleted by '[_3]'",
                $obj->label, $obj->id, $app->user->name
            ),
            level    => MT::Log::INFO(),
            class    => 'system',
            category => 'delete'
        }
    );
}

sub _adjust_ancestry {
    my ( $cat, $ancestor ) = @_;
    return unless $cat && $ancestor;
    if ( $ancestor->parent && ( $ancestor->parent != $cat->id ) ) {
        _adjust_ancestry($cat, $ancestor->parent_category);
    }
    else {
        $ancestor->parent($cat->parent);
        $ancestor->save;
    }
}

sub move_category {
    my $app   = shift;
    my $q = $app->query;
    my $type  = $q->param('_type');
    my $class = $app->model($type)
      or return $app->errtrans("Invalid request.");
    $app->validate_magic() or return;

    my $cat        = $class->load( $q->param('move_cat_id') )
        or return;

    my $new_parent_id = $q->param('move-radio');

    return 1 if ( $new_parent_id == $cat->parent );

    if ( $new_parent_id ) {
        my $new_parent = $class->load( $new_parent_id )
            or return;
       if ( $cat->is_ancestor( $new_parent ) ) {
            _adjust_ancestry( $cat, $new_parent );
        }
    }
    $cat->parent($new_parent_id);
    if ( $type eq 'category' ) {    # folder is able to have a same label
        my @siblings = $class->load(
            {   parent  => $cat->parent,
                blog_id => $cat->blog_id
            }
        );
        foreach (@siblings) {
            return $app->errtrans(
                "The category name '[_1]' conflicts with another category. Top-level categories and sub-categories with the same parent must have unique names.",
                $_->label
            ) if $_->label eq $cat->label;
        }
    }

    $cat->save
      or return $app->error(
        $app->translate( "Saving [_1] failed: [_2]", $class->class_label, $cat->errstr ) );
}

1;

__END__

=head1 NAME

MT::CMS::Category

=head1 METHODS

=head2 can_delete

=head2 can_save

=head2 can_view

=head2 category_add

=head2 category_do_add

=head2 edit

=head2 js_add_category

=head2 list

=head2 move_category

=head2 post_delete

=head2 post_save

=head2 pre_save

=head2 save

=head2 save_filter

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
