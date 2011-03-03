var page = 1;
var response_pos = 0;
function setPage(p) {
    page = p;
    $('#steps li').removeClass('active');
    $('.page').hide();
    $('#page-' + p).show();
    var step = $('#steps li.page-' + p);
    step.addClass('active');
}
function interactive_export( c ) {
    var responseText;
    try {
        responseText = c.responseText;
    } catch ( e ) {
        return;
    }
    if (!responseText) return;
    var text = responseText.substr(response_pos);
    text = text.replace(/\s*JSON:(.|\n)*/, '');
    // strip any partial lines. we'll grab 'em next time
    if (!text.match(/\n$/))
        text = text.replace(/(\r?\n)[^\r\n]*$/, '$1');
    response_pos += text.length;
    if (!text.length) return;
    
    text = text.replace(/\r?\n$/, '');
    
    var lines = text.split(/\r?\n/);
    var last_line;
    for (var i = 0; i < lines.length; i++) {
        var line = lines[i];
        var h = $('#export-log ul').append('<li>' + line + '</li>').height();
        $('#export-log').scrollTo( 'max' , { 'axis' : 'y' });
    }
    if (last_line) {
        alert("Last line: " + last_line);
        //current_task.innerHTML = last_line;
    }
   
}
jQuery(document).ready( function($) {
    $('#steps li').click( function() {
        var p = $(this).attr('pageid');
        if (p != page) {
            setPage(p);
        }
    });
});
