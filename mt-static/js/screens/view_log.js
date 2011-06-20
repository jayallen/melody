function doResetLog(f) {
    if (confirm(mt.screen.trans.ARE_YOU_SURE)) {
        window.location=mt.screen.reset_log_redirect;
    }
}
jQuery(document).ready( function($) {
    $('.listing-filter').listfilter('setfilter',mt.screen.filter,mt.screen.filter_val);
});
