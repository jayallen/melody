package LinkBox::Link;

use strict;
use base qw( MT::Object );

__PACKAGE__->install_properties(
    {   column_defs => {
            'id'              => 'integer not null auto_increment',
            'linkbox_list_id' => 'integer not null',
            'name'            => 'string(255) not null',
            'link'            => 'string(255)',
            'description'     => 'text',
            'order'           => 'integer not null'
        },
        datasource  => 'linkbox_links',
        primary_key => 'id',
        indexes     => {
            id              => 1,
            linkbox_list_id => 1,
        },
        defaults => {
            link        => '',
            description => '',
            order       => 0
        },
    }
);

1;
