#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 11;

use MT;
use MT::Test qw( :app :db );

# get the list of plugins and place them in a hash
my $plugins = ();

my $app = MT->instance();
my $cfg = $app->config;
$cfg->PluginPath('addons');
$cfg->PluginPath('plugins');
$app->init_plugins();

for my $sig ( keys %MT::Plugins ) {
#    print STDERR "Plugin: $sig\n";
	my $profile = $MT::Plugins{$sig};
	if ( my $plugin = $profile->{object} ) {
        print STDERR "  name: " . $plugin->name . "\n";
		$plugins->{ $plugin->name }++;
	}
}

###########################################################
# Test for the existence of at least these plugins
###########################################################

# plguins that really exist with the build
ok (exists $plugins->{"MultiBlog"}, "MultiBlog exists");
ok (exists $plugins->{"Markdown"}, "Markdown exists");
ok (exists $plugins->{"SmartyPants"}, "SmartyPants exists");
ok (exists $plugins->{"Configuration Assistant"}, "Config Assistant exists");
ok (exists $plugins->{"Theme Exporter"}, "Theme Exporter exists");
ok (exists $plugins->{"Theme Manager"}, "Theme Manager exists");
ok (exists $plugins->{"Simple Rich Text Editor"}, "Simple Rich Text Editor exists");
ok (exists $plugins->{"DePoClean"}, "DePoClean exists");
ok (exists $plugins->{"Open Melody Community Feedback"}, "Open Melody Community Feedback exists");

# These are not loading for some reason
ok (exists $plugins->{"WXR Importer"}, "WXR Importer exists");
ok (exists $plugins->{"TypePad AntiSpam"}, "TypePad AntiSpam exists");

# test plugins created by MT::Test
ok (exists $plugins->{"Awesome"}, "Awesome exists");
# ok (exists $plugins->{"testplug.pl"}, "testplug.pl exists");
