<?php
function smarty_function_MTAssetID($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    return $asset['asset_id'];
}
?>

