<?php
# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

function smarty_modifier_sanitize($text, $spec) {
    if ($spec == '1') {
        global $mt;
        $ctx =& $mt->context();
        $blog = $ctx->stash('blog');
        $spec = $blog['blog_sanitize_spec'];
        $spec or $spec = $mt->config('GlobalSanitizeSpec');
    }
    require_once("sanitize_lib.php");
    return sanitize($text, $spec);
}
?>
