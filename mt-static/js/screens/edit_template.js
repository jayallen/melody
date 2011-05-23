var snippets = mt.screen.snippets;

if ( !window.Editor )
    Editor = { strings: {} };

Editor.strings.unsavedChanges = mt.screen.trans.UNSAVED_CHANGES; 

var fieldStorage = {};
var dirty = false;
function setDirty () {
    log.warn('deprecated function setDirty(), call app.setDirty instead');
    app.setDirty();
}
function clearDirty () {
    log.warn('deprecated function clearDirty(), call app.clearDirty instead');
    app.clearDirty();
}

function documentTags( useTextInput ) {
    // scan text of editor for tags
    var str;
    if ( !useTextInput && ( window.app && window.app.cpeList.length > 0
        && window.app.cpeList[0].editor ) ) {
        str = window.app.cpeList[0].getCode();
    } else {
        var area = DOM.getElement('text_cpe') || DOM.getElement('text');
        str = area.value;
    }
    
    if ( !defined( str ) )
        str = '';

    // clear any ignore blocks
    var re = new RegExp('(<m' + 't:?ignore([^>])*?>)[\\S\\s]*?</mt:?ignore>',
        'gi');
    str = str.replace(re, '$1');
    // scan template string for MT tags and build
    // a hash of unique tag names
    var tags = {};
    var matches = str.match(/<\$?[mM][tT]:?[^\s>]+/g);
    if (matches) {
        for (var i = 0; i < matches.length; i++ ) {
            var orig_tag = matches[i];
            if (orig_tag.match(/^<\$/)) {
                if (!orig_tag.match(/\$$/))
                    orig_tag += '$';
            }
            orig_tag = orig_tag.replace(/^</, '&lt;');
            orig_tag += '&gt;';
            var tag = matches[i].replace(/^<\$?[mM][tT]:?/, '');
            tag = tag.replace(/\$$/, '');
            tags[dirify(tag.toLowerCase())] = orig_tag;
        }
    }

    // construct a set of bullets for all discovered tags
    // separate into valid/invalid lists
    var sorted_tags = [];
    for ( var t in tags ) {
        if ( !tags.hasOwnProperty( t ) )
            continue;
        sorted_tags.push(t);
    }
    sorted_tags.sort();
    var list = '';
    var bad_list = '';
    for ( var i = 0; i < sorted_tags.length; i++ ) {
        var t = sorted_tags[i];
        var url = tagDocURL( t );
        var tag_name = tags[t];
        if (!url) {
            bad_list = bad_list + "<li>" + tag_name + "</li>";
            continue;
        }
        var link = "<a target=\"mt_docs\" href=\"" + url + "\">" + tag_name + "</a>";
        list = list + "<li>" + link + "</li>";
    }

    // if we found tags to list, display the tag-list widget, otherwise
    // hide it
    if (list != '') {
        list = '<ul>' + list + '</ul>';
        DOM.getElement("tag-list-inner").innerHTML = list;
        DOM.removeClassName("tag-list", "hidden");
    } else {
        DOM.addClassName("tag-list", "hidden");
    }
    // if we found invalid tags, display them in badtag-list, otherwise
    // hide it
    if (bad_list != '') {
        bad_list = '<ul>' + bad_list + '</ul>';
        DOM.getElement("badtag-list-inner").innerHTML = bad_list;
        DOM.removeClassName("badtag-list", "hidden");
    } else {
        DOM.addClassName("badtag-list", "hidden");
    }
}

function tagDocURL(name) {
    var re = new RegExp('(?:^|,)' + name + '\\??(?:,|$)', 'i');
    for ( var u in mt.screen.tag_docs ) {
        if ( !mt.screen.tag_docs.hasOwnProperty(u) ) continue;
        var m;
        if (m = mt.screen.tag_docs[u].match(re))
            return u.replace(/\%t/, name);
    }
    return;
}

function archiveFileSelect(sel) {
    var fld = sel.name;
    fld = fld.replace(/sel/, 'tmpl');
    var edit = getByID(fld);
    var map = sel.options[sel.selectedIndex].value;
    if (map == '') {
        DOM.addClassName(sel, "hidden");
        DOM.removeClassName(edit, "hidden");
        edit.focus();
    } else {
        edit.value = map;
    }
}

function insertSnippet(el) {
    if (el.selectedIndex == -1) return false;
    var opt = el.options[el.selectedIndex].value;
    if (!opt) return false;
    el.selectedIndex = 0;
    if (mt.screen.tag_inserts[opt]) {
        app.insertCode( mt.screen.tag_inserts[opt] );
    }
}
function setRebuild(f) {
    f['rebuild'].value = 'Y';
}

function validate (f, rebuild) {
    if (f.name && !f.name.value) {
        alert(mt.screen.trans.SET_NAME);
        return false;
    }
    else if (f.outfile && !f.outfile.value) {
        alert(mt.screen.trans.SET_OUTFILE);
        return false;
    }
    else {
        app.clearDirty();
        if (rebuild) setRebuild(f);
    }
    return true;
}
function saveArchiveMapChange(param) {
    showMsg(mt.screen.trans.PROCESSING, 'map-message', 'success')

    // TBD: we need to get the blog id from the selector control
    // itself
    var params = { uri: ScriptURI, method: 'POST', arguments: param, load: savedArchiveMapChange };
    TC.Client.call(params);

}
function savedArchiveMapChange(c) {
    var res = c.responseText;
    if (res == '') 
        message = mt.screen.trans.ERROR_ARCHIVE_MAPS;
    else
        message = mt.screen.trans.SUCCESS_ARCHIVE_MAPS;
    showMsg(message, 'map-message', 'success');
    var map = getByID('template-maps');
    if (map)
        map.innerHTML = res;
}
function deleteMap(mapid) {
    if (!confirm(mt.screen.trans.CONFIRM_REMOVE_MAP))
        return;
    var tr = getByID(mapid);
    if (tr) {
        var tbody = tr.parentNode;
        if (tbody)
            tbody.deleteRow(tr.rowIndex - 1); // thead has a row - subtract it
    }
    var frm = document.forms['archive_map_form'];
    if (!frm) return false;
    var param = '__mode=delete_map'
        + '&blog_id=' + frm['blog_id'].value
        + '&template_id=' + mt.screen.id
        + '&id=' + mapid
        + '&magic_token=' + MagicToken;
    saveArchiveMapChange(param);
}
function setCreateMode () {
    var el = getByID('map-message');
    if (el) el.style.display = 'none';
    getByID('create-inline-mapping').style.display = 'block';
    return false;
}

function cancelCreateMode () {
    getByID('create-inline-mapping').style.display = 'none';
    return false;
}
function addMap() {
    getByID('create-inline-mapping').style.display = 'none';
    var f = document.forms['template-listing-form'];
    var frm = document.forms['archive_map_form'];
    if (!frm) return false;
    var param = '__mode=add_map'
        + '&blog_id=' + frm['blog_id'].value
        + '&template_id=' + mt.screen.id
        + '&new_archive_type=' + f['new_archive_type'].value
        + '&magic_token=' + MagicToken;
    saveArchiveMapChange(param);
}

function togglePreferred(checkbox, mapid) {
    var frm = document.forms['template-listing-form'];
    if (!frm) return false;
    var checkboxes = frm[checkbox.name];
    if (checkbox.length == undefined) {
        for (var j = 0; j < frm[checkbox.id].length; ++j) {
            if (frm[checkbox.id][j].type == 'hidden')
                frm[checkbox.id][j].value = checkbox.checked ? '1' : '0';
        }
    } else {
        for (var i = 0; i < checkboxes.length; ++i) {
            if (checkboxes[i] != checkbox)
                checkboxes[i].checked = false;
            for (var j = 0; j < frm[checkboxes[i].id].length; ++j) {
                if (frm[checkboxes[i].id][j].type == 'hidden') {
                    frm[checkboxes[i].id][j].value = checkboxes[i].checked ? '1' : '0';
                }
            }
        }
    }
}

function toggleCache(id) {
    if ("expire-time" == id) {
        toggleDisable('cache-time-value', 0);
        toggleDisable('cache-time-unit', 0);
    } else {
        toggleDisable('cache-time-value', 1);
        toggleDisable('cache-time-unit', 1);
    }
    var es = DOM.getElement('cache-events').getElementsByTagName('input');
    for (var i=0, len=es.length; i<len; i++)
        toggleDisable( es[i].id, "expire-event" != id )
    return false;
}

Template.templates.autoSave = '[# if ( saving ) { #] [#= trans(\"Auto-saving...\" ) #] [# } else { #] [#= trans(\"Last auto-save at [_1]:[_2]:[_3]\", hh, mm, ss ) #] [# } #]';

jQuery(document).ready(function($) {
    var txt = getByID("text");
    if (txt) {
        var w;
        if (w = txt.contentWindow) {
            if (w.Language) {
                if (w.Language && !w.Language.snippets) {
                    w.Language.snippets = [];
                }
                var fsnippets = w.Language.snippets;
                for (var i = 0; i < snippets.length; i++) {
                    fsnippets.push(snippets[i]);
                }
            }
        }
    }
});
