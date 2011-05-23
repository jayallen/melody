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
    if (!mt.screen.tag_list || tagList.length == 0) return;

    autoTag = new TC.TagComplete("tags", tagList);
    autoTag.delimiter = tag_delim;
}

function validate(form) {    
    if (form.label.value.match(/\S/,''))
        return true;
    alert(mt.screen.trans.SPECIFY_CATEGORY);
    form.label.focus();
    return false;
}

function toggleFile() {
    var fld = getByID("basename");
    if (fld) {
        fld.disabled = false;
        fld.focus();
        var baseman = getByID("basename_manual");
        if (baseman) baseman.value = "1";
        var basewarn = getByID("basename-warning");
        if (basewarn) basewarn.style.display = "block";
    }
    var img = getByID("basename-lock");
    if (img)
        img.style.display = 'none';
    return false;
}

var tableSelect;
jQuery(document).ready(function($) {
    // setup
    tableSelect = new TC.TableSelect( mt.screen.asset_type + "-listing-table" );
    tableSelect.rowSelect = true;
    initTags();
});
