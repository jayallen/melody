<?php
function smarty_function_MTEntryAuthor($args, &$ctx) {
    // status: complete
    // parameters: none
    $entry = $ctx->stash('entry');
    return $entry['author_name'];
}
?>
