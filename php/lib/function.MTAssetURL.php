<?php
function smarty_function_MTAssetURL($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    return $asset['asset_url'];
}
?>

