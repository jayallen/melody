# Copyright 2001-2006 Six Apart. This code cannot be redistributed without
# permission from www.sixapart.com.  For more information, consult your
# Movable Type license.
#
# $Id$

package MT::Trackback;
use strict;

use MT::Object;
@MT::Trackback::ISA = qw( MT::Object );
__PACKAGE__->install_properties({
    column_defs => {
        'id' => 'integer not null auto_increment',
        'blog_id' => 'integer not null',
        'title' => 'string(255)',
        'description' => 'text',
        'rss_file' => 'string(255)',
        'url' => 'string(255)',
        'entry_id' => 'integer not null',
        'category_id' => 'integer not null',
        'is_disabled' => 'boolean',
        'passphrase' => 'string(30)',
    },
    indexes => {
        blog_id => 1,
        entry_id => 1,
        category_id => 1,
        created_on => 1,
    },
    defaults => {
        'entry_id' => 0,
        'category_id' => 0,
        'is_disabled' => 0,
    },
    child_classes => ['MT::TBPing'],
    audit => 1,
    datasource => 'trackback',
    primary_key => 'id',
});

sub remove {
    my $tb = shift;
    $tb->remove_children({ key => 'tb_id' }) or return;
    $tb->SUPER::remove(@_);
}

sub entry {
    my $tb = shift;
    return undef unless $tb->entry_id;
    require MT::Entry;
    MT::Entry->load($tb->entry_id, { cached_ok => 1 });
}

sub category {
    my $tb = shift;
    return undef unless $tb->category_id;
    require MT::Category;
    MT::Category->load($tb->category_id, { cached_ok => 1 });
}

sub children_names {
    my $obj = shift;
    my $children = {
        tbping => 'MT::TBPing',
    };
    $children;
}

sub children_to_xml {
    my $obj = shift;
    my ($namespace, $args) = @_;

    my $t = {};
    if (defined($args)) {
        my $j = $args->{'join'};
        $t = $j->[2] if defined($j);
    }

    my $xml = '';

    my $terms = { 
        'tb_id' => $obj->id,
        %$t,
    };
    
    my $offset = 0;
    while (1) {
        my @objects = MT::TBPing->load(
            $terms,
            { offset => $offset, limit => 50, }
        );
        last unless @objects;
        $offset += scalar @objects;
        for my $object (@objects) {
            $xml .= $object->to_xml($namespace) . "\n" if $object->to_backup;
        }
    }
    $xml;
}

sub parent_names {
    my $obj = shift;
    my $parents = {
        entry => 'MT::Entry',
        category => 'MT::Category',
    };
    $parents;
}

sub restore_parent_ids {
    my $obj = shift;
    my ($data, $objects) = @_;

    my $result = 0;
    my $new_blog = $objects->{'MT::Blog#' . $data->{blog_id}};
    if ($new_blog) {
        $data->{blog_id} = $new_blog->id;
    } else {
        return 0;
    }                            
    if ($data->{category_id}) {
        my $new_obj = $objects->{'MT::Category#' . $data->{category_id}};
        if ($new_obj) {
            $data->{category_id} = $new_obj->id;
            $result = 1;
        }
    } elsif ($data->{entry_id}) {
        my $new_obj = $objects->{'MT::Entry#' . $data->{entry_id}};
        if ($new_obj) {
            $data->{entry_id} = $new_obj->id;
            $result = 1;
        }
    }
    $result;
}

1;
__END__

=head1 NAME

MT::Trackback

=head1 METHODS

=head2 $tb->remove()

Call L<MT::Object/remove> for the trackback.

=head2 $tb->entry()

Call L<MT::Entry/load> for the trackback I<entry_id>.

=head2 $tb->category()

Call L<MT::Category/load> for the trackback I<category_id>.

=head1 AUTHOR & COPYRIGHT

Please see L<MT/AUTHOR & COPYRIGHT>.

=cut
