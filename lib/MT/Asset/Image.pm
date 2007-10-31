# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id: Image.pm 987 2006-12-27 07:25:12Z fumiakiy $

package MT::Asset::Image;

use strict;
use base qw( MT::Asset );

__PACKAGE__->install_properties({
    class_type => 'image',
});
__PACKAGE__->install_meta({
    columns => [
        'image_width',
        'image_height',
    ],
});

# List of supported file extensions (to aid the stock 'can_handle' method.)
sub extensions { [ qr/gif/i, qr/jpe?g/i, qr/png/i, ] }

sub class_label {
    MT->translate('Image');
}

sub class_label_plural {
    MT->translate('Images');
}

sub metadata {
    my $obj = shift;
    my $meta = $obj->SUPER::metadata(@_);
    $meta->{MT->translate("Actual Dimensions")} = MT->translate(
        "[_1] wide, [_2] high",
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

    my $blog = $param{Blog} || $asset->blog;
    return undef unless $blog;
    my $fmgr;

    require MT::Util;
    my $asset_cache_path = File::Spec->catdir($blog->site_path,
        MT->config('AssetCacheDir'));
    if (!-d $asset_cache_path) {
        $fmgr = $blog->file_mgr;
        $fmgr->mkpath($asset_cache_path) or return undef;
    }

    my $file = $asset->thumbnail_filename(@_);
    my $thumbnail = File::Spec->catfile($asset_cache_path, $file);
    my @thumbinfo = stat($thumbnail);

    # thumbnail file exists and is dated on or later than source image
    if (@thumbinfo && ($thumbinfo[9] >= $imginfo[9])) {
        return $thumbnail;
    }

    # stale or non-existent thumbnail. let's create one!
    $fmgr ||= $blog->file_mgr;
    return undef unless $fmgr;

    return undef unless $fmgr->can_write($asset_cache_path);

    # 100000px wide image, 10px tall => 164x230
    #     scale the horizontal to fit
    # 100000px tall image, 10px wide => 164x230
    #     scale the vertical to fit
    # 100000px wide/tall => 164x164
    #     scale the horizontal to fit

    my $h = $param{Height};
    my $w = $param{Width};

    # find the longest dimension of the image:
    my ($i_h, $i_w) = ($asset->image_height, $asset->image_width);
    return undef unless $i_h && $i_w;

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

    my $data;
    if (($n_w == $i_w) && ($n_h == $i_h)) {
        $data = $fmgr->get_data($file_path, 'upload');
    } else {
        # create a thumbnail for this file
        require MT::Image;
        my $img = new MT::Image(Filename => $file_path)
            or return $asset->error(MT::Image->errstr);

        ($data) = $img->scale(Height => $n_h, Width => $n_w)
            or return $asset->error(MT->translate("Error scaling image: [_1]", $img->errstr));
    }
    $fmgr->put_data($data, $thumbnail, 'upload')
        or return $asset->error(MT->translate("Error creating thumbnail file: [_1]", $fmgr->errstr));
    return $thumbnail;
}

sub thumbnail_filename {
    my $asset = shift;
    my (%param) = @_;

    require MT::Util;
    my $signature = sprintf 'height:%d;width:%d',
        $param{Height}, $param{Width};
    my $suffix = MT::Util::perl_sha1_digest_hex($signature);
    return $asset->id . '.' . $suffix . '.' . $asset->file_ext;
}

sub as_html {
    my $asset = shift;
    my ($param) = @_;
    my $text = '';

    if ($param->{include}) {

        my $fname = $asset->file_name;
        require MT::Util;

        my $thumb = undef;
        if ($param->{thumb}) {
            $thumb = MT::Asset->load($param->{thumb_asset_id}) ||
                return $asset->error(
                    MT->translate("Can't load image #[_1]",
                        $param->{thumb_asset_id})
                );
        }

        my $dimensions = sprintf('width="%s" height="%s"', ($thumb
            ? ($thumb->image_width, $thumb->image_height)
            : ($asset->image_width, $asset->image_height)));
        my $wrap_style = '';
        if ($param->{wrap_text} && $param->{align}) {
            $wrap_style = 'class="mt-image-' . $param->{align} . '" ';
            if ($param->{align} eq 'left') {
                $wrap_style .= q{style="float: left; margin: 0 20px 20px 0;"};
            } elsif ($param->{align} eq 'right') {
                $wrap_style .= q{style="float: right; margin: 0 0 20px 20px;"};
            } elsif ($param->{align} eq 'center') {
                $wrap_style .= q{style="text-align: center; display: block; margin: 0 auto 20px;"};
            }
        }

        if ($param->{popup}) {
            my $popup = MT::Asset->load($param->{popup_asset_id}) ||
                return $asset->error(
                    MT->translate("Can't load image #[_1]",
                        $param->{popup_asset_id})
                );
            my $link = $thumb
                ? sprintf('<img src="%s" %s alt="%s" %s />',
                    MT::Util::encode_html($thumb->url),
                    $dimensions,
                    MT::Util::encode_html($asset->label),
                    $wrap_style
                  )
                : MT->translate('View image');
            $text = sprintf(
                q|<a href="%s" onclick="window.open('%s','popup','width=%d,height=%d,scrollbars=no,resizable=no,toolbar=no,directories=no,location=no,menubar=no,status=no,left=0,top=0'); return false">%s</a>|,
                MT::Util::encode_html($popup->url),
                MT::Util::encode_html($popup->url),
                $asset->image_width, $asset->image_height, $link,
            );
        } else {
            if ($param->{thumb}) {
                $text = sprintf(
                    '<a href="%s"><img alt="%s" src="%s" %s %s/></a>',
                    MT::Util::encode_html($asset->url),
                    MT::Util::encode_html($asset->label),
                    MT::Util::encode_html($thumb->url),
                    $dimensions, $wrap_style,
                );
            } else {
                 $text = sprintf(
                    '<img alt="%s" src="%s" %s %s/>',
                    MT::Util::encode_html($asset->label),
                    MT::Util::encode_html($asset->url),
                    $dimensions, $wrap_style,
                );
            }
        }
    } else {
        $text = sprintf('<a href="%s">%s</a>',
            MT::Util::encode_html($asset->url),
            MT->translate('View image'),
        );
    }

    return $asset->enclose($text);
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
    #$param->{constrain} = $blog->image_default_constrain ? 1 : 0;
    $param->{popup} = $blog->image_default_popup ? 1 : 0;
    $param->{wrap_text} = $blog->image_default_wrap_text ? 1 : 0;
    $param->{make_thumb} = $blog->image_default_thumb ? 1 : 0;
    $param->{'align_'.$_} = ($blog->image_default_align || 'left') eq $_ ? 1 : 0
        for qw(left center right);
    $param->{'unit_w'.$_} = ($blog->image_default_wunits || 'pixels') eq $_ ? 1 : 0
        for qw(percent pixels);
    $param->{thumb_width} = $blog->image_default_width || $asset->image_width || 0;

    return $app->build_page('dialog/asset_options_image.tmpl', $param);
}

sub on_upload {
    my $asset = shift;
    my ($param) = @_;

    $asset->SUPER::on_upload(@_);

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
    $thumb_width = $param->{thumb_width};
    $thumb = $param->{thumb};
    if ($thumb) {
        if ($thumb_width && ($thumb_width !~ m/^\d+$/)) {
            undef $thumb_width;
        }
        # width > 1000 not really a thumbnail, so consider invalid
        if ($thumb_width > 1000) {
            undef $thumb_width;
        }
    }
    if ($thumb && !$thumb_width) {
        undef $thumb;
    }
    if ($param->{image_defaults}) {
        return $app->error($app->translate(
            'Permission denied setting image defaults for blog #[_1]', $blog_id
        )) unless $app->{perms}->can_save_image_defaults;
        # Save new defaults if requested.
        $blog->image_default_wrap_text($param->{wrap_text} ? 1 : 0);
        $blog->image_default_align($param->{align} || MT::Blog::ALIGN());
        if ($thumb) {
            $blog->image_default_thumb(1);
            $blog->image_default_width($thumb_width);
            $blog->image_default_wunits($param->{thumb_width_type} || MT::Blog::UNITS());
        } else {
            $blog->image_default_thumb(0);
            $blog->image_default_width(0);
            $blog->image_default_wunits(MT::Blog::UNITS());
        }
        #$blog->image_default_constrain($param->{constrain} ? 1 : 0);
        $blog->image_default_popup($param->{popup} ? 1 : 0);
        $blog->save or die $blog->errstr;
    }

    # Thumbnail creation
    if ($thumb = $param->{thumb}) {
        require MT::Image;
        my $image_type = scalar $param->{image_type};
        my($w, $h) = map $param->{$_}, qw( thumb_width thumb_height );
        my $thumbnail = $asset->thumbnail_file(Height => $h, Width => $w)
            or return $app->error($app->translate(
                "Thumbnail failed: [_1]", MT::Asset->errstr));
        my($base, $path, $ext) = File::Basename::fileparse($thumbnail, qr/[A-Za-z0-9]+$/);
        my $thumbnail_url = $asset->thumbnail_url(Height => $h, Width => $w);
        my $thumb_file_size = (stat($thumbnail))[7];
        my $img_pkg = MT::Asset->handler_for_file($thumbnail);
        my $asset_thumb = new $img_pkg;
        my $original = $asset_thumb->clone;
        $asset_thumb->blog_id($blog_id);
        $asset_thumb->url($thumbnail_url);
        $asset_thumb->file_path($thumbnail);
        $asset_thumb->file_name("$base$ext");
        $asset_thumb->file_ext($ext);
        $asset_thumb->image_width($w);
        $asset_thumb->image_height($h);
        $asset_thumb->created_by($app->user->id);
        $asset_thumb->parent($asset->id);
        $asset_thumb->save;
        $app->run_callbacks('cms_post_save.asset', $app, $asset_thumb, $original);

        $param->{thumb_asset_id} = $asset_thumb->id;

        $app->run_callbacks('cms_upload_file.' . $asset_thumb->class,
                          File => $thumbnail, file => $thumbnail,
                          Url => $thumbnail_url, url => $thumbnail_url,
                          Size => $thumb_file_size, size => $thumb_file_size,
                          Asset => $asset_thumb, asset => $asset_thumb,
                          Type => 'thumbnail', type => 'thumbnail',
                          Blog => $blog, blog => $blog);

        $app->run_callbacks('cms_upload_image',
                          File => $thumbnail, file => $thumbnail,
                          Url => $thumbnail_url, url => $thumbnail_url,
                          Asset => $asset_thumb, asset => $asset_thumb,
                          Width => $w, width => $w,
                          Height => $h, height => $h,
                          ImageType => $image_type, image_type => $image_type,
                          Size => $thumb_file_size, size => $thumb_file_size,
                          Type => 'thumbnail', type => 'thumbnail',
                          Blog => $blog, blog => $blog);
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
            $asset_html->parent($asset->id);
            $asset_html->save;

            $param->{popup_asset_id} = $asset_html->id;

            $app->run_callbacks('cms_post_save.asset', $app, $asset_html, $original);

            $app->run_callbacks('cms_upload_file.' . $asset_html->class,
                File => $abs_file_path, file => $abs_file_path,
                Url => $url, url => $url,
                Asset => $asset_html, asset => $asset_html,
                Size => length($popup), size => length($popup),
                Type => 'popup', type => 'popup',
                Blog => $blog, blog => $blog);
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
