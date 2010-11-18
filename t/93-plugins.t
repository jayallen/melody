#!/usr/bin/perl
use strict;
use warnings;
use lib 't/lib', 'lib', 'extlib', 'addons/Log4MT.plugin/extlib';
use Data::Dumper;
use Test::Warn;
use Test::More tests => 16;
use MT;
use MT::Log::Log4perl qw( l4mtdump ); use Log::Log4perl qw( :resurrect );
###l4p our $logger = MT::Log::Log4perl->new(); $logger->trace();

our ( $app );

my %test_info = (

    'Markdown.plugin/config.yaml' => {
        name        => 'Markdown and SmartyPants',
        base_class  => 'MT::Plugin',  #     <----- DEFAULT
        plugin_path => 'addons',      #     <----- DEFAULT
        enabled     => 1,             #     <----- DEFAULT
    },
    'Awesome/config.yaml'             => { name => 'Awesome'            },
    'ThemeExport.plugin/config.yaml'  => { name => 'Theme Exporter'     },
    'ThemeManager.plugin/config.yaml' => { name => 'Theme Manager'      },
    'DePoClean.plugin/config.yaml'    => { name => 'DePoClean'          },
    'WXRImporter.plugin/config.yaml'  => { name => 'WXR Importer'       },
    'ClassicBlogThemePack.plugin/config.yaml' 
                                => { name => 'Classic Blog Theme Pack'      },
    'SimpleEditor.plugin/config.yaml'
                                => { name => 'Six Apart Rich Text Editor'   },
    'MelodyFeedback.plugin/config.yaml'
                                => { name => 'Open Melody Community Feedback' },
    'MultiBlog.plugin/config.yaml' => {
        name         => 'MultiBlog',
        base_class   => 'MultiBlog::Plugin',
    },
    'TypePadAntiSpam.plugin/config.yaml' => {
        name         => 'TypePad AntiSpam',
        base_class   => 'TypePadAntiSpam::Plugin',
    },
    'ConfigAssistant.pack/config.yaml' => {
        name         => 'Configuration Assistant',
        base_class   => 'MT::Component',
    },
    'Rebless/config.yaml' => {
        name         => 'Rebless Me',
        base_class   => 'Rebless::Plugin',
    },
    'testplug.pl' => {
        message      => ': Non-folder plugin not loaded',
        not_loaded   => 1,
    },
    'subfoldered/subfolderedplug.pl' => {
        name        => 'Subfoldered legacy format plugin',
        # message    => ': Non-folder plugin not loaded',
        # not_loaded => 1,
    }
);

warnings_like {
    use MT::Test qw( :app :db );

    $app = MT->instance();
    $app->init_plugins();
}
[
    qr/testplug.pl.+not loaded.+plugins.+without.+enclosing folder/,
    qr/.+plugin \(subfolderedplug.pl\).+deprecated plugin file format/
],
'Deprecation and compatibility break warnings';

###l4p $logger->debug("PLUGIN: $_") foreach keys %MT::Plugins;

# map { $MT::Plugins{$_}->{object}->name => { plugin}} keys %MT::Plugins

my %Test = ();
foreach my $sig ( sort keys %MT::Plugins ) {
    my $profile   = $MT::Plugins{ $sig };
    my $info      = delete $test_info{ $sig };
    $Test{ $sig } = {
        enabled => $profile->{enabled} || 0,
        plugin  => $profile->{object},
        $info ? (info => $info) : (),
    }
}
my $plugins = {  } keys %MT::Plugins };
print STDERR Dumper($plugins);

# get the list of plugins and place them in a hash
foreach my $test ( @tests ) {


    # test plugins created by MT::Test
    ok( exists $plugins->{"Awesome"},     "Awesome exists" );
    ok( exists $plugins->{"testplug.pl"}, "testplug.pl exists" );
}
