package LinkBox;
use LinkBox::Link;
use MT;
use JSON;
use MT::Plugin;
use MT::PluginData;

use strict;

sub plugin {
    MT->component('LinkBox');
}

sub list_lists {
    my $app     = shift;
    my $blog_id = $app->param('blog_id');
    my @ll = MT->model('linkbox_list')->load({ blog_id => $blog_id },
                                             {
                                                 'sort' => 'order',
                                                 'direction' => 'ascend'
                                             });
    my $lists = {};
    foreach (@ll) {
    	$lists->{ $_->id } = $_->order;
    }
    
    use JSON;
    my $list_order_json = JSON::to_json( $lists );
    
    $app->listing(
        {   type  => 'linkbox_list',
            terms => { blog_id => $blog_id, },
            params => { order_json => $list_order_json },
            args  => {
                sort      => 'name',
                direction => 'ascend'
            },
            code => sub {
                my ( $obj, $row ) = @_;
                my @links = $obj->links;
                $row->{links_count} = scalar @links;
            },
        }
    );
}

sub view_linkbox_list {
    my $app = shift;
    my $q   = $app->param;

    my $tmpl  = plugin()->load_tmpl('edit_linkbox_list.tmpl');
    my $class = $app->model('linkbox_list');
    my %param = ();

    # General setup stuff here
    # (this should really be a genericly available thing in MT,
    # but it can't find the template unless we're in the plugin)

    $param{object_type} = 'linkbox_list';
    my $id = $q->param('id');
    my $obj;
    if ($id) {
        $obj = $class->load($id);
    }
    else {
        $obj = $class->new;
    }

    my $cols = $class->column_names;

    # Populate the param hash with the object's own values
    for my $col (@$cols) {
        $param{$col}
            = defined $q->param($col) ? $q->param($col) : $obj->$col();
    }

    if ( $class->can('class_label') ) {
        $param{object_label} = $class->class_label;
    }
    if ( $class->can('class_label_plural') ) {
        $param{object_label_plural} = $class->class_label_plural;
    }
    $param{links} = ( $id && $obj->links )
        ? objToJson(

        [   map {
                my $link = $_->link;
                $link =~ s/"/\\"/g;
                my $name = $_->name;
                $name =~ s/"/\\"/g;
                my $description = $_->description;
                $description =~ s/"/\\"/g;
                my $order = $_->order;
                {   id   => $_->id,
                    link => $link,
                    name => $name,
                    desc => $description,
                    order => $order
                }
                } $obj->links
        ]
        )
        : '[]';
    $param{links} =~ s/'/\\'/g;

    $param{saved} = $app->param('saved');

    $app->build_page( $tmpl, \%param );
}

sub widget {
    my $app     = shift;
    my $blog_id = $app->param('blog_id');

    require MT::Blog;
    my $blog = MT::Blog->load($blog_id) or return $app->error("Unknown blog");

    return $app->error('Insufficient permissions to create a widget')
        unless ( &check_permissions( $app, 'can_edit_templates' ) );

    require MT::Template;
    MT::Template->set_by_key(
        { blog_id => $blog_id, type => 'widget', name => 'LinkBox' },
        {   text => q(<div class="module">
<h2 class="module-header">Links</h2>
<div class="module-content">
<MTLinkBox>
</div>
</div>),
        }
    );

    $app->redirect(
        $app->mt_uri(
            mode => 'list',
            args => {
                blog_id      => $blog_id,
                _type        => 'template',
                tab          => 'module',
                filter_key   => 'widget_templates',
                widget_saved => 1
            }
        )
    );
}

sub check_permissions {
    my ( $app, $right ) = @_;
    $right = 'can_publish_post' unless $right;
    require MT::Author;
    my $author = $app->user;

    # these are per-blog permissions that are required.  If you are have
    # administrative privileges, your blog_id=0 in your permissions row.

    # first see if you are a system-wide admin.
    my $sys_wide_perms = MT::Permission->load(
        {   blog_id   => 0,
            author_id => $author->id
        }
    );

    if (    $sys_wide_perms
        and $sys_wide_perms->can_administer )
    {
        return 1;
    }

    my $perms = MT::Permission->load(
        {   blog_id   => $app->param('blog_id'),
            author_id => $author->id
        }
    );

    if ( $perms and ( $right eq 'can_publish_post' ) ) {
        return $perms->can_publish_post;
    }
    elsif ( $perms and ( $right eq 'can_edit_templates' ) ) {
        return $perms->can_edit_templates;
    }
    else {
        return 0;
    }
}

sub rebuild_linkbox_template {
    my $app = shift;
    my ($blog_id) = @_;

    require MT::Template;
    my $tmpl
        = MT::Template->load(
        { blog_id => $blog_id, type => 'index', outfile => 'linkbox.js' } )
        or return;
    $app->rebuild_indexes(
        BlogID   => $blog_id,
        Template => $tmpl,
        Force    => 1,
    );
}

sub post_save_list {
    my ( $cb, $app, $obj, $original ) = @_;

    my $links     = $app->param('links');
    my $new_links = $app->param('new_links');

    if ($links) {
        my $links_obj = jsonToObj($links);
        require LinkBox::Link;
    LINK:
        foreach my $link (@$links_obj) {
            if ( $link->{dirty} ) {

                # Something changed!
                if ( $link->{remove} ) {

 # If there's the remove flag *and* id is greater than 0 (i.e., existing link)
 # nix it!
                    LinkBox::Link->remove( { id => $link->{id} } );
                }
                else {

                    # No remove flag, and it's dirty, so it's new or changed
                    my $l = LinkBox::Link->load( $link->{id} ) or next LINK;
                    $l->name( $link->{name} );
                    $l->order( $link->{order} );
                    $l->link( $link->{link} );
                    $l->description( $link->{desc} );

                    $l->save or die "Error saving link: ", $l->errstr;
                }
            }
        }
    }
    if ($new_links) {
        my $links_obj = jsonToObj($new_links);
        require LinkBox::Link;
    LINK:
        foreach my $link (@$links_obj) {
            my $l = LinkBox::Link->new;
            $l->linkbox_list_id( $obj->id );
            $l->name( $link->{name} );
            $l->order( $link->{order} );
            $l->link( $link->{link} );
            $l->description( $link->{desc} );

            $l->save or die "Error saving link: ", $l->errstr;
        }
    }

    # Rebuild stuff too, now that we've saved any updates
    rebuild_linkbox_template( $app, $obj->blog_id );

    1;
}

## This is a callback handler for blog_template_set_change
## It looks for a predefined link list and makes it available
## when the template set has changed.
sub ts_change {
    my ($cb, $param) = @_;
    my $blog = $param->{blog} or return;
    my $ts = $blog->template_set;
    return undef unless $ts;

    my $plugin = MT->component('LinkBox');
    my $reg = MT->registry('template_sets')->{$ts}->{linklists};
    foreach (keys %$reg) {
        next if $_ eq 'plugin';
            unless ($reg->{$_}->{label}) {
                MT->log({
                    blog_id => $blog->id,
                    level => MT->model('log')->INFO(),
                    message => $plugin->translate('Link list with key [_1] missing label attribute. The config.yaml file for [_2] needs to be corrected.', $_, $ts)
                });
                next;
            }
        my $list = MT->model('linkbox_list')->load( { name => $reg->{$_}->{label}(), blog_id => $blog->id });
        if (!$list) {
            $list = MT->model('linkbox_list')->new();
            $list->name( $reg->{$_}->{label}() );
            $list->blog_id( $blog->id );
            $list->order ( $reg->{$_}->{order} ? $reg->{$_}->{order} : 0 );
            $list->save() or die $list->errstr;

            my $links = $reg->{$_}->{links};
            if ($links) {
                foreach my $key (keys %$links) {
                    next if $key eq 'plugin';
                    my $link = $links->{$key};
                    unless ( $link->{url} ) {
                        MT->log({
                            blog_id => $blog->id,
                            level => MT->model('log')->INFO(),
                            message => $plugin->translate('A link with the key [_1] from link set [_2] was missing its url attribute. The config.yaml file for [_3] needs to be corrected.', $key, $list->name, $ts)
                        });
                        next;
                    }
                    unless ( $link->{label} ) {
                        MT->log({
                            blog_id => $blog->id,
                            level => MT->model('log')->INFO(),
                            message => $plugin->translate('A link with the key [_1] from link set [_2] was missing its label attribute. The config.yaml file for [_3] needs to be corrected.', $key, $list->name, $ts)
                        });
                        next;
                    }
                    my $l = MT->model('linkbox_link')->new();
                    $l->linkbox_list_id( $list->id );
                    $l->name( $link->{label}() );
                    $l->description( $link->{description} );
                    $l->link( $link->{url} );
                    $l->order( $link->{order} || 0 );
                    $l->save();
                }
            }
        }
    }
}

sub save_list_order {
    my ($app) = @_;
    my $q = $app->query;
    my $json = $q->param('json');
    
    use JSON;
    my $obj = JSON::from_json( $json );
    my @lls = MT->model('linkbox_list')->load({ blog_id => $app->blog->id });
    foreach (@lls) {
        $_->order( $obj->{$_->id} );
        $_->save || $app->log({message => $_->errstr});
    }    
}

1;
