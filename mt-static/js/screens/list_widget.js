var widgetSetTableSelect;
var widgetTableSelect;

jQuery(document).ready( function($) {
    // setup
    widgetSetTableSelect = new TC.TableSelect( "template-listing-table" );
    widgetSetTableSelect.rowSelect = true;
    widgetTableSelect = new TC.TableSelect( "widget-listing-table" );
    widgetTableSelect.rowSelect = true;
});
