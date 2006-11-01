#!/usr/bin/perl
# $Id$
use strict;
use warnings;
use Test::More tests => 113;
use Fcntl qw( O_RDWR );

use vars qw( $DB_DIR $DB_BTREE );
use lib qw( lib t t/lib );
require 'test-common.pl';

use_ok 'MT';  #1
use_ok 'MT::ObjectDriver';  #2
use_ok 'MT::ConfigMgr';  #3
use_ok 'DB_File';  #4

## Our two object classes.
use_ok 'Foo';  #5
use_ok 'Bar';  #6

if (-d $DB_DIR) {
    system "rm -rf $DB_DIR";
}
mkdir $DB_DIR or die "Can't create dir '$DB_DIR': $!";

my $mgr = eval { MT::ConfigMgr->instance };
warn $@ if $@;
isa_ok($mgr, 'MT::ConfigMgr', 'manager');  #7

$mgr->DataSource($DB_DIR);

my $driver = MT::ObjectDriver->new('DBM');
warn $@ if $@;
isa_ok($driver, 'MT::ObjectDriver', 'driver');  #8

my(@foo, @bar);
my(@tmp, $tmp);

## Create an object.
$foo[0] = Foo->new;
ok($foo[0], 'Foo object created'); #9
$foo[0]->column('name', 'foo');
is($foo[0]->column('name'), 'foo', 'text=foo'); #10
$foo[0]->column('text', 'bar', 'bar');
is($foo[0]->column('text'), 'bar', 'text=bar'); #11
$foo[0]->column('status', 0);
is($foo[0]->column('status'), 0, 'status=0'); #12
$driver->save($foo[0]);

## Check that indexes are updated
for my $col (qw( name status created_on )) {
    my $idx = _tie_index($col, $driver); #13,16,19
    my $col_value = $foo[0]->column($col);
    my $idx_val = $idx->{ $col_value };
    ok($idx_val, "$col_value index value = $idx_val"); #14,17,20
    my %ids = map { $_ => 1 } split /$;/, $idx_val;
    ok(exists $ids{ $foo[0]->column('id') }, 'column id exists'); #15,18,21
}

## Load using ID
$tmp = $driver->load('Foo', $foo[0]->column('id'));
isa_ok($tmp, 'Foo'); #22
is($foo[0]->column('id'), $tmp->column('id'), 'id'); #23
is($foo[0]->column('name'), $tmp->column('name'), 'name'); #24
is($foo[0]->column('text'), $tmp->column('text'), 'text'); #25
## Load using single-column index
$tmp = $driver->load('Foo', { name => $foo[0]->column('name'), });
isa_ok($tmp, 'Foo'); #26
is($foo[0]->column('id'), $tmp->column('id'), 'id'); #27

## Load using multiple-column index
$tmp = $driver->load('Foo',
    { created_on => $foo[0]->column('created_on'),
      name => $foo[0]->column('name'), });
isa_ok($tmp, 'Foo'); #28
is($foo[0]->column('id'), $tmp->column('id'), 'id'); #29

## Create a new object so we can do range and limit lookups.
## Sleep first so that they get different created_on timestamps.
sleep(2);

$foo[1] = Foo->new;
isa_ok($tmp, 'Foo'); #30
$foo[1]->column('name', 'baz');
is($foo[1]->column('name'), 'baz', 'baz'); #31
$foo[1]->column('text', 'quux');
is($foo[1]->column('text'), 'quux', 'quux'); #32
$foo[1]->column('status', 1);
is($foo[1]->column('status'), 1, 'status=1'); #33
$driver->save($foo[1]);

## Check that indexes are updated
for my $col (qw( name status created_on )) {
    my $idx = _tie_index($col, $driver); #27 #30 #33
    my $col_value = $foo[1]->column($col);
    ok(my $idx_val = $idx->{ $col_value }, "$col_value index value"); #35,38,41
    my %ids = map { $_ => 1 } split /$;/, $idx_val;
    ok(exists $ids{ $foo[1]->column('id') }, 'id exists'); #36,39,42
}

## Load using ID
$tmp = $driver->load('Foo', $foo[1]->column('id'));
isa_ok($tmp, 'Foo'); #43
is($foo[1]->column('id'), $tmp->column('id'), 'id'); #44
is($foo[1]->column('name'), $tmp->column('name'), 'name'); #45
is($foo[1]->column('text'), $tmp->column('text'), 'text'); #46

## Load using single-column index
$tmp = $driver->load('Foo', { name => $foo[1]->column('name'), });
isa_ok($tmp, 'Foo'); #47
is($foo[1]->column('id'), $tmp->column('id'), 'id'); #48

## Load using non-existent ID (should fail)
$tmp = $driver->load('Foo', 3);
ok(!$tmp, 'driver undefined'); #49

## Load using descending sort (newest)
$tmp = $driver->load('Foo', undef, {
    sort => 'created_on',
    direction => 'descend',
    limit => 1 });
is($tmp->column('id'), 2, 'id=2'); #50

## Load using ascending sort (oldest)
$tmp = $driver->load('Foo', undef, {
    sort => 'created_on',
    direction => 'ascend',
    limit => 1 });
is($tmp->column('id'), 1, 'id=1'); #51

## Load using descending sort with limit = 2
@tmp = $driver->load('Foo', undef, {
    sort => 'created_on',
    direction => 'descend',
    limit => 2 });
is(@tmp, 2, 'array size=2'); #52
is($tmp[0]->column('id'), 2, 'id=2'); #53
is($tmp[1]->column('id'), 1, 'id=1'); #54

## Load using descending sort by created_on, no limit
@tmp = $driver->load('Foo', undef, {
    sort => 'created_on',
    direction => 'descend' });
is(@tmp, 2, 'array size=2'); #55
is($tmp[0]->column('id'), 2, 'id=2'); #56
is($tmp[1]->column('id'), 1, 'id=1'); #57

## Load using ascending sort by status, no limit
@tmp = $driver->load('Foo', undef, { sort => 'status', });
is(@tmp, 2, 'array size=2'); #58
is($tmp[0]->column('id'), 1, 'id=1'); #59
is($tmp[1]->column('id'), 2, 'id=2'); #60

## Load using 'last' where name = 'foo'
$tmp = $driver->load('Foo', { status => 0 }, {
    sort => 'created_on',
    direction => 'descend',
    limit => 1 });
is($tmp->column('id'), 1, 'id=1'); #61

## Load using range search, one less than foo[1]->created_on and newer
$tmp = $driver->load('Foo',
    { created_on => [ $foo[1]->column('created_on')-1 ] },
    { range => { created_on => 1 } });
isa_ok($tmp, 'Foo'); #62
is($tmp->column('id'), 2, 'id=2'); #63

## Range search, all items with created_on less than foo[1]->created_on
$tmp = $driver->load('Foo',
    { created_on => [ 0, $foo[1]->column('created_on')-1 ] },
    { range => { created_on => 1 } });
isa_ok($tmp, 'Foo'); #64
is($tmp->column('id'), 1, 'id=1'); #65

## Get count of objects
is($driver->count('Foo'), 2, 'count=2'); #66
is($driver->count('Foo', { status => 1 }), 1, 'count=1'); #67
is($driver->count('Foo',
        { created_on => [ $foo[1]->column('created_on') - 1 ] },
        { range => { created_on => 1 } }
    ),
    1, 'count=1'
); #68

## Change indexed column value, save
my $old_status = $foo[0]->column('status');
$foo[0]->column('status', 1);
$driver->save($foo[0]);

## Check that indexes are updated
{
    my $idx = _tie_index('status', $driver);  #69
    ok(!exists $idx->{$old_status}, 'no old_status'); #70
    ok(my $idx_val = $idx->{ $foo[0]->column('status') }, 'status index'); #71
    my %ids = map { $_ => 1 } split /$;/, $idx_val;
    ok(exists $ids{ $foo[0]->column('id') }, 'id'); #72
}

## Change indexed column value, save
$old_status = $foo[0]->column('status');
$foo[0]->column('status', 2);
$driver->save($foo[0]);

## Check that indexes are updated
{
    my $idx = _tie_index('status', $driver); #73
    ok(my $idx_val = $idx->{$old_status}, "oldstatus $old_status index"); #74
    my %ids = map { $_ => 1 } split /$;/, $idx_val;
    ok(!exists $ids{ $foo[0]->column('id') }, 'id'); #75
    ok($idx_val = $idx->{ $foo[0]->column('status') }, 'status index'); #76
    %ids = map { $_ => 1 } split /$;/, $idx_val;
    ok(exists $ids{ $foo[0]->column('id') }, 'id'); #77
}

## Override created_on timestamp, make sure it works
my $ts = substr($foo[1]->created_on, 0, -4) . '0000';
$foo[1]->created_on($ts);
$driver->save($foo[1]);
@tmp = $driver->load('Foo', undef, {
    sort => 'created_on',
    direction => 'descend',
    limit => 2 });
is(@tmp, 2, 'array size=2'); #78
is($tmp[0]->column('id'), 1, 'id=1'); #79
is($tmp[1]->column('id'), 2, 'id=2'); #80

## Test limit of 2 with direction descend, but without
## a sort option. This should sort by the most recently-added
## records, ie. sorted by ID, basically.
@tmp = $driver->load('Foo', undef, {
    direction => 'descend',
    limit => 2 });
is(@tmp, 2, 'array size=2'); #81
is($tmp[0]->column('id'), 2, 'id=2'); #82
is($tmp[1]->column('id'), 1, 'id=1'); #83

## Test loading using offset.
## Should load the second Foo object.
$tmp = $driver->load('Foo', undef, {
    direction => 'descend',
    sort => 'created_on',
    limit => 1,
    offset => 1 });
isa_ok($tmp, 'Foo'); #84
is($tmp->column('id'), 2, 'id=2'); #85

## We only have 2 Foo objects, so this should load
## only the second Foo object (because offset is 1).
@tmp = $driver->load('Foo', undef, {
    direction => 'descend',
    sort => 'created_on',
    limit => 2,
    offset => 1 });
is(@tmp, 1, 'array size=1'); #86
is($tmp[0]->column('id'), 2, 'id=2'); #87

## Should load the first Foo object (ascend).
$tmp = $driver->load('Foo', undef, {
    direction => 'ascend',
    sort => 'created_on',
    limit => 1,
    offset => 1 });
isa_ok($tmp, 'Foo'); #88
is($tmp->column('id'), 1, 'id=1'); #89

## Now test join loads.
## First we need to create a couple of Bar objects.
$bar[0] = Bar->new;
$bar[0]->column('foo_id', $foo[1]->id);
$bar[0]->column('name', 'bar0');
ok($driver->save($bar[0]), "$bar[0] saved"); #90
sleep(2);

$bar[1] = Bar->new;
$bar[1]->column('foo_id', $foo[1]->id);
$bar[1]->column('name', 'bar1');
ok($driver->save($bar[1]), "$bar[1] saved"); #91
sleep(2);

$bar[2] = Bar->new;
$bar[2]->column('foo_id', $foo[0]->id);
$bar[2]->column('name', 'bar2');
ok($driver->save($bar[2]), "$bar[2] saved"); #92
sleep(2);

## Now load all Foo objects in order of most recently
## created Bar object. Make sure they are unique.
@tmp = $driver->load('Foo', undef,
    { join => [ 'Bar', 'foo_id', undef,
        { sort => 'created_on', direction => 'descend', unique => 1 }
    ] }
);
is(@tmp, 2, 'array size=2'); #93
is($tmp[0]->column('id'), $foo[0]->column('id'), "id's equal"); #94
is($tmp[1]->column('id'), $foo[1]->column('id'), "id's equal"); #95

## Load all Foo objects in order of most recently
## created Bar object. No uniqueness requirement.
@tmp = $driver->load('Foo', undef,
    { join => [ 'Bar', 'foo_id', undef,
        { sort => 'created_on', direction => 'descend', }
    ] }
);
is(@tmp, 3, 'array size=3'); #96
is($tmp[0]->column('id'), $foo[0]->column('id'), "id's equal"); #97
is($tmp[1]->column('id'), $foo[1]->column('id'), "id's equal"); #98
is($tmp[2]->column('id'), $foo[1]->column('id'), "id's equal"); #99

## Load last 1 Foo object in order of most recently
## created Bar object.
@tmp = $driver->load('Foo', undef,
    { join => [ 'Bar', 'foo_id', undef,
        { sort => 'created_on', direction => 'descend', unique => 1, limit => 1, }
     ] }
);
is(@tmp, 1, 'array size=1'); #100
is($tmp[0]->column('id'), $foo[0]->column('id'), "id's equal"); #101

## Load all Foo objects where Bar.name = 'bar0'
@tmp = $driver->load('Foo', undef,
    { join => [ 'Bar', 'foo_id',
                { name => 'bar0' },
                { sort => 'created_on',
                  direction => 'descend',
                  unique => 1, } ] });
is(@tmp, 1, 'array size=1'); #102
is($tmp[0]->column('id'), $foo[1]->column('id'), "id's equal"); #103

## Now remove a record.
ok($driver->remove($foo[0]), "removed $foo[0]"); #104

{
    my $db_file = MT::ObjectDriver::DBM::_db_data($driver, $foo[0]);
    ok(-e $db_file, "file $db_file exists"); #105
    tie my %db, 'DB_File', $db_file, O_RDWR, 0666, $DB_BTREE
        or die "Tie '$db_file' failed: $!";
    ok(!exists $db{ $foo[0]->column('id') }, 'no id'); #106
}

## Check that indexes are updated
for my $col (qw( name status created_on )) {
    my $idx = _tie_index($col, $driver); #107,109,111
    ok(!exists $idx->{ $foo[0]->column($col) }, "$col column does not exist"); #108,110,112
}

## Test generate_id
my $id_file = File::Spec->catfile($driver->cfg->DataSource, "ids.db");
tie my %db, 'DB_File', $id_file
    or die "Can't tie '$id_file': $!";
my $last_id = $db{'Foo'};
untie %db;
my $id = $driver->generate_id('Foo');
is($id, $last_id + 1, "$id = $last_id + 1"); #113

system "rm -rf $DB_DIR";

sub _tie_index {
    my($col, $driver) = @_;
    my $idx_file = File::Spec->catfile( $driver->cfg->DataSource,
        Foo->datasource . '.' . $col . '.idx');
    ok(-e $idx_file, "file $idx_file exists");  #13,16,19,34,37,40,69,107,109,111
    tie my %idx, 'DB_File', $idx_file, O_RDWR, 0666, $DB_BTREE
        or die "Tie to '$idx_file' failed: $!";
    return \%idx;
}
