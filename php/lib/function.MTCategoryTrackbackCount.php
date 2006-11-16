<?php
function smarty_function_MTCategoryTrackbackCount($args, &$ctx) {
    $cat = $ctx->stash('category');
    $cat_id = $cat['category_id'];
    return $ctx->mt->db->category_ping_count($cat_id);
}
?>