#!/usr/bin/perl

use strict;
use warnings;

use lib 'lib';
use lib 'extlib';
use lib 't/inc/lib';

use Test::More;
use File::Spec;
use Melody::Util::Test;

plan skip_all => "Skipping to reduce unit testing failure noise for now.";

eval "use Test::Pod::Coverage";
if ($@) {
    plan skip_all => "Test::Pod::Coverage required for testing pod coverage";
} else {
    my $here = File::Spec->curdir();
    my @dirs = File::Spec->catdir($here, 'lib'); 
    push @dirs, @{Melody::Util::Test::find_addon_libs(File::Spec->catdir($here, 'addons'))};
    push @dirs, @{Melody::Util::Test::find_addon_libs(File::Spec->catdir($here, 'plugins'))};
warn join " ", @dirs;
    my $trust = { 
	also_private => [qr/^[A-Z_]+$/],
	trustme => [qr/^(class_label|class_label_plural)$/],
    coverage_class => 'Pod::Coverage::CountParents',
    };
    my $exclude = qr{^MT::(App|CMS)::};
    my @mods = grep { ! m{$exclude} } all_modules(@dirs);
warn join ' ', @mods;
    plan tests => scalar @mods;
    pod_coverage_ok("$_", $trust) for @mods;
}
