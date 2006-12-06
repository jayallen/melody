# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Permission;

use strict;

use MT::Blog;
use MT::Object;
@MT::Permission::ISA = qw(MT::Object);

# NOTE: The number of role mask fields is variable to accomodate expansion
# of permissions. When the field count is increased, the schema version
# must be bumped.
use constant ROLE_BUCKETS => 4;
my %role_mask_buckets;
$role_mask_buckets{"role_mask"} = 'integer';
$role_mask_buckets{"role_mask$_"} = 'integer' for 2..ROLE_BUCKETS;

__PACKAGE__->install_properties({
    column_defs => {
        'id'             => 'integer not null auto_increment',
        'author_id'      => 'integer not null',
        'blog_id'        => 'integer not null',
        %role_mask_buckets,
        'blog_prefs'     => 'string(255)',
        'entry_prefs'    => 'string(255)',
        'template_prefs' => 'string(255)',
    },
    child_of => 'MT::Blog',
    indexes => {
        blog_id        => 1,
        author_id      => 1,
        role_mask      => 1,
    },
    defaults => {
        author_id      => 0,
        blog_id        => 0,
        role_mask      => 0,
        role_mask2     => 0,
        role_mask3     => 0,
        role_mask4     => 0,
    },
    audit => 1,
    datasource  => 'permission',
    primary_key => 'id',
});

sub user {
    my $perm = shift;
    #xxx Beware of circular references
    return undef unless $perm->author_id;
    $perm->cache_property('user', sub {
        require MT::Author;
        MT::Author->load($perm->author_id, {cached_ok=>1});
    });
}
*author = *user;

sub blog {
    my $perm = shift;
    return undef unless $perm->blog_id;
    $perm->cache_property('blog', sub {
        require MT::Blog;
        MT::Blog->load($perm->blog_id, {cached_ok => 1});
    });
}

{
    my @Perms = (
        # System-wide permissions
        [ 1,     'administer', 'System Administrator', 2, 'system' ],
        [ 2,     'create_blog', 'Create Weblogs', 2, 'system' ],
        [ 4,     'view_log', 'View System Activity Log', 2, 'system' ],

        # Blog-specific permissions
        # The order here is the same order they are presented on the
        # role definition screen.
        [ 1,     'comment', 'Post Comments', 1, 'blog'],
        [ 4096,  'administer_blog', 'Weblog Administrator', 1, 'blog'],
        [ 64,    'edit_config', 'Configure Weblog', 1, 'blog'],
        [ 8,     'edit_all_posts', 'Edit All Entries', 1, 'blog'],
        [ 16,    'edit_templates', 'Manage Templates', 1, 'blog'],
        [ 32768, 'save_image_defaults', 'Save Image Defaults', 1, 'blog'],
        [ 2,     'post', 'Create Entries', 1, 'blog'],
        [ 4,     'upload', 'Upload File', 1, 'blog'],
        [ 65536,  'edit_assets', 'Manage Assets', 1, 'blog'],
        [ 512,   'edit_categories', 'Add/Manage Categories', 1, 'blog'],
        [ 16384, 'edit_tags', 'Manage Tags', 1, 'blog'],
        [ 1024,  'edit_notifications', 'Manage Notification List', 1, 'blog'],
        [ 256,   'send_notifications', 'Send Notifications', 1, 'blog'],
        [ 8192,  'view_blog_log', 'View Activity Log', 1, 'blog'],
        # 32 is deprecated; reserved for future use
        [ 128,   'rebuild', 'Rebuild Files', 1, 'blog'],
        # Not a real permission but a denial thereof; unlisted because it
        # has no label.
        [ 2048,  'not_comment', '', 1, 'blog'],
    );

    sub add_permissions {
        my $perms = shift;
        # This parameter can be any MT::Object that provides the
        # role_mask fields. So it works with MT::Permission and MT::Role.
        my ($more_perm) = @_;
        foreach my $mask (keys %role_mask_buckets) {
            my $cur_perm = $perms->column($mask) || 0;
            if (my $more = $more_perm->column($mask)) {
                $perms->column($mask, $cur_perm | $more);
            }
        }
    }

    # Sets permissions of those in a particular set
    sub set_full_permissions {
        my $perms = shift;
        $perms->set_permissions('blog');
    }

    sub set_permissions {
        my $perms = shift;
        my ($set) = @_;
        my @mask;
        for (my $i = 1; $i <= ROLE_BUCKETS; $i++) {
            $mask[$i - 1] = $i == 1 ? $perms->role_mask
                                    : $perms->column('role_mask' . $i);
        }
        for my $ref (@Perms) {
            next if $set && ($set ne '*') && ($ref->[4] ne $set);
            next if ($ref->[1] =~ /^not_/);
            $mask[$ref->[3]-1] |= $ref->[0];
        }
        for (my $i = 1; $i <= ROLE_BUCKETS; $i++) {
            $i == 1 ? $perms->role_mask($mask[$i - 1] || 0)
                    : $perms->column('role_mask' . $i, $mask[$i - 1] || 0);
        }
    }

    # Clears all permissions or those in a particular set
    sub clear_full_permissions {
        my $perms = shift;
        $perms->clear_permissions('*');
    }

    sub clear_permissions {
        my $perms = shift;
        my ($set) = @_;
        my @mask;
        for (my $i = 1; $i <= ROLE_BUCKETS; $i++) {
            $mask[$i-1] = $i == 1 ? $perms->role_mask
                                  : $perms->column('role_mask' . $i);
        }
        for my $ref (@Perms) {
            next if $set && ($set ne '*') && ($ref->[4] ne $set);
            next if ($ref->[1] =~ /^not_/);
            $mask[$ref->[3]-1] = ($mask[$ref->[3]-1] || 0) & (0xffff - $ref->[0]);
        }
        for (my $i = 1; $i <= ROLE_BUCKETS; $i++) {
            $i == 1 ? $perms->role_mask($mask[$i-1] || 0)
                    : $perms->column('role_mask' . $i, $mask[$i - 1] || 0);
        }
    }

    sub perms {
        my $pkg = shift;
        if (@_) {
            my $set = shift;
            my @perms = grep { $_->[4] eq $set } @Perms;
            \@perms;
        } else {
            \@Perms;
        }
    }

    my %Perms;

    sub __mk_perm {
        no strict 'refs';
        my $ref = shift;
        my $mask = $ref->[0];
        my $meth = 'can_' . $ref->[1];

        $Perms{$ref->[1]} = $ref;
        my $bucket = $ref->[3];
        my $set = $ref->[4];
        my $mask_field = 'role_mask' . ($bucket == 1 ? '' : $bucket);

        *$meth = sub {
            my $flags = $_[0]->$mask_field || 0;
            if (@_ == 2) {
                $flags = $_[1] ? ($flags | $mask) :
                                 ($flags & ~$mask);
                $_[0]->$mask_field($flags);
            } else {
                my $author = $_[0]->author;
                return $mask if (($meth ne 'can_administer') && ($author && $author->is_superuser))
                    || (($set eq 'blog') && $_[0]->has('administer_blog'));
            }
            $flags & $mask;
        };
    }

    __mk_perm($_) foreach @Perms;

    sub set_these_permissions {
        my $perms = shift;
        my (@list) = @_;
        if ((ref $list[0]) eq 'ARRAY') {
            @list = @{ $list[0] };
        }
        foreach (@list) {
            my $ref = $Perms{$_};
            die "invalid permission" unless $ref;
            my $bucket = $ref->[3];
            my $mask_field = 'role_mask' . ($bucket == 1 ? '' : $bucket);
            my $val = $perms->$mask_field();
            $val |= $ref->[0];
            $perms->$mask_field($val);
        }
    }

    sub add_permission {
        my $pkg = shift;
        my ($perm) = @_;
        if (ref $perm eq 'HASH') {
            return unless $perm->{mask} && $perm->{key} &&
                    $perm->{bucket} && $perm->{set};
            my $ref = [
                $perm->{mask},
                $perm->{key},
                $perm->{label} || '',
                $perm->{bucket},
                $perm->{set}
            ];
            push @Perms, $ref;
            __mk_perm($ref);
        } elsif (ref $perm eq 'ARRAY') {
            push @Perms, $perm;
            __mk_perm($perm);
        }
    }

    # $perm->has() skips any fancy logic, returning true or false
    # depending only on whether the bit is set in this record.
    sub has {
        my $this = shift;
        my ($flag_name) = @_;
        my $bit = $Perms{$flag_name}[0] || 0;
        return 0 unless $bit;
        my $mask_field = 'role_mask' . ($Perms{$flag_name}[3] == 1 ? '' : $Perms{$flag_name}[3]);
        return ($this->$mask_field() || 0) & $bit;
    }
}

sub can_edit_authors {
    my $perms = shift;
    my $author = $perms->user;
    $perms->can_administer_blog || ($author && $author->is_superuser());
}

sub can_edit_entry {
    my $perms = shift;
    my($entry, $author) = @_;
    die unless $author->isa('MT::Author');
    return 1 if $author->is_superuser();
    unless (ref $entry) {
        require MT::Entry;
        $entry = MT::Entry->load($entry, {cached_ok=>1});
    }
    die unless $entry->isa('MT::Entry');
    $perms->can_edit_all_posts ||
        ($perms->can_post && $entry->author_id == $author->id);
}

sub _static_rebuild {
    my $pkg = shift;
    my ($obj) = @_;

    if ($obj->isa('MT::Association')) {
        my $assoc = $obj;
        if ($assoc->role_id && $assoc->blog_id) {
            if ($assoc->author_id) {
                my $user = $assoc->user or return;
                my $perm = MT::Permission->get_by_key({
                    author_id => $user->id,
                    blog_id => $assoc->blog_id
                });
                $perm->rebuild;
            }
        }
    }
    1;
}

sub rebuild {
    my $perm = shift;
    if (!ref $perm) {
        return $perm->_static_rebuild(@_);
    }

    # rebuild permissions for this user / blog
    my $user_id = $perm->author_id;
    my $blog_id = $perm->blog_id;

    return unless $user_id && $blog_id;

    # clean slate
    $perm->clear_full_permissions;
    my $has_permissions = 0;

    # find all blogs for this user
    my $user = MT::Author->load($user_id) or return;

    my $role_iter = $user->role_iter({ blog_id => $blog_id });
    if ($role_iter) {
        while (my $role = $role_iter->()) {
            $perm->add_permissions($role);
            $has_permissions = 1;
        }
    }

    if ($has_permissions) {
        $perm->save;
    } else {
        $perm->remove if $perm->id;
    }
}
sub to_hash {
    my $perms = shift;
    my $hash = {}; # $perms->SUPER::to_hash(@_);
    my $all_perms = MT::Permission->perms();
    foreach (@$all_perms) {
        my $perm = $_->[1];
        $hash->{"permission.can_$perm"} = $perms->has($perm);
    }
    $hash;
}

sub parent_names {
    my $obj = shift;
    { author => 'MT::Author', blog => 'MT::Blog' };
}

1;
__END__

=head1 NAME

MT::Permission - Movable Type permissions record

=head1 SYNOPSIS

    use MT::Permission;
    my $perms = MT::Permission->load({ blog_id => $blog->id,
                                       author_id => $author->id })
        or die "User has no permissions for blog";
    $perms->can_post
        or die "User cannot post to blog";

    $perms->can_edit_config(0);
    $perms->save
        or die $perms->errstr;

=head1 DESCRIPTION

An I<MT::Permission> object represents the permissions settings for a user
in a particular blog. Permissions are set on a role basis, and each permission
is either on or off for an user-blog combination; permissions are stored as
a bitmask.

Note: The I<MT::Permission> object is not meant to be modified or created
directly. Permissions should be assigned to users through role associations.
The I<MT::Permission> object is actually managed by Movable Type purely, and
is a flattened view of all the permissions a particular user has for a single
blog.

=head1 USAGE

As a subclass of I<MT::Object>, I<MT::Permission> inherits all of the
data-management and -storage methods from that class; thus you should look
at the I<MT::Object> documentation for details about creating a new object,
loading an existing object, saving an object, etc.

The following methods are unique to the I<MT::Permission> interface. Each of
these methods, B<except> for I<set_full_permissions>, can be called with an
optional argument to turn the permission on or off. If the argument is some
true value, the permission is enabled; otherwise, the permission is disabled.
If no argument is provided at all, the existing permission setting is
returned.

=head2 MT::Permission->perms( [ $set ] )

Returns an array reference containing the list of available permissions. The
array is a list of permissions, each of which is an array reference with
the following items:

    [ mask, key, label, bucket, set ]

The 'mask' element is the value of that permission. Permission values are
powers of two, since they are stored as a bitmask.

The 'key' element is a unique identifier that is used to identify the
permission. Declared permissions may be tested through a 'can' method
that is added to the MT::Permission namespace when registering them. So
if you register with a 'key' value of 'foo', this creates a method
'can_foo', which may be tested for like this:

    my $perm = $app->permissions;
    if ($perm->can_foo) {
        $app->foo;
    }

The 'label' element is a phrase that identifies the permission.

The 'bucket' element identifies which role mask field the permission will
be stored in. Each field is capable of holding 31 permission flags, and
we now define 4 fields, most of which are used for future expansion. This
gives us a total of 124 permission flags. Additional role mask fields
may be added in the future if we exhaust the existing ones.

The 'set' element identifies which group or category of permissions the
permission is associated with. Currently, there are two sets of 
permissions: 'blog' and 'system'.

If you call the perms method with the $set parameter, it will only return
permissions declared with that 'set' identifier.

=head2 MT::Permission->add_permission( \%perm )

=head2 MT::Permission->add_permission( \@perm )

Both of these methods can be used to register a new permission with
Movable Type.

Note: It is not advisable to call these method to register custom permissions
without having preregistered for one from Six Apart, Ltd. This will
reserve your permission and allow it to coexist with other plugins and
future permissions defined by Movable Type itself.

When calling add_permission with a hashref, you should specify these
elements in the hash:

=over 4

=item * mask

=item * key

=item * label

=item * bucket

=item * set

=back

See the 'perms' method documentation for more information on these
elements.

If calling the add_permission method with an arrayref, you should
specify the elements of the array in the same order as given by
the 'perms' method. You may only register one permission per call
to the add_permission method.

=head2 $perms->set_full_permissions()

Turns on all blog-level permissions.

=head2 $perms->clear_full_permissions()

Turns off all permissions.

=head2 $perms->set_permissions($set)

Sets all permissions identified by the group C<$set> (use '*' to include
all permissions regardless of grouping).

=head2 $perms->clear_permissions($set)

Clears all permissions identified by the group C<$set> (use '*' to include
all permissions regardless of grouping).

=head2 $perms->add_permissions($more_perms)

Adds C<$more_perms> to C<$perms>.

=head2 $perms->set_these_permissions(@permission_names)

Adds permissions (enabling them) to the existing permission object.

    $perms->set_these_permissions('view_blog_log', 'post');

=head2 MT::Permission->rebuild($assoc)

Rebuilds permission objects affected by the given L<MT::Association> object.

=head2 $perms->rebuild()

Rebuilds the single permission object based on the user/role/blog
relationships that can be found for the author and blog tied to the
permission.

=head2 $perms->has($permission_name)

Returns true or false depending only on whether the bit identified by
C<$permission_name> is set in this permission object.

=head2 $perms->can_administer_blog

Returns true if the user can administer the blog. This is a blog-level
"superuser" capability.

=head2 $perms->can_post

Returns true if the user can post to the blog, and edit the entries that
he/she has posted; false otherwise.

=head2 $perms->can_upload

Returns true if the user can upload files to the blog directories specified
for this blog, false otherwise.

=head2 $perms->can_edit_all_posts

Returns true if the user can edit B<all> entries posted to this blog (even
entries that he/she did not write), false otherwise.

=head2 $perms->can_edit_templates

Returns true if the user can edit the blog's templates, false otherwise.

=head2 $perms->can_send_notifications

Returns true if the user can send messages to the notification list, false
otherwise.

=head2 $perms->can_edit_categories

Returns true if the user can edit the categories defined for the blog, false
otherwise.

=head2 $perms->can_edit_tags

Returns true if the user can edit the tags defined for the blog, false
otherwise.

=head2 $perms->can_edit_notifications

Returns true if the user can edit the notification list for the blog, false
otherwise.

=head2 $perms->can_view_blog_log

Returns true if the user can view the activity log for the blog, false
otherwise.

=head2 $perms->can_rebuild

Returns true if the user can edit the rebuild the blog, false otherwise.

=head2 $perms->can_edit_config

Returns true if the user can edit the blog configuration, false otherwise.

=head2 $perms->can_edit_authors()

Returns true if the 'administer_blog' permission is set or the associated
author has superuser rights.

=head2 $perms->can_edit_entry($entry, $author)

Returns true if the C<$author> has rights to edit entry C<$entry>. This
is always true if C<$author> is a superuser or can edit all posts or
is a blog administrator for the blog that contains the entry. Otherwise,
it returns true if the author has permission to post and the entry was
authored by that author, false otherwise.

The C<$entry> parameter can either be a I<MT::Entry> object or an entry id.

=head2 $perms->can_administer

=head2 $perms->can_view_log

=head2 $perms->can_create_blog

These are system-wide permissions that is reserved for future use.

=head2 $perms->can_not_comment

Returns true if the user has been banned from commenting on the blog.
This permission is used for authenticated commenters.

=head2 $perms->can_comment

Returns true if the user has been approved for commenting on the blog.
This permission is used for authenticated commenters.

=head2 $perms->blog

Returns the I<MT::Blog> object for this permission object.

=head2 $perms->user

=head2 $perms->author

Returns the I<MT::Author> object for this permission object. The C<author>
method is deprecated in favor of C<user>.

=head2 $perms->to_hash

Returns a hashref that represents the contents of the permission object.
Elements are in the form of (enabled permissions are set, disabled
permissions are set to 0):

    { 'permission.can_edit_templates' => 16,
      'permission.can_rebuild' => 0,
      # ....
      'permission.can_post' => 2 }

=head1 DATA ACCESS METHODS

The I<MT::Comment> object holds the following pieces of data. These fields can
be accessed and set using the standard data access methods described in the
I<MT::Object> documentation.

=over 4

=item * id

The numeric ID of this permissions record.

=item * author_id

The numeric ID of the user associated with this permissions record.

=item * blog_id

The numeric ID of the blog associated with this permissions record.

=item * role_mask

=item * role_mask2

=item * role_mask3

=item * role_mask4

The permissions bitmasks. You should not access this value directly; instead
use the I<can_*> methods, above. Since a single column holds only 31 flags,
we spread our full range of permissions across several bitmask fields.

=item * entry_prefs

The setting of display fields of "edit entry" page.  The value
at author_id 0 means default setting of a blog.

=item * template_prefs

The setting of display  "edit template" page.  The value
at author_id 0 means default setting of a blog.

=back

=head1 DATA LOOKUP

In addition to numeric ID lookup, you can look up or sort records by any
combination of the following fields. See the I<load> documentation in
I<MT::Object> for more information.

=over 4

=item * blog_id

=item * author_id

=back

=head1 AUTHOR & COPYRIGHTS

Please see the I<MT> manpage for user, copyright, and license information.

=cut
