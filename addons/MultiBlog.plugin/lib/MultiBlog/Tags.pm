# Movable Type (r) Open Source (C) 2006-2009 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

# Original Copyright (c) 2004-2006 David Raynes

package MultiBlog::Tags;

use strict;
use warnings;

###########################################################################

=head2 MultiBlog

Container tag that wraps the tags inside of it inside loop which covers multiple blogs.

B<Example:>
<mt:MultiBlog include_blogs="1">
    <mt:Entries category="Releases" lastn="4">
         <$mt:EntryTitle$>
    </mt:Entries>
</mt:MultiBlog>

Include the last 4 entries from the category "Releases" in blog with the ID of 1


B<Example:>
<ul>
<MTMultiBlog include_blogs="1,2,3,4,5,6">
    <li><$mt:BlogName$>
         <ul>
    <mt:Entries lastn="4">
         <li><a href="<$mt:EntryPermalink$>"><$mt:EntryTitle$></a></li>
    </mt:Entries>
         </ul>
    </li>
</MTMultiBlog>
</ul>

Print a nested ordered list that shows a blog's name and then the last four entries
for the blogs with IDs 1 through 6.

=cut

###########################################################################

=head2 OtherBlog

An alias for the MultiBlog tag. This is tag is in place only to support a transition
from older versions of Movable Type which used the "OtherBlog" plugin. OtherBlog was
the predecessor to the MultiBlog feature/plugin. It is recommended that any new template
be designed using the MultiBlog tag instead this one, and that anyone using OtherBlog
should plan to use MultiBlog instead (no loss of functionality should occur).

=cut

sub MultiBlog {
    my $plugin = MT->component('MultiBlog');
    my ( $ctx, $args, $cond ) = @_;
	MT->log({message => $plugin});
    return $ctx->error($plugin->translate('MTMultiBlog tags cannot be nested.'))
        if $ctx->stash('multiblog_context');

    # Set default mode for backwards compatibility
    $args->{mode} ||= 'loop';

    # If MTMultiBlog was called with no arguments, we check the 
    # blog-level settings for the default includes/excludes.
    unless (   $args->{blog_ids} 
            || $args->{include_blogs} 
            || $args->{exclude_blogs} ) {
        my $id = $ctx->stash('blog_id');
        my $is_include = $plugin->get_config_value( 
                'default_mtmultiblog_action', "blog:$id" );
        my $blogs = $plugin->get_config_value( 
                'default_mtmulitblog_blogs', "blog:$id" );

        if ($blogs && defined($is_include)) {
            $args->{$is_include ? 'include_blogs' : 'exclude_blogs'} = $blogs;
        } 
        # No blog-level config set
        # Set mode to context as this will mimic no MTMultiBlog tag
        else {
            $args->{'mode'} = 'context';  # Override 'loop' mode
        }
    }

    # Filter MultiBlog args through access controls
    require MultiBlog;
    if ( ! MultiBlog::filter_blogs_from_args($plugin, $ctx, $args) ) {
        return $ctx->errstr ? $ctx->error($ctx->errstr) : '';
    }

    # Run MultiBlog in specified mode
    my $res;
    if ( $args->{mode} eq 'loop') {
        $res = loop($plugin, @_);
    } elsif ( $args->{mode} eq 'context') {
        $res = context($plugin, @_);
    } else {
        # Throw error if mode is unknown
        $res = $ctx->error(
                $plugin->translate(
                    'Unknown "mode" attribute value: [_1]. '
                      . 'Valid values are "loop" and "context".',
                    $args->{mode}
                )
            );
    }
    # Remove multiblog_context and blog_ids
    $ctx->stash('multiblog_context', '');
    $ctx->stash('multiblog_blog_ids', '');
    return defined($res) ? $res : $ctx->error($ctx->errstr);
}

###########################################################################

=head2 MultiBlogLocalBlog

A container tag that sets the immediate context inside of it to the local blog that
is being published. 

B<Example:>
<$mt:BlogID setvar="exclude_me"$>
<mt:MultiBlog exclude_blogs="$exclude_me">
    <mt:If name="__first__">
        <ul>
    </mt:If>

    <li <mt:MultiBlogIfLocalBlog>class="local_blog"</mt:MultiBlogIfLocalBlog>>
        <a href="<$mt:BlogURL$>"><$mt:BlogName$></a> recent updates:
        <ul>
        <mt:Entries lastn="3">
            <a href="<$mt:EntryPermalink$>"><$mt:EntryTitle$></a>
        </mt:Entries>
        </ul>
    </li>

    <mt:If name="__last__">
        </ul>
        <mt:MultiBlogLocalBlog>
            <a href="<$mt:BlogURL$>">&larr; Go Home</a>
        </mt:MultiBlogLocalBlog>
    </mt:If>
</mt:MultiBlog>

Generate a list of all of the blogs, excluding the current one, and their most recent
updates, and then put a link to the main index of the current blog right after the list.

=cut

sub MultiBlogLocalBlog {
    my $plugin = MT->component('MultiBlog');
    MT->log({message => $plugin});
    my ( $ctx, $args, $cond ) = @_;

    require MT::Blog;
    my $blog_id       = $ctx->stash('blog_id');
    my $local_blog_id = $ctx->stash('local_blog_id');

    if ($local_blog_id) {
        $ctx->stash( 'blog_id', $local_blog_id );
        $ctx->stash( 'blog',    MT::Blog->load($local_blog_id) );
    }

    my $builder = $ctx->stash('builder');
    my $tokens  = $ctx->stash('tokens');

    my $out = $builder->build( $ctx, $tokens )
      or return $ctx->error( $builder->errstr );

    if ($local_blog_id) {
        $ctx->stash( 'blog_id', $blog_id );
        $ctx->stash( 'blog',    MT::Blog->load($blog_id) );
    }

    $out;
}

###########################################################################

=head2 MultiBlogIfLocalBlog

A conditional tag that will test for whether or not the local blog is the one currently
in context inside of a MultiBlog tag.

B<Example:>
<MTMultiBlog include_blogs="1,2,3">
    <MTEntries category="Releases" lastn="4">
         <$MTEntryTitle$>
    </MTEntries>
    <MT MultiBlogIfLocalBlog>
        <$MTBlogID$> is the local blog!
    </MTMultiBlogIfLocalBlog>
</MTMultiBlog>

That will output the ID of the local blog along with the string "is the local blog!" when
the MultiBlog loop reaches the local blog.

<mt:MultiBlog include_blogs="all">
    <mt:If name="__first__">
        <ul>
    </mt:If>

    <li <mt:MultiBlogIfLocalBlog>class="local_blog"</mt:MultiBlogIfLocalBlog>>
        <a href="<$mt:BlogURL$>"><$mt:BlogName$></a>
    </li>

    <mt:If name="__last__">
        </ul>
    </mt:If>

</mt:MultiBlog>

That will generate a list of blogs, spanning the entire installation of Melody, with
a specially CSS attribute, local_blog, applied to the list item that corresponds to the local
blog.

=cut

sub MultiBlogIfLocalBlog {
    my $plugin = MT->component('MultiBlog');
    MT->log({message => $plugin});
    my $ctx = shift;
    my $local = $ctx->stash('local_blog_id');
    my $blog_id = $ctx->stash('blog_id');
    defined( $local ) 
        and defined( $blog_id ) 
        and $blog_id == $local;
}

## Supporting functions for 'MultiBlog' tag:

# Multiblog's "context" mode:
# The container's contents are evaluated once with a multi-blog context
sub context {
    my $plugin = shift;
    my ( $ctx, $args, $cond ) = @_;

    # Assuming multiblog context, set it.
    if ($args->{include_blogs} || $args->{exclude_blogs}) {
        my $mode = $args->{include_blogs} ? 'include_blogs' 
                                          : 'exclude_blogs';
        $ctx->stash('multiblog_context', $mode);
        $ctx->stash('multiblog_blog_ids', join ( ',', $args->{$mode} ));
    } 

    # Evaluate container contents and return output
    my $builder = $ctx->stash('builder');
    my $tokens = $ctx->stash('tokens');
    my $out = $builder->build( $ctx, $tokens, $cond);
    return defined($out) ? $out : $ctx->error($ctx->stash('builder')->errstr);

}

# Multiblog's "loop" mode:
# The container's contents are evaluated once per specified blog
sub loop {
    my $plugin = shift;
    my ( $ctx, $args, $cond ) = @_;
    my (%terms, %args);

    # Set the context for blog loading
    $ctx->set_blog_load_context($args, \%terms, \%args, 'id')
        or return $ctx->error($ctx->errstr);

    my $builder = $ctx->stash('builder');
    my $tokens  = $ctx->stash('tokens');

    local $ctx->{__stash}{entries} = undef
        if $args->{ignore_archive_context};
    local $ctx->{current_timestamp} = undef
        if $args->{ignore_archive_context};
    local $ctx->{current_timestamp_end} = undef
        if $args->{ignore_archive_context};
    local $ctx->{__stash}{category} = undef
        if $args->{ignore_archive_context};
    local $ctx->{__stash}{archive_category} = undef
        if $args->{ignore_archive_context};

    require MT::Blog;
    $args{'sort'} = 'name';
    $args{direction} = 'ascend';
    my $iter    = MT::Blog->load_iter(\%terms, \%args);
    my $res     = '';
    while (my $blog = $iter->()) {
        local $ctx->{__stash}{blog} = $blog;
        local $ctx->{__stash}{blog_id} = $blog->id;
        $ctx->stash('multiblog_context', 'include_blogs');
        $ctx->stash('multiblog_blog_ids', $blog->id);
        defined(my $out = $builder->build($ctx, $tokens, $cond))
            or return $ctx->error($builder->errstr);
        $res .= $out;
    }
    $res;
}

1;
