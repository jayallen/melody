#!/usr/bin/perl -w

# Melody, based on Movable Type (r) Open Source (C) 2001-2009 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

use strict;
sub BEGIN {
    my $dir;
    if (eval { require File::Spec; 1; }) {
        if (!($dir = $ENV{MT_HOME})) {
            if ($0 =~ m!(.*[/\\])!) {
                $dir = $1;
            } else {
                $dir = './';
            }
            $ENV{MT_HOME} = $dir;
        }
        unshift @INC, File::Spec->catdir($dir, 'lib');
        unshift @INC, File::Spec->catdir($dir, 'extlib');
    }
}

my $cfg_exist;
my $mt_static_path = q();
my $mt_cgi_path;
if ((-f File::Spec->catfile($ENV{MT_HOME}, 'config.cgi')) ||
    (-f File::Spec->catfile($ENV{MT_HOME}, 'mt.cfg'))) {
    $cfg_exist = 1;
    my $file_handle = open(CFG, $ENV{MT_HOME}.'/mt.cfg') || open(CFG, $ENV{MT_HOME}.'/config.cgi');
    my $line;
    while ($line = <CFG>) {
        next if $line !~ /\S/ || $line =~ /^#/;
        if ($line =~ s/StaticWebPath[\s]*([^\n]*)/$1/) {
            $mt_static_path = $line;
            chomp($mt_static_path);
        }
        elsif ($line =~ s/CGIPath[\s]*([^\n]*)/$1/) {
            $mt_cgi_path = $line;
            chomp($mt_cgi_path);
        }
    }
    if ( !$mt_static_path && $mt_cgi_path ) {
        $mt_cgi_path .= '/' if $mt_cgi_path !~ m|/$|;
        $mt_static_path = $mt_cgi_path . 'mt-static/';
    }
}

local $| = 1;

use CGI;
my $cgi = new CGI;
my $view = $cgi->param("view");
my $version = $cgi->param("version");
# $version ||= '__PRODUCT_VERSION_ID__';

my ($mt, $LH);
my $lang = $cgi->param("language") || $cgi->param("__lang");
eval {
    require MT::App::Wizard;
    $mt = MT::App::Wizard->new();
    
    require MT::Util;
    $lang ||= MT::Util::browser_language();
    
    my $cfg = $mt->config;
    $cfg->PublishCharset('utf-8');
    $cfg->DefaultLanguage($lang);
    require MT::L10N;
    if ( $mt ) {
        $LH = $mt->language_handle;
        $mt->set_language($lang);
    }
    else {
        MT::L10N->get_handle($lang);
    }
};

sub trans_templ {
    my($text) = @_;
    return $mt->translate_templatized($text) if $mt;
    $text =~ s!(<MT_TRANS(?:\s+((?:\w+)\s*=\s*(["'])(?:<[^>]+?>|[^\3]+?)+?\3))+?\s*/?>)!
        my($msg, %args) = ($1);
        #print $msg;
        while ($msg =~ /\b(\w+)\s*=\s*(["'])((?:<[^>]+?>|[^\2])*?)\2/g) {  #"
            $args{$1} = $3;
        }
        $args{params} = '' unless defined $args{params};
        my @p = map decode_html($_),
                split /\s*%%\s*/, $args{params};
        @p = ('') unless @p;
        my $translation = translate($args{phrase}, @p);
        $translation =~ s/([\\'])/\\$1/sg if $args{escape};
        $translation;
    !ge;
    $text;
}

sub translate {
    return (
        $mt ? $mt->translate(@_)
            : $LH ? $LH->maketext(@_)
                  : merge_params(@_)
    );
}

sub decode_html {
    my($html) = @_;
    if ($cfg_exist && (eval 'use MT::Util; 1')) {
        return MT::Util::decode_html($html);
    } else {
        $html =~ s#&quot;#"#g;
        $html =~ s#&lt;#<#g;
        $html =~ s#&gt;#>#g;
        $html =~ s#&amp;#&#g;
    }
    $html;
}

sub merge_params {
    my ($msg, @param) = @_;
    my $cnt = 1;
    foreach my $p (@param) {
        $msg =~ s/\[_$cnt\]/$p/g;
        $cnt++;
    }
    $msg;
}

print "Content-Type: text/html; charset=utf-8\n\n";
if (!$view) {
    print trans_templ(<<HTML);

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta http-equiv="content-language" content="$lang" />
    
    <title><MT_TRANS phrase="Melody System Check"> [check.cgi]</title>
    
    <style type=\"text/css\">
        <!--
        
            body {
                font-family: "Helvetica Neue", Helvetica, Arial, sans-serif;
                font-size: 13px;
                margin: 0;
                padding: 0;
                background-color: #fff;
            }
            
            body.has-static {
                background: #fff url('$mt_static_path/images/chromeless/chromeless_top_bg.gif') repeat-x;
            }
            
            body.has-static #header {
                background: url('$mt_static_path/melody/melody-logo-white-banner.png') no-repeat 25px 10px;
                height: 55px;
            }
            
            #content {
                margin: 20px 20px 100px;
            }
            
            h1 {
                margin: 0;
                padding: 10px;
                text-align: center;
                font-size: 22px;
                color: #fff;
                background: #000;
            }
            body.has-static #header h1 {
                display: none;
            }
            
            h2 {
                margin-top: 2em;
                margin-bottom: .5em;
                font-size: 24px;
                font-weight: normal;
            }
            h2#system-info {
                margin-top: 1em;
            }
            
            h3 {
                color: #333;
                font-size: 16px;
                margin-bottom: 0px;
            }
    
            p, ul {
                margin: 0 0 .75em 0;
                padding: 0;
            }
            
            ul {
                padding-left: 20px;
            }
            
            .msg {
                margin: 0 0 10px 0;
                padding: 16px 10px 16px 46px;
                background-repeat: no-repeat;
            }
            .msg-info {
                background-color: #eaf2ff;
                background-image: url('$mt_static_path/images/icon_info.gif');
                background-position: 12px center;
                border: 1px solid #999;
            }

			.ready {
				color: #fff;
				background-color: #9C6;
                border: 0;
                padding-left: 5px;
			}

            .msg-success {
                background-color: #CFC;
                background-image: url('$mt_static_path/images/icon_success.png');
                background-position: 12px .75em;
                font-size: 24px;
            }
            .msg-success h2 {
                margin-top: 0;
            }
            .msg-success p {
                font-size: 13px;
            }

            .info {
                margin-left: 60px;
                margin-right: 60px;
                padding: 20px;
                border: 1px solid #eaf2ff;
                background: #eaf2ff;
                color: #000;
            }

            .installed {
                color: #93b06b;
                padding-top: 0px;
                margin-top: 0px;
            }

            .warning {
                padding-top: 0px;
                margin-top: 4px;
                border-left: 1px solid red;
                padding-left: 10px;
                margin-left: 20px;
            }
            
            ul.version {
                margin-bottom: 0;
            }
        
        //-->
    </style>

</head>

HTML
    if ($mt_static_path) {
        print "<body class=\"has-static\">\n";
    } else {
        print "<body>\n";
    }
    print trans_templ(<<HTML);
<div id="header"><h1><MT_TRANS phrase="Melody System Check"> [check.cgi]</h1></div>

<div id="content">
<p class="msg msg-info"><MT_TRANS phrase="The check.cgi script provides you with information on your system's configuration and determines whether you have all of the components you need to run Melody."></p>
HTML
}

my $is_good = 1;
my (@REQ, @DATA, @OPT);

my @CORE_REQ = (
    [ 'CGI', 3.45, 1, translate('CGI is required for all Melody application functionality.') ],
    [ 'Class::Accessor', 0.22, 1, translate('Class::Accessor is required for all Melody application functionality.') ],
    [ 'Class::Trigger', '0.10_01', 1, translate('Class::Trigger is required for all Melody application functionality.') ],
    [ 'Data::ObjectDriver', 0.06, 1, translate('Data::ObjectDriver is required for all Melody application functionality.') ],
    [ 'Image::Size', 2.93, 1, translate('Image::Size is required for file uploads (to determine the size of uploaded images in many different formats).') ],
    [ 'YAML::Tiny', 1.12, 1, translate('YAML::Tiny is required for all Melody application functionality.') ],
);

my @CORE_DATA = (
    [ 'DBI', 1.21, 0, translate('DBI is required to store data in database.') ],
    [ 'DBD::mysql', 0, 0, translate('DBI and DBD::mysql are required if you want to use the MySQL database backend.') ],
    [ 'DBD::Pg', 1.32, 0, translate('DBI and DBD::Pg are required if you want to use the PostgreSQL database backend.') ],
    [ 'DBD::SQLite', 0, 0, translate('DBI and DBD::SQLite are required if you want to use the SQLite database backend.') ],
    [ 'DBD::SQLite2', 0, 0, translate('DBI and DBD::SQLite2 are required if you want to use the SQLite 2.x database backend.') ],
);

my @CORE_OPT = (
   
    [ 'Archive::Extract', 0.08, 0, translate('Archive::Tar is required in order to archive files in backup/restore operation.')],  # Part of the HTML::Parser package in CPAN
    [ 'Archive::Tar', 0, 0, translate('Archive::Tar is required in order to archive files in backup/restore operation.')],
    [ 'Archive::Zip', 0, 0, translate('Archive::Zip is required in order to archive files in backup/restore operation.')],
    [ 'Attribute::Params::Validate', 1.7, 0, translate('')],
    [ 'Cache', 2.04, 0, translate('')],
    [ 'Cache::Memcached', 0, 0, translate('Cache::Memcached and memcached server/daemon is required in order to use memcached as caching mechanism used by Melody.')],
    [ 'Class::Data::Inheritable', 0.06, 0, translate('')],
    [ 'Class::ErrorHandler', 0.01, 0, translate('')],
    [ 'Crypt::DH', 0.96, 0, translate('')],
    [ 'Crypt::DSA', 0, 0, translate('Crypt::DSA is optional; if it is installed, comment registration sign-ins will be accelerated.')],
    [ 'Crypt::SSLeay', 0, 0, translate('This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers such as AOL and Yahoo! which require SSL support.')],
    [ 'Digest::SHA1', 0, 0, translate('Digest::SHA1 and its dependencies are required in order to allow commenters to be authenticated by OpenID providers including Vox and LiveJournal.')],
    [ 'File::Copy::Recursive', 0.23, 0, translate('')],
    [ 'GD', 0, 0, translate('This module is needed if you would like to be able to create thumbnails of uploaded images.')],
    [ 'HTML::Entities', 0, 0, translate('HTML::Entities is needed to encode some characters, but this feature can be turned off using the NoHTMLEntities option in the configuration file.') ],
    [ 'HTML::Parser', 0, 0, translate('HTML::Parser is optional; It is needed if you wish to use the TrackBack system, the weblogs.com ping, or the Melody Recently Updated ping.') ],
    [ 'HTML::Template', 2.8, 0, translate('')],
    [ 'Heap::Fibonacci', 0.71, 0, translate('')],
    [ 'IO::Compress::Gzip', 0, 0, translate('IO::Compress::Gzip is required in order to compress files in backup/restore operation.')],
    [ 'IO::Scalar', 2.110, 0, translate('')],
    [ 'IO::Uncompress::Gunzip', 0, 0, translate('IO::Uncompress::Gunzip is required in order to decompress files in backup/restore operation.')],
    [ 'IPC::Cmd', 0.24, 0, translate('This module is needed if you would like to be able to use NetPBM as the image driver for Melody.')],
    [ 'IPC::Run', 0, 0, translate('This module is needed if you would like to be able to use NetPBM as the image driver for Melody.')],
    [ 'Image::Magick', 0, 0, translate('Image::Magick is optional; It is needed if you would like to be able to create thumbnails of uploaded images.') ],
    [ 'JSON', 2.12, 0, translate('')],
    [ 'Jcode', 0.88, 0, translate('')],
    [ 'LWP', 5.831, 0, translate('LWP is optional; It is needed if you wish to use the TrackBack system, the weblogs.com ping, or the Melody Recently Updated ping.') ],
    [ 'Locale::Maketext', 1.13, 0, translate('')],
    [ 'Lucene::QueryParser', 1.04, 0, translate('')],
    [ 'MIME::Charset', 0.044, 0, translate('')],
    [ 'MIME::EncWords', 0.96, 0, translate('')],
    [ 'Mail::Sendmail', 0, 0, translate('Mail::Sendmail is required for sending mail via SMTP Server.')],
    [ 'Math::BigInt', 1.63, 0, translate('')],
    [ 'Module::Load', 0.10, 0, translate('')],
    [ 'Module::Load::Conditional', 0.08, 0, translate('')],
    [ 'Net::OAuth', 0.11, 0, translate('')],
    [ 'Net::OpenID::Consumer', 1.03, 0, translate('')],
    [ 'Param::Check', 0.24, 0, translate('')],
    [ 'Param::Validate', 0.73, 0, translate('')],
    [ 'SOAP::Lite', 0.710.08, 0, translate('SOAP::Lite is optional; It is needed if you wish to use the Melody XML-RPC server implementation.') ],
    [ 'Sub::Install', 0, 0, translate('')],
    [ 'TheSchwartz', 1.07, 0, translate('')],
    [ 'URI', 1.36, 0, translate('')],
    [ 'URI::Fetch', 0.08, 0, translate('')],
    [ 'XML::Atom', 0, 0, translate('XML::Atom is required in order to use the Atom API.')],
    [ 'XML::Elemental', 2.1, 0, translate('')],
    [ 'XML::LibXML', 0, 0, translate('XML::LibXML is required in order to use the Atom API.')],
    [ 'XML::NamespaceSupport', 1.09, 0, translate('')],
    [ 'XML::SAX', 0.96, 0, translate('XML::SAX and/or its dependencies is required in order to restore.')],
    [ 'XML::Simple', 2.14, 0, translate('')],
    [ 'bignum', 0.23, 0, translate('')],
    [ 'version', 0.76, 0, translate('')],
    # [ 'XML::Parser', 0, 0, translate('This module required for action streams.')],
);

use Cwd;
my $cwd = '';
{
    my($bad);
    local $SIG{__WARN__} = sub { $bad++ };
    eval { $cwd = Cwd::getcwd() };
    if ($bad || $@) {
        eval { $cwd = Cwd::cwd() };
        if ($@ && $@ !~ /Insecure \$ENV{PATH}/) {
            die $@;
        }
    }
}

my $ver = ref($^V) eq 'version' ? $^V->normal : ( $^V ? join('.', unpack 'C*', $^V) : $] );
my $perl_ver_check = '';
if ($] < 5.008008) {  # our minimal requirement for support
    $perl_ver_check = <<EOT;
<p class="warning"><MT_TRANS phrase="The version of Perl installed on your server ([_1]) is lower than the minimum supported version ([_2]). Please upgrade to at least Perl [_2]." params="$ver%%5.6.1"></p>
EOT
}
my $config_check = '';
if (!$cfg_exist) {
    $config_check = <<CONFIG;
<p class="warning"><MT_TRANS phrase="Melody configuration file was not found."></p>
CONFIG
}
my $server = $ENV{SERVER_SOFTWARE};
my $inc_path = join "<br />\n", @INC;
print trans_templ(<<INFO);
<h2 id="system-info"><MT_TRANS phrase="System Information"></h2>
$perl_ver_check
$config_check
INFO
if ($version) {
    # sanitize down to letters numbers dashes and period
    $version =~ s/[^a-zA-Z0-9\-\.]//g;
print trans_templ(<<INFO);
<ul class="version">
    <li><strong><MT_TRANS phrase="Melody version:"></strong> <code>$version</code></li>
</ul>
INFO
}
print trans_templ(<<INFO);
<ul>
	<li><strong><MT_TRANS phrase="Current working directory:"></strong> <code>$cwd</code></li>
	<li><strong><MT_TRANS phrase="Melody home directory:"></strong> <code>$ENV{MT_HOME}</code></li>
	<li><strong><MT_TRANS phrase="Operating system:"></strong> $^O</li>
	<li><strong><MT_TRANS phrase="Perl version:"></strong> <code>$ver</code></li>
	<li><strong><MT_TRANS phrase="Perl include path:"></strong><br /> <code>$inc_path</code></li>
INFO
if ($server) {
print trans_templ(<<INFO);
    <li><strong><MT_TRANS phrase="Web server:"></strong> <code>$server</code></li>
INFO
}

## Try to create a new file in the current working directory. This
## isn't a perfect test for running under cgiwrap/suexec, but it
## is a pretty good test.
my $TMP = "test$$.tmp";
local *FH;
if (open(FH, ">$TMP")) {
    close FH;
    unlink($TMP);
    print trans_templ('    <li><MT_TRANS phrase="(Probably) Running under cgiwrap or suexec"></li>' . "\n");
}

print "\n\n</ul>\n";

exit if $ENV{QUERY_STRING} && $ENV{QUERY_STRING} eq 'sys-check';

if ($mt) {
    my $req = $mt->registry("required_packages");
    foreach my $key (keys %$req) {
        next if $key eq 'DBI';
        my $pkg = $req->{$key};
        push @REQ, [ $key, $pkg->{version} || 0, 1, $pkg->{label}, $key, $pkg->{link} ];
    }
    my $drivers = $mt->object_drivers;
    foreach my $key (keys %$drivers) {
        my $driver = $drivers->{$key};
        my $label = $driver->{label};
        my $link = 'http://search.cpan.org/dist/' . $driver->{dbd_package};
        $link =~ s/::/-/g;
        push @DATA, [ $driver->{dbd_package}, $driver->{dbd_version}, 0,
            $mt->translate("The [_1] database driver is required to use [_2].", $driver->{dbd_package}, $label),
            $label, $link ];
    }
    unshift @DATA, [ 'DBI', 1.21, 0, translate('DBI is required to store data in database.') ]
        if @DATA;
    my $opt = $mt->registry("optional_packages");
    foreach my $key (keys %$opt) {
        my $pkg = $opt->{$key};
        push @OPT, [ $key, $pkg->{version} || 0, 0, $pkg->{label}, $key, $pkg->{link} ];
    }
}
@REQ  = @CORE_REQ;  #unless @REQ;
@DATA = @CORE_DATA; #unless @DATA;
@OPT  = @CORE_OPT;  #unless @OPT;

for my $list (\@REQ, \@DATA, \@OPT) {
    my $data = ($list == \@DATA);
    my $req = ($list == \@REQ);
    my $type;
    my $phrase = translate("Checking for");

    if ($data) {
        $type = translate("Data Storage");
    } elsif ($req) {
        $type = translate("Required");
    } else {
        $type = translate("Optional");
    }
    print trans_templ(qq{<h2><MT_TRANS phrase="[_1] [_2] Modules" params="$phrase%%$type"></h2>\n\t<div>\n});
    if (!$req && !$data) {
        print trans_templ(<<MSG);
    <p class="msg msg-info"><MT_TRANS phrase="The following modules are <strong>optional</strong>. If your server does not have these modules installed, you only need to install them if you require the functionality that the module provides."></p>

MSG
    }
    if ($data) {
        print trans_templ(<<MSG);
        <p class="msg msg-info"><MT_TRANS phrase="Some of the following modules are required by the various data storage options in Melody. In order run the system, your server needs to have DBI and at least one of the other modules installed."></p>

MSG
    }
    my $got_one_data = 0;
    my $dbi_is_okay = 0;
    for my $ref (@$list) {
        my($mod, $ver, $req, $desc) = @$ref;
        if ('CODE' eq ref($desc)) {
            $desc = $desc->();
        }
        print "<blockquote>\n" if $mod =~ m/^DBD::/;
        print "    <h3>$mod" .
            ($ver ? " (version &gt;= $ver)" : "") . "</h3>";
        eval("use $mod" . ($ver ? " $ver;" : ";"));
        if ($@) {
            $is_good = 0 if $req;
            my $link = 'http://search.cpan.org/perldoc?' . $mod;
            my $msg = $ver ?
                      trans_templ(qq{<p class="warning"><MT_TRANS phrase="Either your server does not have <a href="[_2]">[_1]</a> installed, the version that is installed is too old, or [_1] requires another module that is not installed." params="$mod%%$link"> }) :
                      trans_templ(qq{<p class="warning"><MT_TRANS phrase="Your server does not have <a href="[_2]">[_1]</a> installed, or [_1] requires another module that is not installed." params="$mod%%$link"> });
            $msg   .= $desc .
                      trans_templ(qq{ <MT_TRANS phrase="Please consult the installation instructions for help in installing [_1]." params="$mod"></p>\n\n});
            print $msg . "\n\n";
        } else {
            if ($data) {
                $dbi_is_okay = 1 if $mod eq 'DBI';
                if ($mod eq 'DBD::mysql') {
                    if ($DBD::mysql::VERSION == 3.0000) {
                        print trans_templ(qq{<p class="warning"><MT_TRANS phrase="The DBD::mysql version you have installed is known to be incompatible with Melody. Please install the current release available from CPAN."></p>});
                    }
                }
                if (!$dbi_is_okay) {
                    print trans_templ(qq{<p class="warning"><MT_TRANS phrase="The $mod is installed properly, but requires an updated DBI module. Please see note above regarding the DBI module requirements."></p>});
                } else {
                    $got_one_data = 1 if $mod ne 'DBI';
                }
            }
            print trans_templ(qq{<p class="installed"><MT_TRANS phrase="Your server has [_1] installed (version [_2])." params="$mod%%} . $mod->VERSION . qq{"></p>\n\n});
        }
        print "</blockquote>\n" if $mod =~ m/^DBD::/;
    }
    $is_good &= $got_one_data if $data;
    print "\n\t</div>\n\n";
}

if ($is_good && $cfg_exist) {
    if (!$view) {
    print trans_templ(<<HTML);
    
    <div class="msg msg-success">
        <h2><MT_TRANS phrase="Melody System Check Successful"></h2>
        <p><strong><MT_TRANS phrase="You're ready to go!"></strong> <MT_TRANS phrase="Your server has all of the required modules installed; you do not need to perform any additional module installations. Continue with the installation instructions."></p>
    </div>

</div>

HTML
    }
}

print "</body>\n\n</html>\n";
