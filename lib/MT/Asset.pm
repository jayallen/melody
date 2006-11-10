package MT::Asset;

use strict;
use MT::Tag;
use base qw(MT::FileInfo MT::Taggable);

our %Classes = (
    'MT::Asset::Image' => 'image',
);
our %Types = (
    'image' => 'MT::Asset::Image',
);

sub types {
    my @types = keys %Types;
    push @types, 'asset';
    \@types;
}

sub add_type {
    my $pkg = shift;
    my ($type, $class) = @_;
    $Types{$type} = $class;
    $Classes{$class} = $type;
}

sub type_class {
    my $pkg = shift;
    my ($type) = @_;
    return 'MT::Asset' if $type eq 'asset';
    my $class = $Types{$type};
    if ($class) {
        eval "use $class;";
        return $class unless $@;
    }
    undef;
}

sub type_names {
    my $pkg = shift;
    my %names = ($pkg->type => $pkg->type_name);
    foreach (keys %Types) {
        my $class = $pkg->type_class($_);
        $names{$class->type} = $class->type_name;
    }
    \%names;
}

sub init {
    my $asset = shift;
    $asset->SUPER::init(@_);
    $asset->archive_type('asset');
    $asset;
}

sub type {
    'asset';
}

sub type_name {
    MT->translate('File');
}

sub set_values {
    my $obj = shift;
    $obj->SUPER::set_values(@_);
    my $at = $obj->archive_type;
    if ($at =~ m/^asset:(.+)$/) {
        my $type = $1;
        if (my $pkg = $obj->type_class($type)) {
            bless $obj, $pkg;
        }
    }
    $obj;
}

sub load {
    my $pkg = shift;
    my ($terms, $args) = @_;
    if ($terms && (!ref($terms))) {
        $terms = { id => $terms };
    } else {
        $terms ||= {};
    }
    $terms->{archive_type} ||= 'asset';
    $pkg->SUPER::load(@_);
}

sub load_iter {
    my $pkg = shift;
    my ($terms, $args) = @_;
    if ($terms && (!ref($terms))) {
        $terms = { id => $terms };
    } else {
        $terms ||= {};
    }
    $terms->{archive_type} ||= 'asset';
    $pkg->SUPER::load_iter(@_);
}

sub save {
    my $asset = shift;
    $asset->SUPER::save(@_) or return;
    # synchronize tags if necessary
    $asset->save_tags;
    1;
}

1;