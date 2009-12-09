<?php
require_once('commenter_auth_lib.php');

class MixiCommenterAuth extends BaseCommenterAuthProvider {
    function get_key() {
        return 'mixicomment';
    }
    function get_label() {
        return 'mixi Commenter Authenticator';
    }
    function get_logo() {
        return 'plugins/mixiComment/images/signin_mixi.png';
    }
    function get_logo_small() {
        return 'plugins/mixiComment/images/signin_mixi_small.gif';
    }
}

global $_commenter_auths;
$provider = new MixiCommenterAuth();
$_commenter_auths[$provider->get_key()] = $provider;

?>
