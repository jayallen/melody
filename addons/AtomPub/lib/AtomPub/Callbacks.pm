package AtomPub::Callbacks;

use strict;
use AtomPub::Util qw( make_atom_id );

sub post_save {
    my ( $cb, $entry, $entry_orig ) = @_;
    if ( !$entry->atom_id && ( ( $entry->status || 0 ) != HOLD ) ) {
        $entry->atom_id( make_atom_id( $entry ) );
        $entry->SUPER::save() if $entry->atom_id;
    }
    return 1;
}

1;
