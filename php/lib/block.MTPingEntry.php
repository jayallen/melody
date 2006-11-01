<?php
function smarty_block_MTPingEntry($args, $content, &$ctx, &$repeat) {
    $localvars = array('entry', 'current_timestamp', 'modification_timestamp');
    if (!isset($content)) {
        $ping = $ctx->stash('ping');
        if (!$ping) { $repeat = false; return ''; }
        $entry_id = $ping['trackback_entry_id'];
        if (!$entry_id) { $repeat = false; return ''; }
        $entry = $ctx->mt->db->fetch_entry($entry_id);
        if (!$entry) { $repeat = false; return ''; }
        $ctx->localize($localvars);
        $ctx->stash('entry', $entry);
        $ctx->stash('current_timestamp', $entry['entry_created_on']);
        $ctx->stash('modification_timestamp', $entry['entry_modified_on']);
    } else {
        $ctx->restore($localvars);
    }
    return $content;
}
?>
