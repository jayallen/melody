<?php
function smarty_function_MTAssetAddedBy($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    if ($asset['author_nickname'] != '')
        return $asset['author_nickname'];

    return $asset['author_name'];
}
?>

