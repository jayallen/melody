# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Asset::Image;

use base 'MT::Asset';

# List of supported file extensions (to aid the stock 'can_handle' method.)
sub extensions { [ qr/gif/i, qr/jpe?g/i, qr/png/i, ] }

sub class_label {
    MT->translate('Image');
}

sub metadata {
    my $obj = shift;
    my $meta = $obj->SUPER::metadata(@_);
    $meta->{MT->translate("Actual Dimensions")} = MT->translate("[_1] wide x [_2] high",
        $obj->image_width, $obj->image_height);
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
    $thumbnail = File::Spec->catfile($path, $file . '-thumb-' . $h . 'x' . $w . '.' . $asset->file_ext);
    my @thumbinfo = stat($thumbnail);

    # thumbnail file exists and is dated on or later than source image
    if (@thumbinfo && ($thumbinfo[9] >= $imginfo[9])) {
        return $thumbnail;
    }

    # stale or non-existent thumbnail. let's create one!
    my $blog = $param{Blog};
    $blog ||= MT::Blog->load($asset->blog_id, { cached_ok => 1 });
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
        $n_w = int($i_w * $h / $i_h);
        $n_h = $h;
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
    my $self = shift;
    my %args = @_;
    (my $name = $self->file_name) =~ s/'/\\'/g;
    return sprintf '<img src="%s" height="%d" width="%d" alt="%s" class="%s" />',
        $self->url, $self->image_height, $self->image_width, $name, $args{class};
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
