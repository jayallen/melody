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
    'addons/Markdown.plugin/config.yaml' => {
        name        => 'Markdown and SmartyPants',
        base_class  => 'MT::Plugin',  #     <----- DEFAULT
        plugin_path => 'addons',      #     <----- DEFAULT
        enabled     => 1,             #     <----- DEFAULT
    },
    't/plugins/Awesome/config.yaml'          => { name => 'Oh Awesome'      },
    'addons/ThemeExport.plugin/config.yaml'  => { name => 'Theme Exporter'  },
    'addons/ThemeManager.plugin/config.yaml' => { name => 'Theme Manager'   },
    'addons/DePoClean.plugin/config.yaml'    => { name => 'DePoClean'       },
    'addons/WXRImporter.plugin/config.yaml'  => { name => 'WXR Importer'    },
    'addons/ClassicBlogThemePack.plugin/config.yaml' 
                                => { name => 'Classic Blog Theme Pack'      },
    'addons/SimpleEditor.plugin/config.yaml'
                                => { name => 'Six Apart Rich Text Editor'   },
    'addons/MelodyFeedback.plugin/config.yaml'
                                => { name => 'Open Melody Community Feedback' },
    'addons/MultiBlog.plugin/config.yaml' => {
        name         => 'MultiBlog',
        base_class   => 'MultiBlog::Plugin',
    },
    'addons/TypePadAntiSpam.plugin/config.yaml' => {
        name         => 'TypePad AntiSpam',
        base_class   => 'TypePadAntiSpam::Plugin',
    },
    'addons/ConfigAssistant.pack/config.yaml' => {
        name         => 'Configuration Assistant',
        base_class   => 'MT::Component',
    },
    't/plugins/Rebless/config.yaml' => {
        name         => 'Rebless Me',
        base_class   => 'Rebless::Plugin',
    },
    't/plugins/stray.pl' => {
        message      => ': Stray, unloaded perl plugin',
        not_loaded   => 1,
    },
    't/plugins/stray.yaml' => {
        message      => ': Stray, unloaded yaml plugin',
        not_loaded   => 1,
    },
    't/plugins/subfoldered/subfoldered.pl' => {
        name        => 'Subfoldered plugin',
    }
);

warnings_like {
    use MT::Test qw( :app :db );

    $app = MT->instance();
    $app->init_plugins();
}
[
    qr/stray.pl.+not loaded.+plugins.+without.+enclosing folder/,
    qr/.+plugin \(subfoldered.pl\).+deprecated plugin file format/
],
'Deprecation and compatibility break warnings';

###l4p $logger->debug("PLUGIN: $_") foreach keys %MT::Plugins;

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


subtest $test->{sig} => sub {
        plan tests => 2;
        $test->{base_class} ||= 'MT::Plugin';
        $test->{message}    ||= " exists";
        my $loaded = $test->{not_loaded} ? 0 : 1;
        is(
            ($test->{sig} && exists $MT::Plugins{$test->{sig}}) ? 1 : 0,
            $loaded,
            $test->{sig} . $test->{message}
        );
        SKIP: {
            skip "Plugin not loaded", 1 unless $loaded;
            is(
                ref( $MT::Plugins{$test->{sig}}->{'object'} ),
                $test->{base_class},
                $test->{name}.' base class is '.$test->{base_class}
            );
        }
    };
 }


# get the list of plugins and place them in a hash
foreach my $test ( @tests ) {


    # test plugins created by MT::Test
    ok( exists $plugins->{"Awesome"},     "Awesome exists" );
    ok( exists $plugins->{"testplug.pl"}, "testplug.pl exists" );
}
