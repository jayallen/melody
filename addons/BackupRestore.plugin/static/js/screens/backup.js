jQuery(document).ready( function() {
    if (mt.screen.open_dialog_on_load) {
        openDialog(false, 'dialog_restore_upload', 
                   'magic_token='+MagicToken+
                   '&amp;files='+mt.screen.files+
                   '&amp;assets='+mt.screen.assets+
                   '&amp;current_file='+mt.screen.filename+
                   '&amp;last='+mt.sceen.last+
                   '&amp;schema_version='+mt.screen.schema_version+
                   '&amp;redirect=1;');
    }
});
