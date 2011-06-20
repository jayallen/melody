function submitMoveMode() {
    var f = getByID('folder-listing-form');
    f['__mode'].value = 'save_cat';
    f.submit();
}
function setCreateMode (id) {
    DOM.addClassName(getByID('create-new-link'), 'hidden');
    var f = getByID('folder-listing-form');
    f['__mode'].value = 'save_cat';
    if (getByID('msg-block')) {
        getByID('msg-block').style.display = 'none'; // hide any messaging 
    }
    if (document.all) {
        if (getByID('create-' + id))
            getByID('create-' + id).style.display = 'block'; // show subcategory creation row
    } else {
        if (getByID('create-' + id))
            getByID('create-' + id).style.display = 'table-row';
    }
    // reset any fields that might be set from a previous failed attempt.
    for (var i = 0; i < mt.screen.category_rows.length; i++) {
        getByID('category-new-parent-' + mt.screen.category_rows[i]).value = '';
        if (mt.screen.category_rows[i] != id) {
            el = getByID('create-' + mt.screen.category_rows[i]);
            if (el.style.display != 'none') el.style.display = 'none';
        }
    }
    if (document.forms['folder-listing-form'].move_cat_id)
    document.forms['folder-listing-form'].move_cat_id.value = '0';

    getByID('category-new-parent-' + id).focus();

    if (getByID('action-col-head'))
        getByID('action-col-head').style.display = 'none'; // hide header of actions column
    if (getByID('delete-col-head'))
        getByID('delete-col-head').style.display = 'none'; // hide header of delete column
    for (var i = 0; i < categoryRows.length; i++) {
        if (getByID('action-' + categoryRows[i]))
            getByID('action-' + categoryRows[i]).style.display = 'none'; // hide actions column for category rows
        if (getByID('delete-' + categoryRows[i]))
            getByID('delete-' + categoryRows[i]).style.display = 'none'; // hide delete column for category rows
    }
    if (getByID('footer-list-actions')) {
        getByID('footer-list-actions').style.display = 'none';
    }
    return false;
}

function cancelCreateMode (id) {
    DOM.removeClassName(getByID('create-new-link'), 'hidden');
    getByID('create-' + id).style.display = 'none'; // hide subcategory creation row
    if (document.all) {
        if (getByID('action-col-head'))
            getByID('action-col-head').style.display = 'block'; // show header of actions column
        if (getByID('delete-col-head'))
            getByID('delete-col-head').style.display = 'block'; // show header of delete column
    } else {
        if (getByID('action-col-head'))
            getByID('action-col-head').style.display = 'table-cell';
        if (getByID('delete-col-head'))
            getByID('delete-col-head').style.display = 'table-cell';
    }
    for (var i = 0; i < categoryRows.length; i++) {
        if (document.all) {
            if (getByID('action-' + categoryRows[i]))
                getByID('action-' + categoryRows[i]).style.display = 'block'; // show actions column for category rows
            if (getByID('delete-' + categoryRows[i]))
                getByID('delete-' + categoryRows[i]).style.display = 'block'; // show delete column for category rows
        } else {
            if (getByID('action-' + categoryRows[i]))
                getByID('action-' + categoryRows[i]).style.display = 'table-cell';
            if (getByID('delete-' + categoryRows[i]))
                getByID('delete-' + categoryRows[i]).style.display = 'table-cell';
        }
    }
    if (getByID('footer-list-actions')) {
        getByID('footer-list-actions').style.display = 'block';
    }
}

function setMoveMode (id) {
    var f = getByID('folder-listing-form');
    f['__mode'].value = 'save_cat';
    if (getByID('msg-block')) {
        getByID('msg-block').style.display = 'none'; // hide any messaging 
    }
    DOM.addClassName( getByID('category-' + id), "selected" );
    getByID('move-radio-' + id).style.display = 'none'; // hide radio button of selected row
    if (document.all) {
        getByID('move-col-head').style.display = 'block'; // show header of radio button column
        getByID('move-0').style.display = 'block'; // show top level row
    } else {
        getByID('move-col-head').style.display = 'table-cell';
        getByID('move-0').style.display = 'table-row';
    }
    getByID('action-col-head').style.display = 'none'; // hide header of actions column
    getByID('delete-col-head').style.display = 'none'; // hide header of delete column
    if (getByID('footer-list-actions')) {
        getByID('footer-list-actions').style.display = 'none';
    }
    document.forms['folder-listing-form'].move_cat_id.value = id;
    for (var i = 0; i < categoryRows.length; i++) {
        if (document.all) {
            getByID('move-col-' + categoryRows[i]).style.display = 'block'; // show radio buttons for category rows
        } else {
            getByID('move-col-' + categoryRows[i]).style.display = 'table-cell';
        }
        getByID('action-' + categoryRows[i]).style.display = 'none'; // hide actions column for category rows
        getByID('delete-' + categoryRows[i]).style.display = 'none'; // hide delete column for category rows
    }
    return false;
}

var tableSelect;
jQuery(document).ready( function($) {
    // setup
    tableSelect = new TC.TableSelect( "folder-listing-table" );
    tableSelect.rowSelect = true;
});
