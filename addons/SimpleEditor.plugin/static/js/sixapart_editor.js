/*
# Movable Type (r) Open Source (C) 2001-2010 Six Apart, Ltd.
# This program is distributed under the terms of the
# GNU General Public License, version 2.
#
# $Id$
*/

MT.App.Editor.Iframe = new Class( Editor.Iframe, {


    initObject: function() {
        arguments.callee.applySuper( this, arguments );
        this.isWebKit = navigator.userAgent.toLowerCase().match(/webkit/);
    },
    
    
    eventFocusIn: function( event ) {
       this.eventFocus( event );
    },


    eventFocus: function( event ) {
        if ( this.editor.mode == "textarea" )
            this.editor.focus();
    },


    eventClick: function( event ) {
        /* for safari */
        if ( this.isWebKit && event.target.nodeName == "A" )
            return event.stop();
        return arguments.callee.applySuper( this, arguments );
    },
    
    
    eventKeyPress: function( event ) {
        /* safari forward delete */
        if ( this.isWebKit && event.keyCode == 63272 )
            return event.stop();
    },
    
    
    eventKeyDown: function( event ) {
        /* safari forward delete */
        if ( this.isWebKit && event.keyCode == 46 ) {
            this.document.execCommand( "forwardDelete", false, true );
            return false;
        }
    },

    eventKeyUp: function( event ) {
        /* safari always makes this event. ignore for language input method */
        if ( this.isWebKit ) {
            return false;
        }
    },

    extendedExecCommand: function( command, userInterface, argument ) {
        switch( command ) {

            case "fontSizeSmaller":     
                this.changeFontSizeOfSelection( false );
                break;

            case "fontSizeLarger":
                this.changeFontSizeOfSelection( true );
                break;
            
            default:
                return arguments.callee.applySuper( this, arguments );
        
        }
    },


    mutateFontSize: function( element, bigger ) {
        // Basic settings:
        var goSmaller = 0.8;
        var goBigger = 1.25;
        var biggest = Math.pow( goBigger, 3 );
        var smallest = Math.pow( goSmaller, 3);
        var defaultSize = bigger ? goBigger + "em" : goSmaller + "em";

        // Initial detection, rejection, adjusting:
        var fontSize = element.style.fontSize.match( /([\d\.]+)(%|em|$)/ );
        if( fontSize == null || isNaN( fontSize[ 1 ] ) ) // "px" sizes are rejected.
            return defaultSize; // A browser problem or bad user data would lead to "NaN" fontSize.
        
        var size;
        if( fontSize[ 2 ] == "%" )
            size = fontSize[ 1 ] / 100; // Convert to "em" units.
        else if( fontSize[ 2 ] == "em" || fontSize[ 2 ] == "" )
            size = fontSize[ 1 ];
        
        // Mutation:
        var factor = bigger ? goBigger : goSmaller;
        size = size * factor;
        
        if( size > biggest ) 
            size = biggest;
        else if( size < smallest ) 
            size = smallest;

        return size + "em";                            
    },

    
    changeFontSizeOfSelection: function( bigger ) {
        var bogus = "-editor-proxy";
        this.document.execCommand( "fontName", false, bogus );
        var elements = this.document.getElementsByTagName( "font" );
        for( var i = 0; i < elements.length; i++ ) {
            var element = elements[ i ];
            if( element.face == bogus ) {
                element.removeAttribute( "face" );
                element.style.fontSize = this.mutateFontSize( element, bigger );
            }
        }
    },


    getHTML: function() {
        var html = this.document.body.innerHTML;

        // cleanup innerHTML garbage browser regurgitates
        // #1 - lowercase tag names (open and closing tags)
        html = html.replace(/<\/?[A-Z0-9]+[\s>]/g, function (m) {
            return m.toLowerCase();
        });

        // #2 - lowercase attribute names
        html = html.replace(/(<[\w\d]+\s+)([^>]+)>/g, function (x, m1, m2) {
            return m1 + m2.replace(/\b([\w\d:-]+)\s*=\s*(?:'([^']*?)'|"([^"]*?)"|(\S+))/g, function (x, m1, m2, m3, m4) {
                if ( !m2 ) m2 = ''; // for ie
                if ( !m3 ) m3 = ''; // for ie
                if ( !m4 ) m4 = ''; // for ie
                return m1.toLowerCase() + '="' + m2 + m3 + m4 + '"';
            }) + ">";
        });

        // #3 - close singlet tags for img, br, input, param, hr
        html = html.replace(/<(br|img|input|param)([^>]+)?([^\/])?>/g, "<$1$2$3 />");

        // #4 - get absolute path and delete from converted URL
        var path = this.document.URL;
        path = path.replace(/(.*)editor-content.html.*/, "$1");
        var regex = new RegExp(path, "g");
        html = html.replace(regex, "");
        /* XXX for save on ff */
        regex = new RegExp(path.replace(/~/, "%7E"), "g");
        html = html.replace(regex, "");

        return html;
    }
} );
