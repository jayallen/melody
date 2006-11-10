# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Asset::Image;

use base 'MT::Asset';

sub type {
    'asset:image';
}

sub type_name {
    MT->translate('Image');
}

sub metadata {
    my $obj = shift;
    { height => $obj->image_height, width => $obj->image_width };
}

1;
