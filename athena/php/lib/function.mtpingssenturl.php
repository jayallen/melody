<?php
function smarty_function_mtpingssenturl($args, &$ctx) {
    $url = $ctx->stash('ping_sent_url');
    return $url;
}
?>
