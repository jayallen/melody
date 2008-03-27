
package MT::Awesome::Image;

our @ISA = qw( MT::Awesome );

__PACKAGE__->install_properties({
    class_type => 'image',
});
__PACKAGE__->install_meta({
    columns => [ 'width', 'height' ]
});

1;
