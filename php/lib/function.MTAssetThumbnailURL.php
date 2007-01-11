<?php
function smarty_function_MTAssetThumbnailURL($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';
    if ($asset['asset_class'] != 'image') return '';

    require_once('MTUtil.php');

    $width = 0;
    $height = 0;
    $scale = 0;

    if (isset($args['width']))
        $width = $args['width'];
    if (isset($args['height']))
        $height = $args['height'];
    if (isset($args['scale']))
        $scale = $args['scale'];

    list($thumb) = get_thumbnail_file($asset['asset_id'], $asset['asset_file_path'], $width, $height, $scale);
    if ($thumb != '') {
        $thumb = basename($thumb);
        $thumb = ereg_replace($asset['asset_file_name'], $thumb, $asset['asset_url']);
    }

    return $thumb;
}
?>

