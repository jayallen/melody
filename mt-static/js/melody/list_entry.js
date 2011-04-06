jQuery(document).ready( function($) {
    $('.list-entry li.quick_look a').click( function() {
        var id = $(this).parents('tr').prev().find('.cb input').val();
        var url = ScriptURI + '?__mode=get_entry&amp;blog_id='+BlogID+'&amp;id=' + id;
        $('#quicklookDialog #content-preview #text').html('').addClass('thinking');
        $("#quicklookDialog").dialog("open");
        $.ajax({
            url: url,
            dataType: 'json',
            error: function (xhr, status, error) {
            },
            success: function (data, status, xhr) {
                $('#quicklookDialog').dialog('option', 'buttons', {
                    'Close':function() {
                        $("#quicklookDialog").dialog("close");
                    }
                });
                var html = data.entry.entry_text_html;
                $('#quicklookDialog #content-preview #text').removeClass('thinking').html( html );
                return false;
            }});
    });
    $("#quicklookDialog").dialog({
        modal: true,
        width: 660,
        height: 500,
        dialogClass: "mt",
        open: function () { $(this).parents('.ui-dialog').wrapInner( '<div class="ui-dialog-inner"></div>' ); },
        autoOpen: false
    });
    $('.listing tr').hover( function() {
        var id;
        if ($(this).hasClass('slave')) {
            id = $(this).prev().find('.cb input').val();
        } else {
            id = $(this).find('.cb input').val();
        }
        $('.listing tr.obj-'+id).addClass('hovered');
      },
      function() {
        var id;
        if ($(this).hasClass('slave')) {
            id = $(this).prev().find('.cb input').val();
        } else {
            id = $(this).find('.cb input').val();
        }
        $('.listing tr.obj-'+id).removeClass('hovered');
    });
    $('.list-entry td.publish a').click( function() {
        var id = $(this).parents('tr').find('.cb input').val();
        ajax_publish( id );
    });    
    $('.list-entry td .actions li.publish_entry a').click( function() {
        var id = $(this).parents('tr').prev().find('.cb input').val();
        ajax_publish( id );
    });
});

function ajax_publish( id ) {
    var link = jQuery('tr#obj-'+id+' td.publish a');
    var was_unpublished = 0;
    if (link.parents('tr').hasClass('unpublished')) {
        was_unpublished = 1;
        var r = confirm("Are you sure you want to change this item's status to 'published?'");
        if (!r) { return; }
    }
    link.css('background','url('+StaticURI+'images/ani-rebuild.gif) no-repeat center -1px');
    jQuery('.listing tr.obj-'+id).addClass('publishing').removeClass('has_published').removeClass('has_errors');
    var url = ScriptURI + '?__mode=rebuild_entry&amp;blog_id='+BlogID+'&amp;id=' + id;
    jQuery.ajax({
        url: url,
        dataType: 'json',
        error: function (xhr, status, error) {
            link.css('background','url('+StaticURI+'images/melody/icon-error.gif) no-repeat center -1px');
            jQuery('.listing tr.obj-'+id).removeClass('publishing').addClass('has_errors');
        },
        success: function (data, status, xhr) {
            jQuery('.listing tr.obj-'+id).removeClass('publishing').addClass('has_published').addClass('published').removeClass('unpublished');
            if (data.success) {
                link.qtip('destroy');
                if (was_unpublished) {
                    link.parents('tr').next().find('.url').hide().html(data.permalink_rel).fadeIn('fast');
                }
                link.fadeOut('slow',function() {
                    jQuery('.listing tr.obj-'+id).removeClass('has_published');
                    link.show();
                    link.css('background','url('+StaticURI+'images/nav-icon-rebuild.gif) no-repeat center 0px');
                });
            } else {
                link.css('background','url('+StaticURI+'images/melody/icon-error.gif) no-repeat center -1px');
                link.qtip({
                    content: data.errstr,
                    position: {
                        corner: {
                            tooltip: 'topRight',
                            target: 'bottomLeft'
                        }
                    },
                    show: {
                        solo: true
                    },
                    style: {
                        border: {
                            width: 3,
                            radius: 5
                        },
                        padding: 6, 
                        tip: true, // Give it a speech bubble tip with automatic corner detection
                        name: 'cream' // Style it according to the preset 'cream' style
                    }
                    });
            }
        }
    });
}
