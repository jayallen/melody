# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Asset;

use strict;
use MT::Tag;
use base qw(MT::Object MT::Taggable);

__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'class' => 'string(255)',
        'blog_id' => 'integer not null',
        'label' => 'string(255)',
        'url' => 'string(255)',
        'description' => 'text',
        'file_path' => 'string(255)',
        'file_name' => 'string(255)',
        'file_ext' => 'string(20)',
        'mime_type' => 'string(255)',
        'image_width' => 'integer',
        'image_height' => 'integer',
        'duration' => 'integer',
        'parent' => 'integer',
    },
    indexes => {
        blog_id => 1,
        url => 1,
        label => 1,
        file_path => 1,
        class => 1,
        parent => 1,
        created_by => 1,
        created_on => 1,
    },
    audit => 1,
    datasource => 'asset',
    primary_key => 'id',
});

# A registry of mappings between asset identifiers and packages.
our %Classes = (
    'image' => 'MT::Asset::Image',
    'file' => 'MT::Asset',
);
our %Types = (
    'MT::Asset::Image' => 'image',
    'MT::Asset' => 'file',
);

sub set_defaults {
    my $obj = shift;
    my $pkg = ref $obj;
    $obj->class($pkg->class);
}

sub class {
    my $pkg = shift;
    return $pkg->SUPER::class(@_) if ref $pkg;
    $Types{ref $pkg || $pkg} || 'file';
}

# Returns the list of registered asset identifiers for this class
# and those that derive from it. Also includes the type of the package
# invoked.
sub classes {
    my $pkg = shift;
    my $this_class = $pkg->class;
    my @classes = values %Types;
    @classes = grep { m/^\Q$this_class\E:/ } @classes;
    push @classes, $this_class;
    \@classes;
}

# Allows registration (or replacement) of an asset type.
sub add_class {
    my $pkg = shift;
    my ($ident, $package) = @_;
    if (exists $Classes{$ident}) {
        delete $Types{$Classes{$ident}};
    }
    $Classes{$ident} = $package;
    $Types{$package} = $ident;
}

sub extensions {
    undef;
}

# This property is a meta-property.
sub url {
    my $asset = shift;
    my $url = $asset->SUPER::url(@_);
    return $url if defined $url;

    return $asset->cache_property(sub {
        my $blog = $asset->blog or return undef;
        my $url = $blog->site_url;
        $url .= '/' unless $url =~ m!/$!;
        my $path = $asset->file_path;
        $path =~ s!\\!/!g;
        $url .= $path;
        $url;
    }, @_);
}

# Returns the package that services a particular asset type. It will also
# make sure this package has been loaded. If the handler of the package
# cannot be found or fails to load, the generic MT::Asset package is returned.
# (For instance, if a plugin that has provided an asset type is no longer
# available, this will at least offer the generic package to access the
# asset.)
sub class_handler {
    my $pkg = shift;
    my ($class) = @_;
    my $package = $Classes{$class};
   if ($package) {
        if (defined *{$package.'::new'}) {
            return $package;
        } else {
            eval "use $package;";
            return $package unless $@;
        }
    }
    __PACKAGE__;
}

# Returns a hashref of asset identifiers mapped to the localized string
# used to name them. (Ie, image => 'Image').
sub class_labels {
    my $pkg = shift;
    my %names;
    foreach (keys %Classes) {
        my $class = $pkg->class_handler($_);
        $names{$class->class} = $class->class_label;
    }
    \%names;
}

# Returns a localized name for the asset type. For MT::Asset, this is simply
# 'File'.
sub class_label {
    MT->translate('File');
}

# Upon loading an object, this routine is called to assign the values to it.
# This is our opportunity to rebless the object based on the asset type.
sub set_values {
    my $obj = shift;
    $obj->SUPER::set_values(@_);
    my $t = $obj->class;
    if (my $pkg = $obj->class_handler($t)) {
        bless $obj, $pkg;
    }
    $obj;
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
# TBD: Should we track and remove any generated thumbnail files here too?
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

sub blog {
    my $asset = shift;
    $asset->cache_property(sub {
        my $blog_id = $asset->blog_id or return undef;
        require MT::Blog;
        MT::Blog->load($blog_id, { cached_ok => 1 });
    });
}

# Returns a true/false response based on whether the active package
# has extensions registered that match the requested filename.
sub can_handle {
    my ($pkg, $filename) = @_;
    # undef is returned from fileparse if the extension is not known.
    require File::Basename;
    return (File::Basename::fileparse($filename, @{ $pkg->extensions }))[2] ? 1 : 0;
}

# Given a filename, returns an appropriate MT::Asset class to associate
# with it. This lookup is based purely on file extension! If none can
# be found, it returns MT::Asset.
sub handler_for_file {
    my $pkg = shift;
    my ($filename) = @_;
    my $classes = $pkg->classes || [];
    foreach my $class (@$classes) {
        my $this_pkg = $pkg->class_handler($class);
        if ($this_pkg->can_handle($filename)) {
            return $this_pkg;
        }
    }
    __PACKAGE__;
}

sub metadata {
    my $asset = shift;
    return {
        MT->translate("Tags") => MT::Tag->join(',', $asset->tags),
        url => $asset->url,
        MT->translate("URL") => $asset->url,
        MT->translate("Location") => $asset->file_path,
        name => $asset->file_name,
        'class' => $asset->class,
        ext => $asset->file_ext,
        mime_type => $asset->mime_type,
        duration => $asset->duration,
    };
}

sub thumbnail_file {
    undef;
}

sub stock_icon_url {
    undef;
}

sub thumbnail_url {
    my $asset = shift;
    my $file_path = $asset->thumbnail_file(@_);
    if ((defined $file_path) && (-f $file_path)) {
        require File::Basename;
        my ($base) = File::Basename::basename($file_path);
        my $url = $asset->url;
        my $file = $asset->file_name;
        $url =~ s/%([A-F0-9]{2})/chr(hex($1))/gei;
        $url =~ s!\Q$file\E$!$base!;
        return $url;
    }
    # Use a stock icon
    return $asset->stock_icon_url(@_);
}

sub as_html {
    my ($self, $q) = @_;
    (my $fname = $self->file_name) =~ s/'/\\'/g;
    my $text = sprintf '<a href="%s">%s</a>', $self->url, $fname;
    return $text;
}

1;

__END__

=head1 NAME

MT::Asset

=head1 SYNOPSIS

    use MT::Asset;

    # Example

=head1 DESCRIPTION

This module provides an object definition for a file that is placed under
MT's control for publishing.

=head1 METHODS

=head2 MT::Asset->new

Constructs a new asset object. The base class is the generic asset object,
which represents a generic file.

=head2 MT::Asset->handler_for_file($filename)

Returns a I<MT::Asset> package suitable for the filename given. This
determination is typically made based on the file's extension.

=head1 AUTHORS & COPYRIGHT

Please see the I<MT> manpage for author, copyright, and license information.

=cut
