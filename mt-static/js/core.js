/* object extensions */

Function.stub = function() {};


if( !Object.prototype.hasOwnProperty ) {
    Object.prototype.hasOwnProperty = function( p ) {
        if( !(p in this) )
            return false;
        try {
            var pr = this.constructor.prototype;
            while( pr ) {
                if( pr[ p ] === this[ p ] )
                    return false;
                if( pr === pr.constructor.prototype )
                    break;
                pr = pr.constructor.prototype;
            }
        } catch( e ) {}
        return true;
    }
}


Object.prototype.extend = function() {
    var a = arguments;
    for( var i = 0; i < a.length; i++ ) {
        var o = a[ i ];
        for( var p in o ) {
            try {
                if( !this[ p ] &&
                    (!o.hasOwnProperty || o.hasOwnProperty( p )) )
                    this[ p ] = o[ p ];
            } catch( e ) {}
        }
    }
    return this;
}


Object.prototype.override = function() {
    var a = arguments;
    for( var i = 0; i < a.length; i++ ) {
        var o = a[ i ];
        for( var p in o ) {
            try {
                if( !o.hasOwnProperty || o.hasOwnProperty( p ) )
                    this[ p ] = o[ p ];
            } catch( e ) {}
        }
    }
    return this;
}


Object.prototype.extend( {
    init: Function.stub,
    destroy: Function.stub
} );



/* function extensions */

Function.prototype.extend( {
    bind: function( object ) {
        var method = this;
        return function() {
            return method.apply( object, arguments );
        };
    },


    bindEventListener: function( object ) {
        var method = this; // Use double closure to work around IE 6 memory leak.
        return function( event ) {
            try {
                event = Event.prep( event );
            } catch( e ) {}
            return method.call( object, event );
        };
    }
} );


/* class helpers */

indirectObjects = [];


Class = function( superClass ) {

    // Set the constructor:
    var constructor = function() {
        if( arguments.length )
            this.init.apply( this, arguments );
    };    
    //   -- Accomplish static-inheritance:
    constructor.override( Class );  // inherit static methods from Class
    superClass = superClass || Object; 
    constructor.override( superClass ); // inherit static methods from the superClass 
    constructor.superClass = superClass.prototype;

    // Set the constructor's prototype (accomplish object-inheritance):
    constructor.prototype = new superClass();
    constructor.prototype.constructor = constructor; // rev. 0.7    
    //   -- extend prototype with Class instance methods
    constructor.prototype.extend( Class.prototype );    
    //   -- override prototype with interface methods
    for( var i = 1; i < arguments.length; i++ )
        constructor.prototype.override( arguments[ i ] );

    return constructor;
}


Class.extend( {
    initSingleton: function() {
        if( this.singleton )
            return this.singleton;
        this.singleton = this.singletonConstructor
            ? new this.singletonConstructor()
            : new this();
        this.singleton.init.apply( this.singleton, arguments );
        return this.singleton;
    }
} );


Class.prototype = {
    destroy: function() {
        try {
            if( this.indirectIndex )
                indirectObjects[ this.indirectIndex ] = undefined;
            delete this.indirectIndex;
        } catch( e ) {}

        for( var property in this ) {
            try {
                if( this.hasOwnProperty( property ) )
                    delete this[ property ];
            } catch( e ) {}
        }
    },

    getBoundMethod: function( methodName ) {
        return this[ name ].bind( this );
    },

    getEventListener: function( methodName ) {
        return this[ methodName ].bindEventListener( this );
    },

    getIndirectIndex: function() {
        if( !defined( this.indirectIndex ) ) {
            this.indirectIndex = indirectObjects.length;
            indirectObjects.push( this );
        }
        return this.indirectIndex;
    },

    getIndirectMethod: function( methodName ) {
        if( !this.indirectMethods )
            this.indirectMethods = {};
        var method = this[ methodName ];
        if( typeof method != "function" )
            return undefined;
        var indirectIndex = this.getIndirectIndex();
        if( !this.indirectMethods[ methodName ] ) {
            this.indirectMethods[ methodName ] = new Function(
                "var o = indirectObjects[" + indirectIndex + "];" +
                "return o." + methodName + ".apply( o, arguments );"
            );
        }
        return this.indirectMethods[ methodName ];
    },

    getIndirectEventListener: function( methodName ) {
        if( !this.indirectEventListeners )
            this.indirectEventListeners = {};
        var method = this[ methodName ];
        if( typeof method != "function" )
            return undefined;
        var indirectIndex = this.getIndirectIndex();
        if( !this.indirectEventListeners[ methodName ] ) {
            this.indirectEventListeners[ methodName ] = new Function( "event",
                "try { event = Event.prep( event ); } catch( e ) {}" +
                "var o = indirectObjects[" + indirectIndex + "];" +
                "return o." + methodName + ".call( o, event );"
            );
        }
        return this.indirectEventListeners[ methodName ];
    }
}
