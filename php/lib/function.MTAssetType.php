<?php
function smarty_function_MTAssetType($args, &$ctx) {
    global $mt;
    $lang = $mt->config['DefaultLanguage'];
    if (!preg_match('/^en/i', $lang))
        @require_once("l10n_$lang.php");
    else
        @require_once("l10n_en.php");

    $asset = $ctx->stash('asset');
    if (!$asset) return '';

    return translate_phrase($asset['asset_class']);
}
?>

