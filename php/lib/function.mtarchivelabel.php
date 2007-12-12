<?php
# Movable Type (r) Open Source (C) 2001-2007 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$

require_once("archive_lib.php");
function smarty_function_mtarchivelabel($args, &$ctx) {
    global $_archivers;
    $at = $ctx->stash('current_archive_type');
    if (isset($args['type'])) {
        $at = $args['type'];
    } elseif (isset($args['archive_type'])) {
        $at = $args['archive_type'];
    }
    if (isset($_archivers[$at])) {
        return $_archivers[$at]->get_label($args, $ctx);
    } else {
      return $at;
    }
}
?>
