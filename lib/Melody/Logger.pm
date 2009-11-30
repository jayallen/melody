# Melody (r) Open Source (C) 2001-2009 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
package Melody::Logger;

use strict;
use warnings;
use diagnostics;
use Carp;

use base qw( Class::Accessor::Fast );
__PACKAGE__->mk_accessors(qw( DRIVERS ));

my @drivers = ();

my $LOGGERMGR;

*instance = \&new;
sub new {
    unless ( $LOGGERMGR ) {
        $LOGGERMGR = bless {}, shift;
        my $logger = $LOGGERMGR->init(@_);
        return $logger if $logger;
    }
    return $LOGGERMGR;
}

sub init {
    my $self = shift;
    return @_ ? $self->get_logger(@_) : undef;
}

sub get_logger {
    my $self = shift;
    $self = $self->instance unless ref $self;
    my %args = (@_ > 1) ? @_
             :      @_  ? ( 'key' => shift )
                        : ();
    $args{class} ||= MT->config->LoggerModule;
    $args{caller} = caller;

    eval 'require ' . $args{class};
    if ($@) {
        die (MT->translate(
            "Bad LoggerModule config '[_1]': [_2]",
                $args{class}, $@));
    }
    my $logger_module
        = $args{class}->new( %args );

    return $logger_module;
}

sub unplug { undef $LOGGERMGR }

1;

__END__

=head1 NAME

Melody::Logger - A module which initializes and manages logging objects

=head1 DESCRIPTION

This module is the base class for Melody's logging and notification framework.
It provides an abstract interface for initializing Melody::Logger drivers
available to the system and managing those active instances to eliminate the
need for later re-initialization when requested again by other parts of the
application.

=head1 METHODS

=head2 new()

Creates and returns the Melody::Logger object. This object is a singleton so subsequent calls to new() will yield the same object. Returns undef on failure.

=head2 instance()

As a singleton, this is an alias of Melody::Logger->new()

=head2 init(\%context)

Initializes Melody::Logger, including registration of basic resources defined by the configuration.

=head2 get_logger(%context)

Initializes and returns a Melody::Logger driver object defined by %context.
Each returned object is cached so that subsequent calls to get_logger() with
the same parameters returns the previously initialized object

%context can be one or more of the following:

=over 4

=item * class

The package name of an available logging module. If no 'class'
attribute if given, the LoggerModule defined in the mt-config.cgi is assumed.

=item * key

A unique identifier which corresponds to a particular variant of the specified
logger class. This may be required, optional or completely ignored by the
logging driver. If "key" is ignored by the driver, it is also ignored for the
purposes of tracking active loggers.

=back

=head2 unplug()

Destroys the Melody::Logger object.

=head1 AUTHOR & COPYRIGHT

Jay Allen, Endevver Consulting <jay@endevver.com>, http://endevver.com

=cut
