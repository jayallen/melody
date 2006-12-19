# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Asset::Image;

use strict;
use base 'MT::Asset';

# List of supported file extensions (to aid the stock 'can_handle' method.)
sub extensions { [ qr/gif/i, qr/jpe?g/i, qr/png/i, ] }

sub class_label {
    MT->translate('Image');
}

sub metadata {
    my $obj = shift;
    my $meta = $obj->SUPER::metadata(@_);
    $meta->{MT->translate("Actual Dimensions")} = MT->translate(
        "[_1] wide x [_2] high",
        $obj->image_width, $obj->image_height
    ) if defined $obj->image_width && defined $obj->image_height;
    $meta;
}

sub thumbnail_file {
    my $asset = shift;
    my (%param) = @_;
    my $file_path = $asset->file_path;
    my @imginfo = stat($file_path);
    return undef unless @imginfo;

    my $h = $param{Height};
    my $w = $param{Width};
    require File::Basename;
    my $path = File::Basename::dirname($file_path);
    my $file = $asset->file_name;
    $file =~ s!\.[a-z]+$!!i;
    my $thumbnail = File::Spec->catfile($path, $file . '-thumb-' . $h . 'x' . $w . '.' . $asset->file_ext);
    my @thumbinfo = stat($thumbnail);

    # thumbnail file exists and is dated on or later than source image
    if (@thumbinfo && ($thumbinfo[9] >= $imginfo[9])) {
        return $thumbnail;
    }

    # stale or non-existent thumbnail. let's create one!
    my $blog = $param{Blog} || $asset->blog;
    return undef unless $blog;
    my $fmgr = $blog->file_mgr;
    return undef unless $fmgr;

    # create a thumbnail for this file
    require MT::Image;
    my $img = new MT::Image(Filename => $file_path)
        or return $asset->error(MT::Image->errstr);

    # 100000px wide image, 10px tall => 164x230
    #     scale the horizontal to fit
    # 100000px tall image, 10px wide => 164x230
    #     scale the vertical to fit
    # 100000px wide/tall => 164x164
    #     scale the horizontal to fit

    # find the longest dimension of the image:
    my ($i_h, $i_w) = ($img->{height}, $img->{width});
    my ($n_h, $n_w) = ($i_h, $i_w);
    my $scale = '';
    if ($i_h > $i_w) {
        # scale, if necessary, by height
        if ($i_h > $h) {
            $scale = 'h';
        } elsif ($i_w > $w) {
            $scale = 'w';
        }
    } else {
        # scale, if necessary, by width
        if ($i_w > $w) {
            $scale = 'w';
        } elsif ($i_h > $h) {
            $scale = 'h';
        }
    }
    if ($scale eq 'h') {
        # scale by height
        $n_h = $h;
        $n_w = int($i_w * $h / $i_h);
        if ($n_w > $w) {
            $n_w = $w;
            $n_h = int($i_h * $w / $i_w);
        }
    } elsif ($scale eq 'w') {
        # scale by width
        $n_w = $w;
        $n_h = int($i_h * $w / $i_w);
    }

    my ($data) = $img->scale(Height => $n_h, Width => $n_w)
        or return $asset->error(MT->translate("Error scaling image: [_1]", $img->errstr));
    $fmgr->put_data($data, $thumbnail, 'upload')
        or return $asset->error(MT->translate("Error creating thumbnail file: [_1]", $fmgr->errstr));
    return $thumbnail;
}

sub as_html {
    my $asset = shift;
    my ($param) = @_;

    my $text = '';

    my $fname = $asset->file_name;
    require MT::Util;

    my $thumb = undef;
    if ($param->{thumb}) {
        $thumb = MT::Asset->load($param->{thumb_asset_id}) ||
            return $asset->error(
                MT->translate("Can't load asset #[_1]",
                    $param->{thumb_asset_id})
            );
    }

    my $dimensions = sprintf('width="%s" height="%s"', ($thumb
        ? ($thumb->image_width, $thumb->image_height)
        : ($asset->image_width, $asset->image_height)));

    if ($param->{popup}) {
        my $link = $thumb
            ? sprintf('<img src="%s" %s alt="%s" />',
                MT::Util::encode_html($thumb->url),
                $dimensions,
                MT::Util::encode_html($fname),
              )
            : MT->translate('View image');
        $text = sprintf(
            q|<a href="%s" onclick="window.open('%s','popup','width=%d,height=%d,scrollbars=no,resizable=no,toolbar=no,directories=no,location=no,menubar=no,status=no,left=0,top=0'); return false">%s</a>|,
            MT::Util::encode_html($asset->url),
            MT::Util::encode_html($asset->url),
            $asset->image_width, $asset->image_height, $link,
        );
    } elsif ($param->{include}) {
        my $wrap_style = $param->{wrap_text} && $param->{align}
            ? 'class="display_img_' . $param->{align} . '" ' : '';
        if ($param->{thumb}) {
            $text = sprintf(
                '<a href="%s"><img alt="%s" src="%s" %s %s/></a>',
                MT::Util::encode_html($asset->url),
                MT::Util::encode_html($fname),
                MT::Util::encode_html($thumb->url),
                $dimensions, $wrap_style,
            );
        } else {
            $text = sprintf(
                '<img alt="%s" src="%s" %s %s/>',
                MT::Util::encode_html($fname),
                MT::Util::encode_html($asset->url),
                $dimensions, $wrap_style,
            );
        }
    } else {
        $text = sprintf('<a href="%s">%s</a>',
            MT::Util::encode_html($asset->url),
            MT->translate('Download file'),
        );
    }

    return $text;
}

# Return a HTML snippet of form options for inserting this asset
# into a web page. Default behavior is no options.
sub insert_options {
    my $asset = shift;
    my ($param) = @_;

    my $app = MT->instance;
    my $perms = $app->{perms};
    my $blog = $asset->blog or return;

    eval { require MT::Image; MT::Image->new or die; };
    $param->{do_thumb} = $@ ? 0 : 1;

    $param->{can_save_image_defaults} = $perms->can_save_image_defaults ? 1 : 0;
    $param->{constrain} = $blog->image_default_constrain ? 1 : 0;
    $param->{popup} = $blog->image_default_popup ? 1 : 0;
    $param->{image_defaults} = $blog->image_default_set ? 1 : 0;
    $param->{wrap_text} = $blog->image_default_wrap_text ? 1 : 0;
    $param->{make_thumb} = $blog->image_default_thumb ? 1 : 0;
    $param->{'align_'.$_} = $blog->image_default_align eq $_ ? 1 : 0
        for qw(left center right);
    $param->{'unit_w'.$_} = $blog->image_default_wunits eq $_ ? 1 : 0
        for qw(percent pixels);
    $param->{'unit_h'.$_} = $blog->image_default_hunits eq $_ ? 1 : 0
        for qw(percent pixels);
    $param->{thumb_width} = $blog->image_default_width || $asset->image_width || 0;
    $param->{thumb_height} = $blog->image_default_height || $asset->image_height || 0;

    return $app->build_page('asset_image_options.tmpl', $param);
}

sub on_upload {
    my $asset = shift;
    my ($param) = @_;

    my $app = MT->instance;
    require MT::Util;

    my $url = $asset->url;
    my $width = $asset->image_width;
    my $height = $asset->image_height;

    my ($base_url, $fname) = $url =~ m|(.*)/([^/]*)|;
    $url = $base_url . '/' . $fname; # no need to re-encode filename; url is already encoded
    my $blog = $asset->blog or return;
    my $blog_id = $blog->id;

    my($thumb, $thumb_width, $thumb_height);
    if($param->{image_defaults}) {
        return $app->error($app->translate(
            'Permission denied setting image defaults for blog #[_2]', $blog_id
        )) unless $app->{perms}->can_save_image_defaults;
        # Save new defaults if requested.
        $blog->image_default_set(1);
        $blog->image_default_wrap_text($param->{wrap_text} ? 1 : 0);
        $blog->image_default_align($param->{align} || MT::Blog::ALIGN());
        $blog->image_default_thumb($param->{thumb} ? 1 : 0);
        $blog->image_default_width($param->{thumb_width} || MT::Blog::WIDTH());
        $blog->image_default_wunits($param->{thumb_width_type} || MT::Blog::UNITS());
        $blog->image_default_height($param->{thumb_height} || MT::Blog::WIDTH());
        $blog->image_default_hunits($param->{thumb_height_type} || MT::Blog::UNITS());
        $blog->image_default_constrain($param->{constrain} ? 1 : 0);
        $blog->image_default_popup($param->{popup} ? 1 : 0);
        $blog->save;
    }

    # Thumbnail creation
    if ($thumb = $param->{thumb}) {
        require MT::Image;
        my $base_path = $param->{site_path} ?
            $blog->site_path : $blog->archive_path;
        my $file = $param->{fname};
        if ($file =~ m!\.\.|\0|\|!) {
            return $app->error($app->translate("Invalid filename '[_1]'", $file));
        }
        my $i_file = File::Spec->catfile($base_path, $file);
        ## Untaint. We checked $file for security holes above.
        ($i_file) = $i_file =~ /(.+)/s;
        my $fmgr = $blog->file_mgr;
        my $data = $fmgr->get_data($i_file, 'upload')
            or return $app->error($app->translate(
                "Reading '[_1]' failed: [_2]", $i_file, $fmgr->errstr));
        my $image_type = scalar $param->{image_type};
        my $img = MT::Image->new( Data => $data,
                                  Type => $image_type )
            or return $app->error($app->translate(
                "Thumbnail failed: [_1]", MT::Image->errstr));
        my($w, $h) = map $param->{$_}, qw( thumb_width thumb_height );
        (my($blob), $thumb_width, $thumb_height) =
            $img->scale( Width => $w, Height => $h )
            or return $app->error($app->translate("Thumbnail failed: [_1]",
                $img->errstr));
        require File::Basename;
        my($base, $path, $ext) = File::Basename::fileparse($i_file, '\.[^.]*');
        my $t_file = $path . $base . '-thumb' . $ext;
        my $basename = $base . '-thumb' . $ext;
        ## If the thumbnail filename already exists, we don't want to overwrite
        ## it, because it could contain valuable data; so we'll just make
        ## sure to generate the name uniquely.
        my $i = 0;
        while ($fmgr->exists($t_file)) {
            $t_file = File::Spec->catfile($path . $base . '-thumb' . (++$i) . $ext);
        }
        $fmgr->put_data($blob, $t_file, 'upload')
            or return $app->error($app->translate(
                "Error writing to '[_1]': [_2]", $t_file, $fmgr->errstr));

        $file =~ s/\Q$base$ext\E$//;
        my $url = $param->{site_path} ? $blog->site_url : $blog->archive_url;
        $url .= '/' unless $url =~ m!/$!;
        $url .= $file;
        $thumb = $url . MT::Util::encode_url($base . '-thumb' . $ext);

        my $img_pkg = MT::Asset->class_handler('image');
        my $asset_thumb = new $img_pkg;
        my $original = $asset_thumb->clone;
        $asset_thumb->blog_id($blog_id);
        $asset_thumb->url($thumb);
        $asset_thumb->file_path($t_file);
        $asset_thumb->file_name($basename);
        my $ext2 = $ext;
        $ext2 =~ s/^\.//;
        $asset_thumb->file_ext($ext2);
        $asset_thumb->image_width($thumb_width);
        $asset_thumb->image_height($thumb_height);
        $asset_thumb->created_by($app->user->id);
        $asset_thumb->save;
        MT->run_callbacks('CMSPostSave.asset', $app, $asset_thumb, $original);

        $param->{thumb_asset_id} = $asset_thumb->id;

        MT->run_callbacks('CMSUploadFile.thumbnail',
                          File => $t_file, Url => $thumb, Size => length($blob),
                          Asset => $asset_thumb,
                          Type => 'thumbnail',
                          Blog => $blog);

        MT->run_callbacks('CMSUploadImage.thumbnail',
                          File => $t_file, Url => $thumb,
                          Asset => $asset_thumb,
                          Width => $thumb_width, Height => $thumb_height,
                          ImageType => $image_type,
                          Size => length($blob),
                          Type => 'thumbnail',
                          Blog => $blog);
    }
    if ($param->{popup}) {
        require MT::Template;
        if (my $tmpl = MT::Template->load({ blog_id => $blog_id,
                                            type => 'popup_image' })) {
            (my $rel_path = $param->{fname}) =~ s!\.[^.]*$!!;
            if ($rel_path =~ m!\.\.|\0|\|!) {
                return $app->error($app->translate(
                    "Invalid basename '[_1]'", $rel_path));
            }
            my $ext = $blog->file_extension || '';
            $ext = '.' . $ext if $ext ne '';
            require MT::Template::Context;
            my $ctx = MT::Template::Context->new;
            $ctx->stash('blog', $blog);
            $ctx->stash('blog_id', $blog->id);
            $ctx->stash('asset', $asset);
            $ctx->stash('image_url', $url);
            $ctx->stash('image_width', $width);
            $ctx->stash('image_height', $height);
            my $popup = $tmpl->build($ctx) or die $tmpl->errstr;
            my $fmgr = $blog->file_mgr;
            my $root_path = $param->{site_path} ?
                $blog->site_path : $blog->archive_path;
            my $abs_file_path = File::Spec->catfile($root_path, $rel_path . $ext);

            ## If the popup filename already exists, we don't want to overwrite
            ## it, because it could contain valuable data; so we'll just make
            ## sure to generate the name uniquely.
            my($i, $rel_path_ext) = (0, $rel_path . $ext);
            while ($fmgr->exists($abs_file_path)) {
                $rel_path_ext = $rel_path . ++$i . $ext;
                $abs_file_path = File::Spec->catfile($root_path, $rel_path_ext);
            }
            my ($vol, $dirs, $basename) = File::Spec->splitpath($rel_path_ext);
            my $rel_url_ext = File::Spec->catpath($vol, $dirs, MT::Util::encode_url($basename));
 
            ## Untaint. We have checked for security holes above, so we
            ## should be safe.
            ($abs_file_path) = $abs_file_path =~ /(.+)/s;
            $fmgr->put_data($popup, $abs_file_path, 'upload')
                or return $app->error($app->translate(
                   "Error writing to '[_1]': [_2]", $abs_file_path,
                                                     $fmgr->errstr));
            $url = $param->{site_path} ?
                $blog->site_url : $blog->archive_url;
            $url .= '/' unless $url =~ m!/$!;
            $rel_url_ext =~ s!^/!!;
            $url .= $rel_url_ext;

            my $html_pkg = MT::Asset->handler_for_file($abs_file_path);
            my $asset_html = new $html_pkg;
            my $original = $asset_html->clone;
            $asset_html->blog_id($blog_id);
            $asset_html->url($url);
            $asset_html->file_path($abs_file_path);
            $asset_html->file_name($basename);
            $asset_html->file_ext($blog->file_extension);
            $asset_html->created_by($app->user->id);
            $asset_html->save;
            MT->run_callbacks('CMSPostSave.asset', $app, $asset_html, $original);

            MT->run_callbacks('CMSUploadFile.popup',
                          File => $abs_file_path, Url => $url,
                          Asset => $asset_html,
                          Size => length($popup),
                          Type => 'popup',
                          Blog => $blog);
        }
    }
    1;
}

1;

__END__

=head1 NAME

MT::Asset::Image

=head1 SYNOPSIS

    use MT::Asset::Image;

    # Example

=head1 DESCRIPTION

=head1 METHODS

=head2 MT::Asset::Image->class

Returns 'image', the identifier for this particular class of asset.

=head2 MT::Asset::Image->class_label

Returns the localized descriptive name for this type of asset.

=head2 MT::Asset::Image->extensions

Returns an arrayref of file extensions that are supported by this
package.

=head2 $asset->metadata

Returns a hashref of metadata values for this asset.

=head2 $asset->thumbnail_file(%param)

Creates or retrieves the file path to a thumbnail image appropriate for
the asset. If a thumbnail cannot be created, this routine will return
undef.

=head2 $asset->as_html

Return the HTML I<IMG> element with the image asset attributes.

=head1 AUTHOR & COPYRIGHT

Please see the L<MT/"AUTHOR & COPYRIGHT"> for author, copyright, and
license information.

=cut
