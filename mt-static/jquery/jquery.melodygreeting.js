(function($){
/*
 * MT Greeting Plugin for jQuery v.0.9.2
 *
 * Copyright (c) 2009-2010 Byrne Reese (endevver.com)
 * Dual licensed under the MIT (MIT-LICENSE.txt)
 * and GPL (GPL-LICENSE.txt) licenses.
 *
 */
    $.fn.greet = function(options) {
	    var defaults = {
	        /* Messages */
	        loggedInMessage:     'Welcome, %p! %o',
	        loggedOutMessage:    '%i or %r',
	        noPermissionMessage: 'Welcome, %p! %o',
	        loginText:           'Sign In',
	        logoutText:          'Sign Out',
	        registerText:        'Sign Up',
	        editProfileText:     '%u',
            indicator:           mt.blog.staticWebPath + 'images/indicator.white.gif',
            linkClass:           'button',
            loginClass:          'login',
            logoutClass:         'logout',
            registerClass:       'register',
            mode:                'mtos',
            greetingContainerTag:  'div',
            isPreview:           false,
            ajaxLogin:           true,
	        returnToURL: null, 
	        /* Events and Callbacks */
	        onSignInClick:  function(e){ return signInClickHandler( $(e) ); },
	        onSignOutClick: function(e){ return signOutClickHandler( $(e) ); },
	        onSignUpClick:  function(e){ return signUpClickHandler( $(e) ); }
	    };
	    var self;
        var settings = $.extend( {}, defaults, options);
	    return this.each(function() {
	        obj = $(this);
	        self = obj;
	        if (jQuery.needsAuth) {
	            $(this).onauthchange( function(e, u) { 
		            _insertText( $(this) ); 
                });
	        } else {
	            _insertText( $(this) );
	            $(this).onauthchange( function() { _insertText( obj ); return false; });
	        }
	    });	
        
	    function _insertText(obj) {
	        var phrase = compileGreetingText();
	        obj.empty().append( jQuery("<" + settings.greetingContainerTag  +">" + phrase + "</" + settings.greetingContainerTag  +">") );
            obj.children().children('a.'+settings.loginClass).click(    function() { return settings.onSignInClick($(this)); });
	        obj.children().children('a.'+settings.logoutClass).click(   function() { return settings.onSignOutClick.call($(this)); });
	        obj.children().children('a.'+settings.registerClass).click( function() { return settings.onSignUpClick.call($(this)); });
	    };
	    function _signIn() {
	        var url = mt.links.signIn;
            if (url.match(/\?/)) { url += '&'; } else { url += '?'; }
	        if (settings.isPreview) {
		        if ( mt.entry && mt.entry.id ) {
		            url += 'entry_id=' + mt.entry.id;
		        } else {
		            url += 'return_url=' + settings.returnToURL;
		        }
	        } else {
	            var doc_url = document.URL;
	            doc_url = doc_url.replace(/#.+/, '');
	            url += 'return_url=' + encodeURIComponent(doc_url);
	        }
	        $.fn.melody.clearUser();
	        location.href = url;
	    };
	    // To make a static function:
	    // * pass in returnToURL
	    // * pass in isPreview
	    function signOutClickHandler(e) {
	        $.fn.melody.clearUser();
	        var doc_url = document.URL;
	        doc_url = doc_url.replace(/#.+/, '');
	        // TODO - error check: signouturl not set?
	        var url = mt.links.signOut;
            if (url.match(/\?/)) { url += '&'; } else { url += '?'; }
	        if (settings.isPreview) {
	            if ( mt.entry && mt.entry.id ) {
		            url += 'entry_id=' + mt.entry.id;
	            } else {
		            url += 'return_url=' + settings.returnToURL;
	            }
	        } else {
	            if (settings.returnToURL) { 
		            url += 'return_url=' + settings.returnToURL;
	            } else {
		            url += 'return_url=' + encodeURIComponent(doc_url);
	            }
	        }
	        location.href = url;
	        return false;
	    };
	    // To make a static function:
	    // * pass in returnToURL
	    // * pass in isPreview
	    function signUpClickHandler(e) {
	        $.fn.melody.clearUser();
	        var doc_url = document.URL;
	        doc_url = doc_url.replace(/#.+/, '');
	        // TODO - error check: signupurl not set?
	        var url = mt.links.signUp;
	        if (url.match(/\?/)) { url += '&'; } else { url += '?'; }
	        if (settings.isPreview) {
		        if ( mt.entry && mt.entry.id ) {
		            url += 'entry_id=' + mt.entry.id;
		        } else {
		            url += 'return_url=' + settings.returnToURL;
		        }
	        } else {
		        url += 'return_url=' + encodeURIComponent(doc_url);
	        }
	        location.href = url;
	        return false;
	    };
	    function signInClickHandler(e) {
            if (settings.ajaxLogin) {
	            var phrase = 'Signing in... <img src="'+settings.indicator+'" height="16" width="16" alt="" />';
	            var target = e.parent().parent();
	            target.html(phrase);
	            $.fn.melody.clearUser(); // clear any 'anonymous' user cookie to allow sign in
	            $.fn.melody.fetchUser(function(u) {
	                if (u && u.is_authenticated) {
		                $.fn.melody.setUser(u);
		                _insertText( $(target) );
	                } else {
		                // user really isn't logged in; so let's do this!
		                _signIn();
	                }
	            });
            } else {
		        _signIn();
            }
	        return false;
        };
	    function compileGreetingText() {
	        var phrase;
	        var u = $.fn.melody.getUser();
	        var profile_link;
	        if ( u && u.is_authenticated ) {
		        if ( u.is_banned ) {
		            phrase = settings.noPermissionText;
		        } else {
		            if ( u.is_author ) {
		                if (mt.links.editProfile) {
		                    profile_link = '<a href="'+mt.links.editProfile;
		                } else if (settings.mode == "mtpro") {
		                    profile_link = '<a href="'+mt.blog.community.script+'?__mode=edit&blog_id=' + mt.blog.id;
		                } else {
		                    profile_link = '<a href="'+mt.blog.comments.script+'?__mode=edit_profile&blog_id=' + mt.blog.id;
		                }
		                if (mt.entry && mt.entry.id)
		                    profile_link += '&entry_id=' + mt.entry.id;
		                if (settings.returnToURL)
		                    profile_link += '&return_to=' + encodeURI(settings.returnToURL);
		                profile_link += '">' + settings.editProfileText + '</a>';
		            } else {
		                // registered user, but not a user with posting rights
		                if (u.url)
		                    profile_link = '<a href="' + u.url + '">' + u.name + '</a>';
		                else
		                    profile_link = u.name;
		            }
		            phrase = settings.loggedInMessage;
		        }
	        } else {
		        // TODO - this obviously does that same thing. 
		        if (mt.blog.registration.required) {
		            phrase = settings.loggedOutMessage;
		        } else {
		            phrase = settings.loggedOutMessage;
		        }
	        }
	        var login_link    = '<a class="'+settings.loginClass+' '+settings.linkClass+'" href="'+mt.links.signIn+'">' + settings.loginText + '</a>';
	        var logout_link   = '<a class="'+settings.logoutClass+' '+settings.linkClass+'" href="'+mt.links.signOut+'">' + settings.logoutText + '</a>';
	        var register_link = '<a class="'+settings.registerClass+' '+settings.linkClass+'" href="'+mt.links.signUp+'">' + settings.registerText + '</a>';
	        phrase = phrase.replace(/\%p/,profile_link);
	        phrase = phrase.replace(/\%i/,login_link);
	        phrase = phrase.replace(/\%o/,logout_link);
	        phrase = phrase.replace(/\%r/,register_link);
	        if ( u && u.is_authenticated ) {
		        phrase = phrase.replace(/\%u/,u.name);
	        }
	        return phrase;
	    };
    };
})(jQuery);
