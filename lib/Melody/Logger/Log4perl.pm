package Melody::Logger::Log4perl;

use strict;
use warnings;
use diagnostics;

use Log::Log4perl;

sub new {
    my $class = shift;
    my %args = @_;
    my $category = $args{key} || $args{caller} || undef;
    return Log::Log4perl::get_logger( $category );
}

1;
