function reveal_api_password() {
    var pw = getByID("api_password");
    alert(mt.screen.trans.YOUR_PASSWORD + pw.value);
    return false;
}
function tagDelimChoice(sel) {
    if (sel.selectedIndex == 2) {
        show("tag_delim_input");
        var el = getByID("tag_delim_input");
        if (el) el.focus();
    } else {
        hide("tag_delim_input");
    }
}

function togglePerms(c) {
    var p = TC.getElementsByTagAndClassName("input", "subPerm", TC.elementOrId("permission-list"));
    for (var i = 0; i < p.length; i++) {
        var sc = p[i];
        if (c.checked) {
            sc.checked = true;
            sc.disabled = true;
        } else {
            sc.checked = false;
            sc.disabled = false;
        }
    }
}
function passwordResetConfirm() {
    var username = mt.screen.username;
    var email = mt.screen.email;
    if (confirm(mt.screen.trans.RESET_SINGLE)) {
        document.forms['recover'].submit();
    }
}
function toggleDisabled( state ){
    if (state == 1) {
        state = false;
    } else if (state == 2) {
        state = true;
    }
    var elements = TC.getElementsByClassName('state_change');
    for (var i=0; i < elements.length; i++) {
        elements[i].disabled = state;
    }
}
function togglePerms(c) {
    var p = TC.getElementsByTagAndClassName("input", "subPerm", TC.elementOrId("permission-list"));
    for (var i = 0; i < p.length; i++) {
        var sc = p[i];
        if (c.checked) {
            sc.checked = true;
            sc.disabled = true;
        } else {
            sc.checked = false;
            sc.disabled = false;
        }
    }
}

function removeUserpic() {
    var param = '__mode=remove_userpic'
        + '&user_id=' + mt.screen.user_id
        + '&magic_token='+MagicToken;
    var params = { uri: ScriptURI, method: 'POST', arguments: param, load: removedUserpic };
    TC.Client.call(params);
}

function removedUserpic(c) {
    var res = c.responseText;
    if (res != 'success') {
        message = mt.screen.trans.ERROR_REMOVING_USERPIC;
        showMsg(message, 'ajax-message', 'error');
    }

    getByID('userpic_asset_id').value = '0';
    if (!DOM.hasClassName('userpic-preview', 'hidden'))
       toggleHidden('userpic-preview');
    if (!DOM.hasClassName('remove-userpic', 'hidden'))
       toggleHidden('remove-userpic');
    return false
}

jQuery(document).ready( function($) {
    var c = document.forms['profile'].elements['is_superuser'];
    if (c.checked)
        togglePerms(document.forms['profile'].elements['is_superuser']);
});
