var tableSelect = [];
function init() {
    tableSelect.push(new TC.TableSelect( 'enabled-plugins-table' ));
    tableSelect[tableSelect.length-1].rowSelect = true;
    tableSelect.push(new TC.TableSelect( 'disabled-plugins-table' ));
    tableSelect[tableSelect.length-1].rowSelect = true;
}
TC.attachLoadEvent(init);
