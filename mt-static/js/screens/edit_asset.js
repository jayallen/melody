function validate(form) {    
    if (form.label.value.match(/\S/,''))
        return true;
    alert(mt.screen.trans.SPECIFY_LABEL);
    form.label.focus();
    return false;
}
