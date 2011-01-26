#!/usr/bin/perl
use strict;
use warnings;
use lib 't/lib', 'lib', 'extlib', 'addons/Log4MT.plugin/extlib';
use Data::Dumper;
use Test::Warn;
use Test::More tests => 11;
use MT;
use MT::Log::Log4perl qw( l4mtdump ); use Log::Log4perl qw( :resurrect );
###l4p our $logger = MT::Log::Log4perl->new(); $logger->trace();

our ( $app );
my %Test = ();          # Hash of tests to run
my @extra_plugins;      # Array of (custom?) plugins which are not included

# Bundled plugins included in our tests indexed by plugin
# signature with expected test values
my %bundled_plugins = (
    'Markdown.plugin/config.yaml' => {
        name        => 'Markdown and SmartyPants',
        base_class  => 'MT::Plugin',  #     <----- DEFAULT
        plugin_path => 'addons',      #     <----- DEFAULT
        enabled     => 1,             #     <----- DEFAULT
    },
    'ThemeExport.plugin/config.yaml'  => { name => 'Theme Exporter'  },
    'ThemeManager.plugin/config.yaml' => { name => 'Theme Manager'   },
    'DePoClean.plugin/config.yaml'    => { name => 'DePoClean'       },
    'WXRImporter.plugin/config.yaml'  => { name => 'WXR Importer'    },
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
);

# Initialize app and plugins
use MT::Test qw( :app :db );
$app = MT->instance();
$app->init_plugins();

###l4p $logger->debug("PLUGIN: $_") foreach keys %MT::Plugins;

# Compile test data for LOADED plugins
foreach my $sig ( sort keys %MT::Plugins ) {
    my $info      = delete $bundled_plugins{ $sig };
    unless ( $info ) {
        push( @extra_plugins, $sig );
        next;
    }
    my $profile   = $MT::Plugins{ $sig };
    $Test{ $sig } = {
        enabled => $profile->{enabled} || 0,
        plugin  => $profile->{object},
        $info ? (info => $info) : (),
    }
}

# Compile test data for NON-LOADED plugins
foreach my $sig ( sort keys %bundled_plugins ) {
    $Test{ $sig } = {
        info => $bundled_plugins{ $sig }
    }
}

# Execute the tests
foreach my $sig ( sort keys %Test ) {
    my $test = $Test{$sig};
    subtest $sig => sub {
        plan tests => 2;
        my $info = $test->{info};
        $info->{base_class} ||= 'MT::Plugin';
        $info->{message}    ||= " exists";
        my $loaded = $info->{not_loaded} ? 0 : 1;
        is(
            ($sig && exists $MT::Plugins{$sig}) ? 1 : 0,
            $loaded,
            $sig . $info->{message}
        );
        SKIP: {
            skip "Plugin not loaded", 1 unless $loaded;
            is(
                ref( $MT::Plugins{$sig}->{'object'} ),
                $info->{base_class},
                $info->{name}.' base class is '.$info->{base_class}
            );
        }
    };

}

# Warn about any plugins not included since they might be newly bundled
diag("The following plugins were not included in the test: \n\t* "
    .join("\n\t* ", @extra_plugins));
