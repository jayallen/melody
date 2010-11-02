#!/usr/bin/perl

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use MT::Test;

use Test::More skip_all => <<REASON;
These tests should be run before the rest of the testing suite since
it will all fail badly without some of these tests passing. These unit
tests does not check for required testing modules and will report 
failures for optional modules not being present. Also, database 
configuration is not considered and will generate failures if all
database drivers are not installed.
REASON

# use Test::More tests => 37;

# This list of modules below is not in sync with what check.cgi and Makefile requires.

# required modules in MT check
use_ok('CGI::Cookie');
use_ok('File::Spec', 0.8);
use_ok('Image::Size', 2.93);
use_ok('CGI', 2.80);

# data storage modules
use_ok('DBI', 1.21);
use_ok('DBD::mysql');
use_ok('DBD::SQLite');
use_ok('DBD::Pg', 1.32);
use_ok('DBD::SQLite2');

# optional modules
use_ok('Scalar::Util');
use_ok('Crypt::DSA');
use_ok('XML::SAX');
use_ok('IPC::Run');
use_ok('Archive::Zip');
use_ok('Storable');
use_ok('SOAP::Lite', 0.5);
use_ok('List::Util');
use_ok('HTML::Entities');
use_ok('Digest::MD5');
use_ok('Text::Balanced');
use_ok('Crypt::SSLeay');
use_ok('GD');
use_ok('Archive::Tar');
use_ok('Safe');
use_ok('IO::Socket::SSL');
use_ok('IO::Uncompress::Gunzip');
use_ok('Digest::SHA1');
use_ok('IO::Compress::Gzip');
# use_ok('XML::Atom');
use_ok('Image::Magick');
use_ok('LWP::UserAgent');
use_ok('MIME::Base64');
use_ok('Mail::Sendmail');
use_ok('HTML::Parser');
use_ok('File::Temp');
use_ok('Net::LDAP');
# use_ok('XML::Parser');
