<?php
function smarty_block_MTCalendarIfNoEntries($args, $content, &$ctx, &$repeat) {
    return $ctx->_hdlr_if($args, $content, $ctx, $repeat, 'CalendarIfNoEntries');
}
?>
