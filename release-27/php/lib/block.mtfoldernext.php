<?php
# Movable Type (r) Open Source (C) 2001-2008 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

require_once('block.mtcategorynext.php');
function smarty_block_mtfoldernext($args, $content, &$ctx, &$repeat) {
    $args['clas'] = 'folder';
    return smarty_block_mtcategorynext($args, $content, $ctx, $repeat);
}
?>
