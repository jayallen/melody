<?php
function smarty_block_MTAssetIsLastInRow($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, $ctx->stash('asset_last_in_row'));
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
