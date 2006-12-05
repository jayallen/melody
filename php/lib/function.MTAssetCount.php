<?php
function smarty_function_MTAssetCount($args, &$ctx) {
    $args['blog_id'] = $ctx->stash('blog_id');
    $count = $ctx->mt->db->asset_count($args);
    return $count;
}
