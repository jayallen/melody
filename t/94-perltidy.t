#!perl
use strict;
use warnings;

# Test::PerlTidy unconditionally checks anything in the CWD that
# looks like Perl. That's doesn't work for Melody so we install
# our own method.

use ExtUtils::Manifest qw(maniread);

our $EXT = qr/(\.(cgi|pl|pm|PL|t)$)/;    # file extensions to look for

sub manifest_files {
    my $manifest = maniread();
    return grep {m/$EXT/}
      grep      { !m/^extlib/ }          # ignore extlib
      keys %$manifest;
}

use Sub::Install;
Sub::Install::reinstall_sub( {
        code => \&manifest_files,
        into => "Test::PerlTidy",
        as   => 'list_files',
    }
);

# Now the moment we've been waiting for.

use Test::PerlTidy;

run_tests();
