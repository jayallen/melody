var last_shown;
function resetPlugin(f) 
{
    if (confirm(mt.screen.trans.RESET_SETTINGS)) {
        f['__mode'].value = 'reset_plugin_config';
        f.submit();
    }
}

function getParameterByName( name )
{
    name = name.replace(/[\[]/,"\\\[").replace(/[\]]/,"\\\]");
    var regexS = "[\\?&]"+name+"=([^&#]*)";
    var regex = new RegExp( regexS );
    var results = regex.exec( window.location.href );
    if( results == null )
        return "";
    else
      return decodeURIComponent(results[1].replace(/\+/g, " "));
}

jQuery(document).ready( function($) {
    $('#content-nav ul li a').click( function() {
        var active    = $(this).parents('ul').find('li.active a').attr('id').replace(/-tab$/,'');
        var newactive = $(this).attr('id').replace(/-tab$/,'');
        //alert('active:'+active+', newactive='+newactive);
        if (active != newactive) {
          $('#content-nav li.active').removeClass('active');
          $('#' + active + '-tab-content').hide();
          $('#content-nav li.' + newactive).addClass('active');
        }
        $('#' + newactive + '-tab-content').show();
        $('h2#page-title').html( $(this).attr('title') );
        document.title = $(this).attr('title');
        window.location.hash = newactive;
    });
    $.history.init(function(hash){
        if (hash == "") { 
            if (getParameterByName('saved')) {
               hash = 'plugin-' + getParameterByName('saved');
            } else {
                hash = $('#content-nav ul li:first-child a').attr('id').replace(/-tab$/,'');
            }
        }
        //alert('hash='+hash);
        $('#content-nav ul li.'+hash+'-tab').addClass('active');
        $('#content-nav ul li.'+hash+'-tab a').click();
    });
});
