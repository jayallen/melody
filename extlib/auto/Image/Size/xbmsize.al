# NOTE: Derived from blib/lib/Image/Size.pm.
# Changes made here will be lost when autosplit is run again.
# See AutoSplit.pm.
package Image::Size;

#line 992 "blib/lib/Image/Size.pm (autosplit into blib/lib/auto/Image/Size/xbmsize.al)"
sub xbmsize
{
    my $stream = shift;

    my $input;
    my ($x, $y, $id) = (undef, undef, 'Could not determine XBM size');

    $input = $READ_IN->($stream, 1024);
    if ($input =~ /^\#define\s*\S*\s*(\d+)\s*\n\#define\s*\S*\s*(\d+)/ix)
    {
        ($x, $y) = ($1, $2);
        $id = 'XBM';
    }

    return ($x, $y, $id);
}

# end of Image::Size::xbmsize
1;
