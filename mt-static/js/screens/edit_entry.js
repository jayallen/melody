jQuery(document).ready( function($) {
    $('#entry_form').ajaxForm({
        beforeSubmit: function(arr) {
            alert('submitting form');
            $.fancybox({
                //'orig': $(this),
                'opacity': .5,
                'centerOnScroll': true,
                'titleShow': false,
                'showCloseButton': false,
                'enableEscapeButton': false,
                'padding': 0,
                'content': 'Saving...',
                'title'   : 'Saving Entry',
                'transitionIn': 'elastic',
                'transitionOut': 'elastic'
            });

        },
        forceSync: true,
        success: function(txt, status, xhr) {
            alert('success!');
        },
        dataType: 'json'
    });
});