<?php
function smarty_function_MTBlogArchiveURL($args, &$ctx) {
    // status: complete
    // parameters: none
    $blog = $ctx->stash('blog');
    $url = $blog['blog_archive_url'];
    if ($url == '') {
        $url = $blog['blog_site_url'];
    }
    if (!preg_match('/\/$/', $url)) $url .= '/';
    return $url;
}
?>
