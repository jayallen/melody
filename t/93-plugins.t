#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 16;

use MT;
use MT::Test qw( :app :db );

my $app = MT->instance();
$app->init_plugins();

###########################################################
# Test for the existence of at least these plugins
###########################################################

# plugins that really exist with the build
my @tests = (
    {
        sig          => 'Markdown.plugin/config.yaml',
        name         => 'Markdown and SmartyPants',
        base_class   => 'MT::Plugin'   # DEFAULT
    },
    {
        sig          => 'MultiBlog.plugin/config.yaml',
        name         => 'MultiBlog',
        base_class   => 'MultiBlog::Plugin',
    },
    {
        sig          => 'ThemeExport.plugin/config.yaml',
        name         => 'Theme Exporter',
    },
    {
        sig          => 'ThemeManager.plugin/config.yaml',
        name         => 'Theme Manager',
    },
    {
        sig          => 'ClassicBlogThemePack.plugin/config.yaml',
        name         => 'Classic Blog Theme Pack',
    },
    {
        sig          => 'SimpleEditor.plugin/config.yaml',
        name         => 'Six Apart Rich Text Editor',
    },
    {
        sig          => 'DePoClean.plugin/config.yaml',
        name         => 'DePoClean',
    },
    {
        sig          => 'MelodyFeedback.plugin/config.yaml',
        name         => 'Open Melody Community Feedback',
    },
    {
        sig          => 'WXRImporter.plugin/config.yaml',
        name         => 'WXR Importer',
    },
    {
        sig          => 'TypePadAntiSpam.plugin/config.yaml',
        name         => 'TypePad AntiSpam',
        base_class   => 'TypePadAntiSpam::Plugin',
    },
    {
        sig          => 'ConfigAssistant.pack/config.yaml',
        name         => 'Configuration Assistant',
        base_class   => 'MT::Component',
    },
    {
        sig          => 'Rebless/config.yaml',
        name         => 'Rebless Me',
        base_class   => 'Rebless::Plugin',
    },
    {
        sig          => 'Awesome/config.yaml',
        name         => 'Awesome',
    },
    {
        sig         => 'testplug.pl',
        message      => ': Non-folder plugin not loaded',
        not_loaded   => 1,
    },
    {
        sig         => 'subfoldered/subfolderedplug.pl',
        name        => 'Subfoldered legacy test plugin',
        # message    => ': Non-folder plugin not loaded',
        # not_loaded => 1,
    }
);


print STDERR "PLUGIN: $_\n" foreach keys %MT::Plugins;

# get the list of plugins and place them in a hash
my $plugins = {};
foreach my $test ( @tests ) {

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
