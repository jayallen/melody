# $Id$

package Bar;
use strict;

use MT::Object;
use base qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'foo_id' => 'integer',
        'name' => 'string(25)',
        'status' => 'smallint',
    },
    indexes => {
        foo_id => 1,
        name => 1,
        created_on => 1,
        status => 1,
    },
    audit => 1,
    datasource => 'bar',
    primary_key => 'id',
});

1;
