#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 15;

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
    print STDERR "Plugin: $sig\n";
	my $profile = $MT::Plugins{$sig};
	if ( my $plugin = $profile->{object} ) {
		$plugins->{ $plugin->name }++;
	}
}

###########################################################
# Test for the existence of at least these plugins
###########################################################

# plguins that really exist with the build
ok (exists $plugins->{"MultiBlog"}, "MultiBlog exists");
ok (exists $plugins->{"Textile"}, "Textile exists");
ok (exists $plugins->{"Markdown"}, "Markdown exists");
ok (exists $plugins->{"SmartyPants"}, "SmartyPants exists");
ok (exists $plugins->{"Widget Manager Upgrade Assistant"}, "Widget Manager Upgrade Assistant exists");
ok (exists $plugins->{"Configuration Assistant"}, "Config Assistant exists");
ok (exists $plugins->{"PubSubHubbub"}, "PubSubHubbub exists");

# These are not loading for some reason
ok (exists $plugins->{"StyleCatcher"}, "StyleCatcher exists");
ok (exists $plugins->{"WXR Importer"}, "WXR Importer exists");
ok (exists $plugins->{"TypePad AntiSpam"}, "TypePad AntiSpam exists");
ok (exists $plugins->{"SpamLookup - Keyword Filter"}, "SpamLookup - Keyword Filter exists");
ok (exists $plugins->{"SpamLookup - Link"}, "SpamLookup - Link exists");
ok (exists $plugins->{"SpamLookup - Lookups"}, "SpamLookup - Lookups exists");


#ok (exists $plugins->{"Action Streams"}, "Action Streams exists");
#ok (exists $plugins->{"Facebook Commenters"}, "Facebook Commenters exists");
#ok (exists $plugins->{"Blog Cloner"}, "Blog Cloner exists");
#ok (exists $plugins->{"Feeds.App Lite"}, "Feeds.App Lite exists");
#ok (exists $plugins->{"Motion"}, "Motion exists");
#ok (exists $plugins->{"Community Action Streams"}, "Community Action Streams exists");

# test plugins created by MT::Test
ok (exists $plugins->{"Awesome"}, "Awesome exists");
ok (exists $plugins->{"testplug.pl"}, "testplug.pl exists");
