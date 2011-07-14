#!/usr/bin/perl
package MT::Plugin::Subfoldered;

use strict;
use warnings;
use base 'MT::Plugin';
our $VERSION = '0.1';

my $plugin;
MT->add_plugin(
                $plugin =
                  __PACKAGE__->new( {
                           name        => 'A Subfoldered Plugin',
                           id          => 'Subfoldered',
                           key         => 'Subfoldered',
                           version     => $VERSION,
                           description => "Subfoldered legacy format plugin",
                           author_name => "Whomever",
                         }
                  )
);

1;
