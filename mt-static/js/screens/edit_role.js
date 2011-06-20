function toggleAndUncheck(obj, target) {
    if (!obj || !target) {
        return;
    }

    var targetObj = getByID(target);
    if (!targetObj) {
        return;
    }

    if (obj.disabled) {
        targetObj.disabled = true;
    } else {
        targetObj.disabled = !obj.checked;
    }
    if (!obj.checked) {
        targetObj.checked = false;
    }
}

function toggleAndDisable(obj, target) {
    if (!obj || !target) {
        return;
    }

    var targetObj = getByID(target);
    if (!targetObj) {
        return;
    }

    if (obj.checked) {
        targetObj.checked = true;
        targetObj.disabled = true;
    } else {
        targetObj.disabled = false;
        // targetObj.checked = true;
    }
}

function on_edit_config_changed(obj) {
    toggleAndUncheck(obj, 'permission-set_publish_paths');
}

function on_create_post_changed(obj) {
    toggleAndUncheck(obj, 'permission-publish_post');
    var eap = getByID('permission-edit_all_posts');
    if (eap && eap.checked) {
        return;
    }
    toggleAndUncheck(obj, 'permission-send_notifications');
}

function on_edit_all_posts_changed(obj) {
    var cp = getByID('permission-create_post');
    if (cp && cp.checked) {
        return;
    }
    toggleAndUncheck(obj, 'permission-send_notifications');
}

function on_edit_assets_changed(obj) {
    toggleAndDisable(obj, 'permission-upload');
    getByID("permission-save_image_defaults").disabled = false;
}

function on_upload_changed(obj) {
    if (getByID("permission-edit_assets").checked)
        return;
    toggleAndUncheck(obj, 'permission-save_image_defaults');
}

var permsChanged = "no";
function checkPerms(obj) { 
    permsChanged = "yes";
    var name = 'on_' + obj.value + '_changed';
    if ('function' == typeof(window[name])) {
        window[name](obj);
    }
}
function permsUnChanged() { permsChanged = "no"; } 

function doSubmitFormConfirm( f, mode, message ) {
    if (confirm(message)) {
        if (f.elements["__mode"] && mode)
            f.elements["__mode"].value = mode;
        f.submit();
    }
    return false;
}

function checkChanged() {
    var orig_roleName = mt.screen.name;
    var roleName = getByID('name').value;
    if(permsChanged == "yes") {
        if(roleName == orig_roleName) {
            return doSubmitFormConfirm(document.role, 'save_role', mt.screen.trans.CHANGED_PRIVS); 
        } else {
            doSubmitForm(document.role, 'save_role');
        }
    } else {
        doSubmitForm(document.role, 'save_role');
    }
    return false;
}

function allPerms(name, check) {
    var f = document.forms['role'];
    var flds = f[name];
    for (var i = 0; i < flds.length; i++) {
        flds[i].checked = check;
        if (!flds[i].className.match(/administer_blog/))
            flds[i].disabled = check;
    }
    return false;
}

function getParentByClass(n, c) {
    var result = n;
    while (!result.className.match(c)
           && result.nodeName && (result.nodeName != 'body')) {
       result = result.parentNode;
    }
    return result;
}

function rectify(permContainer, forcibly) {
    var permCheckboxes = permContainer.getElementsByTagName('input');
    for (var i=0; i < permCheckboxes.length; i++) {
        if (permCheckboxes[i].className.match(/administer_blog/)) {
            isAdmin = permCheckboxes[i].checked;
        }
    }
    for (var i=0; i < permCheckboxes.length; i++) {
        if (!permCheckboxes[i].className.match(/administer_blog/)) {
            if (isAdmin) {
                permCheckboxes[i].disabled = true;
                permCheckboxes[i].checked = true;
            } else {
                if (forcibly) {
                    permCheckboxes[i].disabled = false;
                    permCheckboxes[i].checked = false;
                } else {
                    checkPerms(permCheckboxes[i]);
                }
            }
        }
    }
    if (forcibly) {
        for (var i=0; i < permCheckboxes.length; i++) {
            checkPerms(permCheckboxes[i]);
        }
    }
}

function handleClick(e) {
    e = e || event;
    var targ = e.target || e.srcElement;
    if (!targ || !targ.nodeName) {
        return;
    }
    if (targ.nodeName.toLowerCase() == 'label') {
        if (targ.getAttribute('for'))
            targ = getByID(targ.getAttribute('for'));
        else {
           var inputs = targ.getElementsByTagName('input');
           targ = inputs[0];
           checkPerms(targ);
        }
    }
    if (targ.className.match(/administer_blog/)) {
        permContainer = getParentByClass(targ, 'permission-list');
        rectify(permContainer, 1);
    }
}

jQuery(document).ready( function($) {
    var containers = TC.getElementsByClassName('permission-list');
    for (var i=0; i < containers.length; i++) {
        rectify(containers[i]);
    }
    permsUnChanged();
});
