# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

package MT::ConfigMgr;

use strict;
use base qw( MT::ErrorHandler );
use List::Util qw( first );
use Carp qw( longmess );


our $cfg;

sub instance {
    return $cfg if $cfg;
    $cfg = __PACKAGE__->new;
}

sub new {
    my $mgr
      = bless { __var => {}, __dbvar => {}, __paths => [], __dirty => 0 },
      $_[0];
    $mgr->init;
    $mgr;
}

sub init {
}

sub define {
    my $mgr = shift;
    my ($vars);

    if ( ref $_[0] and grep { ref $_[0] eq $_ } qw( ARRAY HASH ) ) {
        $vars = shift;
    }
    else {
        my ( $var, %param ) = @_;
        $vars = [ [ $var, \%param ] ];
    }

    if ( ref($vars) eq 'ARRAY' ) {
        foreach my $def (@$vars) {
            my ( $var, $param ) = @$def;
            my $lcvar = lc $var;
            $mgr->{__var}{$lcvar}           = undef;
            $mgr->{__settings}{$lcvar}      = keys %$param ? {%$param} : {};
            $mgr->{__settings}{$lcvar}{key} = $var;
            if ( $mgr->{__settings}{$lcvar}{path} ) {
                push @{ $mgr->{__paths} }, $var;
            }
        }
    }
    elsif ( ref($vars) eq 'HASH' ) {
        foreach my $var ( keys %$vars ) {
            my $param = $vars->{$var};
            my $lcvar = lc $var;
            $mgr->{__settings}{$lcvar} = $param;
            if ( ref $param eq 'ARRAY' ) {
                $mgr->{__settings}{$lcvar} = $param->[0];
            }
            $mgr->{__settings}{$lcvar}{key} = $var;
            if ( $mgr->{__settings}{$lcvar}{path} ) {
                push @{ $mgr->{__paths} }, $var;
            }
        }
    }
} ## end sub define

sub type {
    my $mgr = shift;
    my $var = lc shift;
    return undef unless exists $mgr->{__settings}{$var};
    return $mgr->{__settings}{$var}{type} || 'SCALAR';
}

sub default {
    my $mgr  = shift;
    my $var  = lc shift;
    my $def  = my $orig_def = $mgr->{__settings}{$var}{default};
    my $type = $mgr->{__settings}{$var}{type} || '';

    # RIGHT???
    $def = $def->() if 'CODE' eq ref($def);

    # No post-processing needed on defaults for SCALAR config directives
    return $def unless grep { $type eq $_ } qw( ARRAY HASH );

    # $ENV{CONFIGMGRDEBUG}
    #     and diag sprintf "%s (%s): default %s %s %s\n",
    #         (caller(0))[3], (caller(1))[3], $var, $type,
    #         (  ref $def      ? Dumper($def)
    #          : defined $def  ? "= $def"
    #                          : 'not defined'
    #         );

    # Special handling is needed for ARRAY and HASH directives to ensure
    # consistency, predictability and graceful exception handling to callers
    # in using return values.  This is particularly important with undefined
    # values which are translated into empty array and hash refs so that
    # callers can consistently use the return values without encountering
    # errors like "Can't use string ("BLAH") as ARRAY ref while "strict refs"
    # in use:
    #
    #       my $default = $cfg->FooWidgets;
    #       foreach my $fw ( @$default ) {      # BAM - undef would error out
    #           # ....
    #       }
    #
    if ( 'ARRAY' eq $type ) {
        $def = !defined $def
          ? []    # Now @$default works!
          : !ref $def ? [$def]    # 1 element defined as scalar
          : $def                  # No-op, fallback to self
    }
    elsif ( 'HASH' eq $type ) {
        $def = !defined $def
          ? {}                    # Now %$default works
                                  # Data folding: String to hashref
          : !ref $def ? $mgr->_parse_stringy_hash($def) : $def;
    }

    # $ENV{CONFIGMGRDEBUG}
    #     and $type
    #     and $def ne ($orig_def||'')
    #     and diag sprintf "%s (%s): Converted default %s value to %s\n",
    #             (caller(0))[3], (caller(1))[3], $var, Dumper($def);

    # Can be a scalar (either defined or not),
    # an array ref or a hash ref
    return $def;
} ## end sub default

sub is_path {
    my $mgr = shift;
    my $var = lc shift;
    return $mgr->{__settings}{$var}{path};
}

sub paths {
    my $mgr = shift;
    wantarray ? @{ $mgr->{__paths} } : $mgr->{__paths};
}

our $depth = 0;
my $max_depth = 5;

sub get_internal {
    my $mgr   = shift;
    my $var   = lc shift;
    my $alias = $mgr->{__settings}{$var}{alias};

    # Forward aliases immediately
    if ( defined $alias ) {
        if ( $max_depth < $depth ) {
            die MT->translate(
                            'Alias for [_1] is looping in the configuration.',
                            $alias );
        }
        local $depth = $depth + 1;
        return $mgr->get($alias);
    }

    my $val   = $mgr->{__var}{$var};
    my $dbval = $mgr->{__dbvar}{$var};
    my $type  = $mgr->{__settings}{$var}{type} || '';

    # $ENV{CONFIGMGRDEBUG}
    #     and diag sprintf "%s (%s): %s %s %s %s\n",
    #         (caller(0))[3], (caller(1))[3], $var, $type,
    #         (  ref $val      ? Dumper($val)
    #          : defined $val  ? "= $val"
    #                          : 'not defined'
    #         ), Carp::longmess;

    # Dereference code refs to derive actual value
    $val = $val->() if ref $val eq 'CODE';

    return first { defined $_ }
    ( $val, $dbval, ( my $default = $mgr->default($var) ) );

} ## end sub get_internal

sub get {
    my $mgr = shift;
    my $var = lc shift;
    if ( my $h = $mgr->{__settings}{$var}{handler} ) {
        $h = MT->handler_to_coderef($h) unless ref $h;
        return $h->($mgr);
    }

    my $type = $mgr->{__settings}{$var}{type} || '';
    my $val = $mgr->get_internal( $var, @_ );
    my $defaults = sub { $cfg->default($var) || [] };

    if ( $type eq 'ARRAY' ) {
        $val ||= [];
        $val
          = [ map { $_ eq '__DEFAULT__' ? @{ $defaults->() } : $_ } @$val ];
        return wantarray ? @$val : $val;
    }
    elsif ( $type eq 'HASH' ) {
        $val ||= {};
        $val = {
            delete $val->{__DEFAULT__} ? ( %{ $defaults->() }, %$val )
                                       : %$val
        };
        return wantarray ? %$val : $val;
    }
    else {
        return $val;
    }
} ## end sub get


sub set {
    my $mgr = shift;
    my ( $var, $val, $db_flag ) = @_;
    $var = lc $var;
    $mgr->set_dirty($var);

    if ( my $h = $mgr->{__settings}{$var}{handler} ) {
        ref $h or $h = MT->handler_to_coderef($h);
        return $h->( $mgr, $val, $db_flag );
    }
    return $mgr->set_internal(@_);
}

sub set_internal {
    my $mgr = shift;
    my ( $var, $val, $db_flag ) = @_;
    my $set = $db_flag ? '__dbvar' : '__var';
    $var = lc $var;
    my $alias = $mgr->{__settings}{$var}{alias};

    $mgr->set_dirty() if defined($db_flag) && $db_flag;

    if ( defined $alias ) {
        if ( $max_depth < $depth ) {
            die MT->translate(
                            'Alias for [_1] is looping in the configuration.',
                            $alias );
        }
        local $depth = $depth + 1;
        return $mgr->set( $alias, $val, $db_flag );
    }

    my $type = $mgr->{__settings}{$var}{type} || '';

    if ( $type eq 'ARRAY' ) {
        if ( ref $val eq 'ARRAY' ) {

            # $ENV{CONFIGMGRDEBUG}
            #     and printf STDERR "set_internal: Overwriting %s %s with "
            #                         ."arrayref: %s", $set, $var, Dumper($val);

            $mgr->{$set}{$var} = $val;
        }
        else {
            $mgr->{$set}{$var} ||= [];

            # $ENV{CONFIGMGRDEBUG} and
            #     printf STDERR
            #     "set_internal: Appending %s onto current %s %s arrayref: %s\n",
            #     $val, $set, $var, Dumper($mgr->{$set}{$var});

            push @{ $mgr->{$set}{$var} }, $val if defined $val;
        }
        return $mgr->{$set}{$var};
    } ## end if ( $type eq 'ARRAY' )
    elsif ( $type eq 'HASH' ) {
        my $hash = $mgr->{$set}{$var};
        $hash = $mgr->default($var) unless defined $hash;
        if ( ref $val eq 'HASH' ) {
            $mgr->{$set}{$var} = $val;
        }
        else {
            $hash ||= {};
            ( my ($key), $val ) = split( /=/, $val );
            $mgr->{$set}{$var}{$key} = $val;
        }
    }
    else {
        $mgr->{$set}{$var} = $val;
    }
    return $val;
} ## end sub set_internal

sub is_readonly {
    my $class = shift;
    my ($var) = @_;
    return defined $class->instance->{__var}{ lc $var } ? 1 : 0;
}

sub set_dirty {
    my $mgr = shift;
    my ($var) = @_;
    $mgr = $mgr->instance unless ref($mgr);
    return $mgr->{__settings}{ lc $var }{dirty} = 1 if defined $var;
    return $mgr->{__dirty} = 1;
}

sub clear_dirty {
    my $mgr = shift;
    my ($var) = @_;
    $mgr = $mgr->instance unless ref($mgr);
    return delete $mgr->{__settings}{ lc $var }{dirty} if defined $var;
    foreach my $var ( keys %{ $mgr->{__settings} } ) {
        if ( $mgr->{__settings}{$var}{dirty} ) {
            delete $mgr->{__settings}{$var}{dirty};
        }
    }
    return $mgr->{__dirty} = 0;
}

sub is_dirty {
    my $mgr = shift;
    $mgr = $mgr->instance unless ref($mgr);
    return $mgr->{__settings}{ lc $_[0] }{dirty} ? 1 : 0 if @_;
    return $mgr->{__dirty};
}

sub read_config {
    my $class = shift;
    return $class->read_config_file(@_);
}

sub save_config {
    my $class = shift;
    my $mgr   = $class->instance;

    # prevent saving when the db row wasn't read already
    return 0 unless $mgr->{__read_db};
    return 0 unless $mgr->is_dirty();
    my $data     = '';
    my $settings = $mgr->{__dbvar};
    foreach ( sort keys %$settings ) {
        my $type = ( $mgr->{__settings}{$_}{type} || '' );
        delete $mgr->{__settings}{$_}{dirty}
          if exists $mgr->{__settings}{$_}{dirty};
        if ( $type eq 'HASH' ) {
            my $h = $settings->{$_};
            foreach my $k ( keys %$h ) {
                $data
                  .= $mgr->{__settings}{$_}{key} . ' ' 
                  . $k . '='
                  . $h->{$k} . "\n";
            }
        }
        elsif ( $type eq 'ARRAY' ) {
            my $a = $settings->{$_};
            foreach my $v (@$a) {
                $data .= $mgr->{__settings}{$_}{key} . ' ' . $v . "\n";
            }
        }
        else {
            $data
              .= $mgr->{__settings}{$_}{key} . ' ' . $settings->{$_} . "\n";
        }
    } ## end foreach ( sort keys %$settings)

    my $cfg_class = MT->model('config') or return;

    my ($config) = $cfg_class->load() || $cfg_class->new;

    if ( $data !~ m/^schemaversion/im ) {
        if ( $config->id
             && ( ( $config->data || '' ) =~ m/^schemaversion/im ) )
        {
            require Carp;
            MT->log(   "Caught attempt to clear SchemaVersion setting. "
                     . "New config settings were:\n$data "
                     . longmess() );
            return;
        }
    }

    $config->data($data);

    # Ignore any error returned for the sake of MT-Wizard,
    # where the mt_config table doesn't actually exist yet.
    $config->save;
    $mgr->clear_dirty;
    1;
} ## end sub save_config

sub read_config_file {
    my $class      = shift;
    my ($cfg_file) = @_;
    my $mgr        = $class->instance;
    $mgr->{__var} = {};
    local ( *FH, $_, $/ );
    $/ = "\n";

    die "Can't read config without config file name" if !$cfg_file;

    # $ENV{CONFIGMGRDEBUG}
    #     and diag "Opening config file for reading: ".$cfg_file;

    open FH, $cfg_file
      or return $class->error(
        MT->translate( "Error opening file '[_1]': [_2]", $cfg_file, "$!" ) );
    my $line;

    $mgr->{__config_contents} = '';
    while (<FH>) {
        $mgr->{__config_contents} .= $_;
        chomp;
        $line++;
        next if !/\S/ || /^#/;
        my ( $var, $val ) = $_ =~ /^\s*(\S+)\s+(.*)$/;
        return
          $class->error(
                  MT->translate(
                      "Config directive [_1] without value at [_2] line [_3]",
                      $var, $cfg_file, $line
                  )
          ) unless defined($val) && $val ne '';
        $val =~ s/\s*$// if defined($val);
        next unless $var && defined($val);
        $mgr->set( $var, $val );
        my $full = $mgr->{__var}{ lc $var };

        # $ENV{CONFIGMGRDEBUG}
        #     and diag ''.((caller(0))[3])
        #                .": Called set() with $var and $val. Current: "
        #                .( ref $full ? Dumper($full) : $full);
    } ## end while (<FH>)
    close FH;
    1;
} ## end sub read_config_file

sub read_config_db {
    my $class     = shift;
    my $mgr       = $class->instance;
    my $cfg_class = MT->model('config') or return;

    my ($config) = eval { $cfg_class->search };
    if ($config) {
        my $was_dirty = $mgr->is_dirty;
        my $data      = $config->data;
        my @data      = split /[\r?\n]/, $data;
        my $line      = 0;
        foreach (@data) {
            $line++;
            chomp;
            next if !/\S/ || /^#/;
            my ( $var, $val ) = $_ =~ /^\s*(\S+)\s+(.+)$/;
            $val =~ s/\s*$// if defined($val);
            next unless $var && defined($val);
            $mgr->set( $var, $val, 1 );
        }
        $mgr->clear_dirty unless $was_dirty;
    }
    $mgr->{__read_db} = 1;
    1;
} ## end sub read_config_db

sub _parse_stringy_hash {
    my $mgr = shift;
    my ($def) = @_;
    ( my ($key), my ($val) ) = split( /=/, $def );
    return { $key => $val };
}

sub DESTROY {

    # save_config here so not to miss any dirty config change to persist
    # particularly for those which does not construct MT::App.
    $_[0]->save_config;
}

use vars qw( $AUTOLOAD );

sub AUTOLOAD {
    my $mgr = $_[0];
    ( my $var = $AUTOLOAD ) =~ s!.+::!!;
    $var = lc $var;
    return $mgr->error(
                     MT->translate( "No such config variable '[_1]'", $var ) )
      unless exists $mgr->{__settings}->{$var};
    no strict 'refs';
    *$AUTOLOAD = sub {
        my $mgr = shift;
        @_ ? $mgr->set( $var, @_ ) : $mgr->get($var);
    };
    goto &$AUTOLOAD;
}

1;
__END__

=head1 NAME

MT::ConfigMgr - Movable Type configuration manager

=head1 SYNOPSIS

    use MT::ConfigMgr;
    my $cfg = MT::ConfigMgr->instance;

    $cfg->read_config('/path/to/mt.cfg')
        or die $cfg->errstr;

=head1 DESCRIPTION

L<MT::ConfigMgr> is a singleton class that manages the Movable Type
configuration file (F<config.cgi>), allowing access to the config
directives contained therin.

=head1 METHODS

=head2 MT::ConfigMgr->new

Creates a new instance of L<MT::ConfigMgr> and initializes it. It does not
read any configuration file data. This is done using the L<read_config>
method.

=head2 $cfg->init

Initialization method called by the L<new> constructor prior to returning
a new instance of L<MT::ConfigMgr>. Currently does nothing.

=head2 MT::ConfigMgr->instance

Returns the singleton L<MT::ConfigMgr> object. Note that when you want
the object, you should always call L<instance>, never L<new>; L<new>
will construct a B<new> L<MT::ConfigMgr> object, and that isn't what you
want. You want the object that has already been initialized with the
contents of the configuration file.

=head2 $cfg->define($directive[, %arg ])

Defines the directive C<$directive> as a valid configuration directive. For
special configuration directives (HASH or ARRAY types), you must define them
B<before> the configuration file is read.

See L<MT::Core> for a huge array of examples.

=head2 $cfg->type($directive)

Returns the type of the configuration directive: 'SCALAR', 'ARRAY' or 'HASH'.
If the directive is unregistered, this method will return undef.

=head2 $cfg->default($directive)

Returns the default setting for the specified directive, if one exists.
The return value is always scalar.  See L<RETURN VALUES> below for more.

=head2 $cfg->get($directive)

Retrieves the value for C<$directive> from the first of the following
locations where it is defined, if any:

=over 4

=item * The in-memory cache of all directives C<set> during the current
process (e.g. from reading the config file)

=item * The C<mt_config> database table where individual config values can be
persistently stored (see C<set> for more)

=item * The default value for the directive, if one was specified in its
definition

=back

This method provides contextual return values. See L<RETURN VALUES> below for
more.

For ARRAY and HASH directives, there is a special value, __DEFAULT__, one can
use in the C<config.cgi> to apply the default settings of the directive in
addition to your settings.

B<Examples:>

The following config file snippet replaces the built-in defined default of
C<['plugins']> with C<['extensions']>:

    PluginPath  extensions

This next example I<appends> 'extensions' onto the PluginPath array default
yielding C<[qw( plugins extensions )]>

    PluginPath  __DEFAULT__
    PluginPath  extensions

Order is important with ARRAY directives! The following I<prepends> the values
yielding C<[qw( extensions plugins )]>:

    PluginPath  extensions
    PluginPath  __DEFAULT__

Conversely, with HASH directives, the default values are always applied first
so that you can override them with your config settings:

    DefaultEntryPrefs   __DEFAULT__=1
    DefaultEntryPrefs   height=201

=head2 $cfg->get_internal($directive)

The low-level method for getting a configuration setting and bypasses any
declared 'handler'. The method's return value is always scalar. See L<RETURN
VALUES> below for more.

=head2 $cfg->set($directive, $value[, $persist])

The handler method for assigning a value to a specific directive. The
C<$value> should be a SCALAR value for SCALAR configuration directives:

    $cfg->set('EmailAddressMain', 'user@example.com');

For an ARRAY type, C<$value> can be either an array reference or a scalar
value.  If an array reference is passed, it is used as the new value of the
directive.  A scalar value, on the other hand, is appended to any existing
array value for the directive:

    # Replaces any existing array value for 'MemcachedServers':
    $cfg->set('MemcachedServers', ['127.0.0.1', '127.0.0.2']);

    # Adds '127.0.0.3' to the existing array held for 'MemcachedServers':
    $cfg->set('MemcachedServers', '127.0.0.3');

For a HASH type, C<$value> can be either a hash reference or a scalar value.
Like the above, a hash reference sets/replaces the value of the directive. A
scalar value in "key=value" format will be added any to the value of any
existing hash.

    # Replaces any existing hash value for 'AtomApp':
    $cfg->set('AtomApp', { pings => 'Example::AtomPingServer' });

    # Adds a new service declaration to the existing hash held for 'AtomApp':
    $cfg->set('AtomApp', 'foo=Example::Foo');

The return value is the same as that which was set.

=head2 $cfg->set_internal($directive, $value[, $persist])

The low-level method for setting a configuration setting that bypasses any
declared 'handler' and prevents the directive from having its "dirty"
state set.

=head2 $cfg->paths

Returns a list or array reference (depending on whether it is called in
an array or scalar context) of configuration directive names that are
declared as path directives.

=head2 $cfg->is_path($directive)

Returns true if the specified directive is designated in the regsitry as
a filesystem path.

=head2 $cfg->read_config($file)

Forwards to L<MT::ConfigMgr::read_config_file>.

=head2 $cfg->read_config_file($file)

Reads the config file at the path I<$file> and initializes the I<$cfg> object
with the directives in that file. Returns true on success, C<undef> otherwise;
if an error occurs you can obtain the error message with C<$cfg-E<gt>errstr>.

=head2 $cfg->read_config_db()

Reads any configuration settings from the L<MT::Config> class. Note that
these settings are always overridden by settings in the MT configuration
file.

=head2 $cfg->save_config()

Saves any configuration settings that originated from the database, or
were set with the I<persist> option. Settings are stored using the
L<MT::Config> class.

=head2 $cfg->is_readonly($directive)

Returns true when there exists a user-defined value for the configuration
directive that was read from the MT configuration file. Such a value cannot
be overridden through the database, so it is considered a read-only
setting.

=head2 $cfg->set_dirty([$directive])

Assigns a dirty state to the configuration settings as a whole, or to
an individual directive. The former controls whether or not the
L<save_config> method will actually rewrite the configuration settings
to the L<MT::Config> object. The latter is used to identify when a
setting has been set to something other than the default.

=head2 $cfg->is_dirty([$directive])

Returns the 'dirty' state of the configuration settings as a whole, or
for an individual directive.

=head2 $cfg->clear_dirty([$directive])

Clears the 'dirty' state of the configuration settings as a whole, or
for an individual directive.

=head1 RETURN VALUES

All but two accessor methods in the class B<return only a scalar value>. This
is because either the value is always scalar (as with C<type> and all of the
boolean C<is_*> methods) or they retrieve underlying representations of data
which are always stored as some type of scalar (e.g. string, number,
array/hash reference) as is the case with C<default()> and C<get_internal()>.

That scalar value can be C<undef> (which is, of course, not I<technically> a
value), a string or number or, for ARRAY and HASH directives, a reference to
the underlying data structure depending on the method and config directive
used.

    # Returns string: "SCALAR"
    my $type     = $cfg->type('CGIPath');

    # Returns string: "css"
    my $css_path = $cfg->default("CSSPath");

    # Returns arrayref: ['plugins']
    my $ppath    = $cfg->default('PluginPath');

    # Returns hashref: { Allow => '1', Notify => '' }
    my $creg     = $cfg->default('CommenterRegistration');

In the case of an undefined value for a type ARRAY or HASH directive, the
referenced data structure will be an empty list:

    my $psv   = $cfg->default('PluginSchemaVersion');   # Yields {}
    my $p5lib = $cfg->get_internal('PERL5LIB');         # Yields []

=head2 Contextual return values from C<get()> and C<paths()>

Two methods, C<paths()> and C<get()> (as well as its shorthand variant; see
L<SHORTHAND ACCESSOR FORM> below), are sensitive to the context of the method
call and return the appropriate value for that context. If you aren't familiar
with the vagaries of scalar vs list context, you may want to first review the
section on it in the L<perldata> perldoc:
L<http://perldoc.perl.org/perldata.html#Context>

The C<paths()> method returns an array if called in list context and a reference
to that array if called in scalar context:

    my $paths = $cfg->paths;
    my @paths = $cfg->paths;

The return value of the C<get()> method and shorthand equivalent
C<$cfg-E<gt>SomeDirective> works similarly for ARRAY and HASH values.

B<For SCALAR directives,> C<get()> will always return a scalar (which, don't
forget, can be C<undef>).

    my $csspath = $cfg->get('CSSPath');
    my $same    = $cfg->CSSPath;

B<For ARRAY directives,> C<get()> will return an array in list context or a
reference to that array in scalar context. If the directive is undefined, the
array (or referenced array) will be an empty list as in the example above
using C<PERL5LIB>.

    # Returns array: ('plugins')
    my @ppaths   = $cfg->get('PluginPath');

    # Returns arrayref: ['plugins']
    my $ppath    = $cfg->get('pluginpath');     # Case-insensitive

    # Careful! Returns string "plugins"
    #          due to list context!
    my ($ppath)  = $cfg->PluginPath;            # Shorthand form

B<For HASH directives,> C<get()> will return a hash in list context or a
reference to that hash in scalar context. If the directive is undefined, the
hash (or referenced hash) will be an empty list as in the example above
using C<PluginSchemaVersion>.

=head1 SHORTHAND ACCESSOR FORM

Once the I<ConfigMgr> object has been constructed, you can use it to obtain
the configuration settings. Any of the defined settings may be gathered
using a dynamic method invoked directly from the object:

    my $path = $cfg->CGIPath

To set the value of a directive, do the same as the above, but pass in a
value to the method:

    $cfg->CGIPath('http://www.foo.com/mt/');

If you wish to progammatically assign a configuration setting that will
persist, add an extra parameter when doing an assignment, passing '1'
(this second parameter is a boolean that will cause the value to persist,
using the L<MT::Config> class to store the settings into the datatbase):

    $cfg->EmailAddressMain('user@example.com', 1);
    $cfg->save_config;

=head1 AUTHOR & COPYRIGHT

Please see the I<MT> manpage for author, copyright, and license information.

=cut
