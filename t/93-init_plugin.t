#!/usr/bin/perl
package MT::Test::Plugin::Init;

#
# In this test we prove our assertions about which of our test plugins:
#   * should NOT BE LOADED ( e.g. stray, non-subfoldered )
#   * SHOULD load
#   * should load BUT should generate a warning ( e.g. perl init plugins)
#
# We do not concern ourselves in this test with the loading of all of the
# bundled, production plugins. 93-plugins.t handles that.
#
use strict;
use warnings;
use lib 't/lib', 'lib', 'extlib';
use Data::Dumper;
use Test::Output qw( :functions );
use Test::Warn;
use Test::More tests => 11;

{
    no warnings 'once';
    *debug_handle = \&MT::Test::debug_handle;
}

# Serves as a constant boolean flag
# determining this package's debug mode
sub DEBUG() {0}
our $debug = sub { DEBUG && print @_, "\n" };

sub main {
    my $pkg = shift;

    ###
    ### CORE INITIALIZATION
    ###
    my %test_data = $pkg->init_test_data();
    my ( $app, $stderr ) = $pkg->init_test_app();
    $debug = $pkg->debug_handle();

    # Debug dump post_init state
    $debug->( MT::Test->mt_package_hashvars_dump() );

    # Re-initialize all component intialization related MT package vars
    MT::Test::revert_component_init($pkg);

    # Debug dump post-reinit state
    $debug->( MT::Test->mt_package_hashvars_dump() );

    my $Tests = $pkg->merge_observed_data( \%test_data );

    $pkg->test_init_warnings($stderr);

    foreach my $testinfo (@$Tests) {
        my ( $sig, $test ) = each %$testinfo;
        $debug->( Dumper( { sig => $sig, test => $test } ) );
        subtest $sig => sub {
            plan tests => 2;
            my $expected = $test->{expected};
            $expected->{name}       ||= 'NO NAME PLUGIN';
            $expected->{base_class} ||= 'MT::Plugin';
            $expected->{message}    ||= " exists";

            if ( $expected->{name} eq 'Two YAMLs - second' ) {
              TODO: {
                    local $TODO
                      = 'Alternate YAML config names not yet supported. See https://github.com/openmelody/melody/blob/master/lib/MT.pm#L1756';
                    $pkg->test_plugin_loaded( $sig, $expected );
                }
            }
            else {
                $pkg->test_plugin_loaded( $sig, $expected );
            }
        };
    } ## end foreach my $testinfo (@$Tests)

    require MT::Template::Context;
    my $ctx    = MT::Template::Context->new;
    my $b      = MT::Builder->new;
    my $result = $b->build( $ctx, $b->compile( $ctx, '<mt:IDontExist>' ) );
    is( ( !defined $result and $b->errstr =~ m{Unknown tag found} ),
        1, 'IDontExist tag from ignored perl plugin' );
} ## end sub main

sub test_plugin_loaded {
    my $pkg = shift;
    my ( $sig, $info ) = @_;
    my $loaded = $info->{not_loaded} ? 0 : 1;
    is( ( $sig && exists $MT::Plugins{$sig} ) ? 1 : 0,
        $loaded, $sig . $info->{message} );
  SKIP: {
        skip "Plugin not loaded", 1 unless $loaded;
        is(
            ref( $MT::Plugins{$sig}->{'object'} ),
            $info->{base_class},
            join( ' ', $info->{name}, 'base class is', $info->{base_class} )
        );
    }
}

###
### TEST DATA INITIALIZATION
###
sub init_test_data {
    my $pkg = shift;
    return (
           'ConfigAssistant.pack/config.yaml' => {
                                            name => 'Configuration Assistant',
                                            base_class => 'MT::Component',
           },
           'Awesome/config.yaml' => { name => 'Oh Awesome', },
           'Rebless/config.yaml' =>
             { name => 'Rebless Me', base_class => 'Rebless::Plugin', },
           'TwoYAMLs/config.yaml' => { name => 'Two YAMLs - config', },
           'TwoYAMLs/second.yaml' => { name => 'Two YAMLs - second', },
           'IgnorePerl/config.yaml' =>
             { name => 'Ignore perl - YAML initialized - YAY', },
           'stray.pl' =>
             { message => ': Stray, unloaded perl plugin', not_loaded => 1, },
           'stray.yaml' =>
             { message => ': Stray, unloaded yaml plugin', not_loaded => 1, },
           'subfoldered/subfoldered.pl' => {
                                      name       => 'A Subfoldered Plugin',
                                      base_class => 'MT::Plugin::Subfoldered',
           }
    );
} ## end sub init_test_data


###
### MT/MT::APP/MT::TEST FRAMEWORK INITIALIZATION
###
sub init_test_app {
    my $pkg      = shift;
    my $warnings = stderr_from {
        eval {

            # require MT;
            require MT::Test;
            import MT::Test qw( :app :db );
        };
        if ($@) { diag($@) and die "Aborting" }
    };

# print STDERR "YOYO: ".${"${$pkg}::debug"}."\n\n";
    $debug->("WARNINGS generated during app init: $warnings");
    return ( MT->instance(), $warnings );
}


sub merge_observed_data {
    my ( $pkg, $test_data ) = @_;

    # Augment the expected plugin test data with the
    # plugin object and it's enabled status. Store in an
    # array of hashes each keyed by the plugin's signature
    my @tests;
    foreach my $sig ( sort keys %$test_data ) {
        my $profile = $MT::Plugins{$sig};
        push(
              @tests,
              {
                 $sig => {
                           expected => $test_data->{$sig},
                           plugin   => $profile->{object},
                           enabled  => $profile->{enabled},
                 }
              }
        );
    }
    return \@tests;
} ## end sub merge_observed_data

###
### TEST GROUP #1: LOAD WARNINGS AND ERRORS ( 1 TEST )
###
sub test_init_warnings {
    my $pkg = shift;
    my $stderr = shift || '';
    like( $stderr,
          qr/.+plugin \(subfoldered.pl\).+deprecated plugin file format/,
          'Deprecation warning for perl-init plugins' );
}

__PACKAGE__->main();
