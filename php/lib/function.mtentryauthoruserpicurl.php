<?php
function smarty_function_mtentryauthoruserpicurl($args, &$ctx) {
    $entry = $ctx->stash('entry');
    if (!$entry) return '';

    $author = $ctx->mt->db->fetch_author($entry['entry_author_id']);
    if (!$author) return '';

    $asset_id = isset($author['author_userpic_asset_id']) ? $author['author_userpic_asset_id'] : 0;
    $asset = $ctx->mt->db->fetch_assets(array('id' => $asset_id));
    if (!$asset) return '';

    $blog =& $ctx->stash('blog');

    require_once("MTUtil.php");
    $userpic_url = userpic_url($asset[0], $blog, $author);
    return $userpic_url;
}
?>
