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
my $static_path = q();
my $cgi_path;
if ((-f File::Spec->catfile($ENV{MT_HOME}, 'config.cgi')) ||
    (-f File::Spec->catfile($ENV{MT_HOME}, 'mt.cfg'))) {
    $cfg_exist = 1;
    my $file_handle = open(CFG, $ENV{MT_HOME}.'/mt.cfg') || open(CFG, $ENV{MT_HOME}.'/config.cgi');
    my $line;
    while ($line = <CFG>) {
        next if $line !~ /\S/ || $line =~ /^#/;
        if ($line =~ s/StaticWebPath[\s]*([^\n]*)/$1/) {
            $static_path = $line;
            chomp($static_path);
        }
        elsif ($line =~ s/CGIPath[\s]*([^\n]*)/$1/) {
            $cgi_path = $line;
            chomp($cgi_path);
        }
    }
    if ( !$static_path && $cgi_path ) {
        $cgi_path .= '/' if $cgi_path !~ m|/$|;
        $static_path = $cgi_path . 'mt-static/';
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
$lang ||= 'en_US';

sub trans_templ {
    my($text) = @_;
    return $mt->translate_templatized($text) if $mt;
    $text =~ s!(<__trans(?:\s+((?:\w+)\s*=\s*(["'])(?:<[^>]+?>|[^\3]+?)+?\3))+?\s*/?>)!
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

# This script needs to be updated to assume File::Spec is
# available since its been in Perl 5 since Perl 5.6. A special
# in sufficient perl version should be displayed alone and no
# more.
local( *CSS ) ;
open( CSS, $ENV{MT_HOME}.'/check/check.css' );
my $css = do { local( $/ ) ; <CSS> } ;
close(CSS);

$css =~ s{\$static_path}{$static_path}gi;

print "Content-Type: text/html; charset=utf-8\n\n";
if (!$view) {
    print trans_templ(<<HTML);

<!DOCTYPE html PUBLIC "-//W3C//DTD XHTML 1.1//EN" "http://www.w3.org/TR/xhtml11/DTD/xhtml11.dtd">
<html xmlns="http://www.w3.org/1999/xhtml">

<head>
    <meta http-equiv="content-type" content="text/html; charset=utf-8" />
    <meta http-equiv="content-language" content="$lang" />
    
    <title><__trans phrase="Melody System Check"> [check.cgi]</title>
    
    <style type=\"text/css\">
        <!--
$css        
        //-->
    </style>

</head>

HTML
    if ($static_path) {
        print "<body class=\"has-static\">\n";
    } else {
        print "<body>\n";
    }
    print trans_templ(<<HTML);
<div id="header"><h1><__trans phrase="Melody System Check"> [check.cgi]</h1></div>

<div id="content">
<p class="msg msg-info"><__trans phrase="The check.cgi script provides you with information on your system's configuration and determines whether you have all of the components you need to run Melody."></p>
HTML
}

my $is_good = 1;
my (@REQ, @DATA, @OPT);

my @CORE_REQ = (
    [ 'Algorithm::Diff', 1.1902, 1, '', 'http://search.cpan.org/dist/Algorithm-Diff/'],
    [ 'Cache', 2.04, 1, '', 'http://search.cpan.org/dist/Cache/'],
    [ 'CGI', 3.50, 1, '', 'http://search.cpan.org/dist/CGI/'],
    [ 'Class::Accessor', 0.22, 1, '', 'http://search.cpan.org/dist/Class-Accessor/'],
    [ 'Class::Data::Inheritable', 0.06, 1, '', 'http://search.cpan.org/dist/Class-Data-Inheritable/'],
    [ 'Class::Trigger', '0.1001', 1, '', 'http://search.cpan.org/dist/Class-Trigger/'],
    [ 'Data::ObjectDriver', 0.06, 1, '', 'http://search.cpan.org/dist/Data-ObjectDriver/'],
    [ 'Digest::SHA1', 0.06, 1, '', 'http://search.cpan.org/dist/Digest-SHA1/'],
    [ 'File::Copy::Recursive', 0.23, 1, '', 'http://search.cpan.org/dist/File-Copy-Recursive/'],
    [ 'Heap::Fibonacci', 0.71, 1, '', 'http://search.cpan.org/dist/Heap/'],
    [ 'HTML::Diff', 0.561, 1, '', 'http://search.cpan.org/dist/HTML-Diff/'],
    [ 'HTML::Parser', 3.66, 1, '', 'http://search.cpan.org/dist/HTML-Parser/'],
    [ 'Image::Size', 2.93, 1, '', 'http://search.cpan.org/dist/Image-Size/'],
    [ 'JSON', 2.12, 1, '', 'http://search.cpan.org/dist/JSON/'],
    [ 'Jcode', 0.88, 1, '', 'http://search.cpan.org/dist/Jcode/'],
    [ 'Locale::Maketext', 1.13, 1, '', 'http://search.cpan.org/dist/Locale-Maketext/'],
    [ 'Log::Dispatch', 2.26, 1, '', 'http://search.cpan.org/dist/Log-Dispatch'],
    [ 'Log::Log4perl', 1.30, 1, '', 'http://search.cpan.org/dist/Log-Log4Perl'],
    [ 'Lucene::QueryParser', 1.04, 1, '', 'http://search.cpan.org/dist/Lucene-QueryParser'],
    [ 'LWP', 5.831, 1, '', 'http://search.cpan.org/dist/libwww-perl/'],
    [ 'Params::Validate', 0.73, 1, '', 'http://search.cpan.org/dist/Params-Validate'],
    [ 'Sub::Install', 0.925, 1, '', 'http://search.cpan.org/dist/Sub-Install'],
    [ 'TheSchwartz', 1.07, 1, '', 'http://search.cpan.org/dist/TheSchwartz'],
    [ 'URI', 1.36, 1, '', 'http://search.cpan.org/dist/URI'],
    [ 'version', 0.76, 1, '', 'http://search.cpan.org/dist/version/'],
    [ 'YAML::Tiny', 1.12, 1, '', 'http://search.cpan.org/dist/YAML-Tiny/'],
);

my @CORE_DATA = (
    [ 'DBI', 1.21, 0, translate('DBI is required to store data in database.'),'http://search.cpan.org/dist/DBI/'],
    [ 'DBD::mysql', 0, 0, translate('DBI and DBD::mysql are required if you want to use the MySQL database backend.'),'http://search.cpan.org/dist/DBD-mysql/'],
    [ 'DBD::Pg', 1.32, 0, translate('DBI and DBD::Pg are required if you want to use the PostgreSQL database backend.'),'http://search.cpan.org/dist/DBD-Pg/'],
    [ 'DBD::SQLite', 1.20, 0, translate('DBI and DBD::SQLite are required if you want to use the SQLite database backend.'),'http://search.cpan.org/dist/DBD-SQLite/'],
    [ 'DBD::SQLite2', 0, 0, translate('DBI and DBD::SQLite2 are required if you want to use the SQLite 2.x database backend.'),'http://search.cpan.org/dist/DBD-SQLite2/'],
);

my @CORE_OPT = (
    [ 'Archive::Tar', 0, 0, translate('Archive::Tar is needed in order to archive files in backup/restore operation.'),'http://search.cpan.org/dist/Archive-Tar/'],
    [ 'Archive::Zip', 0, 0, translate('Archive::Zip is needed in order to archive files in backup/restore operation.'),'http://search.cpan.org/dist/Archive-Zip/'],
    [ 'Attribute::Params::Validate', 1.07, 0, '','http://search.cpan.org/dist/Params-Validate/lib/Attribute/Params/Validate.pm'],
    [ 'bignum', 0.23, 0, '','http://search.cpan.org/dist/bignum/'], 
    [ 'Cache::Memcached', 0, 0, translate('Cache::Memcached and memcached server/daemon is needed in order to use memcached as caching mechanism used by Melody.'),'http://search.cpan.org/dist/Cache-Memcached/'],
    [ 'Crypt::DH', 0.06, 0, translate('This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers '),'http://search.cpan.org/dist/Crypt-DH/'],
    [ 'Crypt::DSA', 0, 0, translate('Crypt::DSA is optional; if it is installed, comment registration sign-ins will be accelerated.'),'http://search.cpan.org/dist/Crypt-DSA/'],
    [ 'Crypt::SSLeay', 0, 0, translate('This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers that require SSL support.'),'http://search.cpan.org/dist/Crypt-SSLeay/'],
    [ 'Devel::Leak::Object', 0, 0, translate('This module is used by the --leak option of the tools/run-periodic-tasks script.'), 'http://search.cpan.org/dist/GD/Devel-Leak-Object/'],
    [ 'GD', 0, 0, translate('This module is needed if you would like to be able to create thumbnails of uploaded images.'),'http://search.cpan.org/dist/GD/'],
    [ 'IO::Compress::Gzip', 0, 0, translate('IO::Compress::Gzip is needed in order to compress files in backup/restore operation.'),'http://search.cpan.org/dist/IO-Compress/lib/IO/Compress/Gzip.pm'],
    [ 'IO::Scalar', 2.110, 0, translate('IO::Scalar is needed in order to archive files in backup/restore operation.'),'http://search.cpan.org/dist/IO-Scalar/'],
    [ 'IO::Uncompress::Gunzip', 0, 0, translate('IO::Uncompress::Gunzip is required in order to decompress files in backup/restore operation.'),'http://search.cpan.org/dist/IO-Compress/lib/IO/Compress/Gunzip.pm'],
    [ 'IPC::Run', 0, 0, translate('This module is needed if you would like to be able to use NetPBM as the image driver for Melody.'),'http://search.cpan.org/dist/IPC-Run/'],
    [ 'Image::Magick', 0, 0, translate('Image::Magick is optional; It is needed if you would like to be able to create thumbnails of uploaded images.'),'http://search.cpan.org/dist/Image-Magick/'],
    [ 'MIME::Charset', 0.044, 0, translate('MIME::Charset is required for sending mail via SMTP Server.'),'http://search.cpan.org/dist/MIME-Charset/'],
    [ 'MIME::EncWords', 0.96, 0, translate('MIME::EncWords is required for sending mail via SMTP Server.'),'http://search.cpan.org/dist/MIME-EncWords/'],
    [ 'Mail::Sendmail', 0, 0, translate('Mail::Sendmail is required for sending mail via SMTP Server.'),'http://search.cpan.org/dist/Mail-SendMail/'],
    [ 'Net::OpenID::Consumer', 1.03, 0, translate('This module and its dependencies are required in order to allow commenters to be authenticated by OpenID providers '),'http://search.cpan.org/dist/Net-OpenID-Consumer/'],
    [ 'Path::Class', 0, 0, '','http://search.cpan.org/dist/Path-Class/'],
    [ 'Proc::ProcessTable', 0, 0, translate('This module is used by the tools/run-periodic-tasks script and RPTProcessCap directive.'), 'http://search.cpan.org/dist/Proc-ProcessTable'],
    [ 'SOAP::Lite', '0.710.08', 0, translate('SOAP::Lite is optional; It is needed if you wish to use the Melody XML-RPC server implementation.'),'http://search.cpan.org/dist/SOAP-Lite/'],
    [ 'XML::Atom', 0, 0, translate('XML::Atom is required in order to use the Atom API.'),'http://search.cpan.org/dist/XML-Atom/'],
    [ 'XML::LibXML', 0, 0, translate('XML::LibXML is required in order to use the Atom API.'),'http://search.cpan.org/dist/XML-LibXML/'],
    [ 'XML::NamespaceSupport', 1.09, 0, translate('XML::NamespaceSupport is needed in order to archive files in backup/restore operation.'),'http://search.cpan.org/dist/XML-NamespaceSupport/'],
    [ 'XML::Parser', 2.23, 0, '','http://search.cpan.org/dist/XML-Parser/'],
    [ 'XML::SAX', 0.96, 0, translate('XML::SAX is needed in order to archive files in backup/restore operation.'),'http://search.cpan.org/dist/XML-SAX/'],
    [ 'XML::Simple', 2.14, 0, translate('XML::Simple is needed in order to archive files in backup/restore operation.'),'http://search.cpan.org/dist/XML-Simple/'],
    [ 'XML::XPath', 0, 0, '','http://search.cpan.org/dist/XML-XPath'],
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
<p class="warning"><__trans phrase="The version of Perl installed on your server ([_1]) is lower than the minimum supported version ([_2]). Please upgrade to at least Perl [_2]." params="$ver%%5.8.8"></p>
EOT
}
my $config_check = '';
if (!$cfg_exist) {
    $config_check = <<CONFIG;
<p class="warning"><__trans phrase="Melody configuration file was not found."></p>
CONFIG
}
my $server = $ENV{SERVER_SOFTWARE};
my $inc_path = join "<br />\n", @INC;
print trans_templ(<<INFO);
<h2 id="system-info"><__trans phrase="System Information"></h2>
$perl_ver_check
$config_check
INFO
if ($version) {
    # sanitize down to letters numbers dashes and period
    $version =~ s/[^a-zA-Z0-9\-\.]//g;
print trans_templ(<<INFO);
<ul class="version">
    <li><strong><__trans phrase="Melody version:"></strong> <code>$version</code></li>
</ul>
INFO
}
print trans_templ(<<INFO);
<ul>
	<li><strong><__trans phrase="Current working directory:"></strong> <code>$cwd</code></li>
	<li><strong><__trans phrase="Melody home directory:"></strong> <code>$ENV{MT_HOME}</code></li>
	<li><strong><__trans phrase="Operating system:"></strong> $^O</li>
	<li><strong><__trans phrase="Perl version:"></strong> <code>$ver</code></li>
	<li><strong><__trans phrase="Perl include path:"></strong><br /> <code>$inc_path</code></li>
INFO
if ($server) {
print trans_templ(<<INFO);
    <li><strong><__trans phrase="Web server:"></strong> <code>$server</code></li>
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
    print trans_templ('    <li><__trans phrase="(Probably) Running under cgiwrap or suexec"></li>' . "\n");
}

print "\n\n</ul>\n";

exit if $ENV{QUERY_STRING} && $ENV{QUERY_STRING} eq 'sys-check';

#if ($mt) {
#    my $req = $mt->registry("required_packages");
#    foreach my $key (keys %$req) {
#        next if $key eq 'DBI';
#        my $pkg = $req->{$key};
#        push @REQ, [ $key, $pkg->{version} || 0, 1, $pkg->{label}, $key, $pkg->{link} ];
#    }
#    my $drivers = $mt->object_drivers;
#    foreach my $key (keys %$drivers) {
#        my $driver = $drivers->{$key};
#        my $label = $driver->{label};
#        my $link = 'http://search.cpan.org/dist/' . $driver->{dbd_package};
#        $link =~ s/::/-/g;
#        push @DATA, [ $driver->{dbd_package}, $driver->{dbd_version}, 0,
#            $mt->translate("The [_1] database driver is required to use [_2].", $driver->{dbd_package}, $label),
#            $label, $link ];
#    }
#    unshift @DATA, [ 'DBI', 1.21, 0, translate('DBI is required to store data in database.') ]
#        if @DATA;
#    my $opt = $mt->registry("optional_packages");
#    foreach my $key (keys %$opt) {
#        my $pkg = $opt->{$key};
#        push @OPT, [ $key, $pkg->{version} || 0, 0, $pkg->{label}, $key, $pkg->{link} ];
#    }
#}
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
    print trans_templ(qq{<h2><__trans phrase="[_1] [_2] Modules" params="$phrase%%$type"></h2>\n\t<div>\n});
    if (!$req && !$data) {
        print trans_templ(<<MSG);
    <p class="msg msg-info"><__trans phrase="The following modules are <strong>optional</strong>. If your server does not have these modules installed, you only need to install them if you require the functionality that the module provides."></p>

MSG
    }
    if ($data) {
        print trans_templ(<<MSG);
        <p class="msg msg-info"><__trans phrase="Some of the following modules are required by the various data storage options in Melody. In order run the system, your server needs to have DBI and at least one of the other modules installed."></p>

MSG
    }
    my $got_one_data = 0;
    my $dbi_is_okay = 0;
    for my $ref (@$list) {
        my($mod, $ver, $req, $desc, $link) = @$ref;
#        if ('CODE' eq ref($desc)) {
#            $desc = $desc->();
#        }
        if (!$desc && $req) {
               $desc = trans_templ(qq{<__trans phrase="[_1] is required for standard Melody application functionality" params="$mod">});
        }
        print "<blockquote>\n" if $mod =~ m/^DBD::/;
        print "    <h3><a href=\"$link\">$mod</a>" .
            ($ver ? " (version &gt;= $ver)" : "") . "</h3>";
        eval("use $mod" . ($ver ? " $ver;" : ";"));
        if ($@) {
            $is_good = 0 if $req;
            my $link = 'http://search.cpan.org/perldoc?' . $mod;
            my $msg = $ver ?
                      trans_templ(qq{<p class="warning"><__trans phrase="Either your server does not have <a href="[_2]">[_1]</a> installed, the version that is installed is too old, or [_1] requires another module that is not installed." params="$mod%%$link"> }) :
                      trans_templ(qq{<p class="warning"><__trans phrase="Your server does not have <a href="[_2]">[_1]</a> installed, or [_1] requires another module that is not installed." params="$mod%%$link"> });
            $msg   .= $desc .
                      trans_templ(qq{ <__trans phrase="Please consult the installation instructions for help in installing [_1]." params="$mod"></p>\n\n});
            print $msg . "\n\n";
        } else {
            if ($data) {
                $dbi_is_okay = 1 if $mod eq 'DBI';
                if ($mod eq 'DBD::mysql') {
                    if ($DBD::mysql::VERSION == 3.0000) {
                        print trans_templ(qq{<p class="warning"><__trans phrase="The DBD::mysql version you have installed is known to be incompatible with Melody. Please install the current release available from CPAN."></p>});
                    }
                }
                if (!$dbi_is_okay) {
                    print trans_templ(qq{<p class="warning"><__trans phrase="The $mod is installed properly, but requires an updated DBI module. Please see note above regarding the DBI module requirements."></p>});
                } else {
                    $got_one_data = 1 if $mod ne 'DBI';
                }
            }
            print trans_templ(qq{<p class="installed"><__trans phrase="Your server has [_1] installed (version [_2])." params="$mod%%} . $mod->VERSION . qq{"></p>\n\n});
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
        <h2><__trans phrase="Melody System Check Successful"></h2>
        <p><strong><__trans phrase="You're ready to go!"></strong> <__trans phrase="Your server has all of the required modules installed; you do not need to perform any additional module installations. Continue with the installation instructions."></p>
    </div>

</div>

HTML
    }
}

print "</body>\n\n</html>\n";
