<?php
function smarty_function_MTBlogPingCount($args, &$ctx) {
    $args['blog_id'] = $ctx->stash('blog_id');
    return $ctx->mt->db->blog_ping_count($args);
}
?>
