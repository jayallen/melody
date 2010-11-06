use lib qw( t/lib lib extlib );

use strict;
use warnings;

use MT::Test qw( :memcached :db :data :app );
use Test::More tests => 6;

require MT::Author;

# it's in cache now
# we should *reload it* and start again
my $o = MT::Author->load(1);

require MT::Object;
MT::Object->driver->clear_cache;

$o = MT::Author->load(1);
MT::Author->install_meta(
                         { column_defs => { my_meta_hash => 'hash meta' } } );

ok( !defined $o->my_meta_hash, "New meta column isn't defined yet" );

$o->my_meta_hash( { something => 'other' } );
$o->meta_obj->save;

my $ref_o = MT::Author->load(1);

ok( defined $ref_o->my_meta_hash, "New meta column is now defined" );
is( $ref_o->my_meta_hash->{something},
    'other',
    "New meta column has the right HASH value ({'something' => 'other'})" );

my $obj = $ref_o->clone_all;

diag "save entire object";
$ref_o->save;

diag "set the meta field to {something => 'else'}";
$ref_o->my_meta_hash( { something => 'else' } );

diag "save the meta object";
$ref_o->meta_obj->save;

diag "load object";
$ref_o = MT::Author->load(1);
is( $ref_o->my_meta_hash->{something}, 'else',
    "New meta column has the right HASH value ({'something' => 'else'}) after update"
);

MT::Object->driver->clear_cache
  ;    # reset ramcache to make sure data is coming from memcached

$ref_o->my_meta_hash( { a_new => 'hash' } );
$ref_o->meta_obj->save;

MT::Object->driver->clear_cache;

$ref_o = MT::Author->load(1);
ok( exists $ref_o->my_meta_hash->{a_new},
    "Meta column has a new key in its hash" );

MT::Author->install_meta(
                     { column_defs => { 'field.my_field' => 'hash meta' } } );

my $author = MT::Author->load(1);
$author->meta( 'field.my_field', { foo => 11 } );
$author->save;

MT::Object->driver->clear_cache;
$author = MT::Author->load(1);
my $collection = $author->meta_obj->get_collection('field');
ok( %$collection, "get_collection retrieves multiple field meta objects" );


