package MT::Theme::Util;

use strict;
use base 'Exporter';

our @EXPORT_OK = qw( find_theme_plugin );

sub find_theme_plugin {
    my ($set) = @_;
    for my $sig ( keys %MT::Plugins ) {
        my $plugin = $MT::Plugins{$sig};
        my $obj    = $MT::Plugins{$sig}{object};
        my $r      = $obj->{registry};
        my @sets   = keys %{ $r->{'template_sets'} };
        foreach (@sets) {
            return $obj if ( $set eq $_ );
        }
    }
    return undef;
}

1;
__END__

=head1 NAME

MT::Theme::Util - A utility package for themes in Movable Type and Melody.

=head1 SYNOPSIS

  # Retrieve the MT::Plugin object associated with a given theme
  use MT::Theme::Util qw( find_theme_plugin );
  my $ts_id = 'id_of_a_template_set_or_theme';
  my $plugin = find_theme_plugin( $ts );

=head1 DESCRIPTION

This module provides a convenient interface to the PicApp web service.
It requires that you have been given an API Key by PicApp.

=head1 VERSION CONTROL

L<http://github.com/byrnereese/mt-plugin-theme-export

=head1 AUTHORS and CREDITS

Author: Byrne Reese <byrne@endevver.com>

=cut
