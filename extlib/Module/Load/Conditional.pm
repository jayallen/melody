package Module::Load::Conditional;

use strict;

use Module::Load;
use Params::Check qw[check];
use Locale::Maketext::Simple Style => 'gettext';

use Carp        ();
use File::Spec  ();
use FileHandle  ();

BEGIN {
    use vars        qw[$VERSION @ISA $VERBOSE $CACHE @EXPORT_OK $ERROR];
    use Exporter;
    @ISA        =   qw[Exporter];
    $VERSION    =   '0.08';
    $VERBOSE    =   0;

    @EXPORT_OK  =   qw[check_install can_load requires];
}

=pod

=head1 NAME

Module::Load::Conditional - Looking up module information / loading at runtime

=head1 SYNOPSIS

    use Module::Load::Conditional qw[can_load check_install requires];


    my $use_list = {
            CPANPLUS        => 0.05,
            LWP             => 5.60,
            'Test::More'    => undef,
    };

    print can_load( modules => $use_list )
            ? 'all modules loaded successfully'
            : 'failed to load required modules';


    my $rv = check_install( module => 'LWP', verion => 5.60 )
                or print 'LWP is not installed!';

    print 'LWP up to date' if $rv->{uptodate};
    print "LWP version is $rv->{version}\n";
    print "LWP is installed as file $rv->{file}\n";


    print "LWP requires the following modules to be installed:\n";
    print join "\n", requires('LWP');


    ### reset the 'can_load' cache
    undef $Module::Load::Conditional::CACHE;

    ### don't have Module::Load::Conditional issue warnings --
    ### default is '1'
    $Module::Load::Conditional::VERBOSE = 0;

    ### The last error that happened during a call to 'can_load'
    my $err = $Module::Load::Conditional::ERROR;


=head1 DESCRIPTION

Module::Load::Conditional provides simple ways to query and possibly load any of
the modules you have installed on your system during runtime.

It is able to load multiple modules at once or none at all if one of
them was not able to load. It also takes care of any error checking
and so forth.

=head1 Methods

=head1 check_install

C<check_install> allows you to verify if a certain module is installed
or not. You may call it with the following arguments:

=over 4

=item module

The name of the module you wish to verify -- this is a required key

=item version

The version this module needs to be -- this is optional

=item verbose

Whether or not to be verbose about what it is doing -- it will default
to $Module::Load::Conditional::VERBOSE

=back

It will return undef if it was not able to find where the module was
installed, or a hash reference with the following keys if it was able
to find the file:

=over 4

=item file

Full path to the file that contains the module

=item version

The version number of the installed module - this will be C<undef> if
the module had no (or unparsable) version number.

=item uptodate

A boolean value indicating whether or not the module was found to be
at least the version you specified. If you did not specify a version,
uptodate will always be true if the module was found.
If no parsable version was found in the module, uptodate will also be
true, since C<check_install> had no way to verify clearly.

=back

=cut

### this checks if a certain module is installed already ###
### if it returns true, the module in question is already installed
### or we found the file, but couldn't open it, OR there was no version
### to be found in the module
### it will return 0 if the version in the module is LOWER then the one
### we are looking for, or if we couldn't find the desired module to begin with
### if the installed version is higher or equal to the one we want, it will return
### a hashref with he module name and version in it.. so 'true' as well.
sub check_install {
    my %hash = @_;

    my $tmpl = {
            version => { default    => '0.0'    },
            module  => { required   => 1        },
            verbose => { default    => $VERBOSE },
    };

    my $args;
    unless( $args = check( $tmpl, \%hash, $VERBOSE ) ) {
        warn loc( q[A problem occurred checking arguments] ) if $VERBOSE;
        return;
    }

    my $file = File::Spec->catfile( split /::/, $args->{module} ) . '.pm';

    ### where we store the return value ###
    my $href = {
            file        => undef,
            version     => undef,
            uptodate    => undef,
    };

    DIR: for my $dir ( @INC ) {

        my( $fh, $filename );

        if ( ref $dir ) {
            ### @INC hook -- we invoke it and get the filehandle back
            ### this is actually documented behaviour as of 5.8 ;)

            if (UNIVERSAL::isa($dir, 'CODE')) {
                ($fh) = $dir->($dir, $file);

            } elsif (UNIVERSAL::isa($dir, 'ARRAY')) {
                ($fh) = $dir->[0]->($dir, $file, @{$dir}{1..$#{$dir}})

            } elsif (UNIVERSAL::can($dir, 'INC')) {
                ($fh) = $dir->INC->($dir, $file);
            }

            if (!UNIVERSAL::isa($fh, 'GLOB')) {
                warn loc(q[Cannot open file '%1': %2], $file, $!)
                        if $args->{verbose};
                next;
            }

            $filename = $INC{$file} || $file;

        } else {
            $filename = File::Spec->catfile($dir, $file);
            next unless -e $filename;

            $fh = new FileHandle;
            if (!$fh->open($filename)) {
                warn loc(q[Cannot open file '%1': %2], $file, $!)
                        if $args->{verbose};
                next;
            }
        }

        $href->{file} = $filename;

        while (local $_ = <$fh> ) {

	    ### skip commented out lines, they won't eval to anything.
	    next if /^\s*#/;

            ### the following regexp comes from the ExtUtils::MakeMaker
            ### documentation.
            if ( /([\$*])(([\w\:\']*)\bVERSION)\b.*\=/ ) {

                ### this will eval the version in to $VERSION if it
                ### was declared as $VERSION in the module.
                ### else the result will be in $res.
                ### this is a fix on skud's Module::InstalledVersion

                local $VERSION;
                my $res = eval $_;

                ### default to '0.0' if there REALLY is no version
                ### all to satisfy warnings
                $href->{version} = $VERSION || $res || '0.0';

                last DIR;
            }
        }
    }

    ### if we couldn't find the file, return undef ###
    return unless defined $href->{file};

    ### only complain if we expected fo find a version higher than 0.0 anyway
    if( !defined $href->{version} ) {

        {   ### don't warn about the 'not numeric' stuff ###
            local $^W;

            ### if we got here, we didn't find the version
            warn loc(q[Could not check version on '%1'], $args->{module} )
                    if $args->{verbose} and $args->{version} > 0;
        }
        $href->{uptodate} = 1;

    } else {
        ### don't warn about the 'not numeric' stuff ###
        local $^W;
        $href->{uptodate} = $args->{version} <= $href->{version} ? 1 : 0;
    }

    return $href;
}

=head2 can_load

C<can_load> will take a list of modules, optionally with version
numbers and determine if it is able to load them. If it can load *ALL*
of them, it will. If one or more are unloadable, none will be loaded.

This is particularly useful if you have More Than One Way (tm) to
solve a problem in a program, and only wish to continue down a path
if all modules could be loaded, and not load them if they couldn't.

This function uses the C<load> function from Module::Load under the
hood.

C<can_load> takes the following arguments:

=over 4

=item modules

This is a hashref of module/version pairs. The version indicates the
minimum version to load. If no version is provided, any version is
assumed to be good enough.

=item verbose

This controls whether warnings should be printed if a module failed
to load.
The default is to use the value of $Module::Load::Conditional::VERBOSE.

=item nocache

C<can_load> keeps its results in a cache, so it will not load the
same module twice, nor will it attempt to load a module that has
already failed to load before. By default, C<can_load> will check its
cache, but you can override that by setting C<nocache> to true.

=cut

sub can_load {
    my %hash = @_;

    my $tmpl = {
        modules     => { default => {}, strict_type => 1 },
        verbose     => { default => $VERBOSE },
        nocache     => { default => 0 },
    };

    my $args;

    unless( $args = check( $tmpl, \%hash, $VERBOSE ) ) {
        $ERROR = loc(q[Problem validating arguments!]);
        warn $ERROR if $VERBOSE;
        return;
    }

    ### layout of $CACHE:
    ### $CACHE = {
    ###     $ module => {
    ###             usable  => BOOL,
    ###             version => \d,
    ###             file    => /path/to/file,
    ###     },
    ### };

    $CACHE ||= {}; # in case it was undef'd

    my $error;
    BLOCK: {
        my $href = $args->{modules};

        my @load;
        for my $mod ( keys %$href ) {

            next if $CACHE->{$mod}->{usable} && !$args->{nocache};

            ### else, check if the hash key is defined already,
            ### meaning $mod => 0,
            ### indicating UNSUCCESSFUL prior attempt of usage
            if (    !$args->{nocache}
                    && defined $CACHE->{$mod}->{usable}
                    && (($CACHE->{$mod}->{version}||0) >= $href->{$mod})
            ) {
                $error = loc( q[Already tried to use '%1', which was unsuccessful], $mod);
                last BLOCK;
            }

            my $mod_data = check_install(
                                    module  => $mod,
                                    version => $href->{$mod}
                                );

            if( !$mod_data or !defined $mod_data->{file} ) {
                $error = loc(q[Could not find or check module '%1'], $mod);
                $CACHE->{$mod}->{usable} = 0;
                last BLOCK;
            }

            map {
                $CACHE->{$mod}->{$_} = $mod_data->{$_}
            } qw[version file uptodate];

            push @load, $mod;
        }

        for my $mod ( @load ) {

            if ( $CACHE->{$mod}->{uptodate} ) {

                eval { load $mod };

                ### in case anything goes wrong, log the error, the fact
                ### we tried to use this module and return 0;
                if( $@ ) {
                    $error = $@;
                    $CACHE->{$mod}->{usable} = 0;
                    last BLOCK;
                } else {
                    $CACHE->{$mod}->{usable} = 1;
                }

            ### module not found in @INC, store the result in
            ### $CACHE and return 0
            } else {

                $error = loc(q[Module '%1' is not uptodate!], $mod);
                $CACHE->{$mod}->{usable} = 0;
                last BLOCK;
            }
        }

    } # BLOCK

    if( defined $error ) {
        $ERROR = $error;
        Carp::carp( loc(q|%1 [THIS MAY BE A PROBLEM!]|,$error) ) if $args->{verbose};
        return undef;
    } else {
        return 1;
    }
}

=head2 requires

C<requires> can tell you what other modules a particular module
requires. This is particularly useful when you're intending to write
a module for public release and are listing its prerequisites.

C<requires> takes but one argument: the name of a module.
It will then first check if it can actually load this module, and
return undef if it can't.
Otherwise, it will return a list of modules and pragmas that would
have been loaded on the module's behalf.

Note: The list C<require> returns has originated from your current
perl and your current install.

=cut

sub requires {
    my $who = shift;

    unless( check_install( module => $who ) ) {
        warn loc(q[You do not have module '%1' installed], $who) if $VERBOSE;
        return undef;
    }

    my $lib = join " ", map { qq["-I$_"] } @INC;
    my $cmd = qq[$^X $lib -M$who -e"print(join(qq[\\n],keys(%INC)))"];

    return  sort
                grep { !/^$who$/  }
                map  { chomp; s|/|::|g; $_ }
                grep { s|\.pm$||i; }
            `$cmd`;
}

1;

__END__

=head1 Global Variables

The behaviour of Module::Load::Conditional can be altered by changing the
following global variables:

=head2 $Module::Load::Conditional::VERBOSE

This controls whether Module::Load::Conditional will issue warnings and
explanations as to why certain things may have failed. If you set it
to 0, Module::Load::Conditional will not output any warnings.
The default is 0;

=head2 $Module::Load::Conditional::CACHE

This holds the cache of the C<can_load> function. If you explicitly
want to remove the current cache, you can set this variable to
C<undef>

=head2 $Module::Load::Conditional::ERROR

This holds a string of the last error that happened during a call to
C<can_load>. It is useful to inspect this when C<can_load> returns
C<undef>.

=head1 See Also

C<Module::Load>

=head1 AUTHOR

This module by
Jos Boumans E<lt>kane@cpan.orgE<gt>.

=head1 COPYRIGHT

This module is
copyright (c) 2002 Jos Boumans E<lt>kane@cpan.orgE<gt>.
All rights reserved.

This library is free software;
you may redistribute and/or modify it under the same
terms as Perl itself.
