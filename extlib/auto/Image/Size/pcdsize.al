# NOTE: Derived from blib/lib/Image/Size.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Image::Size;

#line 1315 "blib/lib/Image/Size.pm (autosplit into blib/lib/auto/Image/Size/pcdsize.al)"
# Suggested by Matt Mueller <mueller@wetafx.co.nz>, and based on a piece of
# sample Perl code by a currently-unknown author. Credit will be placed here
# once the name is determined.
sub pcdsize
{
    my $stream = shift;

    my ($x, $y, $id) = (undef, undef, 'Unable to determine size of PCD data');
    my $buffer = $READ_IN->($stream, 0xf00);

    # Second-tier sanity check
    if (substr($buffer, 0x800, 3) ne 'PCD')
    {
        return ($x, $y, $id);
    }

    my $orient = ord(substr $buffer, 0x0e02, 1) & 1; # Clear down to one bit
    ($x, $y) = @{$Image::Size::PCD_MAP{lc $Image::Size::PCD_SCALE}}
        [($orient ? (0, 1) : (1, 0))];

    return ($x, $y, 'PCD');
}

# end of Image::Size::pcdsize
1;
