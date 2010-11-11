# NOTE: Derived from blib/lib/Image/Size.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Image::Size;

#line 1170 "blib/lib/Image/Size.pm (autosplit into blib/lib/auto/Image/Size/tiffsize.al)"
# tiffsize: size a TIFF image
#
# Contributed by Cloyce Spradling <cloyce@headgear.org>
sub tiffsize
{
    my $stream = shift;

    my ($x, $y, $id) = (undef, undef, 'Unable to determine size of TIFF data');

    my $endian = 'n';           # Default to big-endian; I like it better
    my $header = $READ_IN->($stream, 4);
    if ($header =~ /II\x2a\x00/o)
    {
        # little-endian
        $endian = 'v';
    }

    # Set up an association between data types and their corresponding
    # pack/unpack specification.  Don't take any special pains to deal with
    # signed numbers; treat them as unsigned because none of the image
    # dimensions should ever be negative. (I hope.)
    my @packspec = ( undef,      # nothing (shouldn't happen)
                     'C',        # BYTE (8-bit unsigned integer)
                     undef,      # ASCII
                     $endian,    # SHORT (16-bit unsigned integer)
                     uc $endian, # LONG (32-bit unsigned integer)
                     undef,      # RATIONAL
                     'c',        # SBYTE (8-bit signed integer)
                     undef,      # UNDEFINED
                     $endian,    # SSHORT (16-bit unsigned integer)
                     uc $endian, # SLONG (32-bit unsigned integer)
                     );

    my $offset = $READ_IN->($stream, 4, 4); # Get offset to IFD
    $offset = unpack uc $endian, $offset; # Fix it so we can use it

    my $ifd = $READ_IN->($stream, 2, $offset); # Get num. of directory entries
    my $num_dirent = unpack $endian, $ifd; # Make it useful
    $offset += 2;
    $num_dirent = $offset + ($num_dirent * 12); # Calc. maximum offset of IFD

    # Do all the work
    $ifd = q{};
    my $tag = 0;
    my $type = 0;
    while ((! defined $x) || (! defined$y)) {
        $ifd = $READ_IN->($stream, 12, $offset);   # Get first directory entry
        last if (($ifd eq q{}) || ($offset > $num_dirent));
        $offset += 12;
        $tag = unpack $endian, $ifd;               # ...and decode its tag
        $type = unpack $endian, substr $ifd, 2, 2; # ...and the data type
        # Check the type for sanity.
        next if (($type > @packspec+0) || (! defined $packspec[$type]));
        if ($tag == 0x0100)    # ImageWidth (x)
        {
            # Decode the value
            $x = unpack $packspec[$type], substr $ifd, 8, 4;
        }
        elsif ($tag == 0x0101) # ImageLength (y)
        {
            # Decode the value
            $y = unpack $packspec[$type], substr $ifd, 8, 4;
        }
    }

    # Decide if we were successful or not
    if (defined $x and defined $y)
    {
        $id = 'TIF';
    }
    else
    {
        $id = q{};
        if (! defined $x)
        {
            $id = 'ImageWidth ';
        }
        if (! defined $y)
        {
            if ($id ne q{})
            {
                $id .= 'and ';
            }
            $id .= 'ImageLength ';
        }
        $id .= 'tag(s) could not be found';
    }

    return ($x, $y, $id);
}

# end of Image::Size::tiffsize
1;
