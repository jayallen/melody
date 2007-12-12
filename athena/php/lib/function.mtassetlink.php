<?php
require_once("function.mtasseturl.php");
function smarty_function_mtassetlink($args, &$ctx) {
    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    $target = "";
    $link = "";
    if (isset($args['new_window']))
        $target = " target=\"_blank\"";

    $url = smarty_function_mtasseturl($args, $ctx);

    return sprintf("<a href=\"%s\"%s>%s</a>",
        $url,
        $target,
        $asset['asset_file_name']);
}
?>

