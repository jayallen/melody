package MT::ObjectTag;

use strict;

use MT::Blog;
use MT::Object;
@MT::ObjectTag::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'blog_id' => 'integer',
        'object_id' => 'integer not null',
        'object_datasource' => 'string(50) not null',
        'tag_id' => 'integer not null',
    },
    indexes => {
        blog_id => 1,
        object_id => 1,
        tag_id => 1,
        object_datasource => 1,
    },
    child_of => 'MT::Blog',
    datasource => 'objecttag',
    primary_key => 'id',
});

sub parent_names {
    my $obj = shift;
    my $parents = {
        blog => 'MT::Blog',
        tag => 'MT::Tag',
        entry => 'MT::Entry',
        asset => 'MT::Asset',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $parent_names = $obj->parent_names;

    my $done = 1;
    for my $parent_element_name (keys %$parent_names) {
        my $parent_class_name = $parent_names->{$parent_element_name};
        my $old_id = $data->{$parent_element_name . '_id'};
        my $new_obj = $objects->{"$parent_class_name#$old_id"};
        next if !(defined($new_obj) && $new_obj);
        $data->{$parent_element_name . '_id'} = $new_obj->id;
        $done++;
    }
    my $old_id = $data->{'object_id'};
    if (defined($old_id) && ($old_id > 0)) {
        my $class = $parent_names->{$data->{'object_datasource'}};
        my $new_obj = $objects->{"$class#$old_id"};
        if (defined($new_obj) && $new_obj) {
            $data->{'object_id'} = $new_obj->id;
            $done++;
        }
    } else {
        $done++;
    }
    (scalar(keys(%$parent_names)) == $done) ? 1 : 0;   
}

1;
__END__

=head1 NAME

MT::ObjectTag

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
