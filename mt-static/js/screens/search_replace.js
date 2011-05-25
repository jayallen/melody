var tableSelect;
jQuery(document).ready( function($) { 
    // setup
    tableSelect = new TC.TableSelect( mt.screen.object_type + "-listing-table" );
    tableSelect.rowSelect = true;
    if (mt.screen.has_results) {
        $('#search').focus();
    }
});

function toggleVisibility(c, s) {
    var e = getByID(s);
    if (e) {
        if (c.checked) e.style.display = 'block';
        if (!c.checked) e.style.display = 'none';
    }
}

function toggleSearchAndReplace(selection) {
    var s = getByID('search-bar-search-field');
    var r = getByID('search-bar-replace-fields');
    var sa = getByID('search-bar-advanced-search');
    var lf = getByID('limited-fields');
    var dr = getByID('date-range');
    if (s && r) {
        if (selection.value == 'search') {
            s.style.display = '';
            sa.style.display = '';
            r.style.display = 'none';
            if ( getByID('is_limited').checked )
                lf.style.display = '';
            else
                lf.style.display = 'none';
            if ( getByID('is_dateranged').checked )
                dr.style.display = '';
        } else if (selection.value == 'replace') {
            r.style.display = '';
            s.style.display = 'none';
            sa.style.display = 'none';
            lf.style.display = 'none';
            dr.style.display = 'none';
        }
    }
}

function reSearch(type) {
    if (type && (document.search_form['_type'].value != type)) {
        if (document.search_form['orig_search'] && 
            document.search_form['orig_search'].value != '') {
            document.search_form['do_search'].value = '1';
        }
        document.search_form['_type'].value = type;
        document.search_form.submit();
    }
    return false;
}

function unLimit(newLimit) {
    document.search_form['limit'].value = newLimit;
    document.search_form['do_search'].value = '1';
    document.search_form.submit();
    return false;
}

function doSearch() {
    document.search_form['limit'].value = '';
    document.search_form['do_search'].value = '1';
    document.search_form.submit();
}

function doReplace() {
    // gather ids from checked items listed and put them in the
    // hidden 'id' field in the search form
    var ids = new Array();
    var div = TC.elementOrId(mt.screen.object_type+'-listing');
    var inputs = TC.getElementsByTagAndClassName('input', 'select', div);
    for (var i = 0; i < inputs.length; i++) {
        if (inputs[i].checked) {
            if (inputs[i].value != 'all')
                ids[ids.length] = inputs[i].value;
        }
    }
    if (ids.length) {
        document.search_form['replace_ids'].value = ids.join(',');
        document.search_form['do_replace'].value = '1';
        document.search_form.submit();
    } else {
        alert(mt.screen.trans.MUST_SELECT);
    }
    return false;
}

function focusDateFields(s) {
    var dateFields = new Array(getByID('datefrom_year'),getByID('datefrom_month'),getByID('datefrom_day'),getByID('dateto_year'),getByID('dateto_month'),getByID('dateto_day'));
    var datesDisbaled = getByID('dates-disabled');
    
    if (datesDisbaled && (datesDisbaled.value == 1)) {
        for (var i = 0; i < dateFields.length; i++) {
            dateFields[i].value = '';
            dateFields[i].style.color = '#000';
        }
        datesDisbaled.value = 0;
    }
}

function blurDateFields(s) {
    var dateFields = new Array(getByID('datefrom_year'),getByID('datefrom_month'),getByID('datefrom_day'),getByID('dateto_year'),getByID('dateto_month'),getByID('dateto_day'));
    var datesDisbaled = getByID('dates-disabled');
    var allEmpty = 1;
    
    if (datesDisbaled && (datesDisbaled.value == 0)) {
        for (var i = 0; i < dateFields.length; i++) {
            if (dateFields[i].value != "") {
                allEmpty = 0;
            }
        }
        
        if (allEmpty) {
            for (var i = 0; i < dateFields.length; i++) {
                if ((i == 0) || (i == 3)) dateFields[i].value = 'YYYY';
                if ((i == 1) || (i == 4)) dateFields[i].value = 'MM';
                if ((i == 2) || (i == 5)) dateFields[i].value = 'DD';
                dateFields[i].style.color = '#999';
            }
            datesDisbaled.value = 1;
        }
    }
}
