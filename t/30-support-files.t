#!/usr/bin/perl

use strict;
use warnings;

BEGIN {
    use lib qw( lib extlib t/lib );
    $ENV{MT_CONFIG} = 'sqlite-test.cfg';
    $ENV{MT_APP}    = 'MT::App::CMS';
}

use Test::More tests => 7;
use MT;
use MT::Test qw( :app :db );
use MT::Builder;
use MT::Template::Context;

my $app = MT::App::CMS->instance();
my $cfg = $app->config;

diag('Now testing default SupportDirectoryPath and SupportDirectoryURL');

is( $cfg->get('SupportDirectoryPath'),
    '', 'Default SupportDirectoryPath config' );    #1

is( $cfg->get('SupportDirectoryURL'),
    '', 'Default SupportDirectoryURL config' );     #2

is( $app->support_directory_path(),
    File::Spec->catdir( $app->static_file_path, 'support' ) . '/',
    'Default $app->support_directory_path()' );     #3

is( $app->support_directory_url(),
    File::Spec->catdir( $app->static_path, 'support' ) . '/',
    'Default $app->support_directory_url()' );      #4

diag('Now setting SupportDirectoryPath and SupportDirectoryURL');

$cfg->set( 'SupportDirectoryPath', '/PATH/TO/SOME/SUPPORT' );
$cfg->set( 'SupportDirectoryURL', 'http://example.com/PATH/TO/SOME/SUPPORT' );

is( $app->support_directory_path(),
    '/PATH/TO/SOME/SUPPORT/', 'Updated $app->support_directory_path()' );   #5

is(
    $app->support_directory_url(),
    'http://example.com/PATH/TO/SOME/SUPPORT/',
    'Updated $app->support_directory_path()'
);                                                                          #6

my $builder = MT::Builder->new;
my $ctx     = MT::Template::Context->new;
my $tokens  = $builder->compile( $ctx, '<$mt:SupportDirectoryURL$>' );      #7
is( $builder->build( $ctx, $tokens ),
    $app->support_directory_url(),
    '<$mt:SupportDirectoryURL$>' );                                         #7
