package LinkBox::LinkList;

use strict;
use warnings;

use base qw( MT::Object );
use LinkBox::Link;

__PACKAGE__->install_properties( {
       column_defs => {
                        'id' => 'integer not null primary key auto_increment',
                        'blog_id' => 'integer not null',
                        'name'    => 'string(255) not null',
                        'order'   => 'integer not null'
       },

       indexes =>
         { 'id' => 1, 'blog_id' => 1, 'name' => 1, 'created_on' => 1, },
       defaults => { 'order' => 0 },

       audit         => 1,
       datasource    => 'linkbox_list',
       primary_key   => 'id',
       child_of      => 'MT::Blog',
       child_classes => ['LinkBox::Link'],
    }
);

sub links {
    my ($obj) = @_;
    return
      LinkBox::Link->load( { linkbox_list_id => $obj->id },
                           { sort => 'order', direction => 'ascend' } );
}

sub class_label {
    MT->translate('Link List');
}

sub class_label_plural {
    MT->translate('Link Lists');
}

sub remove {
    my $list = shift;
    $list->remove_children( { key => 'linkbox_list_id' } );
    $list->SUPER::remove(@_);
}

1;
