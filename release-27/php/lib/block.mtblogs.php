<?php
# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

function smarty_block_mtblogs($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $ctx->localize(array('_blogs', '_blogs_counter', 'blog', 'blog_id'));
        $blogs = $ctx->mt->db->fetch_blogs($args);
        $ctx->stash('_blogs', $blogs);
        $counter = 0;
    } else {
        $blogs = $ctx->stash('_blogs');
        $counter = $ctx->stash('_blogs_counter');
    }
    if ($counter < count($blogs)) {
        $blog = $blogs[$counter];
        $ctx->stash('blog', $blog);
        $ctx->stash('blog_id', $blog['blog_id']);
        $ctx->stash('_blogs_counter', $counter + 1);
        $repeat = true;
    } else {
        $ctx->restore(array('_blogs', '_blogs_counter', 'blog', 'blog_id'));
        $repeat = false;
    }
    return $content;
}
?>
