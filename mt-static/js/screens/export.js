function validate(f) {
    if (!f['blog_id'].value) {
        alert(mt.screen.trans.SELECT_BLOG);
        return false;
    }
    return true;
}
function selectBlog() {
    return openDialog(this.form, 'dialog_select_weblog', 'multi=0&amp;return_args=__mode%3Dstart_export');
}
