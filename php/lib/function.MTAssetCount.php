<?php
function smarty_function_MTAssetCount($args, &$ctx) {
    $args['blog_id'] = $ctx->stash('blog_id');
    $assets = $ctx->mt->db->fetch_assets($args);
    return count($assets);
}
