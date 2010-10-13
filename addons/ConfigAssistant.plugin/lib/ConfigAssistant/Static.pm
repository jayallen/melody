package ConfigAssistant::Static;

use strict;

use base qw( MT::ErrorHandler );
use MT;
use MT::FileMgr;
use File::Spec;
use File::Find;
use File::Copy::Recursive qw( fcopy );

sub upgrade {
    my $self        = shift;
    my $app         = MT->instance;
    my $static_path = $app->config('StaticFilePath');    

    # Static File Path must be set in order to copy files.
    if ( ! $static_path ) {
        # Static File Path wasn't set--warn the user and abort
        $self->error(
            'The <code>StaticFilePath</code> Configuration '
            .'Directive must be set for static file copy to run.'
        );
        # Always return true so that the upgrade can continue.
        return 1; 
    }

    # We need to look at all plugins and decide if they have registry
    # entries, and therefore static entries.
    for my $sig ( keys %MT::Plugins ) {
        my $plugin         = $MT::Plugins{$sig}{object};
        my $registry       = $plugin->{registry};
        my $static_version = $registry->{'static_version'} || '0';            

        next unless $self->plugin_has_static_upgrade( $plugin );
    
        $self->progress(sprintf( 
            'Copying static files for <strong>%s</strong> '
            .'to mt-static/support/plugins/...', 
            $plugin->name
        ));

        # We use File::Find to act on each found file sending the
        # necessary data to deploy_static_file() to complete the copy
        my $srcdir  = File::Spec->catdir( $plugin->path, 'static' );
        my $destdir = File::Spec->catdir(
            $static_path, 'support', 'plugins', $plugin->id);
        my $find_params = {
            wanted => sub {
                -f && deploy_static_file( $srcdir, 
                                          $File::Find::name, 
                                          $destdir )
            },
        };

        # If we have skip_static entries, we add a File::Find 
        # preprocess argument to weed out matching items
        my $skip = $registry->{'skip_static'} || [];
        if ( @$skip ) {
            my $skip_pat = join('|', map { quotemeta($_) } @$skip);
            $find_params->{preprocess}
                = sub { grep { ! /($skip_pat)/ } @_ };
        }

        # Find them and execute them
        find($find_params, $srcdir);

        # Update mt_config with the new static_version.
        $cfg->set(
            'PluginStaticVersion', 
            join('=', $plugin->id, $static_version),
            1
        );
        $self->progress($self->translate_escape(
            "Plugin '[_1]' upgraded successfully to version [_2] (static version [_3]).", 
            $plugin->label, 
            ($plugin->version || '-'),
            $static_version)
        );
    }
    
    1; # Always...
}

sub plugin_has_static_upgrade {
    my $self     = shift;
    my $plugin   = shift;
    my $registry = $plugin->{registry};
    
    # Grab the plugin's static_version, and check if it's newer than
    # the version currently installed. If it is, then we want to
    # install the static files.
    my $static_version = $registry->{'static_version'} || '0';            
    my $ver = MT->config('PluginStaticVersion'); # The saved version

    # Check to see if $plugin->id is valid. If it's not, we need to 
    # undef $ver so that we don't try to grab the static_version 
    # variable. $plugin->id seems to throw an error for some Six
    # Apart-originated plugins. I don't know why.
    my $plugin_id     = eval {$plugin->id} ? $plugin->id : undef $ver;
    my $saved_version = $ver->{$plugin_id} if $ver;
    # FIXME The above needs to be less clever and more obvious
    # undef() ALWAYS return undefined which means that if $plugin->id is 
    # invalid (I've never seen this btw) then $saved_version will always be
    # undefined which would throw an uninit var warning below. I've added an
    # alternating default value of 0 below to avoid that.
    return ($static_version > ($saved_version || 0));
}

sub deploy_static_file {
    my ($src, $abspath, $dest ) = @_;
    my $relpath      = File::Spec->abs2rel( $abspath, $src );
    my $abspath_dest = File::Spec->catfile( $dest, $relpath );
    fcopy( $abspath, $abspath_dest );
}

1;

__END__
