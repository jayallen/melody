package XMLRPC::Tags;

use strict;

###########################################################################

=head2 XMLRPCScript

Returns the value of the C<XMLRPCScript> configuration setting. The
default for this setting if unassigned is "xmlrpc.cgi".

=over 4

=item * url

Returns the script as a URL value.  For example C<<$mt:XMLRPCScript url="1"$>>
might give you http://example.com/m/xmlrpc.cgi

=item * filepath

Returns the script as an absolute filesystem value.  For example
C<<$mt:XMLRPCScript filepath="1"$>> might give you
C</var/www/example.com/htdocs/m/xmlrpc.cgi>

=back

=for tags configuration

=cut

sub _hdlr_xmlrpc_script {
    my ($ctx) = shift;
    return $ctx->_get_script_location( @_, 'XMLRPCScript' );
}

1;
