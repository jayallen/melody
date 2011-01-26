use lib qw( t/lib lib extlib );

use strict;
use warnings;

use MT::Test qw( :memcached :db :data :app );
use Test::More tests => 7;

require MT::Blog;

# it's in cache now
# we should *reload it* and start again
my $blog = MT::Blog->load(1);

$blog->clear_cache;

$blog = MT::Blog->load(1);
is( $blog->meta('page_layout'),
    'layout-wtt', "page_layout meta column is correct" );
MT::Blog->install_meta( { column_defs => { my_meta_hash => 'hash meta' } } );

ok( !defined $blog->my_meta_hash, "New meta column isn't defined yet" );

$blog->my_meta_hash( { something => 'other' } );
$blog->meta_obj->save;

my $ref_blog = MT::Blog->load(1);

ok( defined $ref_blog->my_meta_hash, "New meta column is now defined" );
is( $ref_blog->my_meta_hash->{something},
    'other',
    "New meta column has the right HASH value ({'something' => 'other'})" );

diag "save entire object";
$ref_blog->save;

diag "set the meta field to {something => 'else'}";
$ref_blog->my_meta_hash( { something => 'else' } );

diag "save the meta object";
$ref_blog->meta_obj->save;

diag "load blog object";
$ref_blog = MT::Blog->load(1);
is( $ref_blog->my_meta_hash->{something}, 'else',
    "New meta column has the right HASH value ({'something' => 'else'}) after update"
);

$ref_blog->clear_cache
  ;    # reset ramcache to make sure data is coming from memcached

$ref_blog->my_meta_hash( { a_new => 'hash' } );
$ref_blog->meta_obj->save;

$ref_blog->clear_cache;

$ref_blog = MT::Blog->load(1);
ok( exists $ref_blog->my_meta_hash->{a_new},
    "Meta column has a new key in its hash" );

MT::Author->install_meta(
                     { column_defs => { 'field.my_field' => 'hash meta' } } );

my $author = MT::Author->load(1);
$author->meta( 'field.my_field', { foo => 11 } );
$author->save;

$author->clear_cache;
$author = MT::Author->load(1);
my $collection = $author->meta_obj->get_collection('field');
ok( %$collection, "get_collection retrieves multiple field meta objects" );


