# NOTE: Derived from blib/lib/Image/Size.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Image::Size;

#line 1338 "blib/lib/Image/Size.pm (autosplit into blib/lib/auto/Image/Size/swfmxsize.al)"
# swfmxsize: determine size of compressed ShockWave/Flash MX files. Adapted
# from code sent by Victor Kuriashkin <victor@yasp.com>
sub swfmxsize
{
    my $image = shift;

    my $retval = eval {
        local $SIG{__DIE__} = q{};
        require Compress::Zlib;
        1;
    };
    if (! $retval)
    {
        return (undef, undef, "Error loading Compress::Zlib: $@");
    }

    my $header = $READ_IN->($image, 1058);
    my $ver = _bin2int(unpack 'B8', substr $header, 3, 1);

    my ($d, $status) = Compress::Zlib::inflateInit();
    $header = substr $header, 8, 1024;
    $header = $d->inflate($header);

    my $bs = unpack 'B133', substr $header, 0, 9;
    my $bits = _bin2int(substr $bs, 0, 5);
    my $x = int _bin2int(substr $bs, 5+$bits, $bits)/20;
    my $y = int _bin2int(substr $bs, 5+$bits*3, $bits)/20;

    return ($x, $y, 'CWS');
}

# end of Image::Size::swfmxsize
1;
