package MT::Asset::Image;

use base 'MT::Asset';

sub init {
    my $asset = shift;
    $asset->SUPER::init(@_);
    $asset->archive_type('asset:image');
    $asset;
}

sub type {
    'image';
}

sub type_name {
    MT->translate('Image');
}

sub metadata {
    my $obj = shift;
    my %meta = ( height => $obj->image_height, width => $obj->image_width );
    \%meta;
}

1;
