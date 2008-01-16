# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::Bootstrap;

use strict;

sub BEGIN {
    my ($dir, $orig_dir);
    require File::Spec;
    if (!($dir = $ENV{MT_HOME})) {
        if ($0 =~ m!(.*([/\\]))!) {
            $orig_dir = $dir = $1;
            my $slash = $2;
            $dir =~ s!(?:[/\\]|^)(?:plugins[/\\].*|tools[/\\])$!$slash!;
            $dir = '' if ($dir =~ m!^\.?[\\/]$!);
        } elsif ($] >= 5.006) {
            # MT_DIR/lib/MT/Bootstrap.pm -> MT_DIR/lib/MT -> MT_DIR/lib -> MT_DIR
            require File::Basename;
            $dir = File::Basename::dirname(File::Basename::dirname(
                File::Basename::dirname(File::Spec->rel2abs(__FILE__))));
        }
        unless ($dir) {
            $orig_dir = $dir = $ENV{PWD} || '.';
            $dir =~ s!(?:[/\\]|^)(?:plugins[/\\].*|tools[/\\]?)$!!;
        }
        $ENV{MT_HOME} = $dir;
    }
    unshift @INC, File::Spec->catdir($dir, 'extlib');
    unshift @INC, File::Spec->catdir($orig_dir, 'lib')
        if $orig_dir && ($orig_dir ne $dir);
}

sub import {
    my ($pkg, %param) = @_;

    # use 'App' parameter, or MT_APP from the environment
    my $class = $param{App} || $ENV{MT_APP};

    if ($class) {
        # When running under FastCGI, the initial invocation of the
        # script has a bare environment. We can use this to test
        # for FastCGI.
        my $not_fast_cgi = 0;
        $not_fast_cgi ||= exists $ENV{$_}
            for qw(HTTP_HOST GATEWAY_INTERFACE SCRIPT_FILENAME SCRIPT_URL);
         my $fast_cgi = defined $param{FastCGI} ? $param{FastCGI} : (!$not_fast_cgi);
         if ($fast_cgi) {
             eval 'require CGI::Fast;';
             $fast_cgi = 0 if $@;
         }

        # ready to run now... run inside an eval block so we can gracefully
        # die if something bad happens
        my $app;
        eval {
            # line __LINE__ __FILE__
            require MT;
            eval "# line " . __LINE__ . " " . __FILE__ . "\nrequire $class; 1;" or die $@;
            if ($fast_cgi) {
                $ENV{FAST_CGI} = 1;
                while (my $cgi = new CGI::Fast) {
                    $app = $class->new( %param, CGIObject => $cgi )
                        or die $class->errstr;
                    local $SIG{__WARN__} = sub { $app->trace($_[0]) };
                    MT->set_instance($app);
                    $app->init_request(CGIObject => $cgi);
                    $app->run;
                }
            } else {
                $app = $class->new( %param ) or die $class->errstr;
                local $SIG{__WARN__} = sub { $app->trace($_[0]) };
                $app->run;
            }
        };
        if (my $err = $@) {
            my $charset = 'utf-8';
            eval {
                # line __LINE__ __FILE__
                my $cfg = MT::ConfigMgr->instance;  #this is needed
                $app ||= MT->instance;
                my $c = $app->find_config;
                $app->{cfg}->read_config($c);
                $charset = $app->{cfg}->PublishCharset;
            };
            if ($app && UNIVERSAL::isa($app, 'MT::App')) {
                eval {
                    # line __LINE__ __FILE__
                    my %param = ( error => $err );
                    if ($err =~ m/Bad ObjectDriver/) {
                        $param{error_database_connection} = 1;
                    } elsif ($err =~ m/Bad CGIPath/) {
                        $param{error_cgi_path} = 1;
                    } elsif ($err =~ m/Missing configuration file/) {
                        $param{error_config_file} = 1;
                    }
                    my $page = $app->build_page('error.tmpl', \%param)
                        or die $app->errstr;
                    print "Content-Type: text/html; charset=$charset\n\n";
                    print $page;
                    exit;
                };
                $err = $@;
            } else {
                if ($err =~ m/Missing configuration file/) {
                    my $host = $ENV{SERVER_NAME} || $ENV{HTTP_HOST};
                    $host =~ s/:\d+//;
                    my $port = $ENV{SERVER_PORT};
                    my $uri = $ENV{REQUEST_URI} || $ENV{SCRIPT_NAME};
                    if ($uri =~ m/(\/mt\.(f?cgi|f?pl)(\?.*)?)$/) {
                        my $script = $1;
                        my $ext = $2;

                        if (-f File::Spec->catfile($ENV{MT_HOME}, "mt-wizard.$ext")) {
                            $uri =~ s/\Q$script\E//;
                            $uri .= '/mt-wizard.' . $ext;

                            my $prot = $port == 443 ? 'https' : 'http';
                            my $cgipath = "$prot://$host";
                            $cgipath .= ":$port"
                                unless $port == 443 or $port == 80;
                            $cgipath .= $uri;
                            print "Status: 302 Moved\n";
                            print "Location: " . $cgipath . "\n\n";
                            exit;
                        }
                    }
                }
                print "Content-Type: text/plain; charset=$charset\n\n";
                print $app ? $app->translate("Got an error: [_1]", $app->translate($err)) : "Got an error: $err\n";
            }
        }
    }
}

1;
__END__

=head1 NAME

MT::Bootstrap

=head1 DESCRIPTION

Startup module used to simplify MT application CGIs.

=head1 SYNOPSIS

Movable Type CGI scripts should utilize the C<MT::Bootstrap> module
to invoke the application code itself. When run, it is necessary
to add the MT "lib" directory to the Perl include path.

Example (for CGIs in the main MT directory itself):

    #!/usr/bin/perl -w
    use strict;
    use lib $ENV{MT_HOME} ? "$ENV{MT_HOME}/lib" : 'lib';
    use MT::Bootstrap App => 'MT::App::CMS';

Example (for CGIs in a plugin subdirectory, ie MT/plugins/plugin_x):

    #!/usr/bin/perl -w
    use strict;
    use lib "lib", ($ENV{MT_HOME} ? "$ENV{MT_HOME}/lib" : "../../lib");
    use MT::Bootstrap App => 'MyApp';

=cut
