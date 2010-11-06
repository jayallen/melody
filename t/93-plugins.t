#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 16;

use MT;
use MT::Test qw( :app :db );

# get the list of plugins and place them in a hash
my $plugins = ();

my $app = MT->instance();
# The horse left the barn long ago
# my $cfg = $app->config;
# $cfg->PluginPath(['t/plugins', 'plugins']); 
$app->init_plugins();

for my $sig ( keys %MT::Plugins ) {
    # print STDERR "Plugin: $sig\n";
    my $profile = $MT::Plugins{$sig};
    if ( my $plugin = $profile->{object} ) {
        # print STDERR "  name: " . $plugin->name . "($sig,".ref($profile->{object}).")\n";
        $plugins->{ $plugin->name }++;
    }
}

###########################################################
# Test for the existence of at least these plugins
###########################################################

# plguins that really exist with the build
ok (exists $plugins->{"MultiBlog"}, "MultiBlog exists");
ok (exists $plugins->{"Markdown and SmartyPants"}, "Markdown exists");
ok (exists $plugins->{"Configuration Assistant"}, "Config Assistant exists");
ok (exists $plugins->{"Theme Exporter"}, "Theme Exporter exists");
ok (exists $plugins->{"Theme Manager"}, "Theme Manager exists");
ok (exists $plugins->{"Simple Rich Text Editor"}, "Simple Rich Text Editor exists");
ok (exists $plugins->{"DePoClean"}, "DePoClean exists");
ok (exists $plugins->{"Open Melody Community Feedback"}, "Open Melody Community Feedback exists");
ok (exists $plugins->{"WXR Importer"}, "WXR Importer exists");
ok (exists $plugins->{"TypePad AntiSpam"}, "TypePad AntiSpam exists");

ok (exists $plugins->{"Rebless Me"}, "Rebless Me Test Plugin exists");

ok (ref($MT::Plugins{'Rebless/config.yaml'}->{'object'}) eq 'Rebless::Plugin','Rebless Plugin is Rebless::Plugin');
ok (ref($MT::Plugins{'ConfigAssistant.pack/config.yaml'}->{'object'}) eq 'MT::Component','Config Assistant is MT::Component');
ok (ref($MT::Plugins{'ThemeManager.plugin/config.yaml'}->{'object'}) eq 'MT::Plugin','Theme Manager is MT::Plugin')
;

SKIP: {
    # To test these, you need to do one of the following:
    #   1) use a custom config file (like the ones we used to have) so you can
    #      set the PluginPath normally
    #   2) bootstrap the app yourself or 
    #   3) Override/Hook into the init process so you can set the PluginPath
    #      BEFORE the plugins are initialized, or
    #   4) Break up the damn _init_plugins_core method so that it's actually
    #      testable.
    skip "MT::Test dummy plugins skipped", 2
        unless ref( $app->config->PluginPath ) eq 'ARRAY'
           and grep { m{(t|..)/plugins$} } @{ $app->config->PluginPath };

    # test plugins created by MT::Test
    ok (exists $plugins->{"Awesome"}, "Awesome exists");
    ok (exists $plugins->{"testplug.pl"}, "testplug.pl exists");
};
