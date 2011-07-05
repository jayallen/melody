package MT::Plugin::IgnorePerl;

use strict;
use warnings;
use base 'MT::Plugin';
our $VERSION = '1.0';

my $plugin;
MT->add_plugin(
    $plugin =
      __PACKAGE__->new( {
           name    => 'Ignore perl - Perl initialized',
           version => $VERSION,
           description =>
             'Perl-initialized version of a plugin that should be ignored because of the config.yaml',
           author_name => 'Jay Allen',
           key         => 'IgnorePerl',
           id          => 'ignoreperl',
        }
      )
);


use MT::Template::Context;
MT::Template::Context->add_tag( IDontExist => sub {1} );

1;
