<?php
require_once("block.mtassets.php");
function smarty_block_mtpageassets($args, $content, &$ctx, &$repeat) {
    return smarty_block_mtassets($args, $content, $ctx, $repeat);
}
?>
