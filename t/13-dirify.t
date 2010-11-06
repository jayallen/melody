#!/usr/bin/perl
# $Id$
use strict;
use warnings;

use lib 't/lib';
use lib 'lib';
use lib 'extlib';

use MT;
use MT::Test;
use MT::Util;

my @tests = ( {
                 text => 'Siegfried & Roy',
                 iso  => 'siegfried_roy',
                 utf8 => 'siegfried_roy',
              },
              {
                 text => 'Cauchy-Schwartz Inequality',
                 iso  => 'cauchy-schwartz_inequality',
                 utf8 => 'cauchy-schwartz_inequality',
              },
              { text => "M\303\272m", utf8 => 'mum', },
              { text => 'foo---bar',  iso  => 'foo_bar', utf8 => 'foo_bar', },
              { text => 'foo - bar',  iso  => 'foo_bar', utf8 => 'foo_bar', },
              { text => 'foo_-_bar',  iso  => 'foo_bar', utf8 => 'foo_bar', },
);

use Test::More 'no_plan';

MT->set_language('en_US');

for my $test (@tests) {
    my ( $text, $iso, $utf8 ) = @{$test}{qw( text iso utf8 )};
    is( MT::Util::iso_dirify($text),
        $iso, "String '$text' iso_dirifies correctly" )
      if $iso;
    is( MT::Util::utf8_dirify($text),
        $utf8, "String '$text' utf8_dirifies correctly" )
      if $utf8;
}

my @hypen_tests = ( {
                       text => 'foo---bar',
                       iso  => 'foo-bar',
                       utf8 => 'foo-bar',
                    },
                    {
                       text => 'foo - bar',
                       iso  => 'foo-bar',
                       utf8 => 'foo-bar',
                    },
                    {
                       text => 'foo_-_bar',
                       iso  => 'foo-bar',
                       utf8 => 'foo-bar',
                    },
);

for my $test (@tests) {
    my ( $text, $iso, $utf8 ) = @{$test}{qw( text iso utf8 )};
    is( MT::Util::iso_dirify( $text, 1 ),
        $iso, "String '$text' iso_dirifies correctly with hypen as sep" )
      if $iso;
    is( MT::Util::utf8_dirify( $text, 1 ),
        $utf8, "String '$text' utf8_dirifies correctly with hypen as sep" )
      if $utf8;
}
