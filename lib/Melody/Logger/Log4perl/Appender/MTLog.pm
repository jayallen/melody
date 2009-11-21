### MT::Log::Log4Perl::Appender::MT
# AUTHOR:   Jay Allen, Endevver Consulting
# See README.txt in this package for more details
# $Id: MT.pm 803 2008-02-14 22:52:06Z jay $
package MT::Log;

use constant FATAL => 256;

1;

package MT::Log::Log4perl::Appender::MTLog;

our @ISA = qw(Log::Log4perl::Appender);

# use strict;
use MT;
use MT::Log;

our %level = (
    'DEBUG'    => MT::Log::DEBUG,
    'INFO'     => MT::Log::INFO,
    'WARNING'  => MT::Log::WARNING,
    'ERROR'    => MT::Log::ERROR,
    'FATAL'    => MT::Log::ERROR,
    'SECURITY' => MT::Log::SECURITY,
);

sub new {
    my ( $proto, %p ) = @_;
    my $class = ref $proto || $proto;

    # print STDERR "\n-- $class - NEW()\n";
    my $self = {
        name     => "unknown name",
        category => $class,
        %p,
    };

    # print STDERR Dumper($self);
    bless $self, $class;
    return $self;
}

sub log {
    use Data::Dumper;
    my ( $self, %params ) = @_;

    printf STDERR "\n-- %s - LOG() from %s:\n", ( ref($self) || '' ),
      ( ( caller(1) )[3] || '' );
    print STDERR "PARAMS: " . Dumper( \%params );

    require MT::Log::Log4perl;
    my $logfile =
         MT::Log::Log4perl->new('file')
      or MT::Log::Log4perl->new('')
      or die 'ERROR: couldnt get logger';

    if ( $params{message} and ref( $params{message} ) eq 'ARRAY' ) {
        if ( @{ $params{message} } == 1 ) {
            $log_data = { message => ${ $params{message} }[0] };
        }
        else {
            $log_data = { @{ $params{message} } };
        }
    }
    else {
        $log_data =
          { message => 'Log did not receive message from: ' . Dumper( \@_ ) };
    }

    # my $log_data = $param{message};
    # if (@_ == 1 and ref($_[0]) eq 'HASH') {
    #     $log_data = $_[0];
    # }
    # elsif (@_ > 1) {
    #     $log_data = { @_ };
    # }
    # else {
    #     $log_data = { message => $_[0] };
    # }

    # print STDERR "LOG DATA: ".Dumper($log_data);

    $log_data->{message} = 'Fatal error: ' . $log_data->{message}
      if ( $params{log4p_level} || '' ) eq 'FATAL';
    $log_data->{level} = $level{ $params{log4p_level} };

    my $mt = MT->instance;
    return ( $mt ? $mt->log($log_data) : MT->log($log_data) );
}

1;

__END__
