# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Object;
use strict;

use MT::ObjectDriver;
use MT::ErrorHandler;
use MT::Util qw(epoch2ts);
use HTTP::Date qw(time2isoz);
@MT::Object::ISA = qw( MT::ErrorHandler );

## Magic.

sub install_properties {
    my $class = shift;
    no strict 'refs';
    my $props = shift;
    my @cols;
    if (exists $props->{column_defs}) {
        $props->{columns} = [ keys %{ $props->{column_defs} } ];
        @cols = @{ $props->{columns} };
    } else {
        @cols = @{ $props->{columns} };
        foreach ( @cols ) {
            $props->{column_defs}{$_} = ();
        }
    }
    if ($props->{audit}) {
        $props->{column_defs}{created_on} = 'datetime';
        $props->{column_defs}{created_by} = 'integer';
        $props->{column_defs}{modified_on} = 'timestamp not null';
        $props->{defaults}{modified_on} ||= '20000101000000';
        $props->{column_defs}{modified_by} = 'integer';
    }

    my $pk = $props->{primary_key} || '';
    @cols = sort { $a eq $pk ? -1 : $b eq $pk ? 1 : $a cmp $b } @cols;
    push @cols, qw( created_on created_by modified_on modified_by )
        if $props->{audit};
    $props->{column_names} = \@cols;

    if ((ref $props->{child_classes}) eq 'ARRAY') {
        my $classes = $props->{child_classes};
        $props->{child_classes} = {};
        @{$props->{child_classes}}{@$classes} = ();
    }
    if (exists $props->{child_of}) {
        my $parent_classes = $props->{child_of};
        if (!ref $parent_classes) {
            $parent_classes = [ $parent_classes ];
        }
        foreach my $pc (@$parent_classes) {
            my $pp = $pc->properties;
            $pp->{child_classes} ||= {};
            $pp->{child_classes}{$class} = ();
        }
    }

    ${"${class}::__properties"} = $props;
}

sub properties {
    no strict 'refs';
    my $p;
    unless ($p = ref($_[0]) ? ${ref($_[0]).'::__properties'} : ${"$_[0]::__properties"}) {
        my $pkg = ref $_[0] || $_[0];
        my $parent = @{$pkg . '::ISA'}[0];
        return $parent->properties if $parent;
    }
    $p;
}

## Drivers.

use vars qw( $DRIVER );
sub set_driver { $DRIVER = MT::ObjectDriver->new($_[1]) }
sub driver { $DRIVER }
sub set_callback_routine { shift; $DRIVER->set_callback_routine(@_) }

## Callbacks

sub add_callback {
    my $class = shift;
    my($meth, $priority, $plugin, $code) = @_;
    if (ref$code ne 'CODE') {
        return $class->error(MT->translate("4th argument to add_callback must be a perl CODE reference"));
    }
    MT->add_callback($class . '::' . $meth, $priority, $plugin, $code);
    1;
}

## Construction/initialization.

sub new {
    my $class = shift;
    my $obj = bless {}, $class;
    $obj->init(@_);
}

sub init {
    my $obj = shift;
    $obj->set_defaults();
    $obj;
}

sub set_defaults {
    my $obj = shift;
    my $defaults = $obj->properties->{'defaults'};
    $obj->{'column_values'} = $defaults ? {%$defaults} : {};
}

sub clone {
    my $obj = shift;
    my ($param) = @_;
    my $clone = ref($obj)->new();
    if ($param && $param->{Except}) {
        my $except = $param->{Except};
        while (my ($key, $value) = each %{$obj->column_values()}) {
            $clone->column($key, $value) if !exists($$except{$key});
        } 
    } else {
        $clone->set_values($obj->column_values);
    }
    $clone;
}

sub column_names { $_[0]->properties->{column_names} }

sub datasource { $_[0]->properties->{datasource} }

sub column_values { $_[0]->{'column_values'} }

sub column { 
    defined $_[2] ?
        $_[0]->{column_values}{$_[1]} = $_[2] :
        $_[0]->{column_values}{$_[1]};
}

sub created_on_obj {
    my $obj = shift;
    if (my $ts = $obj->created_on) {
        my $blog;
        if ($obj->isa('MT::Blog')) {
            $blog = $obj;
        } else {
            if (my $blog_id = $obj->blog_id) {
                require MT::Blog;
                $blog = MT::Blog->load($blog_id);
            }
        }
        my($y, $mo, $d, $h, $m, $s) = $ts =~ /(\d\d\d\d)[^\d]?(\d\d)[^\d]?(\d\d)[^\d]?(\d\d)[^\d]?(\d\d)[^\d]?(\d\d)/;
        require MT::DateTime;
        my $four_digit_offset;
        if ($blog) {
            $four_digit_offset = sprintf('%.02d%.02d', int($blog->server_offset),
                                        60 * abs($blog->server_offset
                                                 - int($blog->server_offset)));
        }
        return new MT::DateTime(year => $y, month => $mo, day => $d,
                                hour => $h, minute => $m, second => $s,
                                time_zone => $four_digit_offset);
    }
    undef;
}

sub set_values {
    my $obj = shift;
    my($values) = @_;
    my @cols = @{ $obj->column_names };
    for my $col (@cols) {
        next unless exists $values->{$col};
        $obj->column($col, $values->{$col});
    }
}

sub _mk_passthru {
    my($method) = @_;
    sub {
        my($this) = $_[0];
        die "No ObjectDriver defined" unless defined $DRIVER;
        my $class = ref($this) || $this;
        if (wantarray) {
            my @result = eval {
                my @rc = $DRIVER->$method(@_);
                @rc or return $this->error( $DRIVER->errstr );
                return @rc;
            };
            if ($@) {
                require Carp;
                if ($MT::DebugMode) {
                    Carp::confess($@);
                } else {
                    Carp::croak($@);
                }
            }
            return @result;
        } else {
            my $result = eval {
                my $rc = $DRIVER->$method(@_);
                defined $rc or return $this->error( $DRIVER->errstr );
                return $rc;
            };
            if ($@) {
                require Carp;
                if ($MT::DebugMode) {
                    Carp::confess($@);
                } else {
                    Carp::croak($@);
                }
            }
            return $result;
        }
    }
}

{
    no strict 'refs';
    *join_on = _mk_passthru('join_on');
    *load = _mk_passthru('load');
    *load_iter = _mk_passthru('load_iter');
    *save = _mk_passthru('save');
    *remove = _mk_passthru('remove');
    *remove_all = _mk_passthru('remove_all');
    *exists = _mk_passthru('exists');
    *count = _mk_passthru('count');
    *count_group_by = _mk_passthru('count_group_by');
}

sub remove_children {
    my $obj = shift;
    return 1 unless ref $obj;

    my ($param) = @_;
    my $child_classes = $obj->properties->{child_classes} || {};
    my @classes = keys %$child_classes;
    return 1 unless @classes;

    $param ||= {};
    my $key = $param->{key} || $obj->datasource . '_id';
    my $obj_id = $obj->id;
    for my $class (@classes) {
        eval "use $class;";
        $class->remove({ $key => $obj_id })
            or die $obj->error($class->errstr);
    }
    1;
}

sub get_by_key {
    my $class = shift;
    my ($key) = @_;
    my $obj = $class->load($key);
    $obj ||= new $class;
    foreach my $col (keys %$key) {
        $obj->column($col, $key->{$col});
    }
    $obj;
}

sub set_by_key {
    my $class = shift;
    my ($key, $value) = @_;
    my $obj = $class->load($key);
    $obj ||= new $class;
    $obj->set_values($key);
    foreach my $col (keys %$value) {
        $obj->column($col, $value->{$col});
    }
    $obj->save();
    $obj;
}

sub DESTROY { }

use vars qw( $AUTOLOAD );
sub AUTOLOAD {
    my $obj = $_[0];
    (my $col = $AUTOLOAD) =~ s!.+::!!;
    my $class = ref($obj);
    my $defs = $obj->column_defs;
    if (!exists $defs->{$col}) {
        require Carp;
        Carp::confess("unknown column: $col for class $class");
    }
    no strict 'refs';
    *$AUTOLOAD = sub {
        shift()->column($col, @_);
    };
    goto &$AUTOLOAD;
}

sub column_def {
    my $obj = shift;
    my ($name) = @_;
    $obj->column_defs->{$name};
}

sub column_defs {
    my $obj = shift;
    my $props = $obj->properties;
    my $defs = $props->{column_defs};
    return undef if !$defs;
    my ($key) = keys %$defs;
    if (!(ref $defs->{$key})) {
        $obj->__mangle_defs();
    }
    $props->{column_defs};
}

sub __mangle_defs {
    my $obj = shift;
    my $defs = $obj->properties->{column_defs};
    foreach my $col ( keys %$defs ) {
        $defs->{$col} = $obj->__mangle_def($col, $defs->{$col});
    }
}

sub __mangle_def {
    my $obj = shift;
    my ($col, $def) = @_;
    return undef if !defined $def;
    my $props = $obj->properties;
    my %def;
    if ($def =~ s/^([^( ]+)\s*//) {
        $def{type} = $1;
    }
    if ($def =~ s/^\((\d+)\)\s*//) {
        $def{size} = $1;
    }
    $def{not_null} = 1 if $def =~ m/\bnot null\b/i;
    $def{key} = 1 if $def =~ m/\bprimary key\b/i;
    $def{key} = 1 if ($props->{primary_key}) && ($props->{primary_key} eq $col);
    $def{auto} = 1 if $def =~ m/\bauto[_ ]increment\b/i;
    $def{default} = $props->{defaults}{$col} if exists $props->{defaults}{$col};
    \%def;
}

sub cache_property {
    my $obj = shift;
    my $key = shift;
    my $code = shift;
    if (ref $key eq 'CODE') {
        ($key, $code) = ($code, $key);
    }
    $key ||= (caller(1))[3];

    if (@_) {
        $obj->{__cache}{$key} = $_[0];
    } else {
        if ((!defined $obj->{__cache}{$key}) && $code) {
            $obj->{__cache}{$key} = $code->($obj, @_);
        }
    }
    return exists $obj->{__cache}{$key} ? $obj->{__cache}{$key} : undef;
}

sub to_hash {
    my $obj = shift;
    my $hash = {};
    my $pfx = $obj->datasource;
    my $values = $obj->column_values;
    foreach (keys %$values) {
        $hash->{"${pfx}.$_"} = $values->{$_};
    }
    if (my $blog_id = $obj->column('blog_id')) {
        require MT::Blog;
        my $blog = MT::Blog->load($blog_id);
        my $blog_hash = $blog->to_hash;
        $hash->{"${pfx}.$_"} = $blog_hash->{$_} foreach keys %$blog_hash;
    }
    $hash;
}

sub _is_element {
    my $obj = shift;
    my ($def) = @_;
    return (('text' eq $def->{type}) || (('string' eq $def->{type}) && (255 < $def->{size}))) ? 1 : 0;
}

sub to_backup { 1; }
sub children_to_xml { ''; }

sub to_xml {
    my $obj = shift;

    my $coldefs = $obj->column_defs;
    my $colnames = $obj->column_names;
    my $xml;

    $xml = '<' . $obj->datasource;

    my @elements;
    for my $name (@$colnames) {
        if ($obj->column($name)) {
            if ($obj->_is_element($coldefs->{$name})) {
                push @elements, $name;
                next;
            } elsif (('datetime' eq $coldefs->{$name}{type}) || ('timestamp' eq $coldefs->{$name}{type})) {
                my $ts_iso = HTTP::Date::time2isoz(MT::Util::ts2epoch(undef, $obj->column($name)));
                $ts_iso =~ s/ /T/;
                $xml .= " $name='" . $ts_iso . "'";
                next;
            }
            $xml .= " $name='" . MT::Util::encode_xml($obj->column($name), 1) . "'";
        }
    }
    $xml .= '>';
    $xml .= "<$_>" . MT::Util::encode_xml($obj->column($_), 1) . "</$_>" foreach @elements;
    $xml .= $obj->children_to_xml;
    $xml .= '</' . $obj->datasource . '>';
    $xml;
}

1;
__END__

=head1 NAME

MT::Object - Movable Type base class for database-backed objects

=head1 SYNOPSIS

Creating an I<MT::Object> subclass:

    package MT::Foo;
    use strict;

    use base 'MT::Object';

    __PACKAGE__->install_properties({
        columns_defs => {
            'id'  => 'integer not null auto_increment',
            'foo' => 'string(255)',
        },
        indexes => {
            foo => 1,
        },
        primary_key => 'id',
        datasource => 'foo',
    });

Using an I<MT::Object> subclass:

    use MT;
    use MT::Foo;

    ## Create an MT object to load the system configuration and
    ## initialize an object driver.
    my $mt = MT->new;

    ## Create an MT::Foo object, fill it with data, and save it;
    ## the object is saved using the object driver initialized above.
    my $foo = MT::Foo->new;
    $foo->foo('bar');
    $foo->save
        or die $foo->errstr;

=head1 DESCRIPTION

I<MT::Object> is the base class for all Movable Type objects that will be
serialized/stored to some location for later retrieval; this location could
be a DBM file, a relational database, etc.

Movable Type objects know nothing about how they are stored--they know only
of what types of data they consist, the names of those types of data (their
columns), etc. The actual storage mechanism is in the I<MT::ObjectDriver>
class and its driver subclasses; I<MT::Object> subclasses, on the other hand,
are essentially just standard in-memory Perl objects, but with a little extra
self-knowledge.

This distinction between storage and in-memory representation allows objects
to be serialized to disk in many different ways--for example, an object could
be stored in a MySQL database, in a DBM file, etc. Adding a new storage method
is as simple as writing an object driver--a non-trivial task, to be sure, but
one that will not require touching any other Movable Type code.

=head1 SUBCLASSING

Creating a subclass of I<MT::Object> is very simple; you simply need to
define the properties and metadata about the object you are creating. Start
by declaring your class, and inheriting from I<MT::Object>:

    package MT::Foo;
    use strict;

    use base 'MT::Object';

=item * __PACKAGE__->install_properties($args)

Then call the I<install_properties> method on your class name; an easy way
to get your class name is to use the special I<__PACKAGE__> variable:

    __PACKAGE__->install_properties({
        column_defs => {
            'id' => 'integer not null auto_increment',
            'foo' => 'string(255)',
        },
        indexes => {
            foo => 1,
        },
        primary_key => 'id',
        datasource => 'foo',
    });

I<install_properties> performs the necessary magic to install the metadata
about your new class in the MT system. The method takes one argument, a hash
reference containing the metadata about your class. That hash reference can
have the following keys:

=over 4

=item * column_defs

The definition of the columns (fields) in your object. Column names are also
used for method names for your object, so your column name should not
contain any strange characters. (It could also be used as part of the name of
the column in a relational database table, so that is another reason to keep
column names somewhat sane.)

The value for the I<columns> key should be a reference to an hashref
containing the key/value pairs that are names of your columns matched with
their schema definition.

The type declaration of a column is pseudo-SQL. The data types loosely match
SQL types, but are vendor-neutral, and each MT::ObjectDriver will map these
to appropriate types for the database it services. The format of a column
type is as follows:

    'column_name' => 'type(size) options'

The 'type' part of the declaration can be any one of:

=over 4

=item * string

For storing string data, typically up to 255 characters, but assigned a length identified by '(size)'.

=item * integer

For storing integers, maybe limited to 32 bits.

=item * boolean

For storing boolean values (numeric values of 1 or 0).

=item * smallint

For storing small integers, typically limited to 16 bits.

=item * datetime

For storing a full date and time value.

=item * timestamp

For storing a date and time that automatically updates upon save.

=item * blob

For storing binary data.

=item * text

For storing text data.

=item * float

For storing floating point values.

=back

Note: The physical data storage capacity of these types will vary depending on
the driver's implementation. Please refer to the documentation of the
MT::ObjectDriver you're using to determine the actual capacity for these
types.

The '(size)' element of the declaration is only valid for the 'string' type.

The 'options' element of the declaration is not required, but is used to
specify additional attributes of the column. Such as:

=over 4

=item * not null

Specify this option when you wish to constrain the column so that it must contain a defined value. This is only enforced by the database itself, not by the MT::ObjectDriver.

=item * auto_increment

Specify for integer columns (typically the primary key) to automatically assign a value.

=item * primary key

Specify for identifying the column as the primary key (only valid for a single column).

=back

=item * indexes

Specifies the column indexes on your objects; this only has consequence for
some object drivers (DBM, for example), where indexes are not automatically
maintained by the datastore (as they are in a relational database).

The value for the I<indexes> key should be a reference to a hash containing
column names as keys, and the value C<1> for each key--each key represents
a column that should be indexed.

B<NOTE:> with the DBM driver, if you do not set up an index on a column you
will not be able to select objects with values matching that column using the
I<load> and I<load_iter> interfaces (see below).

=item * audit

Automatically adds bookkeeping capabilities to your class--each object will
take on four new columns: I<created_on>, I<created_by>, I<modified_on>, and
I<modified_by>. These columns will be filled automatically with the proper
values.

=item * datasource

The name of the datasource for your class. The datasource is a name uniquely
identifying your class--it is used by the object drivers to construct table
names, file names, etc. So it should not be specific to any one driver.

=back

=head1 USAGE

=head2 System Initialization

Before using (loading, saving, removing) an I<MT::Object> class and its
objects, you must always initialize the Movable Type system. This is done
with the following lines of code:

    use MT;
    my $mt = MT->new;

Constructing a new I<MT> objects loads the system configuration from the
F<mt.cfg> configuration file, then initializes the object driver that will
be used to manage serialized objects.

=head2 Creating a new object

To create a new object of an I<MT::Object> class, use the I<new> method:

    my $foo = MT::Foo->new;

I<new> takes no arguments, and simply initializes a new in-memory object.
In fact, you need not ever save this object to disk; it can be used as a
purely in-memory object.

=head2 Setting and retrieving column values

To set the column value of an object, use the name of the column as a method
name, and pass in the value for the column:

    $foo->foo('bar');

The return value of the above call will be C<bar>, the value to which you have
set the column.

To retrieve the existing value of a column, call the same method, but without
an argument:

    $foo->foo

This returns the value of the I<foo> column from the I<$foo> object.

=over 4

=item * $obj->init()

=back

This method is used to initialize the object upon construction.

=over 4

=item * $obj->set_defaults()

=back

This method is used by the I<init> method to set the object defaults.

=head2 Saving an object

To save an object using the object driver, call the I<save> method:

=over 4

=item * $foo->save();

=back

On success, I<save> will return some true value; on failure, it will return
C<undef>, and you can retrieve the error message by calling the I<errstr>
method on the object:

    $foo->save
        or die "Saving foo failed: ", $foo->errstr;

If you are saving objects in a loop, take a look at the
L</"Note on object locking">.

=head2 Loading an existing object or objects

=over 4

=item * $obj->load()

=item * $obj->load_iter()

=back

You can load an object from the datastore using the I<load> method. I<load>
is by far the most complicated method, because there are many different ways
to load an object: by ID, by column value, by using a join with another type
of object, etc.

In addition, you can load objects either into an array (I<load>), or by using
an iterator to step through the objects (I<load_iter>).

I<load> has the following general form:

    my @objects = MT::Foo->load(\%terms, \%arguments);

I<load_iter> has the following general form:

    my $iter = MT::Foo->load_iter(\%terms, \%arguments);

Both methods share the same parameters; the only difference is the manner in
which they return the matching objects.

If you call I<load> in scalar context, only the first row of the array
I<@objects> will be returned; this works well when you know that your I<load>
call can only ever result in one object returned--for example, when you load
an object by ID.

I<\%terms> should be either:

=over 4

=item * The numeric ID of an object in the datastore.

=item * A reference to a hash.

The hash should have keys matching column names and the values are the
values for that column.

For example, to load an I<MT::Foo> object where the I<foo> column is
equal to C<bar>, you could do this:

    my @foo = MT::Foo->load({ foo => 'bar' });

In addition to a simple scalar, the hash value can be a reference to an array;
combined with the I<range> setting in the I<\%arguments> list, you can use
this to perform range searches. If the value is a reference, the first element
in the array specifies the low end of the range, and the second element the
high end.

=back

I<\%arguments> should be a reference to a hash containing parameters for the
search. The following parameters are allowed:

=over 4

=item * sort => "column"

Sort the resulting objects by the column C<column>; C<column> must be an
indexed column (see L</"indexes">, above).

=item * direction => "ascend|descend"

To be used together with I<sort>; specifies the sort order (ascending or
descending). The default is C<ascend>.

=item * limit => "N"

Rather than loading all of the matching objects (the default), load only
C<N> objects.

=item * offset => "M"

To be used together with I<limit>; rather than returning the first C<N>
matches (the default), return matches C<M> through C<N + M>.

=item * start_val => "value"

To be used together with I<limit> and I<sort>; rather than returning the
first C<N> matches, return the first C<N> matches where C<column> (the sort
column) is greater than C<value>.

=item * range

To be used together with an array reference as the value for a column in
I<\%terms>; specifies that the specific column should be searched for a range
of values, rather than one specific value.

The value of I<range> should be a hash reference, where the keys are column
names, and the values are all C<1>; each key specifies a column that should
be interpreted as a range.

=item * join

Can be used to select a set of objects based on criteria, or sorted by
criteria, from another set of objects. An example is selecting the C<N>
entries most recently commented-upon; the sorting is based on I<MT::Comment>
objects, but the objects returned are actually I<MT::Entry> objects. Using
I<join> in this situation is faster than loading the most recent
I<MT::Comment> objects, then loading each of the I<MT::Entry> objects
individually.

Note that I<join> is not a normal SQL join, in that the objects returned are
always of only one type--in the above example, the objects returned are only
I<MT::Entry> objects, and cannot include columns from I<MT::Comment> objects.

I<join> has the following general syntax:

    join => MT::Foo->join_on( JOIN_COLUMN, I<\%terms>, I<\%arguments> )

Use the actual MT::Object-descended package name and the join_on static method
providing these parameters: I<JOIN_COLUMN> is the column joining the two
object tables, I<\%terms> and I<\%arguments> have the same meaning as they do
in the outer I<load> or I<load_iter> argument lists: they are used to select
the objects with which the join is performed.

For example, to select the last 10 most recently commmented-upon entries, you
could use the following statement:

    my @entries = MT::Entry->load(undef, {
        'join' => MT::Comment->join_on( 'entry_id',
                    { blog_id => $blog_id },
                    { 'sort' => 'created_on',
                      direction => 'descend',
                      unique => 1,
                      limit => 10 } )
    });

In this statement, the I<unique> setting ensures that the I<MT::Entry>
objects returned are unique; if this flag were not given, two copies of the
same I<MT::Entry> could be returned, if two comments were made on the same
entry.

=item * unique

Ensures that the objects being returned are unique.

This is really only useful when used within a I<join>, because when loading
data out of a single object datastore, the objects are always going to be
unique.

=back

=head2 Removing an object

=over 4

=item * $foo->remove()

=back

To remove an object from the datastore, call the I<remove> method on an
object that you have already loaded using I<load>:

    $foo->remove();

On success, I<remove> will return some true value; on failure, it will return
C<undef>, and you can retrieve the error message by calling the I<errstr>
method on the object:

    $foo->remove
        or die "Removing foo failed: ", $foo->errstr;

If you are removing objects in a loop, take a look at the
L</"Note on object locking">.

=head2 Removing select objects of a particular class

Combining the syntax of the load and remove methods, you can use the
static version of the remove method to remove particular objects:

    MT::Foo->remove({ bar => 'baz' });

The terms you specify to remove by should be indexed columns. This
method will load the object and remove it, firing the callback operations
associated with those operations.

=head2 Removing all of the objects of a particular class

To quickly remove all of the objects of a particular class, call the
I<remove_all> method on the class name in question:

=over 4

=item * MT::Foo->remove_all();

=back

On success, I<remove_all> will return some true value; on failure, it will
return C<undef>, and you can retrieve the error message by calling the
I<errstr> method on the class name:

    MT::Foo->remove_all
        or die "Removing all foo objects failed: ", MT::Foo->errstr;

=head2 Removing all the children of an object

=over 4

=item * $obj->remove_children([ \%param ])

=back

If your class has registered 'child_classes' as part of it's properties,
then this method may be used to remove objects that are associated with
the active object.

This method is typically used in an overridden 'remove' method.

    sub remove {
        my $obj = shift;
        $obj->remove_children({ key => 'object_id' });
        $obj->SUPER::remove(@_);
    }

The 'key' parameter specified here lets you identify the field name used by
the children classes to relate back to the parent class. If unspecified,
C<remove_children> will assume the key to be the datasource name of the
current class with an '_id' suffix.

=head2 Getting the count of a number of objects

To determine how many objects meeting a particular set of conditions exist,
use the I<count> method:

    my $count = MT::Foo->count({ foo => 'bar' });

I<count> takes the same arguments (I<\%terms> and I<\%arguments>) as I<load>
and I<load_iter>, above.

=head2 Determining if an object exists in the datastore

To check an object for existence in the datastore, use the I<exists> method:

    if ($foo->exists) {
        print "Foo $foo already exists!";
    }

=head2 Counting groups of objects

=over 4

=item * $obj->count_group_by()

=back

The count_group_by method can be used (with SQL-based ObjectDrivers)
to retrieve a list of all the distinct values that appear in a given
column along with a count of how many objects carry that value. The
routine can also be used with more than one column, in which case it
retrieves the distinct pairs (or n-tuples) of values in those columns,
along with the counts. Yet more powerful, any SQL expression can be
used in place of the column names to count how many object produce any
given result values when run through those expressions.

  $iter = MT::Foo->count_group_by($terms, {%args, group => $group_exprs});

C<$terms> and C<%args> pick out a subset of the MT::Foo objects in the
usual way. C<$group_expressions> is an array reference containing the
SQL expressions for the values you want to group by. A single row will
be returned for each distinct tuple of values resulting from the
$group_expressions. For example, if $group_expressions were just a
single column (e.g. group => ['created_on']) then a single row would
be returned for each distinct value of the 'created_on' column. If
$group_expressions were multiple columns, a row would be returned for
each distinct pair (or n-tuple) of values found in those columns.

Each application of the iterator C<$iter> returns a list in the form:

  ($count, $group_val1, $group_val2, ...)

Where C<$count> is the number of MT::Foo objects for which the group
expressions are the values ($group_val1, $group_val2, ...). These
values are in the same order as the corresponding group expressions in
the $group_exprs argument.

In this example, we load up groups of MT::Pip objects, grouped by the
pair (cat_id, invoice_id), and print how many pips have that pair of
values.

    $iter = MT::Pip->count_group_by(undef,
                                    {group => ['cat_id',
                                               'invoice_id']});
    while (($count, $cat, $inv) = $iter->()) {
        print "There are $count Pips with " .
            "category $cat and invoice $inv\n";
    }

=head2 Inspecting and Manipulating Object State

=over 4

=item * $obj->column_values()

=back

Use C<column_values> and C<set_values> to get and set the fields of an
object I<en masse>. The former returns a hash reference mapping column
names to their values in this object. For example:

    $values = $obj->column_values()

=over 4

=item * $obj->set_values()

=back

C<set_values> accepts a similar hash ref, which need not give a value
for every field. For example:

    $obj->set_values({col1 => $val1, col2 => $val2});

is equivalent to

    $obj->col1($val1);
    $obj->col2($val2);

=head2 Other Methods

=over 4

=item * $obj->clone([\%param])

Returns a clone of C<$obj>. That is, a distinct object which has all
the same data stored within it. Changing values within one object does
not modify the other.

An optional C<Except> parameter may be provided to exclude particular
columns from the cloning operation. For example, the following would
clone the elements of the blog except the name attribute.

   $blog->clone({ Except => { name => 1 } });

=item * $obj->column_names()

Returns a list of the names of columns in C<$obj>; includes all those
specified to the install_properties method as well as the audit
properties (C<created_on>, C<modified_on>, C<created_by>,
C<modified_by>), if those were enabled in install_properties.

=item * $obj->set_driver()

This method sets the object driver to use to link with a database.

=item * MT::Foo->driver()

=item * $obj->driver()

Returns the ObjectDriver object that links this object with a database.

=item * $obj->created_on_obj()

Returns an MT::DateTime object representing the moment when the
object was first saved to the database.

=item * MT::Foo->set_by_key($key_terms, $value_terms)

A convenience method that loads whatever object matches the C<$key_terms>
argument and sets some or all of its fields according to the
C<$value_terms>. For example:

   MT::Foo->set_by_key({name => 'Thor'},
                       {region => 'Norway', gender => 'Male'});

This loads the C<MT::Foo> object having 'name' field equal to 'Thor'
and sets the 'region' and 'gender' fields appropriately.

More than one term is acceptable in the C<$key_terms> argument. The
matching object is the one that matches all of the C<$key_terms>.

This method only useful if you know that there is a unique object
matching the given key. There need not be a unique constraint on the
columns named in the C<$key_hash>; but if not, you should be confident
that only one object will match the key.

=item * MT::Foo->get_by_key($key_terms)

A convenience method that loads whatever object matches the C<$key_terms>
argument. If no matching object is found, a new object will be constructed
and the C<$key_terms> provided will be assigned to it. So regardless of
whether the key exists already, this method will return an object with the
key requested. Note, however: if a new object is instantiated it is
not automatically saved.

    my $thor = MT::Foo->get_by_key({name => 'Thor'});
    $thor->region('Norway');
    $thor->gender('Male');
    $thor->save;

The fact that it returns a new object if one isn't found is to help
optimize this pattern:

    my $obj = MT::Foo->load({key => $value});
    if (!$obj) {
        $obj = new MT::Foo;
        $obj->key($value);
    }

This is equivalent to:

    my $obj = MT::Foo->get_by_key({key => $value});

If you don't appreciate the autoinstantiation behavior of this method,
just use the C<load> method instead.

More than one term is acceptable in the C<$key_terms> argument. The
matching object is the one that matches all of the C<$key_terms>.

This method only useful if you know that there is a unique object
matching the given key. There need not be a unique constraint on the
columns named in the C<$key_hash>; but if not, you should be confident
that only one object will match the key.

=item * $obj->cache_property($key, $code)

Caches the provided key (e.g. entry, trackback) with the return value
of the given code reference (which is often an object load call) so
that the value does not have to be recomputed each time.

=item * $obj->column_def($name)

This method returns the value of the given I<$name> C<column_defs>
propery.

=item * $obj->column_defs()

This method returns all the C<column_defs> of the property of the
object.

=item * $obj->to_hash()

TODO - So far I have not divined what this method actually does. Hints?

=item * Class->join_on()

This method returns the list of used by the join arguments parameter
used by the L<MT::App::CMS/listing> method.

=item * $obj->properties()

TODO - Return the return properties of the object.

=item * $obj->to_xml()

TODO - Return the XML representation of the object.

=back

=head1 NOTES

=head2 Note on object locking

When you read objects from the datastore, the object table is locked with a
shared lock; when you write to the datastore, the table is locked with an
exclusive lock.

Thus, note that saving or removing objects in the same loop where you are
loading them from an iterator will not work--the reason is that the datastore
maintains a shared lock on the object table while objects are being loaded
from the iterator, and thus the attempt to gain an exclusive lock when saving
or removing an object will cause deadlock.

For example, you cannot do the following:

    my $iter = MT::Foo->load_iter({ foo => 'bar' });
    while (my $foo = $iter->()) {
        $foo->remove;
    }

Instead you should do either this:

    my @foo = MT::Foo->load({ foo => 'bar' });
    for my $foo (@foo) {
        $foo->remove;
    }

or this:

    my $iter = MT::Foo->load_iter({ foo => 'bar' });
    my @to_remove;
    while (my $foo = $iter->()) {
        push @to_remove, $foo
            if SOME CONDITION;
    }
    for my $foo (@to_remove) {
        $foo->remove;
    }

This last example is useful if you will not be removing every I<MT::Foo>
object where I<foo> equals C<bar>, because it saves memory--only the
I<MT::Foo> objects that you will be deleting are kept in memory at the same
time.

=head1 CALLBACKS

=over 4

=item * $obj->add_callback()

=back

Most MT::Object operations can trigger callbacks to plugin code. Some
notable uses of this feature are: to be notified when a database record is
modified, or to pre- or post-process the data being flowing to the
database.

To add a callback, invoke the C<add_callback> method of the I<MT::Object>
subclass, as follows:

   MT::Foo->add_callback( "pre_save", <priority>, 
                          <plugin object>, \&callback_function);

The first argument is the name of the hook point. Any I<MT::Object>
subclass has a pre_ and a post_ hook point for each of the following
operations:

    load
    save
    remove
    remove_all
    (load_iter operations will call the load callbacks)

The second argument, E<lt>priorityE<gt>, is the relative order in
which the callback should be called. The value should be between 1 and
10, inclusive. Callbacks with priority 1 will be called before those
with 2, 2 before 3, and so on.

Plugins which know they need to run first or last can use the priority
values 0 and 11. A callback with priority 0 will run before all
others, and if two callbacks try to use that value, an error will
result. Likewise priority 11 is exclusive, and runs last.

How to remember which callback priorities are special? As you know,
most guitar amps have a volume knob that goes from 1 to 10. But, like
that of certain rock stars, our amp goes up to 11. A callback with
priority 11 is the "loudest" or most powerful callback, as it will be
called just before the object is saved to the database (in the case of
a 'pre' callback), or just before the object is returned (in the case
of a 'post' callback). A callback with priority 0 is the "quietest"
callback, as following callbacks can completely overwhelm it. This may
be a good choice for your plugin, as you may want your plugin to work
well with other plugins. Determining the correct priority is a matter
of thinking about your plugin in relation to others, and adjusting the
priority based on experience so that users get the best use out of the
plugin.

The E<lt>plugin objectE<gt> is an object of type MT::Plugin which
gives some information about the plugin. This is used to include
the plugin's name in any error messages.

E<lt>callback functionE<gt> is a code referense for a subroutine that
will be called. The arguments to this
function vary by operation (see I<MT::Callback> for details),
but in each case the first parameter is the I<MT::Callback> object
itself:

  sub my_callback {
      my ($cb, ...) = @_;

      if ( <error condition> ) {
          return $cb->error("Error message");
      }
  }

Strictly speaking, the return value of a callback is ignored. Calling
the error() method of the MT::Callback object (C<$cb> in this case)
propagates the error message up to the MT activity log. 

Another way to handle errors is to call C<die>. If a callback dies,
I<MT> will warn the error to the activity log, but will continue
processing the MT::Object operation: so other callbacks will still
run, and the database operation should still occur.

=head2 Any-class Object Callbacks

If you add a callback to the MT class with a hook point that begins
with C<*::>, such as:

    MT->add_callback('*::post_save', 7, $my_plugin, \&code_ref);

then it will be called whenever post_save callbacks are called.
"Any-class" callbacks are called I<after> all class-specific
callbacks. Note that C<add_callback> must be called on the C<MT> class,
not on a subclass of C<MT::Object>.

=over 4

=item * $obj->set_callback_routine()

This method just calls the set_callback_routine as defined by the
MT::ObjectDriver set with the I<set_driver> method.

=back

=head2 Caveat

Be careful how you handle errors. If you transform data as it goes
into and out of the database, and it is possible for one of your
callbacks to fail, the data may get saved in an undefined state. It
may then be difficult or impossible for the user to recover that data.

=head1 AUTHOR & COPYRIGHTS

Please see the I<MT> manpage for author, copyright, and license information.

=cut
