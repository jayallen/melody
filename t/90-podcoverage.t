#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use lib 'extlib';
use lib 't/inc/lib';

use Test::More;
use File::Spec;
use Melody::Util::Test;

eval "use Test::Pod::Coverage";
plan skip_all => "Test::Pod::Coverage required for testing pod coverage" if $@;

my $here = File::Spec->curdir();
my @dirs = File::Spec->catdir($here, 'lib'); 
push @dirs, @{Melody::Util::Test::find_addon_libs(File::Spec->catdir($here, 'addons'))};
push @dirs, @{Melody::Util::Test::find_addon_libs(File::Spec->catdir($here, 'plugins'))};
my $trust = { 
	also_private => [qr/^[A-Z_]+$/],
	trustme => [qr/^(class_label|class_label_plural)$/],
    coverage_class => 'Pod::Coverage::CountParents',
};
my @mods = grep { ! qr{^MT::(App|CMS)::} } all_modules(@dirs);
plan tests => scalar @mods;
pod_coverage_ok("$_", $trust) for @mods;
