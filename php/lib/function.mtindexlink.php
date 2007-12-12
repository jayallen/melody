<?php
function smarty_function_mtindexlink($args, &$ctx) {
    $tmpl = $ctx->stash('index_templates');
    $counter = $ctx->stash('index_templates_counter');
    $idx = $tmpl[$counter];
    if (!$idx) return '';

    $blog = $ctx->stash('blog');
    $site_url = $blog['blog_site_url'];
    if (!preg_match('!/$!', $site_url)) $site_url .= '/';
    $link = $site_url . $idx['template_outfile'];
    if (!$args['with_index']) {
        $link = _strip_index($link, $blog);
    }
    return $link;
}
?>
