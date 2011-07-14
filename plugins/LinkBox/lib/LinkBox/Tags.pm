package LinkBox::Tags;
use strict;

sub _hdlr_linkbox {
    my ( $ctx, $args, $cond ) = @_;
    my $blog_id = $ctx->stash("blog_id");

    my $name = $args->{name};
    my ( %terms, %args );
    $terms{blog_id} = $blog_id;
    $terms{name} = $name if ($name);

    # in case name isn't specified, just grab the latest one
    $args{sort}      = 'modified_on';
    $args{direction} = 'descend';
    $args{limit}     = 1;

    my $list = LinkBox::LinkList->load( \%terms, \%args );
    return $ctx->error("Unable to find linkbox list") unless ($list);
    my @links = $list->links;

    #get settings
    my $settings
      = MT->component('LinkBox')->get_config_hash( 'blog:' . $blog_id );
    my $liststyle = $args->{list_style} || $settings->{liststyle};
    my $sortorder = $args->{sort_order} || $settings->{sortorder};

    my $out = "";

    if ( $sortorder && $sortorder eq "alpha" ) {
        @links = sort { $a->name cmp $b->name } @links;
    }
    $out = "<$liststyle class=\"linkbox\">\n";
    for my $l (@links) {
        $out
          .= "<li><a href=\"" . $l->link . "\">" . $l->name . "</a></li>\n";
    }
    $out .= "</$liststyle>\n";

    return $out;
} ## end sub _hdlr_linkbox

sub _hdlr_linkbox_iterator {
    my ( $ctx, $args, $cond ) = @_;
    my $blog_id = $ctx->stash("blog_id");
    my $list;

    unless ( $list = $ctx->stash('linkbox_list') ) {
        my $name = $args->{name};
        my ( %terms, %args );
        $terms{blog_id} = $blog_id;
        $terms{name} = $name if ($name);

        # in case name isn't specified, just grab the latest one
        $args{sort}      = 'modified_on';
        $args{direction} = 'descend';
        $args{limit}     = 1;

        $list = LinkBox::LinkList->load( \%terms, \%args );
    }

    return $ctx->error("Unable to find linkbox list") unless ($list);
    my @links = $list->links;
    my $settings
      = MT->component('LinkBox')->get_config_hash( 'blog:' . $blog_id );
    my $sortorder = $args->{sort_order} || $settings->{sortorder};

    if ( $sortorder && $sortorder eq "alpha" ) {
        @links = sort { $a->name cmp $b->name } @links;
    }
    my $builder = $ctx->stash('builder');
    my $tokens  = $ctx->stash('tokens');
    my $out     = "";
    for my $l (@links) {
        local $ctx->{__stash}{linkbox_link_id}          = $l->id;
        local $ctx->{__stash}{linkbox_link_name}        = $l->name;
        local $ctx->{__stash}{linkbox_link_link}        = $l->link;
        local $ctx->{__stash}{linkbox_link_description} = $l->description;

        $out .= $builder->build( $ctx, $tokens, $cond );
    }
    return $out;
} ## end sub _hdlr_linkbox_iterator

sub _hdlr_linkbox_link_url {
    return $_[0]->stash('linkbox_link_link');
}

sub _hdlr_linkbox_link_name {
    return $_[0]->stash('linkbox_link_name');
}

sub _hdlr_linkbox_link_description {
    return $_[0]->stash('linkbox_link_description');
}

sub _hdlr_link_boxes {
    my ( $ctx, $args, $cond ) = @_;

    my $blog_id = $ctx->stash('blog_id');
    require LinkBox::LinkList;
    my @lists = LinkBox::LinkList->load( { blog_id => $blog_id },
                                  { sort => 'name', direction => 'ascend' } );

    my $res = '';
    for my $list (@lists) {
        local $ctx->{__stash}{linkbox_list}      = $list;
        local $ctx->{__stash}{linkbox_list_name} = $list->name;

        defined( my $out = $ctx->slurp( $args, $cond ) )
          or return $ctx->error( $ctx->errstr );
        $res .= $out;
    }

    $res;
} ## end sub _hdlr_link_boxes

sub _hdlr_link_box_name {
    return $_[0]->stash('linkbox_list_name');
}

1;

