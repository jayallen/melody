<?php
function smarty_block_MTAssetIfTagged($args, $content, &$ctx, &$repeat) {
    if (!isset($content)) {
        $asset = $ctx->stash('asset');
        if ($asset) {
            $asset_id = $asset['asset_id'];
            $tag = $args['tag'];
            $targs = array('asset_id' => $asset_id);
            if ($tag && (substr($tag,0,1) == '@')) {
                $targs['include_private'] = 1;
            }
            $tags = $ctx->mt->db->fetch_asset_tags($targs);
            if ($tag && $tags) {
                $has_tag = 0;
                foreach ($tags as $row) {
                    $row_tag = $row['tag_name'];
                    if ($row_tag == $tag) {
                        $has_tag = 1;
                        break;
                    }
                }
            } else {
                $has_tag = count($tags) > 0;
            }
        }
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat, $has_tag);
    } else {
        return $ctx->_hdlr_if($args, $content, $ctx, $repeat);
    }
}
?>
