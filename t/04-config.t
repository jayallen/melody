#!/usr/bin/perl
# $Id$
use strict;
use warnings;
use lib qw( lib extlib t/lib );

use Data::Dumper;
use Cwd;
use File::Spec;
use File::Temp qw( tempfile );
use vars qw( $BASE );
use Carp qw( longmess );
use File::Basename qw( basename fileparse dirname );


use Test::More tests => 4;

use MT;
use MT::ConfigMgr;
use MT::Test;

require 't/test-common.pl';

$ENV{CONFIGMGRDEBUG} = 0;

# The massive default value list of DeniedAssetFileExtensions
my @denied_exts = qw(
  ascx asis asp aspx bat cfc cfm cgi cmd com cpl dll
  exe htaccess html? inc jhtml js jsb jsp mht(ml)?
  msi php[s\d]? phtml? pif pl pwml py reg scr
  sh shtml? vbs vxd
);

my ( $mt, $cfg, $cfg_file );

subtest "Read config test for MT constructor" => sub {

    plan tests => 3;

    $cfg = init_config();

    isa_ok( $mt,  'MT' );
    isa_ok( $cfg, 'MT::ConfigMgr' );
    ok( -f db_dir() . '/mt.db', 'Database file' );
};


subtest 'MT::ConfigMgr API - accessors/mutators/defaults' => sub {

    plan tests => 6;

    ## Test standard get/set
    $cfg->set( 'DataSource', './db2' );
    is( $cfg->get('DataSource'), './db2', 'get(DataSource)=./db2' );

    ## Test autoloaded methods
    is( $cfg->DataSource, './db2', 'autoloaded DataSource=./db2' );
    $cfg->DataSource('./db');
    is( $cfg->DataSource, './db', 'autoloaded DataSource=./db2' );

    ## Test defaults
    is( $cfg->Serializer, 'MT', 'Serializer=MT' );
    is( $cfg->TimeOffset, 0,    'TimeOffset=0' );

    ## Test bug in early version of ConfigMgr where space was not
    ## stripped from the ends of values.
    ## NOTE: ObjectDriver config forces downcasing on sqlite, mysql, etc
    is( $cfg->ObjectDriver, 'DBI::sqlite', 'ObjectDriver=SQLite' );
};


subtest
  'MT::ConfigMgr API - accessors/mutators/defaults for ARRAY directives' =>
  sub {

    plan tests => 12;

    my @array_vars
      = qw( AssetFileExtensions PluginPath DeniedAssetFileExtensions );

    ## Test data type for ARRAY directives;
    is( $cfg->type($_), 'ARRAY', "MT::ConfigMgr::type: $_ is ARRAY" )
      foreach @array_vars;

    ## Test contextual return values (list vs scalar)
    my @exts = $cfg->DeniedAssetFileExtensions;   # List context returns array
    my $exts = $cfg->DeniedAssetFileExtensions;   # Scalar context returns ref
    is_deeply( $exts, \@exts,
               'MT::ConfigMgr::get: Contextual return values' );

    ## Test array directive default values
    is_deeply(
               [ $cfg->AssetFileExtensions ],
               [],
               'MT::ConfigMgr::get ARRAY directive defaults: '
                 . 'AssetFileExtensions undefined'
    );

    my $got = $cfg->PluginPath;
    is_deeply(
        $got,

        # Converted by MT::init_config into an absolute path
        [ File::Spec->catdir( $mt->{config_dir}, 'plugins' ) ],
        'MT::ConfigMgr::get ARRAY directive defaults: PluginPath is populated'
    ) || diag explain $got;

    is_deeply(
               $exts,
               \@denied_exts,
               'MT::ConfigMgr::get ARRAY directive defaults: '
                 . 'DeniedAssetFileExtensions is heavily populated'
    );

    ## Test MT::ConfigMgr::default() method
    foreach (@array_vars) {
        my $vals = $cfg->$_;
        my $defs = $cfg->default($_);
        if ( $cfg->is_path($_) ) {

            # Cloned so we don't affect the referent
            my @temp
              = map { File::Spec->catdir( $mt->{config_dir}, $_ ) } @$defs;
            $defs = \@temp;
        }
        is_deeply( $defs, $vals,
                   "MT::ConfigMgr::default: Method matches value for $_" )
          || diag explain $defs;
    }

    ## Test appending to an existing ARRAY directive
    my $orig_cnt = my @ppaths = $cfg->PluginPath;

    $cfg->set( 'PluginPath', 'seekret' );

    @ppaths = $cfg->PluginPath;
    is( scalar @ppaths,
        $orig_cnt + 1,
        'MT::ConfigMgr::set: Scalar value arg appends to ARRAY directive' );

    ## Test overriding an existing ARRAY directive
    my @replacements = qw( ernie bert elmo zoe );
    $cfg->set( 'PluginPath', [@replacements] );
    @ppaths = $cfg->PluginPath;
    is_deeply( \@ppaths, [@replacements],
        'MT::ConfigMgr::set: Arrayref value arg overwrites ARRAY directive' );
  };


subtest "Config file assignment of ARRAY directives" => sub {

    plan tests => 4;

    $cfg = init_config(
        <<"    CFG"
        AltTemplate foo bar
        AltTemplate baz quux
        DeniedAssetFileExtensions xls
        DeniedAssetFileExtensions doc
        DeniedAssetFileExtensions ppt
    CFG
    );

    # Test AltTemplate config data type
    is( $cfg->type('AltTemplate'), 'ARRAY', 'AltTemplate=ARRAY' );

  TODO: {
        local $TODO = 'Search app hack overrides default behavior and '
          . 'prepends the default value to the array';

        # See MT::App::Search::Legacy::init_request
        # and MT::App::Search::load_search_tmpl

        # Test for overriden ARRAY value
        my $paths = $cfg->AltTemplate;
        is_deeply( $paths,
                   [ 'foo bar', 'baz quux' ],
                   'AltTemplate: Config file overrides defaults' )
          or diag explain $paths;
    }

    # Test for overridden ARRAY value
    my $override = [qw( xls doc ppt )];
    my $exts     = $cfg->DeniedAssetFileExtensions;
    is_deeply( $exts, [qw( xls doc ppt )],
               'DeniedAssetFileExtensions: Config file overrides default' )
      || diag explain $exts;

    # Write new config using special __DEFAULT__ value
    $cfg = init_config(
        <<"    CFG"
        DeniedAssetFileExtensions __DEFAULT__
        DeniedAssetFileExtensions huey
        DeniedAssetFileExtensions dewey
        DeniedAssetFileExtensions louie
    CFG
    );

    # Test for values appended onto ARRAY default value
    $exts = $cfg->DeniedAssetFileExtensions;
    is_deeply(
             $exts,
             [ @denied_exts, qw( huey dewey louie ) ],
             'DeniedAssetFileExtensions: Config file with __DEFAULT__ appends'
    ) || diag explain $exts;

};

# subtest 'MT::ConfigMgr API - accessors/mutators/defaults for HASH directives' => sub {
#     plan tests => 0;
# };
#
# subtest "Config file assignment of HASH directives" => sub {
#     plan tests => 0;
#     # AtomApp
#     # PluginSwitch
#     # PluginSchemaVersion
#     # DefaultListPrefs
#     # DefaultEntryPrefs
#     # CommenterRegistration
#     # AssetFileTypes
# };

{
    local $ENV{CONFIGMGRDEBUG} = 1;
}

{
    my ( $base_config, $db_dir );

    sub base_config {
        return $base_config if $base_config;
        my $app = MT->instance
          or die "Could not get MT instance: " . MT->errstr;
        my $mgr = $app->config()
          or die "Could not instantiate base config: " . $app->errstr;
        $base_config = $mgr->{__config_contents}
          or die "Base config is empty: " . $mgr->errstr;
    }

    sub db_dir {
        return $db_dir if $db_dir;
        ( my $cwd = cwd() ) =~ s{/+$}{};
        $db_dir = File::Spec->catfile( $cwd, 't', 'db' );
    }
}

sub create_db_dir {
    my $db_dir = db_dir();
    -d $db_dir || mkdir($db_dir) or die "Could not create DB directory: $!";
    $db_dir;
}

sub write_config_file {
    my $data = shift || '';
    my ( $fh, $cfg_file ) = tempfile();
    $ENV{CONFIGMGRDEBUG}
      and diag __PACKAGE__ . "::write_config_file: cfg_file = $cfg_file";

    print $fh join( "\n", base_config(), $data ) . "\n";
    close $fh;
    return $cfg_file;
}

sub init_config {
    my $config = shift || '';
    $config =~ s{^[\s\t]+}{}gsm;    # Strip leading space from heredoc

    $cfg_file = write_config_file($config)
      or die "Could not write config file: $!";

    my $db_dir = create_db_dir();

    $mt ||= MT->instance;

    # Undefine our current config
    delete $mt->{cfg};
    undef $cfg;
    undef $MT::ConfigMgr::cfg;

    $ENV{MT_CONFIG} = $mt->{cfg_file} = $cfg_file;
    $mt->init_config( { Directory => $mt->{mt_dir} } );

    # $mt->{config_dir} = dirname( db_dir() );

    return $mt->config();
} ## end sub init_config
