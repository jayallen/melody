# NOTE: Derived from blib/lib/Image/Size.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Image::Size;

#line 850 "blib/lib/Image/Size.pm (autosplit into blib/lib/auto/Image/Size/gifsize.al)"
###########################################################################
# Subroutine gets the size of the specified GIF
###########################################################################
sub gifsize
{
    my $stream = shift;

    my ($cmapsize, $buf, $sh, $sw, $x, $y, $type);

    my $gif_blockskip = sub {
        my ($skip, $blocktype) = @_;
        my ($lbuf);

        $READ_IN->($stream, $skip);        # Skip header (if any)
        while (1)
        {
            if (img_eof($stream))
            {
                return (undef, undef,
                        "Invalid/Corrupted GIF (at EOF in GIF $blocktype)");
            }
            $lbuf = $READ_IN->($stream, 1);  # Block size
            last if ord($lbuf) == 0;         # Block terminator
            $READ_IN->($stream, ord $lbuf);  # Skip data
        }
    };

    if ($GIF_BEHAVIOR > 2)
    {
        return (undef, undef,
                "\$Image::Size::GIF_BEHAVIOR out of range: $GIF_BEHAVIOR");
    }

    # Skip over the identifying string, since we already know this is a GIF
    $type = $READ_IN->($stream, 6);
    if (length($buf = $READ_IN->($stream, 7)) != 7 )
    {
        return (undef, undef, 'Invalid/Corrupted GIF (bad header)');
    }
    ($sw, $sh, $x) = unpack 'vv C', $buf;
    if ($GIF_BEHAVIOR == 0)
    {
        return ($sw, $sh, 'GIF');
    }

    if ($x & 0x80)
    {
        $cmapsize = 3 * (2**(($x & 0x07) + 1));
        if (! $READ_IN->($stream, $cmapsize))
        {
            return (undef, undef,
                    'Invalid/Corrupted GIF (global color map too small?)');
        }
    }

    # Before we start this loop, set $sw and $sh to 0s and use them to track
    # the largest sub-image in the overall GIF.
    $sw = $sh = 0;

  FINDIMAGE:
    while (1)
    {
        if (img_eof($stream))
        {
            # At this point, if we haven't returned then the user wants the
            # largest of the sub-images. So, if $sh and $sw are still 0s, then
            # we didn't see even one Image Descriptor block. Otherwise, return
            # those two values.
            if ($sw and $sh)
            {
                return ($sw, $sh, 'GIF');
            }
            else
            {
                return (undef, undef,
                        'Invalid/Corrupted GIF (no Image Descriptors)');
            }
        }
        $buf = $READ_IN->($stream, 1);
        ($x) = unpack 'C', $buf;
        if ($x == 0x2c)
        {
            # Image Descriptor (GIF87a, GIF89a 20.c.i)
            if (length($buf = $READ_IN->($stream, 8)) != 8)
            {
                return (undef, undef,
                        'Invalid/Corrupted GIF (missing image header?)');
            }
            ($x, $y) = unpack 'x4 vv', $buf;
            return ($x, $y, 'GIF') if ($GIF_BEHAVIOR == 1);
            if ($x > $sw and $y > $sh)
            {
                $sw = $x;
                $sh = $y;
            }
        }
        if ($x == 0x21)
        {
            # Extension Introducer (GIF89a 23.c.i, could also be in GIF87a)
            $buf = $READ_IN->($stream, 1);
            ($x) = unpack 'C', $buf;
            if ($x == 0xF9)
            {
                # Graphic Control Extension (GIF89a 23.c.ii)
                $READ_IN->($stream, 6);    # Skip it
                next FINDIMAGE;       # Look again for Image Descriptor
            }
            elsif ($x == 0xFE)
            {
                # Comment Extension (GIF89a 24.c.ii)
                $gif_blockskip->(0, 'Comment');
                next FINDIMAGE;       # Look again for Image Descriptor
            }
            elsif ($x == 0x01)
            {
                # Plain Text Label (GIF89a 25.c.ii)
                $gif_blockskip->(13, 'text data');
                next FINDIMAGE;       # Look again for Image Descriptor
            }
            elsif ($x == 0xFF)
            {
                # Application Extension Label (GIF89a 26.c.ii)
                $gif_blockskip->(12, 'application data');
                next FINDIMAGE;       # Look again for Image Descriptor
            }
            else
            {
                return (undef, undef,
                        sprintf 'Invalid/Corrupted GIF (Unknown ' .
                                'extension %#x)', $x);
            }
        }
        else
        {
            return (undef, undef,
                    sprintf 'Invalid/Corrupted GIF (Unknown code %#x)', $x);
        }
    }

    return (undef, undef, 'gifsize fell through to the end, error');
}

# end of Image::Size::gifsize
1;
