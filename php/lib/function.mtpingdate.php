<?php
function smarty_function_mtpingdate($args, &$ctx) {
    $p = $ctx->stash('ping');
    $args['ts'] = $p['tbping_created_on'];
    return $ctx->_hdlr_date($args, $ctx);
}
?>
