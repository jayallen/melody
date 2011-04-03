(function($){
    var defaults = {
        filter_title  : '#filter-title',
        filter_select : '#filter-select',
        selected      : null
    };
    var settings;
    var self;
    var methods = {
        // TODO - handle cancel properly to reset state
        setfilter : function( f, v ) {  
            return this.each( function() {
                self = $(this);
                self.find('#filter-col :selected').removeAttr('selected');
                self.find('#filter-col option[value='+f+']').attr('selected','selected');
                self.find('#filter-col').trigger('change');
                self.find('#'+f+'-val').val( v ).trigger('change');
            });
        },
        init : function( options ) {
            settings = $.extend( {}, defaults, options);
            return this.each( function() {
                self = $(this);
                
                // TODO - port over execFilter
                // TODO - bind keypress to text input fields
                // turn on and off the filter
                self.find('.filter-toggle').click( function() {
                    if ( self.find( settings.filter_title ).is(':visible') ) {
                        self.find( settings.filter_title ).hide();
                        self.find( settings.filter_select ).show();
                    } else {
                        self.find( settings.filter_title ).show();
                        self.find( settings.filter_select ).hide();
                    }
                });
                
                // dislpay fields for selected filter type
                self.find('#filter-col').change( function() {
                    if ( self.find(settings.filter_select).size() == 0 ) return;
                    $(this).parent().find('.shown').hide().removeClass('shown');
                    var value = $(this).val();
                    if ( value != 'none' ) {
                        var fltr = self.find('#filter-' + value);
                        fltr.show().addClass('shown');
                        if ( fltr.find(':selected').hasClass('search') ) self.find('#filter-button').hide();
                        var label = $(this).find(':selected').text();
                        self.find('#filter-text-col').html( '<strong>' + label + '</strong>');
                    }
                });
                
                // execute filter
                self.find('.filter-value').change( function() {
                    // This set the text value of the filter so that it is human readable.
                    if ( $(this).val() == '' && !$(this).find(':selected').hasClass('search') ) return;
                    if ( $(this).is('input') ) {
                        self.find('#filter-text-val').html( '<strong>' + $(this).val() + '</strong>' );
                    } else if ( $(this).is('select') ) {
                        var label = $(this).find(':selected').text();
                        self.find('#filter-text-val').html( '<strong>' + label + '</strong>' );
                        
                        // This makes the button visible or controls filter search function
                        var opt = $(this).find(':selected');
                        if ( $(this).hasClass('has-search') ) {
                            if ( opt.hasClass('search') ) { 
                                window.location = ScriptURI + opt.attr('value');
                            }
                            else {
                                if ( opt.attr('value') == '' ) {
                                    self.find('#filter-button').hide();
                                    return;
                                }
                            }
                        } else if ( $(this).attr('id') == 'filter-col' ) {
                            if (opt.attr('value') == 'author_id') {
                                if ( $('#author_id-val').find(':selected').attr('value') == "") {
                                    self.find('#filter-button').hide();
                                    return;
                                }
                            }
                        }
                    }
                    self.find('#filter-button').css('display','inline');
                });
                
            });
        }
    }; 
    $.fn.listfilter = function( method ) {
        // Method calling logic
        if ( methods[method] ) {
            return methods[ method ].apply( this, Array.prototype.slice.call( arguments, 1 ));
        } else if ( typeof method === 'object' || ! method ) {
            return methods.init.apply( this, arguments );
        } else {
            $.error( 'Method ' +  method + ' does not exist on jQuery.listfilter' );
        }    
    }
})(jQuery);

jQuery(document).ready( function($) {
    /* Dashboard BEGIN */
    $('.widget-close-link').click( function() {
        var w = $(this).parents('.widget');
        var id = w.attr('id');
        var label = w.find('.widget-label span').html();
        w.html('spinner - removing');
		$.post( ScriptURI, {
            '__mode'          : 'update_widget_prefs',
            'widget_id'       : id,
            'blog_id'         : BlogID,
            'magic_token'     : MagicToken,
            'widget_action'   : 'remove',
            'widget_scope'    : 'dashboard:' + (BlogID > 0 ? 'blog' : 'system') + ':' + BlogID,
            'return_args'     : '__mode=dashboard&amp;blog_id=' + BlogID,
            'json'            : 1,
            'widget_singular' : 1
        }, function(data, status, xhr) {
            w.fadeOut().remove();
            $('#add_widget').show();
            $('#add_widget').find('select').append('<option value="'+id+'">'+label+"</option>");
        },'json').error(function() { showMsg("Error removing widget.", "widget-updated", "alert"); });
    });
    $('#add_widget button').click( function() {
        var id = $(this).parent().find('select').val();
		$.post( ScriptURI, {
            '__mode'          : 'update_widget_prefs',
            'blog_id'         : BlogID,
            'magic_token'     : MagicToken,
            'widget_action'   : 'add',
            'widget_scope'    : 'dashboard:' + (BlogID > 0 ? 'blog' : 'system') + ':' + BlogID,
            'widget_set'      : $(this).parents('#add_widget').find('input[name=widget_set]').val(),
            'return_args'     : '__mode=dashboard&amp;blog_id=' + BlogID,
            'widget_id'       : id,
            'json'            : 1,
            'widget_singular' : 1
        }, function(data, status, xhr) {
            var trgt = '#widget-container-' + data['result']['widget_set'];
            alert('appending to: ' + trgt);
            var html = $( data['result']['widget_html'] ).css('visible','hidden');
            $(html).hide().appendTo(trgt).fadeIn('slow');
        },'json').error(function() { showMsg("Error removing widget.", "widget-updated", "alert"); });
    });
/*
        function updateWidget(id) {
            var f = getByID(id + "-form");
            if (!f) return false;
            f['widget_action'].value = 'save';
            if (!TC.Client) return true;
            // if (f['widget_refresh'] && f['widget_refresh'].value) {
            //     return true;
            // }

            var args = DOM.getFormData( f );
            args['json'] = '1';
            TC.Client.call({
                'load': function(c, responseText) { updatedWidget(id, responseText); },
                'error': function() { showMsg("Error updating widget.", "widget-updated", "alert"); },
                'method': 'POST',
                'uri': ScriptURI,
                'arguments': args
            });
            return false;
        }

        function updatedWidget(id, responseText) {
            var el = TC.elementOrId(id);
            var result;
            try {
                result = eval('(' + responseText + ')');
            } catch(e) {
                showMsg("Error updating widget.", "widget-updated", "alert");
                return;
            }
            if (result.result.html) {
        // updatePrefs has returned a new widget
                el.innerHTML = result.result.html;
            }
            if (result.result.message) {
                showMsg(result.result.message, "widget-updated", "info");
            }
        }
*/
    /* Dashboard END */
    /* Display Options BEGIN */
    jQuery('.display-options-link').click( function() {
        var opts = jQuery('#display-options-widget');
        if ( opts.hasClass('active') ) opts.removeClass( 'active' );
        else opts.addClass( 'active' );
    });
    /* Display Options END */

});