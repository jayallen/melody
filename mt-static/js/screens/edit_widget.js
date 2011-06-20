var gCols;
var isIE = navigator.userAgent.indexOf('MSIE') >= 0;
var isOpera = navigator.userAgent.indexOf('Opera') >= 0;
var isSafari = navigator.userAgent.indexOf('Safari') >= 0;
var curMod, curCol;
var dragStartX, dragStartY;
var topZIndex = 10;

function checkName() {
    widgetname = getByID('name').value;
    if (!widgetname) {
        alert(mt.screen.trans.UNIQUE_NAME);
        return false;
    }
}


var gDropIndex, gDrop;
var gCanDrop = 0;

function Column (label, index, left) {
    this.label = label;
    this.node = getByID(label);
    this.node.style.height = '110px';
    this.x = left;
    this.y = 0;
    this.offsetX = offsetX(this.node) - this.x;
    this.offsetY = offsetY(this.node) - this.y;
    this.startX = this.x + 5;
    this.startY = this.y + 35;
    this.index = index;
    this.width = mt.screen.colWidth;
    this.height = 100;
    this.modules = new Array();
    return this;
}

Column.prototype.addModule = function (key, label) {
    var row = this.modules.length;
    this.modules[row] = new Module(key, label, row, this.index, this);
}

Column.prototype.moveModule = function (module, index) {
    var inCol = (curCol.index == module.col);
    if (inCol && (module.row == index)) {
        module.move(module.x, module.y);
        return;
    }
    if (inCol && module.row < index) index--;
    
    // Remove the module from the old column...
    var i;
    var oldMods = gCols[module.col].modules;
    for (i = module.row + 1; i < oldMods.length; i++) {
        oldMods[i].y -= mt.screen.modHeight;
        oldMods[i].row--;
        oldMods[i].move(oldMods[i].x, oldMods[i].y);
        oldMods[i-1] = oldMods[i];
    }
    oldMods.length--;
    if (inCol && index > oldMods.length) index--;
    
    // ... and insert it into the new column.
    var newMods = curCol.modules;
    for (i = newMods.length-1; i >= index; i--) {
        newMods[i].y += mt.screen.modHeight;
        newMods[i].row++;
        newMods[i].move(newMods[i].x, newMods[i].y);
        newMods[i+1] = newMods[i];
    }
    module.colObj = curCol;
    module.row = index;
    module.col = curCol.index;
    module.x = curCol.startX;
    module.y = curCol.startY + index * mt.screen.modHeight;
    module.move(module.x, module.y);
    newMods[index] = module;
    
    calculateHeight();
}

function Module (key, label, row, col, colObj) {
        this.key = key;
        this.label = label;
        this.row = row;
        this.col = col;
        this.colObj = colObj;
        this.node = getByID('module-' + key);
        this.node.onmousedown = this.dragStart;
        this.node.module = this;
        this.x = colObj.startX;
        this.y = colObj.startY + mt.screen.modHeight * row;
        this.move(this.x, this.y);
        this.node.style.width = mt.screen.modWidth + 'px';
        this.node.style.display = 'block';
        return this;
}

Module.prototype.move = function (x, y) {
    move(this.node, x, y);
}

Module.prototype.dragStart = function (event) {
    document.onmousemove = dragMove;
    document.onmouseup = dragStop;
    gCanDrop = 0;
    var module = this.module;
    dragStartX = cursorX(event);
    dragStartY = cursorY(event);
    module.node.style.zIndex = topZIndex;
    curMod = module;
    return false;
}

function dragMove (event) {
    if (!curMod) return true;
    var x = cursorX(event);
    var y = cursorY(event);
    curMod.move(curMod.x + x - dragStartX, curMod.y + y - dragStartY);
    var i;
    curCol = null;
    for (i = 0; i< gCols.length; i++) {
        var adjX = gCols[i].x + gCols[i].offsetX;
        var adjY = gCols[i].y + gCols[i].offsetY;
        if ((x > adjX) &&
            (x < adjX + gCols[i].width) &&
            (y > adjY) &&
            (y < adjY + gCols[i].height)) {
            curCol = gCols[i];
            break;
        }
    }
    if (curCol == null) {
        gDrop.node.style.display = 'none';
        gCanDrop = 0;
        return false;
    }
    gDropIndex = Math.floor((y - curCol.y - curCol.offsetY) / mt.screen.modHeight + 0.0);
    if (gDropIndex < 0)
        gDropIndex = 0;
    if (gDropIndex > curCol.modules.length)
        gDropIndex = curCol.modules.length;
    if (!gCanDrop) {
        gCanDrop = 1;
        gDrop.node.style.display = 'block';
    }
    move(gDrop.node, curCol.startX, curCol.startY + gDropIndex * mt.screen.modHeight - 8);
    return false;
}

function dragStop (event) {
    if (!curMod) return true;
    gDrop.node.style.display = 'none';
    if (!curCol || !gCanDrop)
        curMod.move(curMod.x, curMod.y);
    else
        curCol.moveModule(curMod, gDropIndex);
    curMod = null;
    return false;
}

function moduleListStr () {
    var s = '';
    var i, j;
    for (i = 0; i < gCols.length; i++)
        for (j = 0; j < gCols[i].modules.length; j++)
            s += gCols[i].modules[j].key + '=' + (i+1) + '.' + (j+1) + ';';
    return s;
}

function move (node, x, y) {
    node.style.left = x + 'px';
    node.style.top = y + 'px';
}

function offsetX (node) {
    var o = node.offsetLeft;
    while((node = node.offsetParent) != null)
        o += node.offsetLeft;
    return o;
}

function offsetY (node) {
    var o = node.offsetTop;
    while((node = node.offsetParent) != null)
        o += node.offsetTop;
    return o;
}

function cursorX (event) {
    var x;
    if (isIE || isOpera) {
        x = window.event.clientX;
        if (document.documentElement.scrollLeft)
            x += document.documentElement.scrollLeft;
        if(!isOpera) x += document.body.scrollLeft;
    } else {
        x = event.clientX;
        if (!isSafari)
            x += window.scrollX;
    }
    return x;
}

function cursorY (event) {
    var y;
    if (isIE || isOpera) {
        y = window.event.clientY;
        if (document.documentElement.scrollTop)
            y += document.documentElement.scrollTop;
        if(!isOpera) y += document.body.scrollTop;
    } else {
        y = event.clientY;
        if (!isSafari)
            y += window.scrollY;
    }
    return y;
}

function calculateHeight () {
    var i, newHeight;
    var maxMods = 0;
    for (i = 0; i < gCols.length; i++) {
        if (gCols[i].modules.length > maxMods) {
            maxMods = gCols[i].modules.length;
        }
    }
    if ((maxMods * mt.screen.modHeight) < 100) {
        newHeight = 100;
    } else {
        newHeight = (maxMods + 1) * mt.screen.modHeight;
    }
    for (i = 0; i < gCols.length; i++) {
        gCols[i].height = newHeight;
        gCols[i].node.style.height = (newHeight + 10) + 'px';
    }
    getByID('center-column').style.height = (newHeight + 10) + 'px';
    getByID('stage').style.height = (newHeight + 10) + 'px';
    return true;
}

function toggleCache(id) {
    if ("expire-time" == id) {
        toggleDisable('cache-time-value', 0);
        toggleDisable('cache-time-unit', 0);
    } else {
        toggleDisable('cache-time-value', 1);
        toggleDisable('cache-time-unit', 1);
    }
    var es = DOM.getElement('cache-events').getElementsByTagName('input');
    for (var i=0, len=es.length; i<len; i++)
        toggleDisable( es[i].id, "expire-event" != id )
    return false;
}

jQuery(document).ready( function($) {
    gDrop = new Object();
    gDrop.node = getByID('stage-drop');
    gCols = new Array();
    gCols[0] = new Column('installed-column', 0, 0);
    gCols[1] = new Column('available-column', 1, 322);
    for (i=0;i < mt.screen.installed.length;i++) {
      gCols[0].addModule( mt.screen.installed[i] );
    }
    for (i=0;i < mt.screen.available.length;i++) {
      gCols[1].addModule( mt.screen.available[i] );
    }
    calculateHeight();
});