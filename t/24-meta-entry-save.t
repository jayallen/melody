use lib qw( t/lib lib extlib );

use strict;
use warnings;

use MT::Test qw( :memcached :db :data :app );
use Test::More tests => 13;

require MT::Entry;

# it's in cache now
# we should *reload it* and start again
my $o = MT::Entry->load(1);

require MT::Object;
MT::Object->driver->clear_cache;

$o = MT::Entry->load(1);
MT::Entry->install_meta( { column_defs => { my_meta_hash => 'hash meta' } } );

ok( !defined $o->my_meta_hash, "New meta column isn't defined yet" );

$o->my_meta_hash( { something => 'other' } );

my @queries;
my $start_query = \&MT::ObjectDriver::Driver::DBI::start_query;
*MT::ObjectDriver::Driver::DBI::start_query = sub {
    my $driver = shift;
    my ( $sql, $bind ) = @_;
    push( @queries, $sql );
    my $params
      = ref $bind eq 'ARRAY' ? "[@{[map {defined() ? $_ : 'undef'} @$bind]}]"
      : ref $bind eq 'HASH'  ? "{@{[map {defined() ? $_ : 'undef'} %$bind]}}"
      :                        $bind;
    s/\r?\n/ /g for $sql, $params;
    diag "  $sql $params\n";
    return $start_query->( $driver, @_ );
};

diag "define new meta field, update it and do obj->save";
@queries = ();
$o->save;
is( grep( /INSERT INTO mt_entry_meta/, @queries ),
    1, "mt_entry_meta is inserted once" );
is( grep( /UPDATE mt_entry /, @queries ), 0, "mt_entry is not updated" );

$o = MT::Entry->load(1);
$o->my_meta_hash( { something => 'more' } );

diag "update meta field and do obj->save";
@queries = ();
$o->save;
is( grep( /UPDATE mt_entry_meta/, @queries ),
    1, "mt_entry_meta is updated once" );
is( grep( /UPDATE mt_entry /, @queries ), 0, "mt_entry is not updated" );

$o->my_meta_hash( { something => 'else' } );

diag "update meta field and do obj->meta_obj->save";
@queries = ();
$o->meta_obj->save;
is( grep( /UPDATE mt_entry_meta/, @queries ),
    1, "mt_entry_meta is updated once" );
is( grep( /UPDATE mt_entry /, @queries ), 0, "mt_entry is not updated" );

diag "do obj->save";
@queries = ();
$o->save;
is( grep( /UPDATE mt_entry_meta/, @queries ),
    0, "mt_entry_meta is not updated" );
is( grep( /UPDATE mt_entry /, @queries ), 0, "mt_entry is not updated" );

$o->text_more('foo bar');
diag "update one of direct fields and do obj->save";
@queries = ();
$o->save;
is( grep( /UPDATE mt_entry_meta/, @queries ),
    0, "mt_entry_meta is not updated" );
is( grep( /UPDATE mt_entry /, @queries ), 1, "mt_entry is updated once" );

diag "do obj->save";
@queries = ();
$o->save;
is( grep( /UPDATE mt_entry_meta/, @queries ),
    0, "mt_entry_meta is not updated" );
is( grep( /UPDATE mt_entry /, @queries ), 0, "mt_entry is not updated" );

