# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::App::Wizard;

use strict;
use base qw( MT::App );

use MT::I18N qw( encode_text );
use MT::Util qw( trim browser_language );

sub id {'wizard'}

sub init {
    my $app   = shift;
    my %param = @_;
    $app->init_core();
    my $cfg = $app->config;
    $cfg->define( $app->component('core')->registry('config_settings') );
    $app->init_core_registry();
    $cfg->UsePlugins(0);
    $app->SUPER::init(@_);

    $app->{mt_dir} ||= $ENV{MT_HOME} || $param{Directory};
    $app->{is_admin}             = 1;
    $app->{plugin_template_path} = '';
    $app->add_methods(
                       pre_start       => \&pre_start,
                       upgrade_from_mt => \&upgrade_from_mt,
                       run_step        => \&run_step,
    );
    $app->{template_dir} = 'wizard';
    $app->config->set( 'StaticWebPath', $app->static_path );
    return $app;
} ## end sub init

sub init_request {
    my $app = shift;
    $app->{default_mode} = 'pre_start';

    # prevents init_request from trying to process the configuration file.
    # Must call $app->SUPER::init_request before calling $app->query
    # See https://openmelody.lighthouseapp.com/projects/26604/tickets/207
    $app->SUPER::init_request(@_);
    my $q = $app->query;
    $app->set_no_cache;
    $app->{requires_login} = 0;

    my $default_lang = $q->param('default_language') || browser_language();
    $app->set_language($default_lang);

    if ( $app->is_mtconfig_exists
         || ( $q->param('step') && $q->param('step') eq 'upgrade_from_mt' ) )
    {
        $app->mode('upgrade_from_mt');
        return;
    }

    my $mode = $app->mode;
    return
      unless $mode eq 'previous_step'
          || $mode eq 'next_step'
          || $mode eq 'retry'
          || $mode eq 'test';

    my $step = $q->param('step') || '';

    my $prev_step = 'pre_start';
    my $new_step  = '';

    if ( $mode eq 'retry' ) {
        $new_step = $step;
    }
    elsif ( $mode eq 'test' ) {
        $new_step = $step;
    }
    else {
        my $steps = $app->wizard_steps;
        foreach my $s (@$steps) {
            if ( $mode eq 'next_step' ) {
                if ( $prev_step eq $step ) {
                    $new_step = $s->{key};
                    $q->param( 'save', 1 ) if $app->request_method eq 'POST';
                    last;
                }
            }
            elsif ( $mode eq 'previous_step' ) {
                if ( $s->{key} eq $step ) {
                    $new_step = $prev_step if $prev_step;
                    last;
                }
            }
            $prev_step = $s->{key};
        }
    }

    # If check.cgi exists, redirect to errro screen
    my $cfg_exists = $app->is_config_exists();
    if ( $cfg_exists && lc $step ne 'seed' && lc $mode ne 'retry' ) {
        my %param;
        $param{cfg_exists} = 1;
        $app->mode('pre_start');
        return $app->build_page( "start.tmpl", \%param );
    }

    $q->param( 'next_step', $new_step );
    $app->mode('run_step');
} ## end sub init_request

sub init_core_registry {
    my $app  = shift;
    my $core = $app->component("core");
    $core->{registry}{applications}{wizard} = {
        wizard_steps => {
            start => {
                       order   => 0,
                       handler => \&start,
                       params  => [qw(set_static_uri_to set_static_file_to)],
            },
            configure => {
                order   => 100,
                handler => \&configure,
                params  => [
                    qw(dbpath dbname dbport dbserver dbsocket
                      dbtype dbuser dbpass publish_charset)
                ]
            },
            optional => {
                order   => 200,
                handler => \&optional,
                params  => [
                    qw(mail_transfer sendmail_path smtp_server
                      test_mail_address)
                ]
            },
            cfg_dir => {
                         order     => 300,
                         handler   => \&cfg_dir,
                         params    => ['temp_dir'],
                         condition => \&cfg_dir_conditions,
            },
            seed => { order => 10000, handler => \&seed, },
        },
        'optional_packages' => {
            'Archive::Tar' => {
                'label' =>
                  'Archive::Tar is needed in order to archive files in backup/restore operation.',
                'link' => 'http://search.cpan.org/dist/Archive-Tar/'
            },
            'Archive::Zip' => {
                'label' =>
                  'Archive::Zip is needed in order to archive files in backup/restore operation.',
                'link' => 'http://search.cpan.org/dist/Archive-Zip/'
            },
            'Attribute::Params::Validate' => {
                'link' =>
                  'http://search.cpan.org/dist/Params-Validate/lib/Attribute/Params/Validate.pm',
                'version' => '1.07'
            },
            'Cache::Memcached' => {
                'label' =>
                  'Cache::Memcached and memcached server/daemon is needed in order to use memcached as caching mechanism used by Melody.',
                'link' => 'http://search.cpan.org/dist/Cache-Memcached/'
            },
            'Crypt::DH' => {
                'label' =>
                  'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers ',
                'link'    => 'http://search.cpan.org/dist/Crypt-DH/',
                'version' => '0.06'
            },
            'Crypt::DSA' => {
                'label' =>
                  'Crypt::DSA is optional; if it is installed, comment registration sign-ins will be accelerated.',
                'link' => 'http://search.cpan.org/dist/Crypt-DSA/'
            },
            'Crypt::SSLeay' => {
                'label' =>
                  'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers that require SSL support.',
                'link' => 'http://search.cpan.org/dist/Crypt-SSLeay/'
            },
            'DBD::Pg' => {
                'label' =>
                  'DBI and DBD::Pg are required if you want to use the PostgreSQL database backend.',
                'link'    => 'http://search.cpan.org/dist/DBD-Pg/',
                'version' => '1.32'
            },
            'DBD::SQLite' => {
                'label' =>
                  'DBI and DBD::SQLite are required if you want to use the SQLite database backend.',
                'link'    => 'http://search.cpan.org/dist/DBD-SQLite/',
                'version' => '1.20'
            },
            'DBD::SQLite2' => {
                'label' =>
                  'DBI and DBD::SQLite2 are required if you want to use the SQLite 2.x database backend.',
                'link' => 'http://search.cpan.org/dist/DBD-SQLite2/'
            },
            'DBD::mysql' => {
                'label' =>
                  'DBI and DBD::mysql are required if you want to use the MySQL database backend.',
                'link' => 'http://search.cpan.org/dist/DBD-mysql/'
            },
            'DBI' => {
                      'label' => 'DBI is required to store data in database.',
                      'link'  => 'http://search.cpan.org/dist/DBI/',
                      'version' => '1.21'
            },
            'Devel::Leak::Object' => {
                link => 'http://search.cpan.org/dist/Devel-Leak-Object',
                label =>
                  'This module is used by the --leak option of the tools/run-periodic-tasks script.',
            },
            'GD' => {
                'label' =>
                  'This module is needed if you would like to be able to create thumbnails of uploaded images.',
                'link' => 'http://search.cpan.org/dist/GD/'
            },
            'IO::Compress::Gzip' => {
                'label' =>
                  'IO::Compress::Gzip is needed in order to compress files in backup/restore operation.',
                'link' =>
                  'http://search.cpan.org/dist/IO-Compress/lib/IO/Compress/Gzip.pm'
            },
            'IO::Scalar' => {
                'label' =>
                  'IO::Scalar is needed in order to archive files in backup/restore operation.',
                'link'    => 'http://search.cpan.org/dist/IO-Scalar/',
                'version' => '2.11'
            },
            'IO::Uncompress::Gunzip' => {
                'label' =>
                  'IO::Uncompress::Gunzip is required in order to decompress files in backup/restore operation.',
                'link' =>
                  'http://search.cpan.org/dist/IO-Compress/lib/IO/Compress/Gunzip.pm'
            },
            'IPC::Run' => {
                'label' =>
                  'This module is needed if you would like to be able to use NetPBM as the image driver for Melody.',
                'link' => 'http://search.cpan.org/dist/IPC-Run/'
            },
            'Image::Magick' => {
                'label' =>
                  'Image::Magick is optional; It is needed if you would like to be able to create thumbnails of uploaded images.',
                'link' => 'http://search.cpan.org/dist/Image-Magick/'
            },
            'MIME::Charset' => {
                'label' =>
                  'MIME::Charset is required for sending mail via SMTP Server.',
                'link'    => 'http://search.cpan.org/dist/MIME-Charset/',
                'version' => '0.044'
            },
            'MIME::EncWords' => {
                'label' =>
                  'MIME::EncWords is required for sending mail via SMTP Server.',
                'link'    => 'http://search.cpan.org/dist/MIME-EncWords/',
                'version' => '0.96'
            },
            'Mail::Sendmail' => {
                'label' =>
                  'Mail::Sendmail is required for sending mail via SMTP Server.',
                'link' => 'http://search.cpan.org/dist/Mail-SendMail/'
            },
            'Net::OpenID::Consumer' => {
                'label' =>
                  'This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers ',
                'link' => 'http://search.cpan.org/dist/Net-OpenID-Consumer/',
                'version' => '1.03'
            },
            'Path::Class' =>
              { 'link' => 'http://search.cpan.org/dist/Path-Class/' },
            'Proc::ProcessTable' => {
                link => 'http://search.cpan.org/dist/Proc-ProcessTable',
                label =>
                  'This module is used by the tools/run-periodic-tasks script and RPTProcessCap directive.',
            },
            'SOAP::Lite' => {
                'label' =>
                  'SOAP::Lite is optional; It is needed if you wish to use the Melody XML-RPC server implementation.',
                'link'    => 'http://search.cpan.org/dist/SOAP-Lite/',
                'version' => '0.710.08'
            },
            'XML::Atom' => {
                      'label' =>
                        'XML::Atom is required in order to use the Atom API.',
                      'link' => 'http://search.cpan.org/dist/XML-Atom/'
            },
            'XML::LibXML' => {
                    'label' =>
                      'XML::LibXML is required in order to use the Atom API.',
                    'link' => 'http://search.cpan.org/dist/XML-LibXML/'
            },
            'XML::NamespaceSupport' => {
                'label' =>
                  'XML::NamespaceSupport is needed in order to archive files in backup/restore operation.',
                'link' => 'http://search.cpan.org/dist/XML-NamespaceSupport/',
                'version' => '1.09'
            },
            'XML::Parser' => {
                          'link' => 'http://search.cpan.org/dist/XML-Parser/',
                          'version' => '2.23'
            },
            'XML::SAX' => {
                'label' =>
                  'XML::SAX is needed in order to archive files in backup/restore operation.',
                'link'    => 'http://search.cpan.org/dist/XML-SAX/',
                'version' => '0.96'
            },
            'XML::Simple' => {
                'label' =>
                  'XML::Simple is needed in order to archive files in backup/restore operation.',
                'link'    => 'http://search.cpan.org/dist/XML-Simple/',
                'version' => '2.14'
            },
            'XML::XPath' =>
              { 'link' => 'http://search.cpan.org/dist/XML-XPath' },
            'bignum' => {
                          'link'    => 'http://search.cpan.org/dist/bignum/',
                          'version' => '0.23'
            }
        },
        'required_packages' => {
             'Algorithm::Diff' => {
                      'link' => 'http://search.cpan.org/dist/Algorithm-Diff/',
                      'version' => '1.1902'
             },
             'Attribute::Handlers' => {
                  'link' => 'http://search.cpan.org/dist/Attribute-Handlers/',
                  'version' => '0.88'
             },
             'CGI' => {
                        'link'    => 'http://search.cpan.org/dist/CGI/',
                        'version' => '3.5'
             },
             'Cache' => {
                          'link'    => 'http://search.cpan.org/dist/Cache/',
                          'version' => '2.04'
             },
             'Class::Accessor' => {
                      'link' => 'http://search.cpan.org/dist/Class-Accessor/',
                      'version' => '0.22'
             },
             'Class::Data::Inheritable' => {
                      'link' =>
                        'http://search.cpan.org/dist/Class-Data-Inheritable/',
                      'version' => '0.06'
             },
             'Class::Trigger' => {
                       'link' => 'http://search.cpan.org/dist/Class-Trigger/',
                       'version' => '0.1001'
             },
             'Data::ObjectDriver' => {
                   'link' => 'http://search.cpan.org/dist/Data-ObjectDriver/',
                   'version' => '0.06'
             },
             'Digest::SHA1' => {
                         'link' => 'http://search.cpan.org/dist/Digest-SHA1/',
                         'version' => '0.06'
             },
             'File::Copy::Recursive' => {
                 'link' => 'http://search.cpan.org/dist/File-Copy-Recursive/',
                 'version' => '0.23'
             },
             'HTML::Diff' => {
                           'link' => 'http://search.cpan.org/dist/HTML-Diff/',
                           'version' => '0.561'
             },
             'HTML::Parser' => {
                         'link' => 'http://search.cpan.org/dist/HTML-Parser/',
                         'version' => '3.66'
             },
             'Heap::Fibonacci' => {
                                'link' => 'http://search.cpan.org/dist/Heap/',
                                'version' => '0.71'
             },
             'Image::Size' => {
                          'link' => 'http://search.cpan.org/dist/Image-Size/',
                          'version' => '2.93'
             },
             'JSON' => {
                         'link'    => 'http://search.cpan.org/dist/JSON/',
                         'version' => '2.12'
             },
             'Jcode' => {
                          'link'    => 'http://search.cpan.org/dist/Jcode/',
                          'version' => '0.88'
             },
             'LWP' => {
                        'link' => 'http://search.cpan.org/dist/libwww-perl/',
                        'version' => '5.831'
             },
             'Locale::Maketext' => {
                     'link' => 'http://search.cpan.org/dist/Locale-Maketext/',
                     'version' => '1.13'
             },
             'Log::Dispatch' => {
                         'link' => 'http://search.cpan.org/dist/Log-Dispatch',
                         'version' => '2.26'
             },
             'Log::Log4perl' => {
                         'link' => 'http://search.cpan.org/dist/Log-Log4perl',
                         'version' => '1.3'
             },
             'Lucene::QueryParser' => {
                   'link' => 'http://search.cpan.org/dist/Lucene-QueryParser',
                   'version' => '1.04'
             },
             'Params::Validate' => {
                      'link' => 'http://search.cpan.org/dist/Params-Validate',
                      'version' => '0.73'
             },
             'Sub::Install' => {
                          'link' => 'http://search.cpan.org/dist/Sub-Install',
                          'version' => '0.925'
             },
             'TheSchwartz' => {
                          'link' => 'http://search.cpan.org/dist/TheSchwartz',
                          'version' => '1.07'
             },
             'URI' => {
                        'link'    => 'http://search.cpan.org/dist/URI',
                        'version' => '1.36'
             },
             'YAML::Tiny' => {
                           'link' => 'http://search.cpan.org/dist/YAML-Tiny/',
                           'version' => '1.12'
             },
             'version' => {
                            'link' => 'http://search.cpan.org/dist/version/',
                            'version' => '0.76'
             }
        },
    };
} ## end sub init_core_registry

sub run_step {
    my $app       = shift;
    my $q         = $app->query;
    my $steps     = $app->registry("wizard_steps");
    my $next_step = $q->param('next_step');
    my $curr_step = $q->param('step');
    my $h         = $steps->{$curr_step}{handler};

    my %param = $app->unserialize_config;
    my $keys  = $app->config_keys;
    if ($curr_step) {
        foreach ( @{ $keys->{$curr_step} } ) {
            $param{$_} = $q->param($_) if defined $q->param($_);
        }

        if ( $q->param('save') ) {
            $q->param( 'config', $app->serialize_config(%param) );
        }
    }

    $h = $steps->{$next_step}{handler};

    if ( !$h ) {
        return $app->pre_start();
    }

    $h = $app->handler_to_coderef($h) unless ref($h) eq 'CODE';

    $q->param( 'step', $next_step );
    return $h->( $app, %param );
} ## end sub run_step

sub config_keys {
    my $app   = shift;
    my $steps = $app->registry("wizard_steps");
    my $keys  = {};
    foreach my $key ( keys %$steps ) {
        my $p = $steps->{$key}{params};
        $keys->{$key} = $p if $p;
    }
    return $keys;
}

sub init_config {
    return 1;
}

sub pre_start {
    my $app = shift;
    my %param;

    eval { use File::Spec; };
    my ($static_file_path);
    if ( !$@ ) {
        $static_file_path = File::Spec->catfile( $app->static_file_path );
    }

    $param{cfg_exists}        = $app->is_config_exists;
    $param{valid_static_path} = 1
      if $app->is_valid_static_path( $app->static_path );
    $param{mt_static_exists} = $app->mt_static_exists;
    $param{static_file_path} = $static_file_path;

    $param{languages}
      = MT::I18N::languages_list( $app, $app->current_language );

    return $app->build_page( "start.tmpl", \%param );
} ## end sub pre_start

sub wizard_steps {
    my $app = shift;
    my $q   = $app->query;
    my @steps;
    my $steps       = $app->registry("wizard_steps");
    my $active_step = $app->query->param('step') || 'start';
    my %param       = $app->unserialize_config;
    foreach my $key ( keys %$steps ) {
        if ( my $cond = $steps->{$key}{condition} ) {
            if ( !ref($cond) ) {
                $cond = $app->handler_to_coderef($cond);
            }
            next unless ref($cond) eq 'CODE';
            next unless $cond->( $app, \%param );
        }
        push @steps,
          {
            key    => $key,
            active => $active_step eq $key,
            %{ $steps->{$key} },
          };
    }
    @steps = sort { $a->{order} <=> $b->{order} } @steps;
    return \@steps;
} ## end sub wizard_steps

sub build_page {
    my $app = shift;
    my ( $tmpl, $param ) = @_;

    $param ||= {};
    my $steps = $app->wizard_steps;
    $param->{'wizard_steps'} = $steps;
    $param->{'step'}         = $app->query->param('step');

    $param->{'default_language'} ||= $app->query->param('default_language');

    return $app->SUPER::build_page( $tmpl, $param );
}

sub directories_to_remove {
    my $app = shift;

    $app->SUPER::init_config();

    my $dirs;

    my @PluginPaths;
    my $cfg = MT->config;
    unshift @PluginPaths, File::Spec->catdir( $app->{'mt_dir'}, 'addons' );
    unshift @PluginPaths, $cfg->PluginPath;
    foreach my $PluginPath (@PluginPaths) {
        if ( opendir DH, $PluginPath ) {
            my @p = readdir DH;
            for my $plugin_dir (@p) {
                next if ( $plugin_dir =~ /^\.\.?$/ || $plugin_dir =~ /~$/ );
                my $plugin_full_path
                  = File::Spec->catfile( $PluginPath, $plugin_dir );
                if ( $plugin_dir =~ /([^\/\\]*)\.pl$/ ) {
                    push @{ $dirs->{rename} },
                      {
                        full_path => $plugin_full_path,
                        rename_to =>
                          File::Spec->catfile( $PluginPath, $1, "$1.pl" )
                      };
                }
                elsif ( $plugin_dir
                    =~ /^(Textile|Cloner|spamlookup|StyleCatcher|feeds-app-lite|mixiComment)$/
                  )
                {
                    push @{ $dirs->{optional} }, $plugin_full_path;
                }
                elsif ( $plugin_dir
                    =~ /^(WidgetManager|ThemeExport|ThemeManager|FullScreen|AjaxPublish|SearchMenuOption|WidgetSystemMenuOption|AutoPrefs|ConfigAssistant.plugin|ConfigAssistant|Markdown|MultiBlog|TypePadAntiSpam|WXRImporter)$/
                  )
                {
                    push @{ $dirs->{remove} }, $plugin_full_path;
                }
            } ## end for my $plugin_dir (@p)
        } ## end if ( opendir DH, $PluginPath)
    } ## end foreach my $PluginPath (@PluginPaths)
    return $dirs;
} ## end sub directories_to_remove

sub upgrade_from_mt {
    my $app   = shift;
    my $q     = $app->query;
    my %param = @_;

    $app->{cfg_file}
      = File::Spec->catfile( $app->{'mt_dir'}, 'mt-config.cgi' );
    unless ( -e $app->{cfg_file} ) {
        $app->{cfg_file}
          = File::Spec->catfile( $app->{'mt_dir'}, 'config.cgi' );
    }

    my $dirs = $app->directories_to_remove();
    $param{remove_loop} = $dirs->{remove};
    $param{rename_loop} = $dirs->{rename};
    my $cfg = $app->{cfg_file};
    $cfg =~ s/mt-config/config/;

    $param{cfg_file}     = $app->{cfg_file};
    $param{new_cfg_file} = $cfg;
    $param{rename_cfg}   = ( $app->{cfg_file} =~ /mt-config/ );
    $param{ready}
      = !$param{remove_loop} && !$param{rename_loop} && !$param{rename_cfg};
    return $app->build_page( "upgrade_from_mt.tmpl", \%param );
} ## end sub upgrade_from_mt

sub start {
    my $app   = shift;
    my $q     = $app->query;
    my %param = @_;

    my $static_path = $q->param('set_static_uri_to');
    my $static_file_path
      = defined $param{set_static_file_to}
      ? $param{set_static_file_to}
      : $q->param('set_static_file_to');
    $param{set_static_file_to} = $static_file_path;

    # test for static_path
    unless ( $q->param('set_static_uri_to') ) {
        $param{uri_invalid} = 1;
        return $app->build_page( "start.tmpl", \%param );
    }

    $static_path = $app->cgipath . $static_path
      unless $static_path =~ m#^(https?:/)?/#;
    $static_path =~ s#(^\s+|\s+$)##;
    $static_path .= '/' unless $static_path =~ m!/$!;

    unless ( $app->is_valid_static_path($static_path) ) {
        $param{uri_invalid}       = 1;
        $param{set_static_uri_to} = $q->param('set_static_uri_to');
        return $app->build_page( "start.tmpl", \%param );
    }

    $app->config->set( 'StaticWebPath', $static_path );

    # test for static_file_path
    unless ($static_file_path) {
        $param{file_invalid} = 1;
        return $app->build_page( "start.tmpl", \%param );
    }

    if (    !( -d $static_file_path )
         || !( -f File::Spec->catfile( $static_file_path, "mt.js" ) ) )
    {
        $param{file_invalid}      = 1;
        $param{set_static_uri_to} = $q->param('set_static_uri_to');
        return $app->build_page( "start.tmpl", \%param );
    }
    $param{default_language} = $q->param('default_language');
    $param{config}           = $app->serialize_config(%param);
    $param{static_file}      = $static_file_path;

    # test for required packages...
    my $req = $app->registry("required_packages");
    my @REQ;
    foreach my $pkg ( keys %$req ) {
        my $info = $req->{$pkg};
        push @REQ,
          [
            $pkg, $info->{version} || 0, 1, $info->{label} || '',
            $pkg, $info->{link} || '',
          ];
    }
    my ($needed) = $app->module_check( \@REQ );
    if (@$needed) {
        $param{package_loop} = $needed;
        $param{required}     = 1;
        $param{install_help} = 1;
        return $app->build_page( "packages.tmpl", \%param );
    }

    my @DATA;
    my $drivers = $app->object_drivers;
    foreach my $key ( keys %$drivers ) {
        my $driver = $drivers->{$key};
        my $label  = $driver->{label};
        my $link   = 'http://search.cpan.org/dist/' . $driver->{dbd_package};
        $link =~ s/::/-/g;
        push @DATA,
          [
            $driver->{dbd_package},
            $driver->{dbd_version},
            0,
            $app->translate(
                          "The [_1] database driver is required to use [_2].",
                          $driver->{dbd_package}, $label
            ),
            $label, $link
          ];
    }
    my ($db_missing) = $app->module_check( \@DATA );
    if ( ( scalar @$db_missing ) == ( scalar @DATA ) ) {
        $param{package_loop}           = $db_missing;
        $param{missing_db_or_optional} = 1;
        $param{missing_db}             = 1;
        $param{install_help}           = 1;
        return $app->build_page( "packages.tmpl", \%param );
    }

    my $opt = $app->registry("optional_packages");
    my @OPT;
    foreach my $key ( keys %$opt ) {
        my $pkg = $opt->{$key};
        push @OPT,
          [ $key, $pkg->{version} || 0, 0, $pkg->{label}, $key,
            $pkg->{link} ];
    }
    my ($opt_missing) = $app->module_check( \@OPT );
    push @$opt_missing, @$db_missing;
    if (@$opt_missing) {
        $param{package_loop}           = $opt_missing;
        $param{missing_db_or_optional} = 1;
        $param{optional}               = 1;
        $param{install_help}           = 1;
        return $app->build_page( "packages.tmpl", \%param );
    }

    $param{success} = 1;
    return $app->build_page( "packages.tmpl", \%param );
} ## end sub start

sub object_drivers {
    my $app = shift;
    my $drivers = $app->registry("object_drivers") || {};
    return $drivers;
}

sub configure {
    my $app   = shift;
    my $q     = $app->query;
    my %param = @_;

    $param{set_static_uri_to} = $q->param('set_static_uri_to');

    # set static web path
    $app->config->set( 'StaticWebPath', $param{set_static_uri_to} );
    delete $param{publish_charset};
    if ( my $dbtype = $param{dbtype} )
    {    # This needs to be fixed so it is pluggable.
        $param{"dbtype_$dbtype"} = 1;
        if ( $dbtype eq 'mysql' ) {
            $param{login_required} = 1;
        }
        elsif ( $dbtype eq 'postgres' ) {
            $param{login_required} = 1;
        }
        elsif ( $dbtype eq 'oracle' ) {
            $param{login_required} = 1;
        }
        elsif ( $dbtype eq 'mssqlserver' ) {
            $param{login_required}  = 1;
            $param{publish_charset} = $q->param('publish_charset')
              || ( $app->{cfg}->DefaultLanguage eq 'ja'
                   ? 'Shift_JIS'
                   : 'ISO-8859-1' );
        }
        elsif ( $dbtype eq 'sqlite' ) {
            $param{path_required} = 1;
        }
        elsif ( $dbtype eq 'sqlite2' ) {
            $param{path_required} = 1;
        }
    } ## end if ( my $dbtype = $param...)

    my @DATA;
    my $drivers = $app->object_drivers;
    foreach my $key ( keys %$drivers ) {
        my $driver = $drivers->{$key};
        my $label  = $driver->{label};
        my $link   = 'http://search.cpan.org/dist/' . $driver->{dbd_package};
        $link =~ s/::/-/g;
        push @DATA,
          [
            $driver->{dbd_package},
            $driver->{dbd_version},
            0,
            $app->translate(
                             "The [_1] driver is required to use [_2].",
                             $driver->{dbd_package}, $label
            ),
            $label, $link
          ];
    }
    my ( $missing, $dbmod ) = $app->module_check( \@DATA );
    if ( scalar(@$dbmod) == 0 ) {
        $param{missing_db_or_optional} = 1;
        $param{missing_db}             = 1;
        $param{package_loop}           = $missing;
        return $app->build_page( "packages.tmpl", \%param );
    }
    foreach (@$dbmod) {
        if ( $_->{module} eq 'DBD::mysql' ) {
            $_->{id} = 'mysql';
        }
        elsif ( $_->{module} eq 'DBD::Pg' ) {
            $_->{id} = 'postgres';
        }
        elsif ( $_->{module} eq 'DBD::Oracle' ) {
            $_->{id} = 'oracle';
        }
        elsif ( $_->{module} eq 'DBD::ODBC1.13' ) {
            $_->{id} = 'mssqlserver';
        }
        elsif ( $_->{module} eq 'DBD::ODBC1.14' ) {
            $_->{id} = 'umssqlserver';
        }
        elsif ( $_->{module} eq 'DBD::SQLite' ) {
            $_->{id} = 'sqlite';
        }
        elsif ( $_->{module} eq 'DBD::SQLite2' ) {
            $_->{id} = 'sqlite2';
        }
        if ( $param{dbtype} && ( $param{dbtype} eq $_->{id} ) ) {
            $_->{selected} = 1;
        }
    } ## end foreach (@$dbmod)
    $param{db_loop} = $dbmod;
    $param{one_db}  = $#$dbmod == 0;    # db module is only one or not
    $param{config} = $app->serialize_config(%param);

    my $ok = 1;
    my ( $err_msg, $err_more );
    if ( $q->param('test') ) {

        # if check successfully and push continue then goto next step
        $ok = 0;
        my $dbtype = $param{dbtype};
        my $driver = $drivers->{$dbtype}{config_package}
          if exists $drivers->{$dbtype};
        $param{dbserver_null} = 1 unless $param{dbserver};

        if ($driver) {
            foreach my $key (qw( dbname dbuser dbpass dbsocket dbserver )) {
                chomp $param{$_} if defined $param{$_};
            }
            my $cfg = $app->config;
            $cfg->ObjectDriver($driver);
            $cfg->Database( $param{dbname} )   if $param{dbname};
            $cfg->DBUser( $param{dbuser} )     if $param{dbuser};
            $cfg->DBPassword( $param{dbpass} ) if $param{dbpass};
            $cfg->DBPort( $param{dbport} )     if $param{dbport};
            $cfg->DBSocket( $param{dbsocket} ) if $param{dbsocket};
            $cfg->DBHost( $param{dbserver} )
              if $param{dbserver} && ( $param{dbtype} ne 'oracle' );
            my $current_charset = $cfg->PublishCharset;
            $cfg->PublishCharset( $param{publish_charset} )
              if $param{publish_charset};

            if ( $dbtype eq 'sqlite' || $dbtype eq 'sqlite2' ) {
                require File::Spec;
                my $db_file = $param{dbpath};
                if ( !File::Spec->file_name_is_absolute($db_file) ) {
                    $db_file
                      = File::Spec->catfile( $app->{mt_dir}, $db_file );
                }
                $cfg->Database($db_file) if $db_file;
                $param{dbpath} = $db_file if $db_file;
                if ( $dbtype eq 'sqlite2' ) {
                    $cfg->UseSQLite2(1);
                }
            }

            # test loading of object driver with these parameters...
            require MT::ObjectDriverFactory;
            my $od = MT::ObjectDriverFactory->new($driver);

            $cfg->PublishCharset($current_charset);

            eval { $od->rw_handle; };    ## to test connection
            if ( my $err = $@ ) {
                $err_msg
                  = $app->translate(
                    'An error occurred while attempting to connect to the database.  Check the settings and try again.'
                  );
                if ( $param{publish_charset} ne $current_charset ) {

                    # $param{publish_charset} is sometimes undef which forces encode_text
                    # to guess_encode which should handle all of the cases.
                    $err = encode_text( $err, $param{publish_charset},
                                        $current_charset );
                }
                $err_more = $err;
            }
            else {
                $ok = 1;
            }
        } ## end if ($driver)
        if ($ok) {
            $param{success} = 1;
            return $app->build_page( "configure.tmpl", \%param );
        }
        $param{connect_error} = 1;
        $param{error}         = $err_msg;
        $param{error_more}    = $err_more;
    } ## end if ( $q->param('test'))

    $app->build_page( "configure.tmpl", \%param );
} ## end sub configure

my @Sendmail
  = qw( /usr/lib/sendmail /usr/sbin/sendmail /usr/ucblib/sendmail );

sub cfg_dir_conditions {
    my $app = shift;
    my ($param) = @_;
    if ( $^O ne 'MSWin32' ) {

        # check for writable temp directory
        if ( -w "/tmp" ) {
            return 0;
        }
    }
    return 1;
}

sub cfg_dir {
    my $app   = shift;
    my $q     = $app->query;
    my %param = @_;
    $param{set_static_uri_to} = $q->param('set_static_uri_to');

    # set static web path
    $app->config->set( 'StaticWebPath', $param{set_static_uri_to} );
    $param{config} = $app->serialize_config(%param);
    my $temp_dir;
    if ( $q->param('test') ) {
        $param{changed} = 1;
        if ( $param{temp_dir} ) {
            $temp_dir = $param{temp_dir};
        }
        else {
            $param{invalid_error} = 1;
        }
    }
    else {
        if ( $param{temp_dir} ) {
            $temp_dir = $param{temp_dir};
            $param{changed} = 1;
        }
        else {
            $temp_dir = $app->config->TempDir;
            if ( !-d $temp_dir ) {
                if ( $^O eq 'MSWin32' ) {
                    $temp_dir = 'C:\Windows\Temp';
                }
            }
            $param{temp_dir} = $temp_dir;
        }
    }

    # check temp dir
    if ($temp_dir) {
        if ( !-d $temp_dir ) {
            $param{not_found_error} = 1;
        }
        elsif ( !-w $temp_dir ) {
            $param{not_write_error} = 1;
        }
        else {
            $param{success} = 1;
        }
    }

    $app->build_page( "cfg_dir.tmpl", \%param );
} ## end sub cfg_dir

sub optional {
    my $app   = shift;
    my $q     = $app->query;
    my %param = @_;

    $param{set_static_uri_to} = $q->param('set_static_uri_to');

    # set static web path
    $app->config->set( 'StaticWebPath', $param{set_static_uri_to} );

    # discover sendmail
    my $mgr = $app->config;
    my $sm_loc;
    for my $loc ( $param{sendmail_path}, @Sendmail ) {
        next unless $loc;
        $sm_loc = $loc, last if -x $loc && !-d $loc;
    }
    $param{sendmail_path} = $sm_loc || '';

    my $transfer;
    push @$transfer, { id => 'smtp', name => $app->translate('SMTP Server') };
    push @$transfer,
      { id => 'sendmail', name => $app->translate('Sendmail') };

    foreach (@$transfer) {
        if ( $param{mail_transfer} && $_->{id} eq $param{mail_transfer} ) {
            $_->{selected} = 1;
        }
    }

    $param{ 'use_' . $param{mail_transfer} } = 1 if $param{mail_transfer};
    $param{mail_loop} = $transfer;
    $param{config}    = $app->serialize_config(%param);

    my $ok = 1;
    my $err_msg;
    if ( $q->param('test') ) {
        $ok = 0;
        if ( $param{test_mail_address} ) {
            my $cfg = $app->config;
            $cfg->MailTransfer( $param{mail_transfer} )
              if $param{mail_transfer};
            $cfg->SMTPServer( $param{smtp_server} )
              if $param{mail_transfer}
                  && ( $param{mail_transfer} eq 'smtp' )
                  && $param{smtp_server};
            $cfg->SendMailPath( $param{sendmail_path} )
              if $param{mail_transfer}
                  && ( $param{mail_transfer} eq 'sendmail' )
                  && $param{sendmail_path};
            my %head = (
                  id => 'wizard_test',
                  To => $param{test_mail_address},
                  From => $cfg->EmailAddressMain || $param{test_mail_address},
                  Subject =>
                    $app->translate(
                                  "Test email from [_1] Configuration Wizard",
                                  MT->product_name
                    )
            );
            my $charset = $cfg->MailEncoding || $cfg->PublishCharset;
            $head{'Content-Type'} = qq(text/plain; charset="$charset");

            my $body = $app->translate(
                "This is the test email sent by your new installation of [_1].",
                MT->product_name
            );

            require MT::Mail;
            $ok = MT::Mail->send( \%head, $body );

            if ($ok) {
                $param{success} = 1;
                return $app->build_page( "optional.tmpl", \%param );
            }
            else {
                $err_msg = MT::Mail->errstr;
            }
        } ## end if ( $param{test_mail_address...})

        $param{send_error} = 1;
        $param{error}      = $err_msg;
    } ## end if ( $q->param('test'))
    $app->build_page( "optional.tmpl", \%param );
} ## end sub optional

sub seed {
    my $app   = shift;
    my $q     = $app->query;
    my %param = @_;

    # input data unserialize to config
    unless ( keys(%param) ) {
        $param{config} = $q->param('config');
    }
    else {
        $param{config} = $app->serialize_config(%param);
    }

    $param{static_file_path} = $param{set_static_file_to};

    require URI;
    my $uri = URI->new( $app->cgipath );
    $param{cgi_path}        = $uri->path;
    $uri                    = URI->new( $q->param('set_static_uri_to') );
    $param{static_web_path} = $uri->path;
    $param{static_uri}      = $uri->path;
    my $drivers = $app->object_drivers;

    my $r_uri = $ENV{REQUEST_URI} || $ENV{SCRIPT_NAME};
    if ( $ENV{MOD_PERL}
         || ( ( $r_uri =~ m/\/wizard\.(\w+)(\?.*)?$/ ) && ( $1 ne 'cgi' ) ) )
    {
        my $new = '';
        if ( $ENV{MOD_PERL} ) {
            $param{mod_perl} = 1;
        }
        else {
            $new = '.' . $1;
        }
        my @scripts;
        my $cfg = $app->config;
        my @cfg_keys = grep {/Script$/} keys %{ $cfg->{__settings} };
        $param{mt_script} = $app->config->AdminScript;
        foreach my $key (@cfg_keys) {
            my $path = $cfg->get($key);
            $path =~ s/\.cgi$/$new/;
            if ( -e File::Spec->catfile( $app->{mt_dir}, $path ) ) {
                $param{mt_script} = $path if $key eq 'AdminScript';
                push @scripts, { name => $key, path => $path };
            }
        }
        if (@scripts) {
            $param{script_loop} = \@scripts if @scripts;
            $param{non_cgi_suffix} = 1;
        }
    } ## end if ( $ENV{MOD_PERL} ||...)
    else {
        $param{mt_script} = $app->config->AdminScript;
    }

    # unserialize database configuration
    if ( my $dbtype = $param{dbtype} ) {
        if ( $dbtype eq 'sqlite' ) {
            $param{use_dbms}      = 1;
            $param{object_driver} = 'DBI::sqlite';
            $param{database_name} = $param{dbpath};
        }
        elsif ( $dbtype eq 'sqlite2' ) {
            $param{use_dbms}      = 1;
            $param{use_sqlite2}   = 1;
            $param{object_driver} = 'DBI::sqlite';
            $param{database_name} = $param{dbpath};
        }
        else {
            $param{use_dbms}          = 1;
            $param{object_driver}     = $drivers->{$dbtype}{config_package};
            $param{database_name}     = $param{dbname};
            $param{database_username} = $param{dbuser};
            $param{database_password} = $param{dbpass} if $param{dbpass};
            $param{database_host}     = $param{dbserver}
              if ( $dbtype ne 'oracle' ) && $param{dbserver};
            $param{database_port}   = $param{dbport}   if $param{dbport};
            $param{database_socket} = $param{dbsocket} if $param{dbsocket};
            $param{use_setnames}    = $param{setnames} if $param{setnames};
            $param{publish_charset} = $param{publish_charset}
              if $param{publish_charset};
        }
    } ## end if ( my $dbtype = $param...)

    if ( $param{temp_dir} eq $app->config->TempDir ) {
        $param{temp_dir} = '';
    }

    # authentication configuration
    $param{help_url} = $app->help_url();

    my $tmpls = $app->registry("wizard_template") || [];

    my @tmpl_loop;
    require MT::Template;
    foreach my $code (@$tmpls) {
        if ( $code = $app->handler_to_coderef($code) ) {
            push @tmpl_loop, { tmpl_code => $code };
        }
    }

    $param{tmpl_loop} = \@tmpl_loop;

    my $data = $app->build_page( "mt-config.tmpl", \%param );

    my $cfg_file = File::Spec->catfile( $app->{mt_dir}, 'config.cgi' );
    if ( !-f $cfg_file ) {

        # write!
        if ( open OUT, ">$cfg_file" ) {
            print OUT $data;
            close OUT;
        }
        $param{config_created} = 1 if -f $cfg_file;
        $param{config_file} = $cfg_file;
        if ( ( !-f $cfg_file ) && $q->param('manually') ) {
            $param{file_not_found} = 1;
            $param{manually}       = 1;
        }
    }
    elsif ( $q->param('manually') ) {
        $param{config_created} = 1 if -f $cfg_file;
        $param{config_file} = $cfg_file;
    }

    # back to the complete screen
    return $app->build_page( "complete.tmpl", \%param );
} ## end sub seed

sub serialize_config {
    my $app   = shift;
    my %param = @_;

    require MT::Serialize;
    my $ser  = MT::Serialize->new('MT');
    my $keys = $app->config_keys();
    my %set;
    foreach my $key ( keys %$keys ) {
        foreach my $p ( @{ $keys->{$key} } ) {
            $set{$p} = $param{$p};
        }
    }
    my $set = \%set;
    unpack 'H*', $ser->serialize( \$set );
}

sub unserialize_config {
    my $app  = shift;
    my $data = $app->query->param('config');
    my %config;
    if ($data) {
        $data = pack 'H*', $data;
        require MT::Serialize;
        my $ser    = MT::Serialize->new('MT');
        my $thawed = $ser->unserialize($data);
        if ($thawed) {
            my $saved_cfg = $$thawed;
            if ( keys %$saved_cfg ) {
                foreach my $p ( keys %$saved_cfg ) {
                    $config{$p} = $saved_cfg->{$p};
                }
            }
        }
    }
    %config;
} ## end sub unserialize_config

sub cgipath {
    my $app = shift;

    # these work for Apache... need to test for IIS...
    my $host = $ENV{SERVER_NAME} || $ENV{HTTP_HOST};
    $host =~ s/:\d+//;    # eliminate any port that may be present
    my $port = $ENV{SERVER_PORT};

    # REQUEST_URI for CGI-compliant servers; SCRIPT_NAME for IIS.
    my $uri = $ENV{REQUEST_URI} || $ENV{SCRIPT_NAME};
    $uri =~ s!/wizard(\.f?cgi|\.f?pl)(\?.*)?$!/!;

    my $cgipath = '';
    $cgipath = $port == 443 ? 'https' : 'http';
    $cgipath .= '://' . $host;
    $cgipath .= ( $port == 443 || $port == 80 ) ? '' : ':' . $port;
    $cgipath .= $uri;

    $cgipath;
} ## end sub cgipath

sub module_check {
    my $self    = shift;
    my $modules = shift;
    my ( @missing, @ok );
    foreach my $ref (@$modules) {
        my ( $mod, $ver, $req, $desc, $name, $link ) = @$ref;
        eval( "use $mod" . ( $ver ? " $ver;" : ";" ) );
        $mod .= $ver if $mod eq 'DBD::ODBC';
        if ($@) {
            push @missing,
              {
                module      => $mod,
                version     => $ver,
                required    => $req,
                description => $desc,
                label       => $name,
                link        => $link
              };
        }
        else {
            push @ok,
              {
                module      => $mod,
                version     => $ver,
                required    => $req,
                description => $desc,
                label       => $name,
                link        => $link
              };
        }
    } ## end foreach my $ref (@$modules)
    ( \@missing, \@ok );
} ## end sub module_check

sub static_path {
    my $app         = shift;
    my $static_path = '';

    if ( $app->config->StaticWebPath ne '' ) {
        $static_path = $app->config->StaticWebPath;
        $static_path .= '/' unless $static_path =~ m!/$!;
        return $static_path;
    }
    return $app->mt_static_exists ? $app->cgipath . 'mt-static/' : '';
}

sub mt_static_exists {
    my $app = shift;
    return ( -f File::Spec->catfile( $app->{mt_dir}, "mt-static", "mt.js" ) )
      ? 1
      : 0;
}

sub is_valid_static_path {
    my $app = shift;
    my ($static_uri) = @_;

    my $path;
    if ( $static_uri =~ m/^http/i ) {
        $path = $static_uri . 'mt.js';
    }
    elsif ( $static_uri =~ m#^/# ) {
        my $host = $ENV{SERVER_NAME} || $ENV{HTTP_HOST};
        $host =~ s/:\d+//;    # eliminate any port that may be present
        my $port = $ENV{SERVER_PORT};
        $path = $port == 443 ? 'https' : 'http';
        $path .= '://' . $host;
        $path .= ( $port == 443 || $port == 80 ) ? '' : ':' . $port;
        $path .= $static_uri . 'mt.js';
    }
    else {
        $path = $app->cgipath . $static_uri . 'mt.js';
    }

    require LWP::UserAgent;
    my $ua       = LWP::UserAgent->new;
    my $request  = HTTP::Request->new( GET => $path );
    my $response = $ua->request($request);
    $response->is_success
      and ( $response->content_length() != 0 )
      && ( $response->content =~ m/function\s+openManual/s );
} ## end sub is_valid_static_path

sub is_config_exists {
    my $app = shift;

    eval { use File::Spec; };
    my ( $cfg, $cfg_exists, $static_file_path );
    if ( !$@ ) {
        $cfg = File::Spec->catfile( $app->{mt_dir}, 'config.cgi' );
        $cfg_exists |= 1 if -f $cfg;
    }
    return $cfg_exists;
}

sub is_mtconfig_exists {
    my $app = shift;

    eval { use File::Spec; };
    my ( $cfg, $cfg_exists, $static_file_path );
    if ( !$@ ) {
        $cfg = File::Spec->catfile( $app->{mt_dir}, 'mt-config.cgi' );
        $cfg_exists |= 1 if -f $cfg;
    }
    return $cfg_exists;
}

1;
__END__

=head1 NAME

MT::App::Wizard

=head1 METHODS

=head2 build_page

=head2 cfg_dir

=head2 cfg_dir_conditions

=head2 cgipath

=head2 config_keys

=head2 configure

=head2 id

=head2 init

=head2 init_config

=head2 init_core_registry

=head2 init_request

=head2 is_config_exists

=head2 is_valid_static_path

=head2 module_check

=head2 mt_static_exists

=head2 object_drivers

=head2 optional

=head2 pre_start

=head2 run_step

=head2 seed

=head2 serialize_config

=head2 start

=head2 static_path

=head2 unserialize_config

=head2 wizard_steps


=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
