# Melody - Open Source (C) 2009 Open Melody Software Group, Inc.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
package Melody::Logger::Log4perl::Appender::MTLog;

our @ISA = qw( Log::Log4perl::Appender );

use strict;
use warnings;
use diagnostics;
# use Carp;

use MT;
use MT::Log;

our %level = map {
    eval "MT::Log::$_" => $_
} qw( DEBUG INFO WARNING ERROR FATAL SECURITY );

sub INFO ()     { 1 }
sub WARNING ()  { 2 }
sub ERROR ()    { 4 }
sub SECURITY () { 8 }
sub DEBUG ()    { 16 }
sub FATAL ()    { 256 } # For Log4perl compatibility


sub new {
    my ( $proto, %p ) = @_;
    my $class = ref $proto || $proto;

    # print STDERR "\n-- $class - NEW()\n";
    # print STDERR __PACKAGE__.'::new(): '.Dumper(\@_);
    my $self = {
        name     => "MT Activity Log appender",
        category => $class,
        %p,
    };

    # print STDERR __PACKAGE__."::new(): ".Dumper($self);
    bless $self, $class;
    return $self;
}

sub log {
    use Data::Dumper;
    my ( $self, %params ) = @_;

    # printf STDERR "\n-- %s - LOG() from %s:\n", ( ref($self) || '' ),
    #   ( ( caller(1) )[3] || '' );
    # print STDERR "PARAMS: " . Dumper( \%params );

    # my $logger = MT->get_logger('File')
    #           or MT->get_logger()
    #           or die "ERROR: couldn't get logger";

    # Unwrap the message element
    if ( ref $params{message} eq 'ARRAY' ) {
        $params{message} = join ' ', @{ $params{message} };
    }

    my $app = MT->instance;
    my $log_class = $app->model('log');
    my $log = $log_class->new();
    $log->set_values( \%params );

    if ($app->isa('MT::App')) {
        $log->ip( $app->remote_ip );
        if ( my $blog = $app->blog ) {
            $log->blog_id( $blog->id );
        }
        if ( my $user = $app->user ) {
            $log->author_id( $user->id );
        }
    }

    my $level = $params{log4p_level} ? $level{ $params{log4p_level} }
                                     : MT::Log::INFO();
    $log->level( $level );
    $log->class($params{class} || 'system');
    $log->save;
    # print STDERR $app->translate( "Message: [_1]", $log->message ) . "\n"
    #   if $MT::DebugMode;
}

1;

__END__


