<?php
function smarty_block_MTAssets($args, $content, &$ctx, &$repeat) {
    $localvars = array('_assets', 'asset', 'asset_first_in_row', 'asset_last_in_row');
    $counter = 0;

    if (!isset($content)) {
        $ctx->localize($localvars);
        $blog_id = $ctx->stash('blog_id');
        $args['blog_id'] = $ctx->stash('blog_id');

        $assets = $ctx->mt->db->fetch_assets($args);
        $ctx->stash('_assets', $assets);
    } else {
        $assets = $ctx->stash('_assets');
        $counter = $ctx->stash('_assets_counter');
    }

    if ($counter < count($assets)) {
        $per_row = 1;
        if (isset($args['assets_per_row']))
            $per_row = $args['assets_per_row'];
        $asset = $assets[$counter];
        $ctx->stash('asset',  $asset);
        $ctx->stash('_assets_counter', $counter + 1);
        $ctx->stash('asset_first_in_row', ($counter % $per_row) == 0);
        $ctx->stash('asset_last_in_row', (($counter + 1) % $per_row) == 0);
        if (($counter + 1) >= count($assets))
            $ctx->stash('asset_last_in_row', true);

        $repeat = true;
    } else {
        $ctx->restore($localvars);
        $repeat = false;
    }

    return $content;
}
?>

