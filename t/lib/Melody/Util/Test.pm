package Melody::Util::Test;
use strict;
use warnings;

use File::Spec;

sub find_addon_libs {
	my $addons_full_path = shift;
	my @libs;
	opendir ADDONS, $addons_full_path;
	my @addons = readdir ADDONS;
	closedir ADDONS;
	for (@addons) {
		my $plugin_full_path = File::Spec->catdir($addons_full_path, $_);
		next unless -d $plugin_full_path;
		next if $_ eq '..';
		opendir SUBDIR, $plugin_full_path;
		my @plugin_files = readdir SUBDIR;
		closedir SUBDIR;
		for my $file (@plugin_files) {
			if ($file eq 'lib' || $file eq 'extlib') {
				my $plib = File::Spec->catdir($plugin_full_path, $file);
				unshift @libs, $plib if -d $plib;
			}
		}
	}
	return \@libs;
}

1;
