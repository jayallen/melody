<?php
function smarty_block_MTEntryNext($args, $content, &$ctx, &$repeat) {
    static $_next_cache = array();
    if (!isset($content)) {
        # save all values, to be restored when we're done...
        $ctx->localize(array('entry', 'conditional', 'else_content'));
        $entry = $ctx->stash('entry');
        if ($entry) {
            $entry_id = $entry['entry_id'];
            if (isset($_next_cache[$entry_id])) {
                $next_entry = $_next_cache[$entry_id];
            } else {
                $ts = $entry['entry_created_on'];
                $blog_id = $entry['entry_blog_id'];
                $args = array('not_entry_id' => $entry['entry_id'],
                              'blog_id' => $blog_id,
                              'lastn' => 1,
                              'sort_order' => 'ascend',
                              'current_timestamp' => $ts);
                list($next_entry) = $ctx->mt->db->fetch_entries($args);
                if ($next_entry) $_next_cache[$entry_id] = $next_entry;
            }
            $ctx->stash('entry', $next_entry);
        }
        $ctx->stash('conditional', isset($next_entry));
        $ctx->stash('else_content', null);
    } else {
        if (!$ctx->stash('conditional')) {
            $content = $ctx->stash('else_content');
        }
        $ctx->restore(array('entry', 'conditional', 'else_content'));
    }
    return $content;
}
?>
