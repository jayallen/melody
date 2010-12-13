package MT::ComponentMgr;

use strict;
use warnings;
use base qw( Class::Accessor::Fast MT::ErrorHandler );
use List::Util qw( first );

__PACKAGE__->mk_accessors(qw( base_path search_paths _components ));


Given the search paths, find all plugin init files



sub find_init_files {
    my $self = shift;
    
}

sub init_components {
    my $self = shift;
    my $args = shift;
    # type, use_plugins, plugin_switch
}

=head2 $componentmgr->component( ID || \%args )

Returns a single component matching the specified ID or the criteria in
C<%args>. This is intended for use when you are sure that only one component
should match which means that you should usually be specifying the component's
ID. In fact, the method is optimized for this and a single, scalar argument is
assumed to be a component ID. See section on component metadata for details on
other valid keys.

If you can expect more than one component to be returned, you should use the
C<components> method instead which takes the same exact argument hash.

=cut
sub component {
    my $self   = shift;
    my $args   = shift or return;
    my $cstore = $self->_components;
    $args->{id} = $args unless 'HASH' eq ref $args;
    return first { defined($_) } @{ $self->components( $args ) };
}

=head2 $componentmgr->components( \%args )

Like the C<component> method, this method takes either a reference to an
argument hash or a single scalar argument representing criteria for a
component search. Unlike it, however, it returns all components that match the
criteria and the single scalar argument form is assumed to be a C<type>
parameter.

See the section on Component metadata for details on valid search keys.

=cut
sub components {
    my $self   = shift;
    my $args   = shift;
    my $cstore = $self->_components;
    $args->{type} = $args if $args and ref $args ne 'HASH';

    return $cstore unless $args;

    my @comps;
    foreach my $c ( @$cstore ) {
        next if grep { $c->{$_} ne $args->{$_} } keys %$args;
        push( @comps, $c );
    }
    return wantarray ? @comps : \@comps;
}

1;

__END__

NEED TO WORK MOST OR ALL OF THE FOLLOWING INTO THE CLASS

sub component_libdirs {
    
}

# # Plugin is a file, add it to list for processing
# push @{ $plugins{$type} }, {
#     label => $label,              # used only by packs
#     id    => lc($label),          # used only by packs
#     type  => $type,
#     base  => $plugin_full_path,
#     dir   => $plugin_dir,
#     file  => $file,
#     sig   => $sig,
# 
#     # TODO: remove following comment if app is stable
#     # Changed from $plugin_file because load_tmpl was failing
#     path     => $plugin_full_path,
#     envelope => "$plugin_lastdir/" . $plugin_dir,

sub add_component {
    my $self = shift;
    my ($plugin) = @_;
    my $cstore = $self->_components;
    ###l4p $logger ||= MT::Log::Log4perl->new(); $logger->trace();
    ###l4p $logger->debug('$plugin in add_plugin: ', l4mtdump($plugin));
    
    id
    type
    object
    plugin_sig
    name
    full_path
    envelope
    
    
    if ( ref $plugin eq 'HASH' ) {
        require MT::Plugin;
        $plugin = new MT::Plugin($plugin);
    }
    $plugin->{name} ||= $plugin_sig;
    $plugin->{plugin_sig} = $plugin_sig;

    my $id = $plugin->id;
    unless ($plugin_envelope) {
        warn
          "MT->add_plugin improperly called outside of MT plugin load loop.";
        return;
    }
    ###l4p $logger->debug('Setting plugin_envelope to $plugin_envelope');

    $plugin->envelope($plugin_envelope);
    Carp::confess(
        "You cannot register multiple plugin objects from a single script. $plugin_sig"
      )
      if exists( $Plugins{$plugin_sig} )
          && ( exists $Plugins{$plugin_sig}{object} );

    $Components{ lc $id } = $plugin if $id;
    $Plugins{$plugin_sig}{object} = $plugin;
    $plugin->{full_path} = $plugin_full_path;
    $plugin->path($plugin_full_path);
    unless ( $plugin->{registry} && ( %{ $plugin->{registry} } ) ) {
        $plugin->{registry} = $plugin_registry;
    }
    if ( $plugin->{registry} ) {
        if ( my $settings = $plugin->{registry}{config_settings} ) {
            $settings = $plugin->{registry}{config_settings} = $settings->()
              if ref($settings) eq 'CODE';
            $class->config->define($settings) if $settings;
        }
        if ( my $class = $plugin->{registry}{plugin_class} ) {
            eval "require $class;";
            if ($@) {
                MT->log( {
                       message =>
                         MT->translate(
                           "Could not rebless '[_2]'. Could not find plugin class: [_1]",
                           $class,
                           $plugin->name
                         ),
                       class => 'system',
                       level => MT->model('log')->ERROR(),
                    }
                );
            }
            else {
                bless $plugin, $class;
            }
        }
    } ## end if ( $plugin->{registry...})
    push @Components, $plugin;
    1;
} ## end sub add_plugin

package MT::Component::Respository::FileNext;

package MT::Component::Respository::FindFileRule;

package MT::Component::Respository::Glob;

use File::Glob qw( :glob :nocase );

__PACKAGE__->mk_classdata(
        GlobFlags => GLOB_MARK | GLOB_NOCASE | GLOB_QUOTE | GLOB_ALPHASORT );

chdir("/Users/jay/code/omt/openmelody");

our @plugin_files = __PACKAGE__->search( \@search_paths );

sub search {
    my $pkg   = shift;
    my $paths = shift;
    my $patts = [ "*/*.yaml", "*/*.pl" ];
    my @found = $pkg->SUPER::search( $patta, $paths ));


    PATH: foreach my $path ( @$paths ) {
      EXT: foreach my $ext ( qw( yaml pl )) {
        push( @found, $pkg->SUPER::search( "$path/*/*.$ext" ));
        
            map { bsd_glob("$path/*/*.$_", $pkg->GlobFlags) } qw( yaml pl )
            
        }
        );
    }
    
}

1;



# use Data::Dumper;
sub init_addons {
    my $mt     = shift;
    ###l4p $logger ||= MT::Log::Log4perl->new(); $logger->trace();
    my $cfg    = $mt->config;
    my $addons = $mt->find_addons('pack');
    ###l4p $logger->debug('After find_addons("pack"): ', l4mtdump($addons));
    return $mt->_init_plugins_core( {}, 1, $addons );
}

sub init_plugins {
    my $mt = shift;
    ###l4p $logger ||= MT::Log::Log4perl->new(); $logger->trace();

    # Load compatibility module for prior version
    # This should always be MT::Compat::v(MAJOR_RELEASE_VERSION - 1).
    require MT::Compat::v3;

    my $cfg          = $mt->config;
    my $use_plugins  = $cfg->UsePlugins;
    my $PluginSwitch = $cfg->PluginSwitch || {};
    ###l4p $logger->debug('$PluginSwitch: ', l4mtdump($PluginSwitch));

    my $plugins      = $mt->find_addons('plugin');
    ###l4p $logger->debug('After find_addons("plugin"): ', l4mtdump($plugins));
    return $mt->_init_plugins_core( $PluginSwitch, $use_plugins, $plugins );
}

sub _init_plugins_core {
    my $mt = shift;
    my ( $PluginSwitch, $use_plugins, $plugins ) = @_;
    ###l4p $logger ||= MT::Log::Log4perl->new(); $logger->trace();

    my $timer;
    if ( $mt->config->PerformanceLogging ) {
        $timer = $mt->get_timer();
    }

    # TODO Refactor/abstract this load_plugin anonymous subroutine out of here
    # For testing purposes and maintainability, we need to make it a point
    # to continually make large methods like this smaller and more focused.
    my $load_plugin = sub {
        my ( $plugin, $sig ) = @_;
        die "Bad plugin filename '$plugin'"
          if ( $plugin !~ /^([-\\\/\@\:\w\.\s~]+)$/ );
        local $plugin_sig      = $plugin->{sig};
        # local $plugin_sig      = $sig;
        ###l4p $logger->debug('$plugin_sig: '.$plugin_sig);
        local $plugin_registry = {};
        $plugin = $1;
        if (
             !$use_plugins
             || ( exists $PluginSwitch->{$plugin_sig}
                  && !$PluginSwitch->{$plugin_sig} )
          )
        {
            $Plugins{$plugin_sig}{full_path} = $plugin_full_path;
            $Plugins{$plugin_sig}{enabled}   = 0;
            return 0;
        }
        return 0 if exists $Plugins{$plugin_sig};
        $Plugins{$plugin_sig}{full_path} = $plugin_full_path;
        $timer->pause_partial if $timer;
        eval "# line " 
          . __LINE__ . " " 
          . __FILE__
          . "\nrequire '"
          . $plugin_full_path . "';";
        $timer->mark( "Loaded plugin " . $sig ) if $timer;
        if ($@) {
            $Plugins{$plugin_sig}{error} = $@;

            # Log the issue but do it in a post_init callback so
            # that we won't prematurely initialize the schema before
            # all plugins are finished loading
            my $msg = $mt->translate( "Plugin error: [_1] [_2]",
                                      $plugin, $Plugins{$plugin_sig}{error} );
            $mt->log(
                  { message => $msg, class => 'system', level => 'ERROR', } );
            return 0;
        }
        else {
            if ( my $obj = $Plugins{$plugin_sig}{object} ) {
                $obj->init_callbacks();
            }
            else {

                # A plugin did not register itself, so
                # create a dummy plugin object which will
                # cause it to show up in the plugin listing
                # by it's filename.
                MT->add_plugin( {} );
            }
        }
        $Plugins{$plugin_sig}{enabled} = 1;
        return 1;
    };    # end load_plugin sub


    my @deprecated_perl_init = ();
    foreach my $plugin (@$plugins) {

        # TODO in Melody 1.1: do NOT load plugin, .pl is deprecated
        if ( $plugin->{file} =~ /\.pl$/ ) {
            push( @deprecated_perl_init, $plugin );
            $plugin_envelope  = $plugin->{envelope};
            $plugin_full_path = $plugin->{path};
            ###l4p $logger->debug('Loading deprecated plugin: ',l4mtdump($plugin));
            $load_plugin->( $plugin->{path}, $plugin->{file} );
        }
        else {
            my $pclass
              = $plugin->{type} eq 'pack' ? 'MT::Component' : 'MT::Plugin';

            # Don't process disabled plugin config.yaml files.
            if (
                 $pclass eq 'MT::Plugin'
                 && (
                      !$use_plugins
                      || ( exists $PluginSwitch->{ $plugin->{sig} }
                           && !$PluginSwitch->{ $plugin->{sig} } )
                 )
              )
            {
                $Plugins{ $plugin->{sig} }{full_path} = File::Spec->catfile($plugin->{path},$plugin->{file});
                $Plugins{ $plugin->{sig} }{enabled}   = 0;
                next;
            }

            # TODO - the plugin signature cannot simply be the base directory
            #        in the event that there are multiple yaml files. Therefore
            #        the signature must become a conjunction of the directory and
            #        config.yaml file.
            #        To address this, the ultimate normalizer should be the
            #        id declared in the yaml.
            # See http://bugs.movabletype.org/?79933
            local $plugin_sig = $plugin->{dir} . '/' . $plugin->{file};
            ###l4p $logger->debug('coco plugin_sig: ', $plugin_sig);
            next if exists $Plugins{$plugin_sig};

            # TODO - the id needs to be yaml specific, not directory
            # TODO - the id needs to be reformulated from contents of yaml
            my $id = lc $plugin->{dir};
            $id =~ s/\.\w+$//;

            my $plugin_init = {
                id       => $id,
                path     => $plugin->{base},
                config   => $plugin->{file},
                envelope => $plugin->{envelope}
            };
            ###l4p $logger->info("Initializing $pclass: ",l4mtdump($plugin_init));
            my $p = $pclass->new( $plugin_init);
            ###l4p $logger->debug("Blessed $pclass: ", l4mtdump($p));

            $Plugins{$plugin_sig}{enabled} = 1;
            $plugin_envelope               = $plugin->{envelope};
            $plugin_full_path              = $plugin->{path};
            MT->add_plugin($p);
            $p->init_callbacks();
            next;
        } ## end else [ if ( $plugin->{file} =~...)]
    } ## end foreach my $plugin (@$plugins)

    # FIXME See _perl_init_plugin_warnings() below for more details
    if (@deprecated_perl_init) {
        MT->add_callback(
            'post_init',
            1, undef,
            sub {
                MT->_perl_init_plugin_warnings(@deprecated_perl_init);
            }
        );
    }

    # Reset the Text_filters hash in case it was preloaded by plugins by
    # calling all_text_filters (Markdown in particular does this).
    # Upon calling all_text_filters again, it will be properly loaded by
    # querying the registry.
    %Text_filters = ();

    1;
} ## end sub _init_plugins_core

###
### FIXME Handle perl plugin deprecation properly
###
### This was a quickly cobbled together solution to preserve a good
### feature gone horribly wrong: With EACH load of the application
### ONE log message PER deprecated plugin would be generated. Do the math.
# If we have deprecated plugins, we definitely warn them. Question is:
#                           HOW LOUDLY?!?!?!
#
# Additional note: This had to be done post_init because
# the MT::Session properties had not yet been initialized
sub _perl_init_plugin_warnings {
    my $cb       = shift;
    my @deps     = @_;
    my $mt       = MT->instance;
    my $warn_msg = sub {
        return
          $mt->translate(
                        "DEPRECATION WARNING: One of your plugins ([_1]) "
                     .  "uses a deprecated plugin file format (.pl) that "
                     .  "will not be supported in the future.",
                     (shift)->{file}
          );
    };

    # We definitely complain to STDERR every time for each plugin
    print STDERR $warn_msg->($_) . "\n" foreach @deps;

    # We need to be more sensitive about the activity log...
    # Get the session storing the last warning for perl-init plugins
    # If it's over a day old, it doesn't exist.
    require MT::Session;
    my $sess_terms = {
                       id => 'Deprecation warning: Perl initialized plugins',
                       kind => 'DW ',
    };
    my $recent_warning
      = MT::Session::get_unexpired_value( 86400, $sess_terms, {} );

    require File::Spec;
    my $plugin_sig = sub {
        @_ and return
          File::Spec->catfile( ( $_[0]->{envelope} || '' ),
                               ( $_[0]->{file} || '' ) );
    };

    # ISSUE A NEW WARNING IF:
    #  -- No recent warning was found, OR
    #  -- We find a perl-init'd plugin not recorded in most recent warn
    my $needs_warning = !$recent_warning;
    $needs_warning
      ||= grep { !$recent_warning->get( $plugin_sig->($_) ) } @deps;

    if ($needs_warning) {
        my $dep_plugin_log_warn = sub {
            $mt->log( {
                        message  => $warn_msg->(shift),
                        class    => 'system',
                        category => 'deprecation',
                        level    => 'WARNING',
                      }
            );
        };

        # Reuse recent warning record or create a new session
        $recent_warning ||= MT::Session->new();
        $recent_warning->set_values($sess_terms);
        $recent_warning->start(time);
        foreach my $p (@deps) {
            $dep_plugin_log_warn->($p);
            $recent_warning->set( $plugin_sig->($p),
                                  ( $p->{label} || $p->{id} ) );
        }
        unless ( $recent_warning->save ) {
            warn "Could not record recent warning about "
              . "perl initialized plugins : "
              . ( $recent_warning->errstr || 'Unknown error' );
        }
    } ## end if ($needs_warning)
} ## end sub _perl_init_plugin_warnings

my %addons;

sub find_addons {
    my $mt = shift;
    my ($type) = @_;
    ###l4p $logger ||= MT::Log::Log4perl->new(); $logger->trace();
    unless (%addons) {
        my @PluginPaths;
        my $cfg = $mt->config;
        unshift @PluginPaths, File::Spec->catdir( $MT_DIR, 'addons' );
        unshift @PluginPaths, $cfg->PluginPath;
        foreach my $PluginPath (@PluginPaths) {
            ###l4p $logger->info("Looking for plugins in $PluginPath");
            __merge_hash( \%addons,
                          $mt->scan_directory_for_addons($PluginPath) );
        }
    }
    if ($type) {
        my $addons = $addons{$type} ||= [];
        return $addons;
    }
    return 1;
}

sub scan_directory_for_addons {
    my $mt             = shift;
    my ($PluginPath)   = @_;
    ###l4p $logger ||= MT::Log::Log4perl->new(); $logger->trace();
    my $plugin_lastdir = $PluginPath;
    $plugin_lastdir =~ s![\\/]$!!;
    $plugin_lastdir =~ s!.*[\\/]!!;
    local *DH;
    my %plugins;
    if ( opendir DH, $PluginPath ) {
        my @p = readdir DH;
      PLUGIN:
        for my $plugin_dir (@p) {
            next if ( $plugin_dir =~ /^\.\.?$/ || $plugin_dir =~ /~$/ );

            # Legacy support when plugins were not
            # placed in their own directory
            $plugin_full_path
              = File::Spec->catfile( $PluginPath, $plugin_dir );
            if ( -f $plugin_full_path ) {
                if ( $plugin_full_path =~ /\.pl$/ ) {

                    my $err = $mt->translate("The plugin [_1] "
                            . "was not loaded because it resides in the "
                            . "top level of a plugin directory, a legacy MT "
                            . "plugin practice Melody does not support.",
                              $plugin_full_path);
                    print STDERR "ERROR: $err\n";
                    ###l4p $logger->error($err);
                    $mt->log( {
                                message => $err,
                                class   => 'system',
                                level   => MT->model('log')->ERROR()
                              }
                    );
                    # push @{ $plugins{'plugin'} },
                    #   {
                    #     dir      => $PluginPath,
                    #     file     => $plugin_dir,
                    #     path     => $plugin_full_path,
                    #     envelope => $plugin_lastdir,
                    #   };
                }
            }
            else {
                # open and scan the directory for plugin files,
                # save them to load later. Report errors in
                # the activity log
                unless ( opendir SUBDIR, $plugin_full_path ) {
                    my $msg =
                      $mt->translate(
                         "Bad directory found in plugin initialization: [_1]",
                         $plugin_full_path
                      );
                    $mt->log( {
                                message => $msg,
                                class   => 'system',
                                level   => 'ERROR',
                              }
                    );
                    next;
                }

                my @plugin_files = readdir SUBDIR;
                closedir SUBDIR;
                for my $file (@plugin_files) {
                    if ( $file eq 'lib' || $file eq 'extlib' ) {
                        my $plib
                          = File::Spec->catdir( $plugin_full_path, $file );
                        unshift @INC, $plib if -d $plib;
                        next;
                    }

                    # Skip all unless it's a plugin file (pl or yaml)
                    next unless $file =~ m{(\.pl|config\.yaml)$};

                    # Give preference to config.yaml initialization
                    next
                      if ( '.pl' eq $1 )
                      and -f File::Spec->catfile( $plugin_full_path,
                                                  'config.yaml' );

                    my ( $label, $type )
                      = ( $plugin_dir =~ /^([^\.]+)\.?(\w+)?$/ );
                    unless ($type) {
                        if ( $plugin_dir =~ /addons/ ) {
                            $type = 'pack';
                        }
                        else {
                            $type = 'plugin';
                        }
                    }
                    if ( $type eq 'pack' ) {
                        $label .= ' Pack';
                    }
                    elsif ( $type eq 'theme' ) {
                        $label .= ' Theme';
                    }
                    elsif ( $type eq 'plugin' ) {
                        $label .= ' Plugin';
                    }
                    my $plugin_file
                      = File::Spec->catfile( $plugin_full_path, $file );
                    if ( -f $plugin_file ) {
                        my $sig = File::Spec->catfile( $plugin_dir, $file );
                        ###l4p $logger->debug("Adding $plugin_file ", l4mtdump({
                        ###l4p     dir      => $plugin_dir,
                        ###l4p     base     => $plugin_full_path,
                        ###l4p     envelope => "$plugin_lastdir/" . $plugin_dir,
                        ###l4p     path     => $plugin_full_path,
                        ###l4p     file     => $file,
                        ###l4p     sig     => $sig,
                        ###l4p }));

                        # Plugin is a file, add it to list for processing
                        push @{ $plugins{$type} }, {
                            label => $label,              # used only by packs
                            id    => lc($label),          # used only by packs
                            type  => $type,
                            base  => $plugin_full_path,
                            dir   => $plugin_dir,
                            file  => $file,
                            sig   => $sig,

                            # TODO: remove following comment if app is stable
                            # Changed from $plugin_file because load_tmpl was failing
                            path     => $plugin_full_path,
                            envelope => "$plugin_lastdir/" . $plugin_dir,
                        };
                    }
                } ## end for my $file (@plugin_files)
            } ## end else [ if ( -f $plugin_full_path)]
        } ## end for my $plugin_dir (@p)
        closedir DH;
    } ## end if ( opendir DH, $PluginPath)
    return \%plugins;
} ## end sub scan_directory_for_addons
