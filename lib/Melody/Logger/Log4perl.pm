# Melody (r) Open Source (C) 2001-2009 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
package Melody::Logger::Log4perl;

use strict;
use warnings;
use diagnostics;
use Carp;

use base qw( Class::Data::Inheritable );
__PACKAGE__->mk_classdata('initialized');

use Log::Log4perl;
use MT::Log;
use Data::Dumper;

our %level = map {
    eval "MT::Log::$_" => $_
} qw( DEBUG INFO WARNING ERROR FATAL SECURITY );

sub new {
    my $class = shift;
    my %args = @_;
    # print STDERR __PACKAGE__.'::new(): '.Dumper(\%args);

    unless ( $class->initialized ) {
        Log::Log4perl::init_and_watch( MT->config->LoggerConfigFile ,10 );
        $class->initialized(1);
    }

    my $logger;
    if ( my $category = $args{key} || $args{caller} ) {
        $logger = Log::Log4perl->get_logger( $category );
        # print STDERR "CATEGORY: $category\n";
        # print STDERR $logger."\n";
    }
    else {
        $logger = bless {}, $class;  # DRIVER ACCESSOR
    }
    return $logger;
}

sub log4perl_level {
    my ($self, $mtlog_level) = @_;
    # print STDERR "Got mtlog_level $mtlog_level\n";
    if ( $mtlog_level =~ m{^[0-9]+$} ) {
        $mtlog_level = $level{$mtlog_level};
    }
    else {
        $mtlog_level = '' unless defined $mtlog_level;
    }
    $mtlog_level =~ s{WARNING}{WARN};
    # print STDERR "mtlog_level now $mtlog_level\n";
    require Log::Log4perl::Level;
    my $level = Log::Log4perl::Level::to_priority( $mtlog_level );
    # print STDERR "level is $level\n";
    return $level;
}


1;
