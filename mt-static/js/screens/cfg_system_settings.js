function clearWeblogCloneSource() {
    var el_name = getByID("new_user_template_blog_name");
    var el_id = getByID("new_user_template_blog_id");
    if (el_name && el_id) {
        el_id.value = "";
        el_name.innerHTML = mt.screen.trans.NO_BLOG;
    }
    var el_id_link = getByID("select-blog-link");
    if (el_id_link) {
        el_id_link.innerHTML = mt.screen.trans.SELECT_BLOG;
    }
}
function validate (f) {
    if (f.default_site_url.value && !is_valid_url(f.default_site_url.value)){
        alert(mt.screen.trans.VALID_DEFAULT_SITE_URL);
        return false;
    } else if (f.default_site_root.value && !is_valid_path(f.default_site_root.value)) {
        alert(mt.screen.trans.VALID_SITE_ROOT);
        return false;
    }
    return true;
}
function is_valid_url(url_){
    return url_.match( /^https?:\/\/[A-Za-z0-9!$%()=_.:,;@~-]+/ );
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
function clearNotifyUsers() {
    var el_name = getByID("notify_user_name");
    var el_id = getByID("notify_user_id");
    if (el_name && el_id) {
        el_id.value = "";
        el_name.innerHTML = mt.screen.trans.NONE_SELECTED;
    }
}
