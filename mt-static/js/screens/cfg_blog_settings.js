function validate (f) {
    if (!f.site_path.value) {
        alert(mt.screen.trans.SET_LOCAL);
        return false;
    } else if (!is_valid_url(f.site_url.value)){
        alert(mt.screen.trans.SET_VALID_SITE_URL);
        return false;
    } else if (!is_valid_path(f.site_path.value)){
        alert(mt.screen.trans.SET_VALID_LOCAL_PATH);
        return false;
    }
    if (f.enable_archive_paths.checked) {
        if (!f.archive_path.value) {
            alert(mt.screen.trans.SET_VALID_PATH);
            return false;
        } else if (!is_valid_url(f.archive_url.value)){
            alert(mt.screen.trans.SET_VALID_ARCHIVE_URL);
            return false;
        } else if (!is_valid_path(f.archive_path.value)){
            alert(mt.screen.trans.SET_VALID_ARCHIVE_PATH);
            return false;
        }
    }
    if (!f.name.value) {
        alert(mt.screen.trans.SET_BLOG_NAME);
        return false;
    } else if (f.server_offset.value == '') {
        alert(mt.screen.trans.SET_TIMEZONE);
        return false;
    }
    f.site_url.disabled = false;
    f.site_path.disabled = false;
    f.archive_path.disabled = false;
    f.archive_url.disabled = false;
    return true;
}
function is_valid_url(url_){
    return url_.match( /^https?:\/\/[A-Za-z0-9!$%()=_.:,;@~-]+/ );
}
function is_valid_path(path_){
    var str = path_.replace(/[ "%<>\[\\\]\^`{\|}~]/g, "");
    str = encodeURI(str);
    if (str.indexOf('%') != -1) {
        return false;
    }
    if (str.match(/\.\./)) {
        return false;
    }
    return true;
}
function doRemoveLicense () {
    document.cfg_form.cc_license.value = '';
    var e = getByID('has-license');
    if (e) e.style.display = 'none';
    e = getByID('no-license');
    if (e) e.style.display = 'block';
}

function setLicense() {
    var w = window.open(mt.screen.creative_commons_url, 'cc', 'width=600,height=650,scrollbars=yes,resizable=no');
    if ( w ) w.focus();
   return false;
}

function disableFields(path1,path2) {
    var url_is = mt.screen.site_url;
    var path_is = mt.screen.site_path;
    if (url_is.match(/BLOG-NAME/)) {
        var daURL = getByID(path1);
        var lock = path1 +"-lock";
        var lock_img = getByID(lock);
        daURL.disabled = false;
        lock_img.style.display = 'none';
    }
    if (path_is.match(/BLOG-NAME/)) {
        var daPath = getByID(path2);
        var lock = path2 +"-lock";
        var lock_img = getByID(lock);
        daPath.disabled = false;
        lock_img.style.display = 'none';
    }
    return;
}

function toggleFile(path) {
    var fld = getByID(path);
    if (fld) {
        fld.disabled = false;
        fld.focus();
        var which_warning = path + "-warning";
        var urlwarn = getByID(which_warning);
        if (urlwarn) urlwarn.style.display = "block";
    }
    var which_lock = path + "-lock";
    var img = getByID(which_lock);
    if (img)
        img.style.display = 'none';
    return false;
}

jQuery(document).ready( function($) {
    // conditionally disables
    disableFields('site_url','site_path');
});

// Event handler for Setup TypePad link on Login & Signup tab
// Switches to Web Services tab
$(function() {
    $('#lnkTypePad').click(function() {
        $('a[title=web-services]').click();
    });
});
