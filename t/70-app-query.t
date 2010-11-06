#!/usr/bin/perl

=pod

This module tests MT::App's CGI query handling methods:

  SUPPORTED METHODS

    * $app->query
      Initialization, storage and retrieval of the query object

    * $app->query->param( $key )
      CGI module's ability to get/set query parameters

    * $app->query->Vars
      Retriever of hash of param keys and values (no args, list context)

  DEPRECATED METHODS
  For the proper warnings and return values to 
  ensure continued backwards compatibility

    * $app->{query}
      Storage and retrieval of query object via direct hash access
      Use $app->query
      
    * $app->param
      Getter/setter of query parameters
      Retriever of query object (no args, scalar context)
      Retriever of hash of param keys and values (no args, list context)
      Use: $app->query->param
      
    * $app->query->param
      Retriever of hash of param keys and values (no args, list context)
      Use: $app->query->Vars
      ***THIS IS UNTESTABLE*** because it's a valid method in list context
      but simply returns and array of parameter keys instead of a parameter
      hash of keys and values.  Even if you overrode CGI.pm and filtered 
      calls, you still couldn't know whether the left side of the assignment 
      expected an array or a hash. Developers beware. Hic svnt dracones!


----------------------------------------------------------------------
As of 07/27/2010:  All tests successful.
Files=1, Tests=40,  3 wallclock secs ( 0.03 usr  0.01 sys +  2.70 cusr  0.25 csys =  2.99 CPU)
Result: PASS
=cut

use strict;
use warnings;

use lib 't/lib', 'lib', 'extlib';
use Test::More tests => 44;
use Test::Differences;
use Test::Deep;
use Test::Warn;

BEGIN {
    $ENV{MT_APP} = 'MT::App::CMS';
}

use MT;
use MT::Test qw( :app :db :data );

my $app = MT::App::CMS->instance();

isa_ok( $app, 'MT::App::CMS', 'Current app' );
can_ok( $app, 'query' );
can_ok( $app, 'param' );
can_ok( $app, 'param_hash' );

my ( $query, $query2, %params, $name );
my %param_hash = (
                   blank    => {},
                   capitals => {
                                 'Paris'        => 'France',
                                 'Budapest'     => 'Hungary',
                                 'Buenos Aires' => 'Argentina',
                                 'Vienna'       => 'Austria',
                   }
);

foreach my $key ( keys %param_hash ) {

    # SUPPORTED methods
    test_mt_app_query($key);
    test_mt_app_query_param($key);
    test_mt_app_query_vars($key);

    # DEPRECATED methods
    warn_mt_app_query_hash($key);
    warn_mt_app_param($key);
}

sub new_cgi_object {
    my $key       = shift;
    my @args      = defined $param_hash{$key} ? $param_hash{$key} : ();
    my $cgi_query = CGI->new(@args);
    return $cgi_query;
}
sub store_query { $app->query( +shift ); return $app->query }
sub init_query { store_query( new_cgi_object(@_) ) }


## Testing $app->query()
sub test_mt_app_query {
    my $key = shift;

    # Create and store CGI query object in $app->query
    my $cgi_query;
    store_query( $cgi_query = new_cgi_object($key) );
    isa_ok( $cgi_query, 'CGI', 'The object returned from CGI->new' );

    # Retrieve CGI query object from $app->query
    my $q = $app->query;
    isa_ok( $q, 'CGI', 'The object returned from $app->query' );

    # Compare the two objects
    cmp_deeply(
         $q,
         $cgi_query,
         "'$key' param hash comparison: query object equivalent to CGI object"
    );
}

## Testing $app->query->param()
sub test_mt_app_query_param {
    my $key = shift;
    my $q   = init_query($key);
    can_ok( $q, 'param' );
    my @returnvals = $q->param;
    cmp_deeply( \@returnvals,
                [ keys %{ $param_hash{$key} } ],
                "'$key' query keys match" );

    is( my $name = $q->param('name'), undef, 'Uninitialized key is undef' );
    $q->param( 'name', 'Ophelia' );
    is( $q->param('name'), 'Ophelia', 'Param value assignment' );

}

## Testing $app->query->Vars()
sub test_mt_app_query_vars {
    my $key = shift;
    my $q   = init_query($key);
    can_ok( $q, 'Vars' );
    my %returnvals = $q->Vars;
    cmp_deeply( \%returnvals, $param_hash{$key},
                "Vars: '$key' query parameter hash match" );
}

## Testing $app->{query}
sub warn_mt_app_query_hash {
    my $key       = shift;
    my $cgi_query = new_cgi_object($key);

    # Test for warning on storage and access
    my $t;
    my $start = 'DEPRECATION WARNING: Direct';
    my $end   = 'to.*See MT::App POD for details.';
    warning_like { $app->{query} = $cgi_query } qr/$start assignment $end/,
      'Deprecation warning for $app->{query} assignment';
    warning_like { $t = $app->{query} } qr/$start access $end/,
      'Deprecation warning for $app->{query} access';

    # Test for correct return value
    isa_ok( $t, 'CGI', 'query object returned from query hash' );
    cmp_deeply( $t, $cgi_query, 'query object returned from query hash' );
}

## Testing $app->param()
sub warn_mt_app_param {
    my $key       = shift;
    my $cgi_query = new_cgi_object($key);
    my %usage     = Melody::DeprecatedParamUsage::usage();
    my $start     = 'DEPRECATION WARNING:.*';
    my $end       = 'instead.';

    my $pat = sub {
        my $k     = shift;
        my $utype = $usage{$k};
        return
          sprintf( '%s %s.*%s %s',
                   $start, $utype->{description},
                   quotemeta( $utype->{replacement} ), $end );
    };

    my ( $name, %param, $q );

    ### param_hash ###
    my $localpat = $pat->('param_hash');
    warning_like { %param = $app->param } qr{$localpat},
      'Deprecation warning for $app->param, list context';

    cmp_deeply( \%param,
                { map { $_ => $cgi_query->param($_) } $cgi_query->param },
                'Backcompat of $app->param, list context' );

    ### query_object ###
    $localpat = $pat->('query_object');
    warning_like { $q = $app->param } qr{$localpat},
      'Deprecation warning for $app->param, list context';

    cmp_deeply( $q, $cgi_query, 'Backcompat for $q->param, scalar context' );

    ### get_set ###
    $localpat = $pat->('get_set');
    warning_like { $app->param( 'name', 'ophelia' ) } qr{$localpat},
      'Deprecation warning for $app->param( KEY, VAL )';

    warning_like { $name = $app->param('name') } qr{$localpat},
      'Deprecation warning for $app->param( KEY, VAL )';

    is( $name, 'ophelia', 'Backcompat of $app->param(KEY, VAL)' );

} ## end sub warn_mt_app_param

1;

