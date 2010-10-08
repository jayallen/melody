#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 2;

BEGIN {
        $ENV{MT_APP} = 'MT::App::CMS';
}

use MT;
use MT::CMS::Entry;
use MT::Blog;
use MT::Test qw( :app :db :data );

my $app = MT::App::CMS->instance();

# get the current list of template sets from registry
my $sets = $app->registry("template_sets");
ok ($sets, "Template sets exist");
ok (exists $sets->{"mt_blog"}, "Blog template set exists");
