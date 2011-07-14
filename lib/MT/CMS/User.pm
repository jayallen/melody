package MT::CMS::User;

use strict;

use MT::Util
  qw( format_ts relative_date is_valid_email is_url encode_url encode_html );
use MT::Author;

sub edit {
    my $cb = shift;
    my ( $app, $id, $obj, $param ) = @_;

    my $author = $app->user;

    if ($id) {

        # TODO: Populate permissions / blogs for this user
        # populate blog_loop, permission_loop
        $param->{is_me} = 1 if $id == $author->id;
        $param->{editing_other_profile} = 1
          if !$param->{is_me} && $author->is_superuser;

        $param->{userpic} = $obj->userpic_html();

        require MT::Permission;

        # General permissions...
        my $sys_perms = MT::Permission->perms('system');
        foreach (@$sys_perms) {
            $param->{ 'perm_can_' . $_->[0] }
              = ( $obj->is_superuser || $obj->permissions(0)->has( $_->[0] ) )
              ? 1
              : 0;
        }
        $param->{perm_is_superuser} = $obj->is_superuser;

        require MT::Auth;
        if ( $app->user->is_superuser ) {
            $param->{search_label}      = $app->translate('Users');
            $param->{object_type}       = 'author';
            $param->{can_edit_username} = 1;
        }
        else {
            $param->{search_label} = $app->translate('Entries');
            $param->{search_type}  = 'entry';
        }
        $param->{status_enabled} = $obj->is_active ? 1 : 0;
        $param->{status_pending}
          = $obj->status == MT::Author::PENDING() ? 1 : 0;
        $param->{can_modify_password}
          = ( $param->{editing_other_profile} || $param->{is_me} )
          && MT::Auth->password_exists;
        $param->{can_recover_password} = MT::Auth->can_recover_password;
        $param->{languages} = $app->languages_list( $obj->preferred_language )
          unless exists $param->{langauges};
        eval { require MT::Image; MT::Image->new or die; };
        $param->{can_use_userpic} = $@ ? 0 : 1;
    } ## end if ($id)
    else {
        $param->{create_personal_weblog}
          = $app->config->NewUserAutoProvisioning ? 1 : 0
          unless exists $param->{create_personal_weblog};
        $param->{can_modify_password}  = MT::Auth->password_exists;
        $param->{can_recover_password} = MT::Auth->can_recover_password;
    }

    $app->add_breadcrumb(
                          $app->translate("Users"),
                          $app->user->is_superuser
                          ? $app->uri( mode => 'list_authors' )
                          : undef
    );
    my $auth_prefs;
    if ($obj) {
        $app->add_breadcrumb( $obj->name );
        $param->{languages}
          = $app->languages_list( $obj->preferred_language );
        $auth_prefs = $obj->entry_prefs;
    }
    else {
        $app->add_breadcrumb( $app->translate("Create User") );
        $param->{languages}
          = $app->languages_list( $app->config('DefaultUserLanguage') )
          unless ( exists $param->{languages} );
        $auth_prefs = { tag_delim => $app->config->DefaultUserTagDelimiter }
          unless ( exists $param->{'auth_pref_tag_delim'} );
    }
    $param->{text_filters}
      = $app->load_text_filters( $obj ? $obj->text_format : undef,
                                 'comment' );
    unless ( exists $param->{'auth_pref_tag_delim'} ) {
        my $delim = chr( $auth_prefs->{tag_delim} );
        if ( $delim eq ',' ) {
            $param->{'auth_pref_tag_delim_comma'} = 1;
        }
        elsif ( $delim eq ' ' ) {
            $param->{'auth_pref_tag_delim_space'} = 1;
        }
        else {
            $param->{'auth_pref_tag_delim_other'} = 1;
        }
        $param->{'auth_pref_tag_delim'} = $delim;
    }
    $param->{'nav_authors'} = 1;
} ## end sub edit

sub edit_role {
    my $app = shift;
    my $q   = $app->query;
    $app->return_to_dashboard( redirect => 1 ) if $q->param('blog_id');

    my %param  = $_[0] ? %{ $_[0] } : ();
    my $author = $app->user;
    my $id     = $q->param('id');

    require MT::Permission;
    if ( !$author->is_superuser ) {
        return $app->error( $app->translate("Invalid request.") );
    }
    my $role;
    require MT::Role;
    if ($id) {
        $role = MT::Role->load($id)
          or return $app->error(
                          $app->translate( 'Can\'t load role #[_1].', $id ) );

        # $param{is_enabled} = $role->is_active;
        $param{is_enabled}  = 1;
        $param{name}        = $role->name;
        $param{description} = $role->description;
        $param{id}          = $role->id;
        my $creator = MT::Author->load( $role->created_by )
          if $role->created_by;
        $param{created_by} = $creator ? $creator->name : '';

        my $permissions = $role->permissions;
        if ( defined($permissions) && $permissions ) {
            my @perms = split ',', $permissions;

            my @roles = MT::Role->load_same(
                { 'id' => [$id] }, { not => { id => 1 } }, 1,    # exact match
                @perms );
            my @same_perms;
            for my $other_role (@roles) {
                push @same_perms,
                  { name => $other_role->name, id => $other_role->id, };
            }
            $param{same_perm_loop} = \@same_perms if @same_perms;
        }
        require MT::Association;
        $param{user_count} =
          MT::Author->count(
                             undef,
                             {
                                join =>
                                  MT::Association->join_on(
                                                           'author_id',
                                                           { role_id => $id },
                                                           { unique  => 1 }
                                  )
                             }
          );
    } ## end if ($id)

    my $all_perm_flags = MT::Permission->perms('blog');
    my $param_groups   = {};
    foreach my $perm (@$all_perm_flags) {
        $param_groups->{ $perm->[3] } = []
          unless $param_groups->{ $perm->[3] };
        my $p = {
              'have_access-'
                . $perm->[0] => ( $role && $role->has( $perm->[0] ) ) ? 1 : 0,
              'prompt-' . $perm->[0] => $perm->[1]
        };
        push( @{ $param_groups->{ $perm->[3] } }, $p );
    }

    my $groups = $app->registry('permission_groups');
    my @keys   = keys(%$groups);
    my @param_groups;
    foreach my $k (@keys) {
        next if $groups->{$k}->{system};
        push(
              @param_groups,
              {
                 group_id    => $k,
                 group_label => $groups->{$k}->{label}(),
                 group_perms => [],
                 group_order => $groups->{$k}->{order} || 0
              }
        );
    }

    foreach my $p (@param_groups) {
        my @grepped_perms
          = grep { $_ if $_->[3] eq $p->{group_id} } @$all_perm_flags;

        @grepped_perms = sort { $a->[2] <=> $b->[2] } @grepped_perms;

        my @perms = map { {
               perm_id    => $_->[0],
               perm_label => $_->[1],
               'have_access-' . $_->[0] => ( $role && $role->has( $_->[0] ) )
               ? 1
               : 0

            }
        } @grepped_perms;
        $p->{group_perms} = \@perms;
    }

    $param{pgroups} = \@param_groups;

    #for my $ref (@$all_perm_flags) {
    #    $param{ 'have_access-' . $ref->[0] }
    #      = ( $role && $role->has( $ref->[0] ) ) ? 1 : 0;
    #    $param{ 'prompt-' . $ref->[0] } = $ref->[1];
    #}
    $param{saved}          = $q->param('saved');
    $param{nav_privileges} = 1;
    $app->add_breadcrumb( $app->translate('Roles'),
                          $app->uri( mode => 'list_roles' ) );
    if ($id) {
        $app->add_breadcrumb( $role->name );
    }
    else {
        $app->add_breadcrumb( $app->translate('Create Role') );
    }
    $param{screen_class}        = "settings-screen edit-role";
    $param{object_type}         = 'role';
    $param{object_label}        = MT::Role->class_label;
    $param{object_label_plural} = MT::Role->class_label_plural;
    $param{search_label}        = $app->translate('Users');
    $app->load_tmpl( 'edit_role.tmpl', \%param );
} ## end sub edit_role

sub list_association {
    my $app     = shift;
    my $q       = $app->query;
    my $blog_id = $q->param('blog_id');
    $app->return_to_dashboard( redirect => 1 ) if $blog_id;
    my $author_id = $q->param('author_id');
    my $role_id   = $q->param('role_id');
    my $this_user = $app->user;
    if ( !$this_user->is_superuser ) {

        if ( (
                  !$blog_id
               || !$this_user->permissions($blog_id)->can_administer_blog
             )
             && ( !$author_id || ( $author_id != $this_user->id ) )
          )
        {
            return $app->errtrans("Permission denied.");
        }
    }

    my ( $user, $role );
    $app->error(undef);

    if ($author_id) {
        $app->add_breadcrumb(
                              $app->translate('Users'),
                              $app->user->is_superuser
                              ? $app->uri( mode => 'list_authors' )
                              : undef
        );
        if ( 'PSEUDO' ne $author_id ) {
            my $author_class = $app->model('author');
            $user = $author_class->load($author_id);
            $app->add_breadcrumb(
                                  $user->name,
                                  $app->uri(
                                             mode => 'view',
                                             args => {
                                                       _type => 'author',
                                                       id    => $author_id
                                             }
                                  )
            );
        }
        else {
            $app->add_breadcrumb( $app->translate('(newly created user)') );
        }
        $app->add_breadcrumb( $app->translate('User Associations') );
    } ## end if ($author_id)
    if ($role_id) {
        my $role_class = $app->model('role') or return;
        $role = $role_class->load($role_id);
        $app->add_breadcrumb( $app->translate("Roles"),
                              $app->uri( mode => "list_roles" ) );
        $app->add_breadcrumb(
                              $role->name,
                              $app->uri(
                                   mode => 'edit_role',
                                   args => { _type => 'role', id => $role_id }
                              )
        );
        $app->add_breadcrumb( $app->translate("Role Users & Groups") );
    }
    if ( !$role_id && !$author_id ) {
        if ($blog_id) {
            $app->add_breadcrumb( $app->translate("Users") );
        }
        else {
            $app->add_breadcrumb( $app->translate("Associations") );
        }
    }

    my $pref = $app->list_pref('association');

    # Supplies additional parameters for the row being listed
    my %users;
    $users{ $this_user->id } = $this_user;
    my $hasher = sub {
        my ( $obj, $row ) = @_;
        if ( my $user = $obj->user ) {
            $row->{user_id}   = $user->id;
            $row->{user_name} = $user->name;
        }
        if ( my $role = $obj->role ) {
            $row->{role_name} = $role->name;

            # populate permissions for the expanded view
            if ( $pref->{view_expanded} ) {
                my @perms;
                my @all_perms = @{ MT::Permission->perms() };
                foreach (@all_perms) {
                    next unless length( $_->[1] || '' );
                    push @perms, { name => $_->[1] } if $role->has( $_->[0] );
                }
                $row->{perm_loop} = \@perms;
            }
        }
        else {
            $row->{role_name} = $app->translate("(Custom)");
        }
        if ( my $blog = $obj->blog ) {
            $row->{blog_name} = $blog->name;
        }
        if ( my $ts = $obj->created_on ) {
            $row->{created_on_formatted}
              = format_ts(
                           MT::App::CMS::LISTING_DATE_FORMAT(),
                           $ts,
                           $obj->blog,
                           $app->user ? $app->user->preferred_language : undef
              );
            $row->{created_on_time_formatted}
              = format_ts(
                           MT::App::CMS::LISTING_TIMESTAMP_FORMAT(),
                           $ts,
                           $obj->blog,
                           $app->user ? $app->user->preferred_language : undef
              );
            $row->{created_on_relative}
              = relative_date( $ts, time, $obj->blog );
        }
        if ( $row->{created_by} ) {
            my $created_user = $users{ $row->{created_by} }
              ||= MT::Author->load( $row->{created_by} );
            if ($created_user) {
                $row->{created_by} = $created_user->name;
            }
            else {
                $row->{created_by} = $app->translate('(user deleted)');
            }
        }
    };
    $app->model('association') or return;
    my $types;
    if ( !$author_id && !$blog_id ) {
        $types
          = [ MT::Association::USER_BLOG_ROLE(), MT::Association::USER_ROLE(),
          ];
    }
    elsif ( !$author_id ) {
        $types = [ MT::Association::USER_BLOG_ROLE(), ];
    }
    elsif ($author_id) {
        $types = [ MT::Association::USER_BLOG_ROLE(),
                   MT::Association::USER_ROLE() ];
    }

    my $pre_build = sub {
        my ($param) = @_;
        my $data = $param->{object_loop} || [];

        #TODO: handle group_view
        if ( $param->{user_view} && ( 'PSEUDO' ne $param->{edit_author_id} ) )
        {

            # don't merge
        }
        elsif ( $param->{role_view} ) {
            _merge_default_assignments( $app, $data, $hasher, 'role',
                                        $param->{role_id} );
        }
        elsif ( $param->{blog_view} ) {
            _merge_default_assignments( $app, $data, $hasher, 'blog',
                                        $param->{blog_id} );
        }
        else {
            _merge_default_assignments( $app, $data, $hasher, 'all' );
        }
    };

    return
      $app->listing( {
           args  => { sort => 'created_on', direction => 'descend' },
           type  => 'association',
           code  => $hasher,
           terms => {
                      type => $types,
                      $author_id ? ( author_id => $author_id ) : (),
                      $blog_id   ? ( blog_id   => $blog_id )   : (),
                      $role_id   ? ( role_id   => $role_id )   : (),
           },
           pre_build => $pre_build,
           params    => {
               can_create_association => $app->user->is_superuser
                 || (    $blog_id
                      && $app->user->permissions($blog_id)
                      ->can_administer_blog ),
               has_expanded_mode => 1,
               nav_privileges    => ( $author_id || $blog_id ? 0 : 1 )
                 || $role_id,
               nav_authors => ( $author_id || $blog_id ? 1 : 0 ) && !$role_id,
               blog_view => $blog_id   ? 1 : 0,
               user_view => $author_id ? 1 : 0,
               role_view => $role_id   ? 1 : 0,
               $role_id
               ? (
                   return_args => '__mode=list_association&role_id='
                     . $role_id,
                   role_id   => $role_id,
                   role_name => $role->name,
                 )
               : (),
               $author_id
               ? (
                   return_args => '__mode=list_association&author_id='
                     . $author_id,
                   edit_author_id => $author_id,
                   edit_name      => $user
                   ? ( $user->nickname ? $user->nickname : $user->name )
                   : $app->translate('(newly created user)'),
                   edit_object    => $app->translate('The user'),
                   group_count    => $user ? $user->group_count() : 0,
                   status_enabled => $user ? ( $user->is_active ? 1 : 0 ) : 0,
                   status_pending => $user
                   ? ( $user->status == MT::Author::PENDING() ? 1 : 0 )
                   : 0,
                 )
               : (),
               saved         => $q->param('saved')         || 0,
               saved_deleted => $q->param('saved_deleted') || 0,
               usergroup_view => !$author_id && !$role_id,
               blog_id        => $blog_id,
               search_label   => $app->translate('Users'),
               object_type    => 'association',
               pt_name        => $app->translate('User'),
               screen_id      => "list-associations",
           },
        }
      );
} ## end sub list_association

sub list_role {
    my $app = shift;
    $app->return_to_dashboard( redirect => 1 )
      if $app->query->param('blog_id');
    my $pref         = $app->list_pref('role');
    my $author_class = $app->model('author');
    my $assoc_class  = $app->model('association');
    my $hasher       = sub {
        my ( $obj, $row ) = @_;
        my $user_count =
          $assoc_class->count( {
                                  role_id   => $obj->id,
                                  author_id => [ 1, undef ],
                               },
                               {
                                  unique     => 'author_id',
                                  range_incl => { author_id => 1 },
                               }
          );
        $row->{members} = $user_count;
        $row->{weblogs} =
          $assoc_class->count( {
                                  role_id => $obj->id,
                                  blog_id => [ 1, undef ],
                               },
                               {
                                  unique     => 'blog_id',
                                  range_incl => { blog_id => 1 },
                               }
          );
        if ( $obj->created_by ) {
            my $user = $author_class->load( $obj->created_by );
            $row->{created_by} = $user ? $user->name : '';
        }
        else {
            $row->{created_by} = '';
        }

        # populate permissions for the expanded view
        if ( $pref->{view_expanded} ) {
            my @perms;
            my @all_perms = @{ MT::Permission->perms() };
            foreach (@all_perms) {
                next unless length( $_->[1] || '' );
                push @perms, { name => $_->[1] } if $obj->has( $_->[0] );
            }
            $row->{perm_loop} = \@perms;
        }
    };
    unless ( $app->user->is_superuser() ) {
        return $app->errtrans("Permission denied.");
    }
    $app->add_breadcrumb( $app->translate("Roles") );
    $app->listing( {
                     args   => { sort => 'name' },
                     type   => 'role',
                     code   => $hasher,
                     params => {
                                 nav_privileges  => 1,
                                 list_noncron    => 1,
                                 can_create_role => $app->user->is_superuser,
                                 has_expanded_mode => 1,
                                 search_label => $app->translate('Users'),
                                 object_type  => 'role',
                                 screen_id    => 'list-role',
                     },
                   }
    );
} ## end sub list_role

sub can_delete_role {
    my ( $eh, $app, $id ) = @_;
    return $app->user->is_superuser;
}


sub save_role {
    my $app = shift;
    my $q   = $app->query;
    $app->validate_magic()   or return;
    $app->user->is_superuser or return $app->errtrans("Permission denied.");

    my $id    = $q->param('id');
    my @perms = $q->param('permission');
    my $role;
    require MT::Role;
    $role = $id ? MT::Role->load($id) : MT::Role->new;
    my $name = $q->param('name') || '';
    $name =~ s/(^\s+|\s+$)//g;
    return $app->errtrans("Role name cannot be blank.") if $name eq '';

    my $role_by_name = MT::Role->load( { name => $name } );
    if ( $role_by_name && ( ( $id && ( $role->id != $id ) ) || !$id ) ) {
        return $app->errtrans("Another role already exists by that name.");
    }
    if ( !@perms ) {
        return $app->errtrans(
                             "You cannot define a role without permissions.");
    }

    $role->name( $q->param('name') );
    $role->description( $q->param('description') );
    $role->clear_full_permissions;
    $role->set_these_permissions(@perms);
    if ( $role->id ) {
        $role->modified_by( $app->user->id );
    }
    else {
        $role->created_by( $app->user->id );
    }
    $role->save or return $app->error( $role->errstr );

    my $url;
    $url = $app->uri( 'mode' => 'edit_role',
                      args   => { id => $role->id, saved => 1 } );
    $app->redirect($url);
} ## end sub save_role

sub enable {
    my $app = shift;
    set_object_status( $app, MT::Author::ACTIVE() );
}

sub disable {
    my $app = shift;
    set_object_status( $app, MT::Author::INACTIVE() );
}

sub set_object_status {
    my ( $app, $new_status ) = @_;

    $app->validate_magic() or return;
    return $app->error( $app->translate('Permission denied.') )
      unless $app->user->is_superuser;
    return $app->error( $app->translate("Invalid request.") )
      if $app->request_method ne 'POST';

    my $q    = $app->query;
    my $type = $q->param('_type');
    return $app->error( $app->translate('Invalid type') )
      unless ( $type eq 'user' )
      || ( $type eq 'author' )
      || ( $type eq 'group' );

    my $class = $app->model($type);

    my @sync;
    my $saved = 0;
    for my $id ( $q->param('id') ) {
        next unless $id;    # avoid 'empty' ids
        my $obj = $class->load($id);
        next unless $obj;
        if ( ( $obj->id == $app->user->id ) && ( $type eq 'author' ) ) {
            next;
        }
        next if $new_status == $obj->status;
        my $create_blog
          = (    $new_status == MT::Author::ACTIVE()
              && $type eq 'author'
              && $app->config->NewUserAutoProvisioning
              && $obj->status == MT::Author::PENDING() ) ? 1 : 0;
        $obj->status($new_status);
        $obj->save;
        $saved++;
        if ( $type eq 'author' ) {
            if ( $new_status == MT::Author::ACTIVE() ) {
                push @sync, $obj;
            }
        }
        if ($create_blog) {

            # provision new user with a personal blog
            $app->run_callbacks( 'new_user_provisioning', $obj );
        }
    } ## end for my $id ( $q->param(...))
    my $unchanged = 0;
    if (@sync) {
        MT::Auth->synchronize_author( User => \@sync );
        foreach (@sync) {
            if ( $_->status != MT::Author::ACTIVE() ) {
                $unchanged++;
            }
        }
    }
    if ( $saved && ( $saved > $unchanged ) ) {
        $app->add_return_arg(
                       saved_status => ( $new_status == MT::Author::ACTIVE() )
                       ? 'enabled'
                       : 'disabled' );
    }
    $app->add_return_arg( is_power_edit => 1 ) if $q->param('is_power_edit');
    $app->add_return_arg( unchanged => $unchanged ) if $unchanged;
    $app->call_return;
} ## end sub set_object_status

sub upload_userpic {
    my $app = shift;

    $app->validate_magic() or return;
    return $app->errtrans("Invalid request.") if $app->param('blog_id');

    require MT::CMS::Asset;
    my ( $asset, $bytes )
      = MT::CMS::Asset::_upload_file( $app, @_, require_type => 'image', );
    return if !defined $asset;
    return $asset if !defined $bytes;    # whatever it is

    ## TODO: should this be layered into _upload_file somehow, so we don't
    ## save the asset twice?
    my $user_id = $app->query->param('user_id');

    $asset->tags('@userpic');
    $asset->created_by($user_id);
    $asset->save;

    $app->forward( 'asset_userpic',
                   { asset => $asset, user_id => $user_id } );
} ## end sub upload_userpic

sub cfg_system_users {
    my $app = shift;
    my $q   = $app->query;
    my %param;
    if ( $q->param('blog_id') ) {
        return $app->return_to_dashboard( redirect => 1 );
    }
    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();
    my $cfg = $app->config;
    $app->add_breadcrumb( $app->translate('General Settings') );
    $param{nav_config} = 1;

    $param{nav_settings} = 1;
    $param{languages}
      = $app->languages_list( $app->config('DefaultUserLanguage') );
    my $tag_delim = $app->config('DefaultUserTagDelimiter') || ord(',');
    if ( $tag_delim eq ord(',') ) {
        $tag_delim = 'comma';
    }
    elsif ( $tag_delim eq ord(' ') ) {
        $tag_delim = 'space';
    }
    else {
        $tag_delim = 'comma';
    }
    $param{"tag_delim_$tag_delim"} = 1;

    ( my $tz = $app->config('DefaultTimezone') ) =~ s![-\.]!_!g;
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
    $param{system_email_address} = $cfg->EmailAddressMain;
    $param{saved}                = $q->param('saved');
    $param{error}                = $q->param('error');
    $param{screen_class}         = "settings-screen system-general-settings";
    my $registration = $cfg->CommenterRegistration;
    if ( $registration->{Allow} ) {
        $param{registration} = 1;
        if ( my $ids = $registration->{Notify} ) {
            my @ids = split ',', $ids;
            my @sysadmins =
              MT::Author->load(
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
    $app->load_tmpl( 'cfg_system_users.tmpl', \%param );
} ## end sub cfg_system_users

sub save_cfg_system_users {
    my $app = shift;
    my $q   = $app->query;
    $app->validate_magic or return;
    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser();
    my $tmpl_blog_id = $q->param('new_user_template_blog_id') || '';
    if ( $tmpl_blog_id =~ m/^\d+$/ ) {
        MT::Blog->load($tmpl_blog_id)
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

    my $cfg = $app->config;
    my $tz  = $q->param('default_time_zone');
    $app->config( 'DefaultTimezone', $tz || undef, 1 );
    $app->config( 'DefaultSiteRoot', $q->param('default_site_root') || undef,
                  1 );
    $app->config( 'DefaultSiteURL', $q->param('default_site_url') || undef,
                  1 );
    $app->config( 'NewUserAutoProvisioning',
                  $q->param('personal_weblog') ? 1 : 0, 1 );
    $app->config( 'NewUserTemplateBlogId', $tmpl_blog_id || undef, 1 );
    $app->config( 'DefaultUserLanguage', $q->param('default_language'), 1 );
    $app->config( 'DefaultUserTagDelimiter',
                  $q->param('default_user_tag_delimiter') || undef, 1 );
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
    $cfg->save_config();

    my $args = ();

    if ( $app->config->NewUserAutoProvisioning() ne
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
                   $app->uri( 'mode' => 'cfg_system_users', args => $args ) );
} ## end sub save_cfg_system_users

sub remove_user_assoc {
    my $app = shift;
    my $q   = $app->query;
    $app->validate_magic or return;
    my $user  = $app->user;
    my $perms = $app->permissions;
    return $app->errtrans("Permission denied.")
      unless $perms->can_administer_blog || $perms->can_manage_users;
    my $can_remove_administrator = $user->is_superuser
      || $perms->can_administer_blog;
    my $blog_id = $q->param('blog_id');
    my @ids     = $q->param('id');
    return $app->errtrans("Invalid request.") unless $blog_id && @ids;
    require MT::Association;
    require MT::Permission;

    foreach my $id (@ids) {
        next unless $id;
        my $perm
          = MT::Permission->load( { blog_id => $blog_id, author_id => $id } );
        next if !$can_remove_administrator && $perm->can_administer_blog;
        if ( $id =~ /PSEUDO-/ ) {
            _delete_pseudo_association( $app, $id );
            next;
        }

        MT::Association->remove( { blog_id => $blog_id, author_id => $id } );

        # these too, just in case there are no real associations
        # (ie, commenters)
        $perm->remove;
    }

    $app->add_return_arg( saved => 1 );
    $app->call_return;
} ## end sub remove_user_assoc

sub revoke_role {
    my $app = shift;
    my $q   = $app->query;
    $app->validate_magic or return;
    my $user  = $app->user;
    my $perms = $app->permissions;
    return $app->errtrans("Permission denied.")
      unless ( $perms->can_administer_blog || $perms->can_manage_users );
    my $blog_id = $q->param('blog_id');
    my $role_id = $q->param('role_id');
    my $user_id = $q->param('author_id');
    return $app->errtrans("Invalid request.")
      unless $blog_id && $role_id && $user_id;

    require MT::Association;
    require MT::Role;
    require MT::Blog;

    my $author = MT::Author->load($user_id);
    my $role   = MT::Role->load($role_id);
    my $blog   = MT::Blog->load($blog_id);
    return $app->errtrans("Invalid request.")
      unless $blog && $role && $author;
    return $app->errtrans("Permission denied.")
      if !$user->is_superuser
          && !$perms->can_administer_blog
          && $role->has('administer_blog');

    MT::Association->unlink( $blog => $role => $author );

    $app->add_return_arg( saved => 1 );
    $app->call_return;
} ## end sub revoke_role

sub grant_role {
    my $app  = shift;
    my $q    = $app->query;
    my $user = $app->user;
    return unless $app->validate_magic;
    my $blogs   = $q->param('blog')   || '';
    my $authors = $q->param('author') || '';
    my $roles   = $q->param('role')   || '';
    my $author_id = $q->param('author_id');
    my $blog_id   = $q->param('blog_id');
    my $role_id   = $q->param('role_id');

    my @blogs    = split /,/, $blogs;
    my @authors  = split /,/, $authors;
    my @role_ids = split /,/, $roles;

    require MT::Blog;
    require MT::Role;

    foreach (@blogs) {
        my $id = $_;
        $id =~ s/\D//g;
        $_ = MT::Blog->load($id);
    }
    push @blogs, MT::Blog->load($blog_id) if $blog_id;

    my $can_grant_administer = 1;
    if ( !$user->is_superuser ) {
        if ( ( scalar @blogs != 1 )
             || !$user->permissions( $blogs[0] )->can_administer_blog )
        {
            $can_grant_administer = 0;
            if ( !$user->permissions( $blogs[0] )->can_manage_users ) {
                return $app->errtrans("Permission denied.");
            }
        }
    }

    my @roles;
    foreach my $id (@role_ids) {
        $id =~ s/\D//g;
        my $role = MT::Role->load($id);
        if ( $can_grant_administer || !$role->has('administer_blog') ) {
            push @roles, $role;
        }
    }
    push @roles, MT::Role->load($role_id) if $role_id;

    my $add_pseudo_new_user = 0;
    foreach (@authors) {
        my $id = $_;
        if ( 'author-PSEUDO' eq $id ) {
            $add_pseudo_new_user = 1;
            next;
        }
        $id =~ s/\D//g;
        $_ = MT::Author->load($id);
    }
    $app->error(undef);

    if ($author_id) {
        if ( $author_id eq 'PSEUDO' ) {
            $add_pseudo_new_user = 1;
        }
        else {
            push @authors, MT::Author->load($author_id);
        }
    }

    require MT::Association;

    my @default_assignments;

    # TBD: handle case for associating system roles to users/groups
    foreach my $blog (@blogs) {
        next unless ref $blog;
        foreach my $role (@roles) {
            next unless ref $role;
            if ($add_pseudo_new_user) {
                push @default_assignments, $role->id . ',' . $blog->id;
            }
            foreach my $ug (@authors) {
                next unless ref $ug;
                MT::Association->link( $ug => $role => $blog );
            }
        }
    }

    if ( $add_pseudo_new_user && @default_assignments ) {
        my $da = $app->config('DefaultAssignments');
        $da .= ',' if $da;
        $app->config( 'DefaultAssignments',
                      $da . join( ',', @default_assignments ), 1 );
        $app->config->save_config;
    }

    $app->add_return_arg( saved => 1 );
    $app->call_return;
} ## end sub grant_role

sub dialog_select_author {
    my $app    = shift;
    my $q      = $app->query;
    my $hasher = sub {
        my ( $obj, $row ) = @_;
        $row->{label}       = $row->{name};
        $row->{description} = $row->{nickname};
    };

    $app->listing( {
                type  => 'author',
                terms => {
                           type   => MT::Author::AUTHOR(),
                           status => MT::Author::ACTIVE(),
                },
                args => {
                          sort => 'name',
                          join =>
                            MT::Permission->join_on(
                                        'author_id',
                                        {
                                          permissions => "\%'create_post'\%",
                                          blog_id     => $app->blog->id,
                                        },
                                        { 'like' => { 'permissions' => 1 } }
                            ),
                },
                code     => $hasher,
                template => 'dialog/select_users.tmpl',
                params   => {
                     dialog_title => $app->translate("Select a entry author"),
                     items_prompt => $app->translate("Selected author"),
                     search_prompt =>
                       $app->translate(
                              "Type a username to filter the choices below."),
                     panel_label       => $app->translate("Entry author"),
                     panel_description => $app->translate("Name"),
                     panel_type        => 'author',
                     panel_multi       => defined $q->param('multi')
                     ? $q->param('multi')
                     : 0,
                     panel_searchable => 1,
                     panel_first      => 1,
                     panel_last       => 1,
                     list_noncron     => 1,
                     idfield          => $q->param('idfield'),
                     namefield        => $q->param('namefield'),
                },
              }
    );
} ## end sub dialog_select_author

sub dialog_select_sysadmin {
    my $app = shift;
    my $q   = $app->query;
    return $app->errtrans("Permission denied.")
      unless $app->user->is_superuser;
    my $hasher = sub {
        my ( $obj, $row ) = @_;
        $row->{label}       = $row->{name};
        $row->{description} = $row->{nickname};
    };
    $app->listing( {
              type  => 'author',
              terms => {
                         type   => MT::Author::AUTHOR(),
                         status => MT::Author::ACTIVE(),
              },
              args => {
                   sort => 'name',
                   join =>
                     MT::Permission->join_on(
                       'author_id',
                       { permissions => "\%'administer'\%", blog_id => '0', },
                       { 'like' => { 'permissions' => 1 } }
                     ),
              },
              code     => $hasher,
              template => 'dialog/select_users.tmpl',
              params   => {
                       dialog_title =>
                         $app->translate("Select a System Administrator"),
                       items_prompt =>
                         $app->translate("Selected System Administrator"),
                       search_prompt =>
                         $app->translate(
                              "Type a username to filter the choices below."),
                       panel_label => $app->translate("System Administrator"),
                       panel_description => $app->translate("Name"),
                       panel_type        => 'author',
                       panel_multi       => defined $q->param('multi')
                       ? $q->param('multi')
                       : 0,
                       panel_searchable => 1,
                       panel_first      => 1,
                       panel_last       => 1,
                       list_noncron     => 1,
                       idfield          => $q->param('idfield'),
                       namefield        => $q->param('namefield'),
              },
            }
    );
} ## end sub dialog_select_sysadmin

# This mode can be called to service a number of views
# Adding roles->blogs for a user
# Adding roles->blogs for a group
# Adding users->roles->blogs
# Adding groups->roles->blogs
sub dialog_grant_role {
    my $app       = shift;
    my $q         = $app->query;
    my $author_id = $q->param('author_id');
    my $blog_id   = $q->param('blog_id');
    my $role_id   = $q->param('role_id');

    my $this_user = $app->user;
    if ( !$this_user->is_superuser ) {
        if (
             !$blog_id
             || (    !$this_user->permissions($blog_id)->can_administer_blog
                  && !$this_user->permissions($blog_id)->can_manage_users )
          )
        {
            return $app->errtrans("Permission denied.");
        }
    }

    my $type = $q->param('_type');
    my ( $user, $role );
    if ($author_id) {
        $user = MT::Author->load($author_id);
    }
    if ($role_id) {
        require MT::Role;
        $role = MT::Role->load($role_id);
    }

    my $hasher = sub {
        my ( $obj, $row ) = @_;
        $row->{label}       = $row->{name};
        $row->{description} = $row->{nickname} if exists $row->{nickname};
        $row->{disabled}    = 1
          if UNIVERSAL::isa( $obj, 'MT::Role' )
              && $obj->has('administer_blog')
              && !$this_user->is_superuser
              && !$this_user->permissions($blog_id)->can_administer_blog;
    };

    # Only show active users who are not commenters.
    my $terms = {};
    if ( $type && ( $type eq 'author' ) ) {
        $terms->{status} = MT::Author::ACTIVE();
        $terms->{type}   = MT::Author::AUTHOR();
    }

    my $pseudo_user_row = {
        id    => 'PSEUDO',
        label => $app->translate('(newly created user)'),
        description =>
          $app->translate('represents a user who will be created afterwards'),
    };

    if ( $q->param('search') || $q->param('json') ) {
        my $params
          = { panel_type => $type, list_noncron => 1, panel_multi => 1, };
        $app->listing( {
               terms    => $terms,
               args     => { sort => 'name' },
               type     => $type,
               code     => $hasher,
               params   => $params,
               template => 'include/listing_panel.tmpl',
               $q->param('search') ? () : (
                   pre_build => sub {
                       my ($param) = @_;
                       if ( $type && $type eq 'author' ) {
                           if ( !$q->param('offset') ) {
                               my $objs = $param->{object_loop} ||= [];
                               unshift @$objs, $pseudo_user_row;
                           }
                       }
                   }
               ),
            }
        );
    } ## end if ( $q->param('search'...))
    else {

        # traditional, full-screen listing
        my $params = {
                       ( $author_id || 0 ) eq 'PSEUDO'
                       ? (
                           edit_author_name =>
                             $app->translate('(newly created user)'),
                           edit_author_id => 'PSEUDO'
                         )
                       : $author_id ? (
                                        edit_author_name => $user->nickname
                                        ? $user->nickname
                                        : $user->name,
                                        edit_author_id => $user->id,
                         )
                       : (),
                       $role_id
                       ? ( role_name => $role->name, role_id => $role->id, )
                       : (),
        };

        my @panels;
        if ( !$role_id ) {
            push @panels, 'role';
        }
        if ( !$blog_id ) {
            my @blogs;
            my $iter = MT::Blog->load_iter();
            while ( my $blog = $iter->() ) {
                push @blogs, $blog->id;
            }

            # if only one blog exists, skip the blog selection step.
            if ( @blogs == 1 ) {
                $blog_id = $blogs[0];
            }
            else {
                push @panels, 'blog';
            }
        }
        if ( !$author_id ) {
            if ( $type eq 'user' ) {
                unshift @panels, 'author';
            }
        }

        my $panel_info = {
                      'blog' => {
                          panel_title  => $app->translate("Select Blogs"),
                          panel_label  => $app->translate("Blog Name"),
                          items_prompt => $app->translate("Blogs Selected"),
                          search_label => $app->translate("Search Blogs"),
                          panel_description => $app->translate("Description"),
                      },
                      'author' => {
                            panel_title  => $app->translate("Select Users"),
                            panel_label  => $app->translate("Username"),
                            items_prompt => $app->translate("Users Selected"),
                            search_label => $app->translate("Search Users"),
                            panel_description => $app->translate("Name"),
                      },
                      'role' => {
                          panel_title  => $app->translate("Select Roles"),
                          panel_label  => $app->translate("Role Name"),
                          items_prompt => $app->translate("Roles Selected"),
                          search_label => $app->translate(""),
                          panel_description => $app->translate("Description"),
                      },
        };

        $params->{panel_multi}  = 1;
        $params->{blog_id}      = $blog_id;
        $params->{dialog_title} = $app->translate("Grant Permissions");
        $params->{panel_loop}   = [];

        for ( my $i = 0; $i <= $#panels; $i++ ) {
            my $source = $panels[$i];
            my $panel_params = {
                            panel_type => $source,
                            %{ $panel_info->{$source} },
                            list_noncron     => 1,
                            panel_last       => $i == $#panels,
                            panel_first      => $i == 0,
                            panel_number     => $i + 1,
                            panel_total      => $#panels + 1,
                            panel_has_steps  => ( $#panels == '0' ? 0 : 1 ),
                            panel_searchable => ( $source eq 'role' ? 0 : 1 ),
            };

            # Only show active user/groups.
            my $terms = {};
            if ( $source eq 'author' ) {
                $terms->{status} = MT::Author::ACTIVE();
                $terms->{type}   = MT::Author::AUTHOR();
            }

            $app->listing( {
                             no_html => 1,
                             code    => $hasher,
                             type    => $source,
                             params  => $panel_params,
                             terms   => $terms,
                             args    => { sort => 'name' },
                           }
            );
            if ( $source && ( $source eq 'author' ) ) {
                if ( !$q->param('offset') ) {
                    my $data = $panel_params->{object_loop} ||= [];
                    unshift @$data, $pseudo_user_row;
                }
            }
            if (
                 !$panel_params->{object_loop}
                 || ( $panel_params->{object_loop}
                      && @{ $panel_params->{object_loop} } < 1 )
              )
            {
                $params->{"missing_$source"} = 1;
                $params->{"missing_data"}    = 1;
            }
            push @{ $params->{panel_loop} }, $panel_params;
        } ## end for ( my $i = 0; $i <= ...)

        # save the arguments from whence we came...
        $params->{return_args} = $app->return_args;
        $app->load_tmpl( 'dialog/create_association.tmpl', $params );
    } ## end else [ if ( $q->param('search'...))]
} ## end sub dialog_grant_role

sub remove_userpic {
    my $app = shift;
    $app->validate_magic() or return;
    my $q       = $app->query;
    my $user_id = $q->param('user_id');
    my $user    = $app->model('author')->load( { id => $user_id } ) or return;
    if ( $user->userpic_asset_id ) {
        my $old_file = $user->userpic_file();
        my $fmgr     = MT::FileMgr->new('Local');
        if ( $fmgr->exists($old_file) ) {
            $fmgr->delete($old_file);
        }
        $user->userpic_asset_id(0);
        $user->save;
    }
    return 'success';
}

sub can_delete_association {
    my ( $eh, $app, $obj ) = @_;
    my $blog_id = $app->query->param('blog_id');
    my $user    = $app->user;
    if ( !$user->is_superuser ) {
        if ( !$blog_id || !$user->permissions($blog_id)->can_administer_blog )
        {
            return $eh->error( MT->translate("Permission denied.") );
        }
        if ( $obj->author_id == $user->id ) {
            return $eh->error(
                   MT->translate("You cannot delete your own association.") );
        }
    }
    1;
}

sub can_view {
    my ( $eh, $app, $id ) = @_;
    return $id && ( $app->user->id == $id );
}

sub can_save {
    my ( $eh, $app, $id ) = @_;
    my $author = $app->user;
    if ( !$id ) {
        return $author->is_superuser;
    }
    else {
        return $author->id == $id;
    }
}

sub can_delete {
    my ( $eh, $app, $obj ) = @_;
    my $author = $app->user;
    if ( $author->id == $obj->id ) {
        return $eh->error(
                   MT->translate("You cannot delete your own user record.") );
    }
    return 1 if $author->is_superuser();
    if ( !( $obj->created_by && $obj->created_by == $author->id ) ) {
        return
          $eh->error(
             MT->translate(
                 "You have no permission to delete the user [_1].", $obj->name
             )
          );
    }
}

sub save_filter {
    my ( $eh, $app ) = @_;
    my $q      = $app->query;
    my $status = $q->param('status');
    return 1 if $status and $status == MT::Author::INACTIVE();
    require MT::Auth;
    my $auth_mode = $app->config('AuthenticationModule');
    my ($pref) = split /\s+/, $auth_mode;

    my $name     = $q->param('name');
    my $nickname = $q->param('nickname');

    if ( $pref eq 'MT' ) {
        if ( defined $name ) {
            $name =~ s/(^\s+|\s+$)//g;
            $q->param( 'name', $name );
        }
        return $eh->error( $app->translate("User requires username") )
          if ( !$name );

        if ( $name =~ m/([<>])/ ) {
            return
              $eh->error(
                          $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Username"),
                                   encode_html($1)
                          )
              );
        }
    }

    # Display name is required for all auth types; for new users
    # under external auth, the field is not shown, so the value is
    # undefined. Only check requirement if the value is defined.
    if ( defined $nickname ) {
        $nickname =~ s/(^\s+|\s+$)//g;
        $q->param( 'nickname', $nickname );
        return $eh->error( $app->translate("User requires display name") )
          if ( !length($nickname) );

        if ( $nickname =~ m/([<>])/ ) {
            return
              $eh->error(
                          $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Display Name"),
                                   encode_html($1)
                          )
              );
        }
    }

    require MT::Author;
    my $existing
      = MT::Author->load( { name => $name, type => MT::Author::AUTHOR() } );
    my $id = $q->param('id');
    if ( $existing && ( ( $id && $existing->id ne $id ) || !$id ) ) {
        return $eh->error(
               $app->translate("A user with the same name already exists.") );
    }

    require MT::Auth;
    my $error = MT::Auth->sanity_check($app);
    if ($error) {
        require MT::Log;
        $app->log( {
                     message  => $error,
                     level    => MT::Log::ERROR(),
                     class    => 'system',
                     category => 'save_author_profile'
                   }
        );
        return $eh->error($error);
    }

    return 1 if ( $pref ne 'MT' );
    if ( !$q->param('id') ) {    # it's a new object
        return $eh->error( $app->translate("User requires password") )
          if ( !$q->param('pass') );
    }
    my $email = $q->param('email');
    return $eh->error(
            MT->translate("Email Address is required for password recovery") )
      unless $email;
    if ( !is_valid_email($email) ) {
        return $eh->error( $app->translate("Email Address is invalid.") );
    }

    if ( $email =~ m/([<>])/ ) {
        return
          $eh->error(
                      $app->translate(
                                   "[_1] contains an invalid character: [_2]",
                                   $app->translate("Email Address"),
                                   encode_html($1)
                      )
          );
    }

    if ( $q->param('url') ) {
        my $url = $q->param('url');
        return $eh->error( MT->translate("URL is invalid.") )
          if !is_url($url) || ( $url =~ m/[<>]/ );
    }
    1;
} ## end sub save_filter

sub pre_save {
    my $eh = shift;
    my ( $app, $obj, $original ) = @_;
    my $q = $app->query;

    # Authors should only be of type AUTHOR when created from
    # the CMS app; COMMENTERs are created from the Comments app.
    $obj->type( MT::Author::AUTHOR() );

    my $pass = $q->param('pass');
    if ($pass) {
        $obj->set_password($pass);
    }
    elsif ( !$obj->id ) {
        $obj->password('(none)');
    }

    my ( $delim, $delim2 ) = $q->param('tag_delim');
    $delim = $delim ? $delim : $delim2;
    if ( $delim =~ m/comma/i ) {
        $delim = ord(',');
    }
    elsif ( $delim =~ m/space/i ) {
        $delim = ord(' ');
    }
    else {
        $delim = ord(',');
    }
    $obj->entry_prefs( 'tag_delim' => $delim );

    unless ( $obj->id ) {
        $obj->created_by( $app->user->id );
    }
    1;
} ## end sub pre_save

sub post_save {
    my $eh = shift;
    my ( $app, $obj, $original ) = @_;
    my $q = $app->query;
    if ( !$original->id ) {
        $app->log( {
                     message =>
                       $app->translate(
                                    "User '[_1]' (ID:[_2]) created by '[_3]'",
                                    $obj->name, $obj->id, $app->user->name
                       ),
                     level    => MT::Log::INFO(),
                     class    => 'author',
                     category => 'new',
                   }
        );
        $obj->add_default_roles;

        my $author_id = $obj->id;
        if ( $q->param('create_personal_weblog') ) {

            # provision new user with a personal blog
            $app->run_callbacks( 'new_user_provisioning', $obj );
        }
    } ## end if ( !$original->id )
    else {
        if ( $app->user->id == $obj->id ) {
            ## If this is a user editing his/her profile, $id will be
            ## some defined value; if so we should update the user's
            ## cookie to reflect any changes made to username and password.
            ## Otherwise, this is a new user, and we shouldn't update the
            ## cookie.
            $app->user($obj);
            if ( ( $obj->name ne $original->name ) || ( $q->param('pass') ) )
            {
                $app->start_session();
            }
        }
        if (    $original->status == MT::Author::PENDING()
             && $obj->status == MT::Author::ACTIVE()
             && $app->config->NewUserAutoProvisioning )
        {

            # provision new user with a personal blog
            $app->run_callbacks( 'new_user_provisioning', $obj );
        }
    } ## end else [ if ( !$original->id ) ]
    1;
} ## end sub post_save

sub post_delete {
    my ( $eh, $app, $obj ) = @_;

    $app->log( {
                 message =>
                   $app->translate(
                                    "User '[_1]' (ID:[_2]) deleted by '[_3]'",
                                    $obj->name, $obj->id, $app->user->name
                   ),
                 level    => MT::Log::INFO(),
                 class    => 'system',
                 category => 'delete'
               }
    );
}

sub _merge_default_assignments {
    my $app = shift;
    my ( $data, $hasher, $type, $id ) = @_;

    my $role_class = $app->model('role');
    if ( my $def = MT->config->DefaultAssignments ) {
        my @def = split ',', $def;
        while ( my $role_id = shift @def ) {
            my $blog_id = shift @def;
            next unless $role_id && $blog_id;
            next if ( $type eq 'role' ) && ( $id != $role_id );
            next if ( $type eq 'blog' ) && ( $id != $blog_id );
            my $obj = MT::Association->new;
            $obj->role_id($role_id);
            $obj->blog_id($blog_id);
            $obj->id( 'PSEUDO-' . $role_id . '-' . $blog_id );
            my $row = $obj->get_values();
            $hasher->( $obj, $row ) if $hasher;
            $row->{user_id}   = 'PSEUDO';
            $row->{user_name} = MT->translate('(newly created user)');
            $row->{user_nickname}
              = $app->translate(
                          'represents a user who will be created afterwards'),
              my $role = $role_class->load($role_id);
            my @role_loop = ( {
                                role_name    => $role->name,
                                role_id      => $role->id,
                                is_removable => 0,
                              }
            );
            $row->{role_loop} = \@role_loop if @role_loop;
            push @$data, $row;
        } ## end while ( my $role_id = shift...)
    } ## end if ( my $def = MT->config...)
} ## end sub _merge_default_assignments

sub build_author_table {
    my $app    = shift;
    my $q      = $app->query;
    my (%args) = @_;
    my $i      = 1;
    my @author;
    my $iter;
    if ( $args{load_args} ) {
        my $class = $app->model('author');
        $iter = $class->load_iter( @{ $args{load_args} } );
    }
    elsif ( $args{iter} ) {
        $iter = $args{iter};
    }
    elsif ( $args{items} ) {
        $iter = sub { pop @{ $args{items} } };
    }
    return [] unless $iter;
    my $blog_id = $q->param('blog_id');
    my $param   = $args{param};
    $param->{has_edit_access}  = $app->user->is_superuser();
    $param->{is_administrator} = $app->user->is_superuser();
    my ( %blogs, %entry_count_refs );
    while ( my $author = $iter->() ) {
        my $row = {
                name           => $author->name,
                nickname       => $author->nickname,
                email          => $author->email,
                url            => $author->url,
                status_enabled => $author->is_active,
                status_pending => ( $author->status == MT::Author::PENDING() )
                ? 1
                : 0,
                id          => $author->id,
                entry_count => 0,
                is_me       => ( $app->user->id == $author->id ? 1 : 0 )
        };
        $entry_count_refs{ $author->id } = \$row->{entry_count};
        if ( $author->created_by ) {
            if ( my $parent_author
                 = $app->model('author')->load( $author->created_by ) )
            {
                $row->{created_by} = $parent_author->name;
            }
            else {
                $row->{created_by} = $app->translate('(user deleted)');
            }
        }
        $row->{object} = $author;
        $row->{usertype_author} = 1 if $author->type == MT::Author::AUTHOR();
        if ( $author->type == MT::Author::COMMENTER() ) {
            $row->{usertype_commenter} = 1;
            $row->{status_trusted}     = 1
              if $blog_id && $author->is_trusted($blog_id);
            if ( $row->{name} =~ m/^[a-f0-9]{32}$/ ) {
                $row->{name} = $row->{nickname} || $row->{url};
            }
        }
        $row->{auth_icon_url} = $author->auth_icon_url;
        push @author, $row;
    } ## end while ( my $author = $iter...)
    return [] unless @author;
    my $type = $q->param('entry_type') || 'entry';
    my $entry_class = $app->model($type);
    my $author_entry_count_iter =
      $entry_class->count_group_by( {
                                       author_id => [ keys %entry_count_refs ]
                                    },
                                    { group => ['author_id'] }
      );
    while ( my ( $count, $author_id ) = $author_entry_count_iter->() ) {
        ${ $entry_count_refs{$author_id} } = $count;
    }
    $param->{author_table}[0]{object_loop} = \@author;

    $app->load_list_actions( 'author', $param->{author_table}[0] );
    $param->{page_actions} = $param->{author_table}[0]{page_actions}
      = $app->page_actions('list_authors');
    $param->{object_loop} = $param->{author_table}[0]{object_loop};

    \@author;
} ## end sub build_author_table

sub _delete_pseudo_association {
    my $app = shift;
    my ( $pid, $bid ) = @_;
    my $rid;
    if ($pid) {
        ( my $pseudo, $rid, $bid ) = split '-', $pid;
    }
    my @newdef;
    if ( my $def = $app->config->DefaultAssignments ) {
        my @def = split ',', $def;
        while ( my $role_id = shift @def ) {
            my $blog_id = shift @def;
            next unless $role_id && $blog_id;
            next
              if ( $rid && ( $role_id == $rid ) && ( $blog_id == $bid ) )
              || ( !defined($rid) && ( $blog_id == $bid ) );
            push @newdef, "$role_id,$blog_id";
        }
    }
    if (@newdef) {
        $app->config( 'DefaultAssignments', join( ',', @newdef ), 1 );
    }
    else {
        $app->config( 'DefaultAssignments', undef, 1 );
    }
    $app->config->save_config;
} ## end sub _delete_pseudo_association

1;

__END__

=head1 NAME

MT::CMS::User

=head1 METHODS

=head2 build_author_table

=head2 can_delete

=head2 can_delete_association

=head2 can_save

=head2 can_view

=head2 cfg_system_users

=head2 dialog_grant_role

=head2 dialog_select_author

=head2 dialog_select_sysadmin

=head2 disable

=head2 edit

=head2 edit_role

=head2 enable

=head2 grant_role

=head2 list

=head2 list_association

=head2 list_member

=head2 list_role

=head2 post_delete

=head2 post_save

=head2 pre_save

=head2 remove_user_assoc

=head2 remove_userpic

=head2 revoke_role

=head2 save_cfg_system_users

=head2 save_filter

=head2 save_role

=head2 set_object_status

=head2 upload_userpic

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
