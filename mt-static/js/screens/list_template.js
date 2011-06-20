function showTable(name) {
    for (var i=0, len=tableList.length; i<len; i++) {
        var el = tableList[i] + "-listing"
        var elTab = tableList[i] + "-tab"
        if (name == "all-listing") {
            DOM.removeClassName ( el, "hidden");
            DOM.removeClassName ( elTab, "current-filter");
            DOM.addClassName( "all-tab", "current-filter" );
        }
        else if (name == el) {
            DOM.removeClassName ( el, "hidden");
            DOM.addClassName( elTab, "current-filter" );
            DOM.removeClassName( "all-tab", "current-filter" );
        }
        else {
            DOM.addClassName( el, "hidden" );
            DOM.removeClassName( elTab, "current-filter" );
            DOM.removeClassName( "all-tab", "current-filter" );
        }
    }
}

var tableSelect = [];
jQuery(document).ready( function($) {
    for (i=0;i<mt.screen.template_types.length;i++) {
        tableSelect.push(new TC.TableSelect( mt.screen.template_types[i]+'-listing-table' ));
        tableSelect[tableSelect.length-1].rowSelect = true;
    }
    var name = (window.location.hash && window.location.hash.match( /^#/ ) ) ? window.location.hash.substr(1) : "all";
    showTable(name + "-listing");
});

