#!/usr/bin/perl

# This test contains one subtest per MT::Util function.
# Most are not yet covered but no better time to start than NOW!

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 3;

use MT;
use MT::Util;

use MT::Log::Log4perl qw( l4mtdump ); use Log::Log4perl qw( :resurrect );
###l4p our $logger = MT::Log::Log4perl->new(); $logger->trace();

# Initialize app and plugins
use MT::Test qw( :app :db );

# subtest '_pre_to_json()'                  => sub { };
# subtest 'addbin()'                        => sub { };
# subtest 'archive_file_for()'              => sub { };
# subtest 'asset_cleanup()'                 => sub { };
# subtest 'bin2dec()'                       => sub { };
# subtest 'browser_language()'              => sub { };
# subtest 'caturl()'                        => sub { };
# subtest 'cc_image()'                      => sub { };
# subtest 'cc_name()'                       => sub { };
# subtest 'cc_rdf()'                        => sub { };
# subtest 'cc_url()'                        => sub { };
# subtest 'convert_high_ascii()'            => sub { };
# subtest 'convert_word_chars()'            => sub { };
# subtest 'days_in()'                       => sub { };
# subtest 'dec2bin()'                       => sub { };
# subtest 'decode_html()'                   => sub { };
# subtest 'decode_url()'                    => sub { };
# subtest 'decode_xml()'                    => sub { };
# subtest 'dirify()'                        => sub { };
# subtest 'discover_tb()'                   => sub { };
# subtest 'divbindec()'                     => sub { };
# subtest 'dsa_verify()'                    => sub { };
# subtest 'encode_html()'                   => sub { };
# subtest 'encode_js()'                     => sub { };
# subtest 'encode_json()'                   => sub { };
# subtest 'encode_php()'                    => sub { };
# subtest 'encode_phphere()'                => sub { };
# subtest 'encode_url()'                    => sub { };
# subtest 'encode_xml()'                    => sub { };
# subtest 'epoch2ts()'                      => sub { };
# subtest 'escape_unicode()'                => sub { };
# subtest 'extract_domain()'                => sub { };
# subtest 'extract_domains()'               => sub { };
# subtest 'extract_urls()'                  => sub { };
# subtest 'first_n_words()'                 => sub { };
# subtest 'format_ts()'                     => sub { };
# subtest 'get_entry()'                     => sub { };
# subtest 'get_newsbox_html()'              => sub { };
# subtest 'html_text_transform()'           => sub { };
# subtest 'init_sax()'                      => sub { };
# subtest 'is_leap_year()'                  => sub { };
# subtest 'is_url()'                        => sub { };
# subtest 'is_valid_date()'                 => sub { };
# subtest 'is_valid_email()'                => sub { };
# subtest 'is_valid_url()'                  => sub { };
# subtest 'iso2ts()'                        => sub { };
# subtest 'iso_dirify()'                    => sub { };
# subtest 'launch_background_tasks()'       => sub { };
# subtest 'leap_day()'                      => sub { };
# subtest 'leap_year()'                     => sub { };
# subtest 'log_time()'                      => sub { };
# subtest 'ltrim()'                         => sub { };
# subtest 'make_basename()'                 => sub { };
# subtest 'make_string_csv()'               => sub { };
# subtest 'make_unique_author_basename()'   => sub { };
# subtest 'make_unique_basename()'          => sub { };
# subtest 'make_unique_category_basename()' => sub { };
# subtest 'mark_odd_rows()'                 => sub { };
# subtest 'multbindec()'                    => sub { };
# subtest 'multi_iter()'                    => sub { };
# subtest 'munge_comment()'                 => sub { };
# subtest 'offset_time()'                   => sub { };
# subtest 'offset_time_list()'              => sub { };
# subtest 'perl_sha1_digest()'              => sub { };
# subtest 'perl_sha1_digest_base64()'       => sub { };
# subtest 'perl_sha1_digest_hex()'          => sub { };
# subtest 'relative_date()'                 => sub { };
# subtest 'remove_html()'                   => sub { };
# subtest 'rich_text_transform()'           => sub { };
# subtest 'rtrim()'                         => sub { };
# subtest 'sanitize_embed()'                => sub { };
# subtest 'sanitize_input()'                => sub { };
# subtest 'sax_parser()'                    => sub { };
# subtest 'spam_protect()'                  => sub { };
# subtest 'start_background_task()'         => sub { };
# subtest 'start_end_day()'                 => sub { };
# subtest 'start_end_month()'               => sub { };
# subtest 'start_end_period()'              => sub { };
# subtest 'start_end_week()'                => sub { };
# subtest 'start_end_year()'                => sub { };
# subtest 'strip_index()'                   => sub { };
# subtest 'substr_wref()'                   => sub { };
# subtest 'to_json()'                       => sub { };
# subtest 'translate_naughty_words()'       => sub { };
# subtest 'trim()'                          => sub { };
# subtest 'ts2epoch()'                      => sub { };
# subtest 'ts2iso()'                        => sub { };
# subtest 'unescape_unicode()'              => sub { };
# subtest 'utf8_dirify()'                   => sub { };
# subtest 'wday_from_ts()'                  => sub { };
# subtest 'weaken()'                        => sub { };
# subtest 'week2ymd()'                      => sub { };
# subtest 'xliterate_utf8()'                => sub { };
# subtest 'yday_from_ts()'                  => sub { };

subtest 'file_extension()' => sub {

    my %tests = (
        'file.txt'        => 'txt',
        'file.tar.gz'     => 'gz',
        'file.'           => '',
        'file.0'          => 0,
        'file'            => '',
        '.htaccess'       => '',
        '.my.cnf'         => 'cnf',
        '.'               => '',
        '..'              => '',
    );
    plan tests => scalar keys %tests;

    is( MT::Util::file_extension( $_ ), $tests{$_},
        "'$_' returns '$tests{$_}'" )
            foreach keys %tests;
};


subtest 'file_mime_type()' => sub {
    my %tests = (
        'COPYING'              => 'text/plain',
        'readme.html'          => 'text/html',
        'mt-static/styles.css' => 'text/css',
        'mt-static/mt.js'      => 'application/javascript',
        't/images/test.gif'    => 'image/gif',
        't/images/test.jpg'    => 'image/jpeg',
    );
    plan tests => scalar keys %tests;

    require File::Spec;
    foreach my $key ( keys %tests ) {
        is(
            MT::Util::file_mime_type( File::Spec->catfile( $ENV{MT_HOME}, $key )),
            $tests{$key},
            "'$key' returns '$tests{$key}'"
        )
    }
};

subtest "mime_type_extension()" => sub {
    my %tests = (
        'text/plain'              => 'txt',
        'text/html',              => 'html',
        'text/css',               => 'css',
        'application/javascript', => 'js',
        'image/gif',              => 'gif',
        'image/jpeg',             => 'jpeg',
        'video/3gpp'              => '3gp',
        'video/mpeg'              => 'mpeg',
        'video/mp4'               => 'mp4',
        'video/quicktime'         => 'mov',
        'audio/mpeg'              => 'mp3',
        'audio/x-wav'             => 'wav',
        'audio/ogg'               => 'ogg',
    );

    plan tests => scalar keys %tests;

    foreach my $type ( keys %tests ) {
        my $ext        = $tests{$type};
        my @extensions = MT::Util::mime_type_extension( $type );
        ok(( grep { /^$ext$/ } @extensions ), "'$type' returns '$tests{$type}'" );
    }
};

1;
__END__



