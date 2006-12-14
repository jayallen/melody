/* for showing and hiding asset details */

function toggleScrollBar(which) {
    var el = getByID("selector");
    if (which == 'left') {
        TC.addClassName(el, "condensed");
    } else {
        TC.removeClassName(el, "condensed");
    }
}

var opened = false;
var asset_id = '';
function hasOpened(id) {
    opened = true;
    asset_id = id;
}

function notOpened(id) {
    opened = false;
    asset_id = '';
}

function checkOpened() {
    if (opened) {
        hide('asset-' + asset_id + '-detail');
        notOpened(asset_id);
        toggleScrollBar('right');
    }
}

function toggleAssetDetails(id) {
    var isModal = getByID("list-assets-dialog");
    if (asset_id == id) {
        hide('asset-' + asset_id + '-detail');
        notOpened(asset_id);
        if (isModal) {
            toggleScrollBar('right');
        }
    } else {
        displayAssetDetails(id);
        if (isModal) {
            toggleScrollBar('left');
        }
    }
}
