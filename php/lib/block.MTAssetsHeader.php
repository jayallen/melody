<?php
function smarty_block_MTAssetsHeader($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $counter = $ctx->stash('_assets_counter');
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, $counter == 1);
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
