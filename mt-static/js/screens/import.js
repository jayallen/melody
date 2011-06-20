var last_shown;
function toggleDisplay(selection) {
    var id = 'config-' + selection.value;
    var div = getByID(id);
    if (div) {
        if (div.style.display != "block") {
            if (last_shown) {
                last_shown.style.display = "none";
            }
            div.style.display = "block";
            last_shown = div;
        } else {
            div.style.display = "none";
        }
    }
    return false;
}
function validate(f) {
    if (!f['blog_id'].value) {
        alert(mt.screen.trans.SELECT_BLOG);
        return false;
    }
    return true;
}
function selectBlog() {
    return openDialog(this.form, 'dialog_select_weblog', 'multi=0&amp;return_args=__mode%3Dstart_import');
}
