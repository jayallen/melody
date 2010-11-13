$(document).ready( function() {
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

    $('#list-entry td.publish a').click( function() {
        var link = $(this);
        var id = link.parents('tr').find('.cb input').val();
        var was_unpublished = 0;
        if (link.parents('tr').hasClass('unpublished')) {
            was_unpublished = 1;
            var r = confirm("Are you sure you want to change this item's status to 'published?'");
            if (!r) { return; }
        }
        link.css('background','url('+StaticURI+'images/ani-rebuild.gif) no-repeat center -1px');
        $('.listing tr.obj-'+id).addClass('publishing').removeClass('has_published').removeClass('has_errors');
        var url = ScriptURI + '?__mode=rebuild_entry&amp;blog_id='+BlogID+'&amp;id=' + id;
        $.ajax({
            url: url,
            dataType: 'json',
            error: function (xhr, status, error) {
                link.css('background','url('+StaticURI+'melody/icon-error.gif) no-repeat center -1px');
                $('.listing tr.obj-'+id).removeClass('publishing').addClass('has_errors');
            },
            success: function (data, status, xhr) {
                $('.listing tr.obj-'+id).removeClass('publishing').addClass('has_published').addClass('published').removeClass('unpublished');
                if (data.success) {
                    link.qtip('destroy');
                    if (was_unpublished) {
                      link.parents('tr').next().find('.url').hide().html(data.permalink_rel).fadeIn('fast');
                    }
                    link.fadeOut('slow',function() {
                        $('.listing tr.obj-'+id).removeClass('has_published');
                        link.show();
                        link.css('background','url('+StaticURI+'images/nav-icon-rebuild.gif) no-repeat center 0px');
                    });
                } else {
                    link.css('background','url('+StaticURI+'melody/icon-error.gif) no-repeat center -1px');
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
    });
});
