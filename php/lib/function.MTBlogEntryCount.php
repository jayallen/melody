<?php
function smarty_function_MTBlogEntryCount($args, &$ctx) {
    // status: complete
    // parameters: none
    $args['blog_id'] = $ctx->stash('blog_id');
    $count = $ctx->mt->db->blog_entry_count($args);
    return $count;
}
?>
