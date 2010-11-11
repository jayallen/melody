# NOTE: Derived from blib/lib/Image/Size.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Image::Size;

#line 1135 "blib/lib/Image/Size.pm (autosplit into blib/lib/auto/Image/Size/ppmsize.al)"
# ppmsize: gets data on the PPM/PGM/PBM family.
#
# Contributed by Carsten Dominik <dominik@strw.LeidenUniv.nl>
sub ppmsize
{
    my $stream = shift;

    my ($x, $y, $id) =
        (undef, undef, 'Unable to determine size of PPM/PGM/PBM data');
    my $n;
    my @table = qw(nil PBM PGM PPM PBM PGM PPM);

    my $header = $READ_IN->($stream, 1024);

    # PPM file of some sort
    $header =~ s/^\#.*//mg;
    if ($header =~ /^(?:P([1-7]))\s+(\d+)\s+(\d+)/)
    {
        ($n, $x, $y) = ($1, $2, $3);

        if ($n == 7)
        {
            # John Bradley's XV thumbnail pics (from inwap@jomis.Tymnet.COM)
            $id = 'XV';
            ($x, $y) = ($header =~ /IMGINFO:(\d+)x(\d+)/s);
        }
        else
        {
            $id = $table[$n];
        }
    }

    return ($x, $y, $id);
}

# end of Image::Size::ppmsize
1;
