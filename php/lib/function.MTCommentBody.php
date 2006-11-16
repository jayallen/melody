<?php
function smarty_function_MTCommentBody($args, &$ctx) {
    $comment = $ctx->stash('comment');
    $text = $comment['comment_text'];

    $blog = $ctx->stash('blog');
    if (!$blog['blog_allow_comment_html']) {
        $text = strip_tags($text);
    }
    $cb = isset($args['convert_breaks']) ? $args['convert_breaks'] : $blog['blog_convert_paras_comments'];
    if ($cb == '1' || $cb == '__default__') {
        $cb = 'convert_breaks';
    }
    if ($cb) {
        if ($ctx->load_modifier($cb)) {
            $mod = 'smarty_modifier_'.$cb;
            $text = $mod($text);
        }
    }
    if ($blog['blog_autolink_urls']) {
        $text = preg_replace('!(^|\s|>)(https?://[^\s<]+)!s', '$1<a href="$2">$2</a>', $text);
    }
    return $text;
}
?>