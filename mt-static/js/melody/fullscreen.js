function toggleClass(id, classname) {
  var el = DOM.getElement(id);
  if (DOM.hasClassName(el, classname))
    DOM.removeClassName(el, classname);
  else
    DOM.addClassName(el, classname);
}

function toggleFullscreen() {
  var el = DOM.getElement('content');
  var ed = DOM.getElement('text');
  if (DOM.hasClassName(el, 'fullscreen')) {
    DOM.addClassName('container-inner', 'related-content');
    DOM.addClassName('container-inner', 'related-content-without-content-nav');
    show('related-content');
    if (ed) { ed.style.width = '675px'; }
  } else {
    hide('related-content');
    DOM.removeClassName('container-inner', 'related-content');
    DOM.removeClassName('container-inner', 'related-content-without-content-nav');
    if (ed) { ed.style.width = '900px'; }
  }
  toggleClass(el, 'fullscreen');
}
