var pre_sortable_node;

function restoreBarPosition() {
    var current_bar_position = mt.screen.position_actions_both ? 'both' : 
       mt.screen.position_actions_top ? 'top' : 
          mt.screen.position_actions_bottom ? 'bottom' : 'top';
    setBarPosition( current_bar_position );
    jQuery( '#bar_position_' + current_bar_position ).attr('checked','checked');
}

function setCustomFields(args) {
    var i = 0;

    if (!pre_sortable_node)
        pre_sortable_node = TC.elementOrId(mt.screen.customizable_fields[0] + "-field").previousSibling;

    if (args && args['order']) {
        var order = args['order'];
        for (var i = order.length - 1; i >= 0; i--) {
            var el = TC.elementOrId(customizable_fields[order[i]] + "-field");
            el.parentNode.removeChild(el);
            if (pre_sortable_node.nextSibling)
                pre_sortable_node.parentNode.insertBefore(el, pre_sortable_node.nextSibling);
            else
                pre_sortable_node.parentNode.appendChild(el);
        }
    }

    // we loop over all customizable fields here (which includes
    // all the metadata fields). we want to hide the metadata (or
    // other fieldset, if we grow another customizable fieldset)
    // from view if all fields within it are hidden. alternatively,
    // if the user enables a field, the fieldset should be enabled.

    // add only the fields which are currently checked and enabled
    for (i = 0; i < customizable_fields.length; i++) {
        var hide = true;
        var field_object = TC.elementOrId("custom-prefs-"+customizable_fields[i]);

        if (field_object && field_object.checked) {
            hide = false;
        }
        var div = TC.elementOrId(customizable_fields[i] + '-field');
        if (div) {
            if (hide)
                TC.addClassName(div, 'hidden');
            else
                TC.removeClassName(div, 'hidden');
        }
    }

    var entry_prefs = getByID('entry_prefs');
    entry_prefs.value = 'Custom';

    return false;
}

function setDirty () {
    log.warn('deprecated function setDirty(), call app.setDirty instead');
    app.setDirty();
}
function clearDirty () {
    log.warn('deprecated function clearDirty(), call app.clearDirty instead');
    app.clearDirty();
}

// array of tag names
var tagList;

function rebasename(title) {
    if (!mt.screen.orig_basename) {
        dir_title = dirify(title.value);
        dir_title = dir_title.substring(0, mt.screen.basename_limit);
        trimmed = dir_title.match(/^(.*[^_])/);
        if (trimmed && trimmed.length) {
            setElementValue('basename', trimmed[0]);
        } else {
            setElementValue('basename', '');
        }
    }
}

RegExp.escape = (function() {
  var specials = [
    '/', '.', '*', '+', '?', '|',
    '(', ')', '[', ']', '{', '}', '\\'
  ];

  sRE = new RegExp(
    '(\\' + specials.join('|\\') + ')', 'g'
  );
  
  return function(text) {
    return text.replace(sRE, '\\$1');
  }
})();

function tagSplit(str) {
    var delim = RegExp.escape(mt.screen.tag_delim);
    var delim_scan = new RegExp('^((([\'"])(.*?)\\3[^' + delim + ']*?|.*?)(' + delim + '\\s*|$))', '');
    str = str.replace(/(^\s+|\s+$)/g, '');
    var tags = [];
    while (str.length && str.match(delim_scan)) {
        str = str.substr(RegExp.$1.length);
        var tag = RegExp.$4 ? RegExp.$4 : RegExp.$2;
        tag = tag.replace(/(^\s+|\s+$)/g, '');
        tag = tag.replace(/\s+/g, ' ');
        if (tag != '') tags.push(tag);
    }
    return tags;
}

function openTFDocs() {
    var s = document.forms['entry_form'].convert_breaks;
    var key = s.options[s.selectedIndex].value;
    if (url = mt.screen.docs[key]) {
        if (url.indexOf('http://') == -1)
            url = HelpBaseURI + url;
        window.open(url, 'manual', 'width=450,height=550,scrollbars=yes,status=yes,resizable=yes');
    } else {
        return false;
        // return openManual('entries', 'entry_text_formatting');
    }
}

var autoTag;
var tagPos = 0;

function initTags() {
    /* browsers don't want to cache the tags field, so we use a hidden input field to cache them */
    var t = getByID('tags-cache');
    if ( t ) {
        log('tag cache:'+t.value);
        var v = getByID('tags');
        if ( t.value )
            v.value = t.value;
        DOM.addEventListener( v, "change", function() { log('caching tags'); t.value = v.value; } );
    }
    if (!mt.screen.tag_list || mt.screen.tag_list.length == 0) return;

    autoTag = new TC.TagComplete("tags", mt.screen.tag_list);
    autoTag.delimiter = tag_delim;
}

function highlightSwitch(selection) {
    var descriptionObject = getByID('created_on-label');
    var highlightObject = getByID('created_on-date');
    if (highlightObject) {
        if (selection.value == 4) {
            highlightObject.className = 'highlight';
            descriptionObject.innerHTML = mt.screen.trans.PUBLISH_ON;
        } else {
            highlightObject.className = 'default';
            descriptionObject.innerHTML = mt.screen.trans.PUBLISH_DATE;
        }
    }
    return false;
}

Template.templates.autoSave = '[# if ( saving ) { #] [#= trans(\"Auto-saving...\" ) #] [# } else { #] [#= trans(\"Last auto-save at [_1]:[_2]:[_3]\", hh, mm, ss ) #] [# } #]';

function listPreviousPings () {
    window.open(ScriptURI + '?__mode=pinged_urls&entry_id='+mt.screen.id+'&blog_id='+BlogID, 'urls', 'width=400,height=400,resizable=yes,scrollbars=yes');
}

jQuery(document).ready( function($) {
/*
    $('button.save').click( function() { $(this).parents('form').find('input[name=__mode]').val('save_entry'); });
    $('button.preview').click( function() { $(this).parents('form').find('input[name=__mode]').val('preview_entry'); });
    $('#entry_form').ajaxForm({
        beforeSubmit: function(arr) {
            $.fancybox({
                //'orig': $(this),
                'opacity': .5,
                'centerOnScroll': true,
                'showCloseButton': false,
                'enableEscapeButton': false,
                'content': 'Saving...',
                'title'   : 'Saving Entry',
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'
            });
        },
        forceSync: true,
        success: function(txt, status, xhr) {
            alert('success!');
        },
        dataType: 'json'
    });
*/
});