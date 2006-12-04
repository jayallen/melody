<?php
function smarty_function_MTAssetType($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    return $asset['asset_class'];
}
?>

