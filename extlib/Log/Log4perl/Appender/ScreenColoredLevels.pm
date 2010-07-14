##################################################
package Log::Log4perl::Appender::ScreenColoredLevels;
##################################################
our @ISA = qw(Log::Log4perl::Appender);

use warnings;
use strict;

use Term::ANSIColor qw();
use Log::Log4perl::Level;

##################################################
sub new {
##################################################
    my($class, @options) = @_;

    my $self = {
        name   => "unknown name",
        stderr => 1,
        color  => {},
        @options,
    };

      # also accept lower/mixed case levels in config
    for my $level ( keys %{ $self->{color} } ) {
        my $uclevel = uc($level);
        $self->{color}->{$uclevel} = $self->{color}->{$level};
    }

    my %default_colors = (
        TRACE   => 'yellow',
        DEBUG   => '',
        INFO    => 'green',
        WARN    => 'blue',
        ERROR   => 'magenta',
        FATAL   => 'red',
    );
    for my $level ( keys %default_colors ) {
        if ( ! exists $self->{ 'color' }->{ $level } ) {
            $self->{ 'color' }->{ $level } = $default_colors{ $level };
        }
    }

    bless $self, $class;
}
    
##################################################
sub log {
##################################################
    my($self, %params) = @_;

    my $msg = $params{ 'message' };

    if ( my $color = $self->{ 'color' }->{ $params{ 'log4p_level' } } ) {
        $msg = Term::ANSIColor::colored( $msg, $color );
    }
    
    if($self->{stderr}) {
        print STDERR $msg;
    } else {
        print $msg;
    }
}

1;

__END__

=head1 NAME

Log::Log4perl::Appender::ScreenColoredLevel - Colorize messages according to level

=head1 SYNOPSIS

    use Log::Log4perl qw(:easy);

    Log::Log4perl->init(\ <<'EOT');
      log4perl.category = DEBUG, Screen
      log4perl.appender.Screen = \
          Log::Log4perl::Appender::ScreenColoredLevels
      log4perl.appender.Screen.layout = \
          Log::Log4perl::Layout::PatternLayout
      log4perl.appender.Screen.layout.ConversionPattern = \
          %d %F{1} %L> %m %n
    EOT

      # Appears black
    DEBUG "Debug Message";

      # Appears green
    INFO  "Info Message";

      # Appears blue
    WARN  "Warn Message";

      # Appears magenta
    ERROR "Error Message";

      # Appears red
    FATAL "Fatal Message";

=head1 DESCRIPTION

This appender acts like Log::Log4perl::Appender::Screen, except that
it colorizes its output, based on the priority of the message sent.

You can configure the colors and attributes used for the different
levels, by specifying them in your configuration:

    log4perl.appender.Screen.color.TRACE=cyan
    log4perl.appender.Screen.color.DEBUG=bold blue

You can also specify nothing, to indicate that level should not have
coloring applied, which means the text will be whatever the default
color for your terminal is.  This is the default for debug messages.

    log4perl.appender.Screen.color.DEBUG=

You can use any attribute supported by L<Term::ANSIColor> as a configuration
option.

    log4perl.appender.Screen.color.FATAL=\
        bold underline blink red on_white

The commonly used colors and attributes are:

=over 4

=item attributes

BOLD, DARK, UNDERLINE, UNDERSCORE, BLINK

=item colors

BLACK, RED, GREEN, YELLOW, BLUE, MAGENTA, CYAN, WHITE

=item background colors

ON_BLACK, ON_RED, ON_GREEN, ON_YELLOW, ON_BLUE, ON_MAGENTA, ON_CYAN, ON_WHITE

=back

See L<Term::ANSIColor> for a complete list, and information on which are
supported by various common terminal emulators.

The default values for these options are:

=over 4

=item Trace

Yellow

=item Debug

None (whatever the terminal default is)

=item Info

Green

=item Warn

Blue

=item Error

Magenta

=item Fatal

Red

=back

The constructor C<new()> takes an optional parameter C<stderr>,
if set to a true value, the appender will log to STDERR. If C<stderr>
is set to a false value, it will log to STDOUT. The default setting
for C<stderr> is 1, so messages will be logged to STDERR by default.
The constructor can also take an optional parameter C<color>, whose
value is a  hashref of color configuration options, any levels that
are not included in the hashref will be set to their default values.

=head1 AUTHOR

Mike Schilli C<< <log4perl@perlmeister.com> >>, 2004

Color configuration and attribute support added 2007 by
Jason Kohles C<< <email@jasonkohles.com> >>.

=cut
