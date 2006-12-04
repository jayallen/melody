<?php
function smarty_function_MTAssetFileExt($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    return $asset['asset_file_ext'];
}
?>

