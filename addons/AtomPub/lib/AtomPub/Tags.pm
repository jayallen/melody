package AtomPub::Tags;

use strict;
use AtomPub::Util qw( make_atom_id );

###########################################################################

=head2 AtomScript

Returns the value of the C<AtomScript> configuration setting. The
default for this setting if unassigned is "atom.cgi".

=over 4

=item * url

Returns the script as a URL value.  For example C<<$mt:AtomScript url="1"$>>
might give you http://example.com/m/atom.cgi

=item * filepath

Returns the script as an absolute filesystem value.  For example
C<<$mt:AtomScript filepath="1"$>> might give you
C</var/www/example.com/htdocs/m/atom.cgi>

=back

=for tags configuration

=cut

sub hdlr_atom_script {
    my ($ctx) = shift;
    return $ctx->_get_script_location( @_, 'AtomScript' );
}

###########################################################################

=head2 EntryAtomID

Outputs the unique Atom ID for the current entry in context.

=cut

sub _hdlr_entry_atom_id {
    my ( $ctx, $args, $cond ) = @_;
    my $e = $ctx->stash('entry') or return $ctx->_no_entry_error();
    return
         $e->atom_id()
      || make_atom_id( $e )
      || $ctx->error(
         MT->translate( "Could not create atom id for entry [_1]", $e->id ) );
}

1;
