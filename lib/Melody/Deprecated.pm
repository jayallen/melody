package Melody::Deprecated;
use strict;
use warnings;

use Attribute::Handlers;

my %done = ();

sub UNIVERSAL::DEPRECATED : ATTR(CODE) {
    my ( $package, $symbol, $referent, $attr, $data ) = @_;
    my $subname = $package . '::' . *{$symbol}{NAME};
    no warnings 'redefine';
    *{$symbol} = sub {
        my ( $cpack, $file, $line ) = caller;
        unless ( $done{"$file:$line"}++ ) {
            warn
              "Call to deprecated routine '$subname' at $file line $line.\n";
        }
        goto &$referent;
    };
}

1;

__END__

=head1 NAME

Melody::Deprecated - Manage and report deprecated code usage in Melody

=head1 SYNOPSIS

  use Melody::Deprecated;

  sub do_something_now obsolete : DEPRECATED {
    ...
  }

=head1 DESCRIPTION

This class enables a developer to mark a method with a 'DEPRECATED' attribute and a warning will be generated when it is called. This is to be used by other developers to clean up and update their code that is calling the obsolete method. It's a little bit easier, and more visually distinctive, to mark the method like this that to insert explicit warnings.

=head1 TO DO

=over

=item Need to hook in to forthcoming logging framework rather than simply relying on warn.

=item Need to add support for handling deprecated tags differently.

=back

=head1 AUTHOR

This module was based on Attribute::Deprecated authored by Marty Pauley E<lt>marty@kasei.comE<gt>, based on code by Marcel GrE<uuml>nauer E<lt>marcel@codewerk.comE<gt> and Damian Conway E<lt>damian@conway.orgE<gt>

=head1 COPYRIGHT

=cut
