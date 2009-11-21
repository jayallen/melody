package MT::Logger::Log4perl;

use strict;
use warnings;
use diagnostics;

use base qw( Log::Log4perl );

sub new {
    my $real_logger = Log::Log4perl::get_logger(@_);
    bless { real_logger => $real_logger }, $_[0];
}

sub AUTOLOAD {
    no strict;
    my $self = shift;
    $AUTOLOAD =~ s/.*:://;
    $self->{real_logger}->$AUTOLOAD(@_);
}

sub DESTROY { }

1;
