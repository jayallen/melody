# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Author;

use strict;

use base 'MT::Object';

__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'name' => 'string(255) not null',
        'nickname' => 'string(255)',
        'password' => 'string(60) not null',
        'type' => 'smallint not null',
        'email' => 'string(75)',
        'url' => 'string(255)',
        'can_create_blog' => 'boolean',
        'is_superuser' => 'boolean',
        'hint' => 'string(75)',
        'can_view_log' => 'boolean',
        'public_key' => 'text',
        'preferred_language' => 'string(50)',
        'api_password' => 'string(60)',
        'remote_auth_username' => 'string(50)',
        'remote_auth_token' => 'string(50)',
        'entry_prefs' => 'string(255)',
        'status' => 'integer',
    },
    defaults => {
        type => 1,
        status => 1,
    },
    indexes => {
        created_on => 1,
        name => 1,
        email => 1,
        type => 1,
        status => 1,
        is_superuser => 1,
    },
    child_classes => ['MT::Permission', 'MT::Association'],
    datasource => 'author',
    primary_key => 'id',
    audit => 1,
});

# Valid "type" codes:
use constant AUTHOR => 1;
use constant COMMENTER => 2;

# Commenter statuses
use constant APPROVED => 1;
use constant BANNED => 2;
use constant BLOCKED => 2; # alias for BANNED for backward compatibility
use constant PENDING => 3;

# Author statuses
use constant ACTIVE   => 1;
use constant INACTIVE => 2;

use Exporter;
*import = \&Exporter::import;
use vars qw(@EXPORT_OK %EXPORT_TAGS);
@EXPORT_OK = qw(AUTHOR COMMENTER ACTIVE INACTIVE APPROVED BANNED PENDING);
%EXPORT_TAGS = (constants => [qw(AUTHOR COMMENTER ACTIVE INACTIVE APPROVED BANNED PENDING)]);

sub set_defaults {
    my $auth = shift;
    my $cfg = MT::ConfigMgr->instance;
    $auth->SUPER::set_defaults(@_);
    $auth->preferred_language($cfg->DefaultUserLanguage || $cfg->DefaultLanguage);
}

sub remove_sessions {
    my $auth = shift;
    require MT::Session;
    my $sess_iter = MT::Session->load_iter({ kind => 'US' });
    my @sess;
    while (my $sess = $sess_iter->()) {
        my $id = $sess->get('author_id');
        next unless $id == $auth->id;
        push @sess, $sess;
    }
    $_->remove foreach @sess;
}

sub session {
    die "This was removed";        # FIXME: this is to catch mistakes
}

sub magic_token {
    die "there is no magic_token"; # FIXME: this is to catch mistakes
}

sub set_password {
    my $auth = shift;
    my($pass) = @_;
    my @alpha = ('a'..'z', 'A'..'Z', 0..9);
    my $salt = join '', map $alpha[rand @alpha], 1..2;
    $auth->column('password', crypt $pass, $salt);
}

sub is_valid_password {
    my $auth = shift;
    my($pass, $crypted) = @_;
    $pass ||= '';
    my $real_pass = $auth->column('password');
    return $crypted ? $real_pass eq $pass :
                      crypt($pass, $real_pass) eq $real_pass;
}

sub is_email_hidden {
    my $auth = shift;
    return ($auth->email =~ /^[0-9a-f]{40}$/i) ? 1 : 0;
}

# The two permissions can_comment and can_not_comment form the
# three-state "status" variable:
# can_comment   can_not_comment | status
#    0             0            | pending
#    1             0            | approved
#    0             1            | banned

# Existing comments of a user are made visible only if the 
# user is coming from "pending" status.

sub set_commenter_perm {
    my $this = shift;
    my ($blog_id, $action) = @_;
    return $this->error(MT->translate("Can't approve/ban non-COMMENTER user"))
        if ($this->type ne COMMENTER);

    require MT::Permission;
    my %perm_spec = (
        author_id => $this->id(),
        blog_id => $blog_id
    );
    my $perm = MT::Permission->load(\%perm_spec);
    if (!$perm) {
        $perm = MT::Permission->new();
        $perm->set_values(\%perm_spec);
    }
    my $was_pending = !$perm->can_comment() && !$perm->can_not_comment();
    if ($action eq 'approve') {
        $perm->can_comment(1);
        $perm->can_not_comment(0);
    } elsif (($action eq 'ban') || ($action eq 'block')) {
        $perm->can_not_comment(1);
        $perm->can_comment(0);
    } elsif ($action eq 'pending') {
        return if $was_pending && $perm->id; # no need to resave here
        $perm->can_not_comment(0);
        $perm->can_comment(0);
    }
    $perm->save()
        or return $this->error(MT->translate("The approval could not be committed: [_1]", $perm->errstr));

    return 1;
}

sub status {
    my $this = shift;
    if ($this->type == COMMENTER) {
        my ($blog_id) = @_;
        # TBD: cache the permission record FIXME
        require MT::Permission;
        my $perm = MT::Permission->load({author_id=>$this->id, blog_id=>$blog_id});
        return PENDING if !$perm;
        return BANNED if $perm->can_not_comment();
        return APPROVED if $perm->can_comment();
        return PENDING;
    } else {
        $this->SUPER::status(@_);
    }
}

sub is_active { shift->status(@_) == ACTIVE; }
sub is_trusted { shift->status(@_) == APPROVED; }
sub is_banned { shift->status(@_) == BANNED; }
*is_blocked = \&is_banned;
sub is_not_trusted { shift->status(@_) == PENDING; }
*is_untrusted = \&is_not_trusted;

sub approve {
    my $this = shift;
    my ($blog_id) = @_;
    $this->set_commenter_perm($blog_id, 'approve');
}

*trust = \&approve;

sub pending {
    $_[0]->set_commenter_perm($_[1], 'pending');
}

sub ban {
    my $this = shift;
    my ($blog_id) = @_;
    $this->set_commenter_perm($blog_id, 'ban');
}
*block = \&ban;

sub save {
    my $auth = shift;

    if ((!$auth->id) && ($auth->type == AUTHOR)) {
        # New author, undefined API password. Generate one.
        if (!defined $auth->api_password) {
            my @pool = ('a'..'z', 0..9);
            my $pass = '';
            for (1..8) { $pass .= $pool[ rand @pool ] }
            $auth->api_password($pass);
        }
    }

    $auth->SUPER::save(@_);
}

sub remove {
    my $auth = shift;
    $auth->remove_sessions if ref $auth;
    $auth->remove_children({ key => 'author_id' }) or return;
    $auth->SUPER::remove(@_);
}

sub can_edit_entry {
    my $author = shift;
    die unless $author->isa('MT::Author');
    return 1 if $author->is_superuser();
    my($entry) = @_;
    unless (ref $entry) {
        require MT::Entry;
        $entry = MT::Entry->load($entry, {cached_ok=>1});
    }
    die unless $entry->isa('MT::Entry');
    my $perms = $author->permissions($entry->blog_id);
    die unless $perms->isa('MT::Permission');
    $perms->can_edit_all_posts ||
    ($perms->can_post && $entry->author_id == $author->id);
}

sub can_create_blog {
    my $author = shift;
    $author->is_superuser() || $author->SUPER::can_create_blog(@_);
}

sub can_view_log {
    my $author = shift;
    $author->is_superuser() || $author->SUPER::can_view_log(@_);
}

sub blog_perm {
    my $author = shift;
    my ($blog_id) = @_;
    $author->permissions($blog_id);
}

sub permissions {
    my $author = shift;
    my ($obj) = @_;

    my $terms = { author_id => $author->id };
    my $cache_key = "__perm_author_" . $author->id;
    if ($obj) {
        my $blog_id;
        if ((ref $obj) && $obj->isa('MT::Blog')) {
            $blog_id = $obj->id;
        } elsif ($obj) {
            $blog_id = $obj;
            require MT::Blog;
            $obj = MT::Blog->load($blog_id, { cached_ok => 1 });
        }
        $cache_key .= "_blog_$blog_id";
        $terms->{blog_id} = [ 0, $blog_id ];
    } else {
        $terms->{blog_id} = 0;
    }

    require MT::Request;
    my $r = MT::Request->instance;
    my $p = $r->stash($cache_key);
    return $p if $p;

    require MT::Permission;
    my @perm = MT::Permission->load($terms);
    my $perm;
    if ($obj) {
        if (@perm == 2) {
            if (!$perm[0]->blog_id) {
                @perm = reverse @perm;
            }
            ($perm, my $sys_perm) = @perm;
            $perm->add_permission($sys_perm);
        } elsif (@perm == 1) {
            $perm = $perm[0];
            if (!$perm->blog_id) {
                $perm->blog_id($obj->id);
                $perm->id(0);
            }
        } elsif (@perm) {
            die "invalid permissions for author " . $author->id;
        }
    } else {
        $perm = $perm[0] if @perm;
     }
    unless (@perm) {
        # Use superclass is_superuser method here to avoid
        # recursive calls.
        if ($author->SUPER::is_superuser) {
            $perm = new MT::Permission;
            $perm->author_id($author->id);
            $perm->set_full_permissions;
        }
    }
    unless ($perm) {
        $perm = new MT::Permission;
        $perm->author_id($author->id);
        $perm->clear_full_permissions;
    }
    $r->stash($cache_key, $perm);
    $perm;
}
 
sub common_blogs { # returns the blogs in the form of permission records of $this
    die "This was removed";        # FIXME: this is to catch mistakes
}
sub can_administer {
    die "This was removed";        # FIXME: this is to catch mistakes
}

sub entry_prefs {
    my $author = shift;
    my @prefs = split /,/, ($author->column('entry_prefs') || '');
    my %prefs;
    foreach (@prefs) {
        my ($name, $value) = split /=/, $_, 2;
        $prefs{$name} = $value;
    }
    if (@_) {
        %prefs = (%prefs, @_);
        my $pref = '';
        foreach (keys %prefs) {
            $pref .= ',' if $pref ne '';
            $pref .= $_ . '=' . $prefs{$_};
        }
        $author->column('entry_prefs', $pref);
    }

    # default assignments for author entry preferences
    $prefs{tag_delim} ||= ord(',');

    \%prefs;
}

sub role_iter {
    my $author = shift;
    my ($terms, $args) = @_;
    require MT::Association;
    require MT::Role;
    my $blog_id = delete $terms->{blog_id};
    my $type;
    if ($blog_id) {
        $type = MT::Association::USER_BLOG_ROLE();
    } else {
        $type = MT::Association::USER_ROLE();
    }
    $args->{join} = MT::Association->join_on('role_id', {
        type => $type,
        author_id => $author->id,
        $blog_id ? (blog_id => $blog_id) : (blog_id => 0),
    });
    MT::Role->load_iter($terms, $args);
}

sub blog_iter {
    my $author = shift;
    my ($terms, $args) = @_;
    my $perm = $author->permissions;
    if (!$author->is_superuser) {
        require MT::Permission;
        $args->{join} = MT::Permission->join_on('blog_id', {
            author_id => $author->id,
        });
    }
    require MT::Blog;
    MT::Blog->load_iter($terms, $args);
}

sub add_role {
    my $author = shift;
    my ($role, $blog) = @_;
    $author->save unless $author->id;
    $role->save unless $role->id;
    $blog->save if $blog && !$blog->id;
    require MT::Association;
    MT::Association->link($author, @_);
}

sub remove_role {
    my $author = shift;
    require MT::Association;
    MT::Association->unlink($author, @_);
}

sub to_hash {
    my $author = shift;
    my $hash = $author->SUPER::to_hash(@_);
    my $app = MT->instance;
    my $blog = $app->blog if $app->can('blog');
    if ($blog) {
        require MT::Permission;
        if (my $perms = MT::Permission->load({ author_id => $author->id, blog_id => $blog->id })) {
            my $perms_hash = $perms->to_hash;
            $hash->{"author.$_"} = $perms_hash->{$_} foreach keys %$perms_hash;
        }
    }
    $hash;
}

sub children_names {
    my $obj = shift;
    my $children = {
        permission => 'MT::Permission',
        association => 'MT::Association',
        #entry => 'MT::Entry',       ## An author is a parent of a category/entry
        #category => 'MT::Category', ## but a category/entry is not a child of an author
                                     ## otherwise they duplicate in restore operation.
                                     ## Also, <author> must come before <category> and
                                     ## <entry> in the backup file.
    };
    $children;
}
1;
__END__

=head1 NAME

MT::Author - Movable Type author record

=head1 SYNOPSIS

    use MT::Author;
    my $author = MT::Author->new;
    $author->name('Foo Bar');
    $author->set_password('secret');
    $author->save
        or die $author->errstr;

    my $author = MT::Author->load($author_id);

=head1 DESCRIPTION

An I<MT::Author> object represents a user in the Movable Type system. It
contains profile information (name, nickname, email address, etc.), global
permissions settings (blog creation, activity log viewing), and authentication
information (password, public key). It does not contain any per-blog
permissions settings--for those, look at the I<MT::Permission> object.

=head1 USAGE

As a subclass of I<MT::Object>, I<MT::Author> inherits all of the
data-management and -storage methods from that class; thus you should look
at the I<MT::Object> documentation for details about creating a new object,
loading an existing object, saving an object, etc.

The following methods are unique to the I<MT::Author> interface:

=head2 $author->set_password($pass)

One-way encrypts I<$pass> with a randomly-generated salt, using the Unix
I<crypt> function, and sets the I<password> data field in the I<MT::Author>
object I<$author>.

Because the password is one-way encrypted, there is B<no way> of recovering
the initial password.

=head2 $author->is_valid_password($check_pass)

Tests whether I<$check_pass> is a valid password for the I<MT::Author> object
I<$author> (ie, whether it matches the password originally set using
I<set_password>). This check is done by one-way encrypting I<$check_pass>,
using the same salt used to encrypt the original password, then comparing the
two encrypted strings for equality.

=head1 DATA ACCESS METHODS

The I<MT::Author> object holds the following pieces of data. These fields can
be accessed and set using the standard data access methods described in the
I<MT::Object> documentation.

=over 4

=item * id

The numeric ID of the author.

=item * name

The username of the author. This is the username used to log in to the system.

=item * nickname

The author nickname (or "display" name). This is the preferred name used for publishing the author's name.

=item * password

The author's password, one-way encrypted. If you wish to check the validity of
a password, you should use the I<is_valid_password> method, above.

=item * type

The type of author record. Currently, MT stores authenticated commenters in the author table. The type column can be one of AUTHOR or COMMENTER (constants defined in this package).

=item * status

A column that defines whether the records of an AUTHOR type are ACTIVE or INACTIVE (constants declared in this package). For COMMENTER type author records, this method requires a blog id to be passed as the argument and a value of APPROVED, BANNED or PENDING (constants declared in this package) is returned.

=item * email

The author's email address.

=item * url

The author's homepage URL.

=item * hint

The answer to the question used when recovering the user's password. Currently
this is the birthplace of the author, though this may change in the future.

=item * can_create_blog

A boolean flag specifying whether the author has permission to create a new
blog in the system.

=item * can_view_log

A boolean flag specifying whether the author has permission to view the global
system activity log.

=item * created_by

The author ID of the author who created this author. If the author was created by a process where no user was logged in to Movable Type, the created_by column will be empty.

=item * public_key

The author's ASCII-armoured public key, to be used in the future for verifying
incoming email messages.

=back

=head1 DATA LOOKUP

In addition to numeric ID lookup, you can look up or sort records by any
combination of the following fields. See the I<load> documentation in
I<MT::Object> for more information.

=over 4

=item * name

=item * email

=back

=head1 NOTES

=over 4

=item *

When you remove an author using I<MT::Author::remove>, in addition to removing
the author record, all of the author's permissions (I<MT::Permission> objects)
will be removed, as well.

=back

=head1 AUTHOR & COPYRIGHTS

Please see the I<MT> manpage for author, copyright, and license information.

=cut
