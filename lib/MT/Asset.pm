# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Asset;

use strict;
use MT::Tag;
use base qw(MT::FileInfo MT::Taggable);

# A registry of mappings between asset identifiers and packages.
our %Classes = (
    'MT::Asset::Image' => 'image',
);
our %Types = (
    'asset:image' => 'MT::Asset::Image',
);

# Returns the list of registered asset identifiers, including the generic
# one.
sub types {
    my @types = keys %Types;
    push @types, 'asset';
    \@types;
}

# Allows registration (or replacement) of an asset type.
sub add_type {
    my $pkg = shift;
    my ($type, $class) = @_;
    if (exists $Types{$type}) {
        delete $Classes{$Types{$type}};
    }
    $Types{$type} = $class;
    $Classes{$class} = $type;
}

# Returns the package that services a particular asset type. It will also
# make sure this package has been loaded. If the handler of the package
# cannot be found or fails to load, the generic MT::Asset package is returned.
# (For instance, if a plugin that has provided an asset type is no longer
# available, this will at least offer the generic package to access the
# asset.)
sub type_class {
    my $pkg = shift;
    my ($type) = @_;
    return 'MT::Asset' if $type eq 'asset';
    my $class = $Types{$type};
    if ($class) {
        eval "use $class;";
        return $class unless $@;
    }
    __PACKAGE__;
}

# Returns a hashref of asset identifiers mapped to the localized string
# used to name them. (Ie, image => 'Image').
sub type_names {
    my $pkg = shift;
    my %names = ($pkg->type => $pkg->type_name);
    foreach (keys %Types) {
        my $class = $pkg->type_class($_);
        $names{$class->type} = $class->type_name;
    }
    \%names;
}

# Initializes the MT::Asset object (which is actually a MT::FileInfo object),
# assigning a generic asset_type to it.
sub init {
    my $asset = shift;
    $asset->SUPER::init(@_);
    my $type = $asset->type;
    $asset->archive_type($asset->type);
    $asset;
}

# Returns the asset type identifier; for generic MT::Asset, this is just
# 'asset'
sub type {
    'asset';
}

# Returns a localized name for the asset type. For MT::Asset, this is simply
# 'File'.
sub type_name {
    MT->translate('File');
}

# Upon loading an object, this routine is called to assign the values to it.
# This is our opportunity to rebless the object based on the asset type.
sub set_values {
    my $obj = shift;
    $obj->SUPER::set_values(@_);
    my $at = $obj->archive_type;
    if (my $pkg = $obj->type_class($at)) {
        bless $obj, $pkg;
    }
    $obj;
}

# Calls the standard MT::Object::load routine, but sets the
# archive_type, if unset. This restricts the load to include only
# the assets that match the package requested. Note that this will
# exclude by default all other asset types, even if you use
# MT::Asset->load. To include all asset types, the archive_type
# load term should be set to the value of MT::Asset->types.
sub load {
    my $pkg = shift;
    my ($terms, $args) = @_;
    if ($terms && (!ref($terms))) {
        $terms = { id => $terms };
    } else {
        $terms ||= {};
    }
    $terms->{archive_type} ||= $pkg->type;
    $pkg->SUPER::load(@_);
}

# See notes for the load method.
sub load_iter {
    my $pkg = shift;
    my ($terms, $args) = @_;
    if ($terms && (!ref($terms))) {
        $terms = { id => $terms };
    } else {
        $terms ||= {};
    }
    $terms->{archive_type} ||= $pkg->type;
    $pkg->SUPER::load_iter(@_);
}

# Saves the asset and associated tags.
sub save {
    my $asset = shift;
    $asset->SUPER::save(@_) or return;
    # synchronize tags if necessary
    $asset->save_tags;
    1;
}

# Removes the asset, associated tags and related file.
sub remove {
    my $asset = shift;
    if (ref $asset) {
        $asset->remove_tags;
        my $blog = MT::Blog->load($asset->blog_id, { cached_ok => 1 });
        if ($blog) {
            my $file = $asset->file_path;
            $blog->file_mgr->delete($file);
        }
    }
    $asset->SUPER::remove(@_);
}

1;