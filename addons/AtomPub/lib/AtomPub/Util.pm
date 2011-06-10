package AtomPub::Util;

use strict;

use base 'Exporter';

our @EXPORT_OK
    = qw( make_atom_id );

# TBD: Write a test for this routine
sub make_atom_id {
    my $entry = shift;

    my $blog = $entry->blog;
    my ( $host, $year, $path, $blog_id, $entry_id );
    $blog_id  = $blog->id;
    $entry_id = $entry->id;
    my $url = $blog->site_url || '';
    return unless $url;
    $url .= '/' unless $url =~ m!/$!;
    if ( $url && ( $url =~ m!^https?://([^/:]+)(?::\d+)?(/.*)$! ) ) {
        $host = $1;
        $path = $2;
    }
    if ( $entry->authored_on && ( $entry->authored_on =~ m/^(\d{4})/ ) ) {
        $year = $1;
    }
    return unless $host && $year && $path && $blog_id && $entry_id;
    qq{tag:$host,$year:$path/$blog_id.$entry_id};
} ## end sub make_atom_id

1;

__END__

=head1 NAME

AtomPub::Util - Atom Publishing Protocol utility functions

=head1 SYNOPSIS

    use AtomPub::Util qw( functions );

=head1 DESCRIPTION

I<AtomPub::Util> provides a variety of utility functions used by the Atom
libraries.

=head1 USAGE

=head2 make_atom_id($entry)

Given an I<$entry>, create a unique identifier suitable for use in an atom feed.

=head1 AUTHOR & COPYRIGHTS

Please see the manpage for author, copyright, and license information.

=cut


