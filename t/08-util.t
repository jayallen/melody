# $Id$

use lib 't/lib', 'extlib', 'lib', '../lib', '../extlib';
use Test;
use MT;
use MT::Test;
use MT::Util qw( encode_html decode_html wday_from_ts format_ts dirify
                 convert_high_ascii encode_xml decode_xml substr_wref
                 trim ltrim rtrim remove_html );
use MT::I18N qw( encode_text );
use strict;

my $mt = MT->new;
$mt->config('NoHTMLEntities', 1);

BEGIN { plan tests => 212 };

ok(substr_wref("Sabado", 0, 3), "Sab"); #1
ok(substr_wref("S&agrave;bado", 0, 3), "S&agrave;b"); #2
ok(substr_wref("S&agrave;bado", 0, 6), "S&agrave;bado"); #3

ok(convert_high_ascii("\xd8"), 'O'); #4
ok(convert_high_ascii("Febr\xf9ary"), 'February'); #5

my $str = '';
for (my $i = 0; $i < 256; $i++) {
    $str .= chr($i);
}
$mt->config('PublishCharset', 'iso-8859-1');
ok(dirify($str), '_abcdefghijklmnopqrstuvwxyz_abcdefghijklmnopqrstuvwxyzaaaaaaaeceeeeiiiinoooooouuuuyssaaaaaaaeceeeeiiiinoooooouuuuyy'); #6
$mt->config('PublishCharset', 'utf-8');
use bytes;
my $utf8_str = q{ÀÁÂÃÄÅĀĄĂÆÇĆČĈĊĎĐÈÉÊËĒĘĚĔĖĜĞĠĢĤĦÌÍÎÏĪĨĬĮİĲĴĶŁĽĹĻĿÑŃŇŅŊÒÓÔÕÖØŌŐŎŒŔŘŖŚŠŞŜȘŤŢŦȚÙÚÛÜŪŮŰŬŨŲŴÝŶŸŹŽŻàáâãäåāąăæçćčĉċďđèéêëēęěĕėƒĝğġģĥħìíîïīĩĭįıĳĵķĸłľĺļŀñńňņŉŋòóôõöøōőŏœŕřŗśšşŝșťţŧțùúûüūůűŭũųŵýÿŷžżźÞþßſÐð};
ok(dirify($utf8_str), 'aaaaaaaaaaecccccddeeeeeeeeegggghhiiiiiiiiiijjklllllnnnnnooooooooooerrrsssssttttuuuuuuuuuuwyyyzzzaaaaaaaaaaecccccddeeeeeeeeefgggghhiiiiiiiiiijjkklllllnnnnnnooooooooooerrrsssssttttuuuuuuuuuuwyyyzzzss'); #7

my $ts = '19770908153005';
ok(format_ts('%a', $ts), 'Thu'); #8
ok(format_ts('%A', $ts), 'Thursday'); #9
ok(format_ts('%b', $ts), 'Sep'); #10
ok(format_ts('%B', $ts), 'September'); #11
ok(format_ts('%d', $ts), '08'); #12
ok(format_ts('%e', $ts), ' 8'); #13
ok(format_ts('%H', $ts), '15'); #14
ok(format_ts('%I', $ts), '03'); #15
ok(format_ts('%j', $ts), '251'); #16
ok(format_ts('%k', $ts), '15'); #17
ok(format_ts('%l', $ts), ' 3'); #18
ok(format_ts('%m', $ts), '09'); #19
ok(format_ts('%M', $ts), '30'); #20
ok(format_ts('%p', $ts), 'PM'); #21
ok(format_ts('%S', $ts), '05'); #22
ok(format_ts('%x', $ts), 'September  8, 1977'); #23
ok(format_ts('%X', $ts), ' 3:30 PM'); #24
ok(format_ts('%y', $ts), '77'); #25
ok(format_ts('%Y', $ts), '1977'); #26

ok(encode_html('<foo>'), '&lt;foo&gt;'); #27
ok(encode_html('&gt;'), '&gt;'); #28
ok(encode_html('&gt;', 1), '&amp;gt;'); #29
ok(encode_html("foo & bar &baz"), "foo &amp; bar &amp;baz"); #30
ok(decode_html(encode_html('<foo>')), '<foo>'); #31
ok(encode_html(), ''); #32
ok(encode_html("&lt;"), "&lt;"); #33
ok(encode_html("&#x192;"), "&#x192;"); #34
ok(encode_html("&#X192;"), "&#X192;"); #35
ok(encode_html("&#192;"), "&#192;"); #36
ok(encode_html('"'), '&quot;'); #37
ok(encode_html('&'), '&amp;'); #38
ok(encode_html('>'), '&gt;'); #39
ok(encode_html('<'), '&lt;'); #40
ok(encode_html("<foo>\cM\n"), "&lt;foo&gt;\n"); #41

ok(wday_from_ts(1964,1,3) == 5); #42
ok(wday_from_ts(1995,11,13) == 1); #43
ok(wday_from_ts(1995,11,14) == 2); #44
ok(wday_from_ts(1995,11,15) == 3); #45
ok(wday_from_ts(1995,11,16) == 4); #46
ok(wday_from_ts(1995,11,17) == 5); #47
ok(wday_from_ts(1995,11,18) == 6); #48
ok(wday_from_ts(1995,11,19) == 0); #49
ok(wday_from_ts(1995,11,20) == 1); #50
ok(wday_from_ts(1995,2,28) == 2); #51
ok(wday_from_ts(1946,12,26) == 4); #52

my %xml_tests = (
    'foo' => 'foo', #53 #54 #55
    'x < y' => 'x &lt; y', #56 #57 #58
    'foo & bar' => 'foo &amp; bar', #59 #60 #61
    'foo\'s bar' => 'foo&apos;s bar', #62 #63 #64
    '<title>my title</title>' => #65 #66 #67 #68
        [ '<![CDATA[<title>my title</title>]]>',
          '&lt;title&gt;my title&lt;/title&gt;', ],
    '<foo>]]>' => #69 #70 #71 #72
        [ '<![CDATA[<foo>]]&gt;]]>',
          '&lt;foo&gt;]]&gt;', ],
    'x &lt; y' => #73 #74 #75 #76
        [ '<![CDATA[x &lt; y]]>',
          'x &amp;lt; y', ],
    'foob&aacute;r' => #77 #78 #79 #80
        [ '<![CDATA[foob&aacute;r]]>',
          'foob&amp;aacute;r', ],
);
 
for my $test (keys %xml_tests) {
    if (ref($xml_tests{$test}) eq 'ARRAY') {
        ok(encode_xml($test), $xml_tests{$test}[0]); #65 #69 #73 #77
        ok(decode_xml($xml_tests{$test}[0]), $test); #66 #70 #74 #78
        ok(decode_xml(encode_xml($test)), $test); #67 #71 #75 #79
        MT::ConfigMgr->instance->NoCDATA(1);
        ok(encode_xml($test), $xml_tests{$test}[1]); #68 #72 #76 #80
        MT::ConfigMgr->instance->NoCDATA(0);
    } else {
        ok(encode_xml($test), $xml_tests{$test}); #53 #56 #59 #62
        ok(decode_xml($xml_tests{$test}), $test); #54 #57 #60 #63
        ok(decode_xml(encode_xml($test)), $test); #55 #58 #61 #64
    }
}

### single line tests for ltrim, rtrim and trim

ok(ltrim('sunday'),                     'sunday');                  #81
ok(ltrim(' sunday'),                    'sunday');                  #82
ok(ltrim('  sunday'),                   'sunday');                  #83
ok(ltrim('sunday '),                    'sunday ');                 #84
ok(ltrim('sunday  '),                   'sunday  ');                #85
ok(ltrim(' sunday '),                   'sunday ');                 #86
ok(ltrim('  sunday  '),                 'sunday  ');                #87
ok(ltrim('sunday monday'),              'sunday monday');           #88
ok(ltrim(' sunday monday'),             'sunday monday');           #89
ok(ltrim('  sunday monday'),            'sunday monday');           #90
ok(ltrim('sunday monday '),             'sunday monday ');          #91
ok(ltrim('sunday monday  '),            'sunday monday  ');         #92
ok(ltrim(' sunday monday  '),           'sunday monday  ');         #93
ok(ltrim('  sunday monday  '),          'sunday monday  ');         #94
ok(ltrim('sunday monday tuesday'),      'sunday monday tuesday');   #95
ok(ltrim(' sunday monday tuesday'),     'sunday monday tuesday');   #96
ok(ltrim('  sunday monday tuesday'),    'sunday monday tuesday');   #97
ok(ltrim('sunday monday tuesday '),     'sunday monday tuesday ');  #98
ok(ltrim('sunday monday tuesday  '),    'sunday monday tuesday  '); #99
ok(ltrim(' sunday monday tuesday '),    'sunday monday tuesday ');  #100
ok(ltrim('  sunday monday tuesday  '),  'sunday monday tuesday  '); #101


ok(rtrim('sunday'),                     'sunday');                     #102
ok(rtrim(' sunday'),                    ' sunday');                    #103
ok(rtrim('  sunday'),                   '  sunday');                   #104
ok(rtrim('sunday '),                    'sunday');                     #105
ok(rtrim('sunday  '),                   'sunday');                     #106
ok(rtrim(' sunday '),                   ' sunday');                    #107
ok(rtrim('  sunday  '),                 '  sunday');                   #108
ok(rtrim('sunday monday'),              'sunday monday');              #109
ok(rtrim(' sunday monday'),             ' sunday monday');             #110
ok(rtrim('  sunday monday'),            '  sunday monday');            #111
ok(rtrim('sunday monday '),             'sunday monday');              #112
ok(rtrim('sunday monday  '),            'sunday monday');              #113
ok(rtrim(' sunday monday  '),           ' sunday monday');             #114
ok(rtrim('  sunday monday  '),          '  sunday monday');            #115
ok(rtrim('sunday monday tuesday'),      'sunday monday tuesday');      #116
ok(rtrim(' sunday monday tuesday'),     ' sunday monday tuesday');     #117
ok(rtrim('  sunday monday tuesday'),    '  sunday monday tuesday');    #118
ok(rtrim('sunday monday tuesday '),     'sunday monday tuesday');      #119
ok(rtrim('sunday monday tuesday  '),    'sunday monday tuesday');      #120
ok(rtrim(' sunday monday tuesday '),    ' sunday monday tuesday');     #121
ok(rtrim('  sunday monday tuesday  '),  '  sunday monday tuesday');    #122


ok(trim('sunday'),                      'sunday');                 #123
ok(trim(' sunday'),                     'sunday');                 #124
ok(trim('  sunday'),                    'sunday');                 #125
ok(trim('sunday '),                     'sunday');                 #126
ok(trim('sunday  '),                    'sunday');                 #127
ok(trim(' sunday '),                    'sunday');                 #128
ok(trim('  sunday  '),                  'sunday');                 #129
ok(trim('sunday monday'),               'sunday monday');          #130
ok(trim(' sunday monday'),              'sunday monday');          #131
ok(trim('  sunday monday'),             'sunday monday');          #132
ok(trim('sunday monday '),              'sunday monday');          #133
ok(trim('sunday monday  '),             'sunday monday');          #134
ok(trim(' sunday monday  '),            'sunday monday');          #135
ok(trim('  sunday monday  '),           'sunday monday');          #136
ok(trim('sunday monday tuesday'),       'sunday monday tuesday');  #137
ok(trim(' sunday monday tuesday'),      'sunday monday tuesday');  #138
ok(trim('  sunday monday tuesday'),     'sunday monday tuesday');  #139
ok(trim('sunday monday tuesday '),      'sunday monday tuesday');  #140
ok(trim('sunday monday tuesday  '),     'sunday monday tuesday');  #141
ok(trim(' sunday monday tuesday '),     'sunday monday tuesday');  #142
ok(trim('  sunday monday tuesday  '),   'sunday monday tuesday');  #143

### multiline line tests for ltrim, rtrim and trim
### Inner-string spaces around newlines should not be touched

ok(ltrim("hello\nthere"),        "hello\nthere");       #144
ok(ltrim("hello \n there"),      "hello \n there");     #145
ok(ltrim("hello \n  there"),     "hello \n  there");    #146
ok(ltrim("hello  \n there"),     "hello  \n there");    #147
ok(ltrim("hello  \n  there"),    "hello  \n  there");   #148
ok(ltrim("  hello\nthere"),      "hello\nthere");       #149
ok(ltrim("  hello \n there"),    "hello \n there");     #150
ok(ltrim("  hello \n  there"),   "hello \n  there");    #151
ok(ltrim("  hello  \n there"),   "hello  \n there");    #152
ok(ltrim("  hello  \n  there"),  "hello  \n  there");   #153
ok(ltrim("hello\nthere  "),      "hello\nthere  ");     #154
ok(ltrim("hello \n there  "),    "hello \n there  ");   #155
ok(ltrim("hello \n  there  "),   "hello \n  there  ");  #156
ok(ltrim("hello  \n there  "),   "hello  \n there  ");  #157
ok(ltrim("hello  \n  there  "),  "hello  \n  there  "); #158

ok(rtrim("hello\nthere"),        "hello\nthere");       #159
ok(rtrim("hello \n there"),      "hello \n there");     #160
ok(rtrim("hello \n  there"),     "hello \n  there");    #161
ok(rtrim("hello  \n there"),     "hello  \n there");    #162
ok(rtrim("hello  \n  there"),    "hello  \n  there");   #163
ok(rtrim("  hello\nthere"),      "  hello\nthere");     #164
ok(rtrim("  hello \n there"),    "  hello \n there");   #165
ok(rtrim("  hello \n  there"),   "  hello \n  there");  #166
ok(rtrim("  hello  \n there"),   "  hello  \n there");  #167
ok(rtrim("  hello  \n  there"),  "  hello  \n  there"); #168
ok(rtrim("hello\nthere  "),      "hello\nthere");       #169
ok(rtrim("hello \n there  "),    "hello \n there");     #170
ok(rtrim("hello \n  there  "),   "hello \n  there");    #171
ok(rtrim("hello  \n there  "),   "hello  \n there");    #172
ok(rtrim("hello  \n  there  "),  "hello  \n  there");   #173

ok(trim("hello\nthere"),        "hello\nthere");        #174
ok(trim("hello \n there"),      "hello \n there");      #175
ok(trim("hello \n  there"),     "hello \n  there");     #176
ok(trim("hello  \n there"),     "hello  \n there");     #177
ok(trim("hello  \n  there"),    "hello  \n  there");    #178
ok(trim("  hello\nthere"),      "hello\nthere");        #179
ok(trim("  hello \n there"),    "hello \n there");      #180
ok(trim("  hello \n  there"),   "hello \n  there");     #181
ok(trim("  hello  \n there"),   "hello  \n there");     #182
ok(trim("  hello  \n  there"),  "hello  \n  there");    #183
ok(trim("hello\nthere  "),      "hello\nthere");        #184
ok(trim("hello \n there  "),    "hello \n there");      #185
ok(trim("hello \n  there  "),   "hello \n  there");     #186
ok(trim("hello  \n there  "),   "hello  \n there");     #187
ok(trim("hello  \n  there  "),  "hello  \n  there");    #188

### multiline line tests for ltrim, rtrim and trim
### Outer-string newlines and surrounding spaces should be stripped

ok(ltrim("\nhello\n"),              "hello\n");         #189
ok(ltrim(" \nhello\n "),            "hello\n ");        #190
ok(ltrim(" \n hello \n "),          "hello \n ");       #191
ok(ltrim(" \n\n  hello  \n\n "),    "hello  \n\n ");    #192

ok(rtrim("\nhello\n"),              "\nhello");         #193
ok(rtrim(" \nhello\n "),            " \nhello");        #194
ok(rtrim(" \n hello \n "),          " \n hello");       #195
ok(rtrim(" \n\n  hello  \n\n "),    " \n\n  hello");    #196

ok(trim("\nhello\n"),              "hello");            #197
ok(trim(" \nhello\n "),            "hello");            #198
ok(trim(" \n hello \n "),          "hello");            #199
ok(trim(" \n\n  hello  \n\n "),    "hello");            #200

ok(remove_html('<![CDATA[foo]]>'), '<![CDATA[foo]]>', "remove html preserves CDATA"); #201
ok(remove_html('<![CDATA[]]><script>alert("foo")</script><![CDATA[]]>'), '<![CDATA[]]>alert("foo")<![CDATA[]]>', "remove html prevents abuse"); #202
ok(remove_html('<![CDATA[one]]><script>alert("foo")</script><![CDATA[two]]>'), '<![CDATA[one]]>alert("foo")<![CDATA[two]]>', "remove html prevents abuse, saves plain text"); #203
ok(remove_html('<![CDATA[<foo>]]><script>alert("foo")</script><![CDATA[two]]>'), '<![CDATA[&lt;foo>]]>alert("foo")<![CDATA[two]]>', "remove html prevents abuse, saves plain text, escapes inner < characters"); #204

ok(MT::Util::to_json({'foo' => 2}), '{"foo":2}'); #205
ok(MT::Util::to_json({'foo' => 1}), '{"foo":1}'); #206
ok(MT::Util::to_json({'foo' => 0}), '{"foo":0}'); #207
ok(MT::Util::to_json({'foo' => 'hoge'}), '{"foo":"hoge"}'); #208
ok(MT::Util::to_json({'foo' => 'ho1ge'}), '{"foo":"ho1ge"}'); #209
ok(MT::Util::to_json(['foo', 'bar', 'baz']), '["foo","bar","baz"]'); #210
ok(MT::Util::to_json(['foo', 1, 'bar', 2, 3, 4]), '["foo",1,"bar",2,3,4]'); #211
ok(MT::Util::to_json(['foo', 1, 'bar', { hoge => 1, moge => 'a' }]), '["foo",1,"bar",{"hoge":1,"moge":"a"}]'); #212

=pod

my %dates = (
          '20021224103045'            => '20021224T10:30:45',
          '20021224T10:30:45'         => '20021224T10:30:45',
          '20021224T103045Z'          => '20021224T02:30:45',
          '20021224T10:30:45-0000'    => '20021224T02:30:45',
          '20021224T10:30:45+0030'    => '20021224T02:00:45',
          '2002-12-24T103045+02'      => '20021224T00:30:45',
          '2002-12-24T10:30:45-08:00' => '20021224T10:30:45',
          '20020615103045'            => '20020615T10:30:45',
          '20020615103045-08'         => '20020615T11:30:45',
          '20020615103045+02'         => '20020615T01:30:45',
          );
for my $date (keys %dates) {
    ok(parse_iso8601_date($date, -8, 'gmtime'), $dates{$date});
   #for my $tz ((":America/Los_Angeles", ":Europe/Helsinki")) {
   #    $ENV{"TZ"} = $tz;
   #    for my $lt (("localtime", "gmtime")) {
   #        my $fmt = $lt eq "localtime" ? " %18s " : "%20s";
   #        printf "%-25s -> $fmt %s\n", $i, parseISO8601Date($i, $lt), $tz;
   #    }
   #}
}

=cut
