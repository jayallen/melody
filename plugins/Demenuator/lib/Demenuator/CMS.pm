
package Demenuator::CMS;

use strict;
use warnings;

sub init_app {
    my ( $cb, $app ) = @_;

    no warnings 'redefine';

    require MT::App::CMS;
    my $core_menus = \&MT::App::CMS::core_menus;
    *MT::App::CMS::core_menus = sub {
        return demenuize( $core_menus->(@_), @_ );
    };

    1;
}

sub demenuize {
    my ( $menus, $app ) = @_;
    
    # touch nothing if current user is a superuser
    # and we're told not to touch their menus
    return $menus
      if ( $app->config->PreserveSuperuserMenus 
           && $app->user 
           && $app->user->is_superuser );

    my $removed_menus      = $app->config->RemovedMenus;
    my $removed_menu_items = $app->config->RemovedMenuItems;

    my %rmenus  = map { $_ => 1 } split( /\s*,\s*/, $removed_menus );
    my %rmitems = map { $_ => 1 } split( /\s*,\s*/, $removed_menu_items );

    my @nixed_keys = ();

    # nix any top levels or full menu items specifically
    # then look for top menu sub items, just in case
    foreach my $k ( keys %$menus ) {
        delete $menus->{$k} if ( exists $rmenus{$k} || exists $rmitems{$k} );
        if ( $k =~ /^([^:]):/ ) {
            delete $menus->{$k} if ( exists $rmenus{$1} );
        }
    }

    return $menus;
}

1;
