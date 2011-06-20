
function dirify_blog_name(fld) {
    var dir_blog_name = dirify(fld.value);
    if (!dir_blog_name.length) return;
    var url = fld.form['site_url'];
    var path = fld.form['site_path'];
    /* detect linux/mac or windows path separator */
    var slash = mt.screen.orig_site_path.match( /(\\|\/)/ )[ 0 ];
    var basic_site_url = mt.screen.orig_site_url.replace(/\/BLOG-NAME\/$/, '/');
    var basic_site_path = mt.screen.orig_site_path.replace(/(\/|\\)BLOG-NAME(\/|\\)?$/, slash);
    if (basic_site_url && (url.value.indexOf(basic_site_url) == 0))
        url.value = basic_site_url + dir_blog_name + '/';
    if (basic_site_path && (path.value.indexOf(basic_site_path) == 0))
        path.value = basic_site_path + dir_blog_name;
}

function validate (f) {
    if (mt.screen.can_edit_config && !f.name.value) {
        alert(mt.screen.trans.SET_BLOG_NAME);
        return false;
    } else if (mt.screen.can_edit_config && f.server_offset.value == '') {
        alert(mt.screen.trans.SET_TIMEZONE);
        return false;
    } else if (mt.screen.can_edit_config && mt.screen.can_set_publishing_paths && !f.site_path.value) {
        alert(mt.screen.trans.SET_LOCAL_PATH);
        return false;
    } else if (!f.site_url.value) {
        alert(mt.screen.trans.SET_SITE_URL);
        return false;
    } else if (f.server_offset.value == '') {
        alert(mt.screen.trans.SELECT_TIMEZONE);
        return false;
    } else if (!is_valid_url(f.site_url.value)){
        alert(mt.screen.trans.INVALID_SITE_URL);
        return false;
    } else if (checkUrlSpaces(f.site_url.value)){
        alert(mt.screen.trans.NOSPACES_SITE_URL);
        return false;
    } else if (checkPathSpaces(f.site_path.value)){
        alert(mt.screen.trans.NOSPACES_LOCAL_PATH);
        return false;
    } else if (!is_valid_path(f.site_path.value)){
        alert(mt.screen.trans.INVALID_SITE_PATH);
        return false;
</mt:if>
    }
    return true;
}

function checkUrlSpaces(url_){
    if (url_.match(/\s+/)){
        return true;
    }
}
function is_valid_url(url_){
    return url_.match( /^https?:\/\/[A-Za-z0-9!$%()=_.:,;@~-]+/ );
}
function checkPathSpaces(path_){
    if (path_.match(/\s+/)){
        return true;
    }
}
function is_valid_path(path_){
    for(i = 0; i < path_.length; i++){
        var buf = escape(path_.substr(i, 1));
        if (buf.match(/^%u.*/)){
            return false;
        }
        if (buf.match(/(%.{2}){2}?/)){
            return false;
        }
    }
    return true;
}

jQuery(document).ready( function($) {
    if (mt.screen.new_object) {
        getByID("name").focus();
    }
}