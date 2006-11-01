/*
Copyright 2003-2006 Six Apart. This code cannot be redistributed without
permission from www.sixapart.com.

$Id$
*/


/*
--------------------------------------------------------------------------------
TC.TableSelect
table selection
--------------------------------------------------------------------------------
*/

/* constructor */

TC.TableSelect = function( element ) {
    // make closures
    var self = this;
    this.clickClosure = function( evt ) { return self.click( evt ); };
    this.lastClicked = null;
    this.thisClicked = null;
    this.updating = false;
    this.shiftKey = false;
    this.onChange = null;

    // initialize
    this.init( element );
}


/* config */

TC.TableSelect.prototype.rowSelect = false;


/* instance methods */

TC.TableSelect.prototype.init = function( container ) {
    container = TC.elementOrId( container );
    if ( !container ) return;

    // basic setup
    this.container = container;

    // event handlers
    TC.attachEvent( container, "click", this.clickClosure );

    // select rows
    this.selectAll();
}


TC.TableSelect.prototype.click = function( evt ) {
    evt = evt || event;
    var element = evt.target || evt.srcElement;
    this.shiftKey = evt.shiftKey;

    // get tag name
    var tagName = element.tagName ? element.tagName.toLowerCase() : null;

    // handle checkboxes
    if ( tagName == "input" &&
        TC.hasClassName( element, "select" ) ) {
        if ((element.type == "checkbox") || (element.type == "radio"))
            return this.select( element );
    }

    // handle rows
    if ( !this.rowSelect && tagName != "td" ) return;
    if ( ( tagName == 'a') || ( TC.getParentByTagName( element, "a" ) ) )
        return;
    var parent = TC.getParentByTagName( element, "tr" );
    while ( TC.hasClassName( parent, "slave" ) )
        parent = parent.previousSibling;

    if ( parent ) {
        var elements = TC.getElementsByTagAndClassName( "input", "select", parent );
        for ( var i = 0; i < elements.length; i++ ) {
            element = elements[ i ];
            if ( (element.type == "checkbox") || (element.type == "radio") ) {
                element.checked = !element.checked;
                return this.select( element );
            }
        }
    }
}


TC.TableSelect.prototype.select = function( checkbox ) {
    // setup
    this.thisClicked = checkbox;
    var checked = checkbox.checked ? true : false; // important, trinary value (null is valid)
    var all = checkbox.value == "all" ? true : false;
    
    if ( all ) {
        this.thisClicked = null;
        this.lastClicked = null;
        return this.selectAll( checkbox );
    }

    var row = TC.getParentByTagName( checkbox, "tr" );
    if (this.selectRow( row, checked )) {
        if (this.onChange) this.onChange(this, row, checked);
        if (checkbox.type == "radio") {
            this.lastClicked = null;
            this.clearOthers(row);
            return;
        }
    }
    this.selectAll();
    this.lastClicked = this.thisClicked;
}

TC.TableSelect.prototype.clearOthers = function( sel_row ) {
    var rows = this.container.getElementsByTagName( "tr" );
    for ( var i = 0; i < rows.length; i++ ) {
        var row = rows[ i ];
        if ( !row || !row.tagName )
            continue;
        if (row.id == sel_row.id)
            continue;
        this.selectRow(row, false);
    }
}

TC.TableSelect.prototype.selectAll = function( checkbox ) {
    // setup
    if (this.updating) return;
    this.updating = true;
    var alls = [];
    var count = 0;
    var selectedCount = 0;
    var invert = false;

    var lastClicked = -1;
    var thisClicked = -1;
    
    // iterate
    var rows = this.container.getElementsByTagName( "tr" );

    for ( var i = 0; i < rows.length; i++ ) {
        var row = rows[ i ];
        if ( !row || !row.tagName )
            continue;
        var inputs = row.getElementsByTagName( "input" );

        var anyChecked = false;
        for ( var j = 0; j < inputs.length; j++ ) {
            var input = inputs[ j ];
            if ( ((input.type != "checkbox") && (input.type != "radio")) ||
                !TC.hasClassName( input, "select" ) )
                continue;

            if (this.lastClicked && input == this.lastClicked)
                lastClicked = i;

            if (this.thisClicked && input == this.thisClicked)
                thisClicked = i;

            if (input.checked)
                anyChecked = true;
        }

        invert = this.shiftKey;
    }

    for ( var i = 0; i < rows.length; i++ ) {
        var row = rows[ i ];
        if ( !row || !row.tagName )
            continue;
        var inputs = row.getElementsByTagName( "input" );
        for ( var j = 0; j < inputs.length; j++ ) {
            var input = inputs[ j ];
            if ( ((input.type != "checkbox") && (input.type != "radio")) ||
                !TC.hasClassName( input, "select" ) )
                continue;
            
            // test and select
            var checked;
            if (checkbox) {
                var checked;
                if (invert)
                    checked = !input.checked;
                else
                    checked = checkbox ? checkbox.checked : input.checked;
                input.checked = checked;
                if (this.selectRow( row, checked )) {
                    if ( input.value != "all" ) {
                        if (this.onChange) this.onChange(this, row, checked);
                    }
                }
            }
            
            // add to alls
            if ( input.value == "all" )
                alls[ alls.length ] = input;
            else {
                count++;
                if ( input.checked )
                    selectedCount++;
            }
        }
    }

    if ((lastClicked != -1) && (this.shiftKey)) {
        var low, hi;
        if (thisClicked < lastClicked) {
            low = thisClicked;
            hi = lastClicked;
        } else {
            low = lastClicked;
            hi = thisClicked;
        }
        for (i = low + 1; i < hi; i++) {
            var row = rows[ i ];
            if (!row || !row.tagName )
                continue;

            var inputs = row.getElementsByTagName( "input" );

            for ( var j = 0; j < inputs.length; j++ ) {
                var input = inputs[ j ];
                if ( ((input.type != "checkbox") && (input.type != "radio")) ||
                    !TC.hasClassName( input, "select" ) || input.value == "all" )
                    continue;
                input.checked = this.thisClicked.checked;
            }
            if (this.selectRow( row, this.thisClicked.checked )) {
                if (this.onChange) this.onChange(this, row, this.thisClicked.checked);
            }
        }
        this.lastClicked.checked = this.thisClicked.checked;
        if (this.selectRow( rows[ lastClicked ], this.lastClicked.checked )) {
            if (this.onChange) this.onChange(this, rows[ lastClicked ], this.lastClicked.checked);
        }
    }

    // check alls
    for ( var i = 0; i < alls.length; i++ ) {
        if ( count && count == selectedCount ) {
            alls[ i ].checked = true;
        } else
            alls[ i ].checked = false;
    }
    this.updating = false;
}


TC.TableSelect.prototype.selected = function() {
    // setup
    var values = [];

    // iterate
    var rows = this.container.getElementsByTagName( "tr" );

    for ( var i = 0; i < rows.length; i++ ) {
        var row = rows[ i ];
        if ( !row || !row.tagName )
            continue;
        var inputs = row.getElementsByTagName( "input" );

        for ( var j = 0; j < inputs.length; j++ ) {
            var input = inputs[ j ];
            if ( ( (input.type != "checkbox") && (input.type != "radio")) ||
                !TC.hasClassName( input, "select" ) )
                continue;

            if (input.checked)
                values[values.length] = input;
        }
    }

    return values;
}


TC.TableSelect.prototype.selectRow = function( row, checked ) {
    if ( !row ) return false;
    var changed = false;
    if( checked ) {
        if (!TC.hasClassName( row, "selected" )) {
            TC.addClassName( row, "selected" );
            changed = true;
        }
    } else {
        if (TC.hasClassName( row, "selected" )) {
            TC.removeClassName( row, "selected" );
            changed = true;
        }
    }
    if (changed) {
        // sync checkbox if necessary
        var inputs = row.getElementsByTagName( "input" );

        for ( var j = 0; j < inputs.length; j++ ) {
            var input = inputs[ j ];
            if ( input.type != "checkbox" || !TC.hasClassName( input, "select" ) )
                continue;
            input.checked = checked;
        }

        var next = row.nextSibling;
        while (next && TC.hasClassName( next, "slave" )) {
            if ( checked )
                TC.addClassName( next, "selected" );
            else
                TC.removeClassName( next, "selected" );
            next = next.nextSibling;
        }
    }
    return changed;
}

TC.TableSelect.prototype.selectThese = function(list) {
    // list is an array of DOM IDs
    for (var i = 0; i < list.length; i++) {
        var el = TC.elementOrId(list[i]);
        this.selectRow(el, true);
    }
    this.selectAll();
}
