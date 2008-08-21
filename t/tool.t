#!/usr/bin/perl

# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id: driver-tests.pl 2601 2008-06-18 09:50:16Z fumiakiy $

use strict;
use warnings;
use Data::Dumper;
use English qw( -no_match_vars );

use lib 't/lib';
use MT::Test qw();

package MT::Tool::Fake;
use base qw( MT::Tool );

our ($usage, $help, @options_list);

sub usage   {}
sub help    {}
sub options {}

package Test::Tool;
use base qw( Test::Class MT::Test );
use Test::More;
use Test::Deep;

sub options_list : Tests(4) {
    local @ARGV = ();
    no warnings 'redefine';

    local *MT::Tool::GetOptions = sub {
        my %args = @_;
        cmp_deeply(
            [ sort keys %args ],
            [ 'help!', 'usage!', 'verbose|v+' ],
            'Regular listwise options sends GetOptions the basic options'
        );
        cmp_deeply(
            [ map { ref } values %args ],
            [ ('SCALAR') x 3 ],
            'All listwise option args are scalar references'
        );
        return 1;
    };
    ok(!MT::Tool::Fake->parse_options(), q{No verbosity with no options set});

    local *MT::Tool::GetOptions = sub {
        my %args = @_;
        ${ $args{q{verbose|v+}} } = 1;
        return 1;
    };
    is(MT::Tool::Fake->parse_options(), 1, q{Options parse as verbose if GetOptions says so});
}

sub options_hash : Tests(7) {
    my %opts;
    local @ARGV = ();
    no warnings 'redefine';

    local *MT::Tool::Fake::options = sub { \%opts };
    local *MT::Tool::GetOptions = sub {
        my @args = @_;
        is(scalar @args, 4, 'Regular hashwise options sends GetOptions four parameters');
        isa_ok($args[0], 'HASH', 'First option when invoked hashwise is the parameter hash');
        cmp_deeply(
            [ sort @args[1..3] ],
            [ 'help!', 'usage!', 'verbose|v+' ],
            'Regular hashwise options sends GetOptions the basic options'
        );

        return 1;
    };
    ok(!MT::Tool::Fake->parse_options(), q{No verbosity with no hash options set});
    ok(!$opts{verbose}, 'No verbosity in the option hash either');

    local *MT::Tool::GetOptions = sub {
        my @args = @_;
        $args[0]->{verbose} = 1;
        return 1;
    };
    is(MT::Tool::Fake->parse_options(), 1, q{Hash options parse as verbose if GetOptions says so});
    is($opts{verbose}, 1, 'Verbosity is left in the options hash too');
}
package main;

Test::Tool->runtests();

