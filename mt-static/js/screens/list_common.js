var cols = [];
var vals = [];
var checked = [];
var total = 0;
var editable_total = 0;
var editable_count_in_page;

var current_id = mt.screen.initial_filter.id;
var currentPage = 1;
var inputCount = 0;
var initial_load = true;

var editSysFilter = 0;
var editNewFilter = 0;
var allPass       = 0;

var request_id = 0;
var this_request;

function handleMessages( data, additional_class ) {
  if ( initial_load ) {
    initial_load = false;
  }
  else {
    jQuery('#msg-block .msg-success').remove();
    jQuery('#msg-container .msg-success').remove();
  }

  if ( data.error ) {
    var error_cls = 'error';
    if ( additional_class ) error_cls += ' ' + additional_class;
    showMessage( data.error, error_cls);
    return false;
  }
  if ( !data.result ) return false;
  var messages = data.result.messages;
  if ( !data.result.messages ) return true;
  for ( var i=0; i < messages.length; i++ ) {
    var msg   = messages[i];
    var cls = msg.cls;
    if ( additional_class ) cls += ' ' + additional_class;
    showMessage(msg.msg, cls);
  }
  return true;
}

function showMessage( content, cls ){
  var error_block;
  if ( typeof content == 'object' ) {
    jQuery('#msg-block').append(
      error_block = jQuery('<div>')
      .attr('class', 'msg msg-' + cls )
      .append(
        jQuery('<p />')
          .attr('class', 'msg-text')
          .append(content)
          .append('<span class="mt-close-msg close-link clickable icon-remove icon16 action-icon">'+mt.screen.trans.CLOSE+'</span>')
      )
    );
  }
  else {
    jQuery('#msg-block').append(
      error_block = jQuery('<div />')
      .attr('class', 'msg msg-' + cls )
      .append(
        jQuery('<p />')
          .attr('class', 'msg-text')
          .append(content)
          .append('<span class="mt-close-msg close-link clickable icon-remove icon16 action-icon">'+mt.screen.trans.CLOSE+'</span>')
      )
    );
  }
  return error_block;
}

function loginAgain(fn) {
  jQuery(window)
    .unbind('dialogReady.loginAgain')
    .bind('dialogReady.loginAgain', function(){
      var dialog = jQuery('#mt-dialog-iframe').contents();
      dialog
        .find('#sign-in-button')
          .text(mt.screen.trans.CONTINUE)
          .unbind()
          .click(function(){
            dialog.find('#msg-block').empty();
            jQuery.ajax({
              type: 'POST',
              async: false,
              url: ScriptURI,
              dataType: 'json',
              data: {
                __mode: 'login_json',
                username: dialog.find('#username').val(),
                password: dialog.find('#password').val()
              },
              success: function(data) {
                jQuery.fn.mtDialog.close();
                fn();
                return false;
              },
              error: function(data) {
                dialog.find('#password').val('');
                dialog
                  .find('#msg-block')
                  .append('<div class="msg msg-error">'+mt.screen.trans.INVALID_LOGIN+'</div>');
              }
            });
            return false;
          });
    });
  jQuery.fn.mtDialog.open(ScriptURI + '?__mode=dashboard');
}

function renderFilterList() {
  jQuery('#dialog_filter_content').empty();
  var has_user_filter = 0;
  var has_sys_filter = 0;
  for (var i = 0, length = mt.screen.filters.length; i < length; i++) {
    if ( parseInt(mt.screen.filters[i].can_save) )
      has_user_filter++;
    else
      has_sys_filter++;
  }

  jQuery('<div class="filter-list-block">')
    .append(
      jQuery('<h3 class="filter-list-label" />').text(mt.screen.trans.MY_FILTERS))
    .append(
      jQuery('<ul id="user-filters" class="editable"><li class="filter line"><a href="#" id="new_filter" class="icon-mini-left addnew create-new apply-link">'+mt.screen.trans.CREATE_NEW+'</a></li></ul>'))
    .appendTo('#dialog_filter_content');

  if ( has_sys_filter ) {
    jQuery('<div class="filter-list-block">')
      .append(
        jQuery('<h3 class="filter-list-label" />').text(mt.screen.trans.BUILT_IN))
      .append(
        jQuery('<ul id="built-in-filters" />'))
      .appendTo('#dialog_filter_content');
  }

  for (var i = 0, length = mt.screen.filters.length; i < length; i++) {
    var filter = mt.screen.filters[i];
    if ( parseInt(filter.can_save) ) {
      var line = '<span class="filter-label unit size2of3"><a href="#'+i+'" class="apply-link '
        + ( filter.can_save ? 'user-filter' : 'system-filter' )
        + '">'+filter.label+'</a></span>'
        + '<span class="item-ctrl unit size1of3"><a href="#'+i+'" class="rename-link tool-link">'+mt.screen.trans.RENAME+'</a><a href="#'+i+'" class="delete-link action-icon icon16 icon-delete">'+mt.screen.trans.DELETE+'</a></span>';
      jQuery('<li class="filter line" />').append(line).prependTo('#user-filters');
    }
    else {
      var line = '<span class="filter-label"><a href="#'+i+'" class="apply-link '
        + ( filter.can_save ? 'user-filter' : 'system-filter' )
        + '">'+filter.label+'</a></span>';
      jQuery('<li class="filter line" />').append(line).appendTo('#built-in-filters');
    }
  }
  jQuery('#new_filter').click(function() {
    jQuery('#filter-detail').show().parent('#filter').addClass('active');
    jQuery('#item_list').attr('selectedIndex', 0);
    resetFilterDetails();
    jQuery('input[name=filter_name]').mtUnvalidate().val(mt.screen.trans.NEW_FILTER);
    jQuery('#opener').html(mt.screen.trans.NEW_FILTER);
    jQuery('#filter_id').val('');
    jQuery('input[name=filter_id]').val('');
    updateItemList();
    jQuery('#dialog_filter').dialog('close');
    updateFilterSaveButtons({
      system:     0,
      new_filter: 1,
      allpass:    0
    });
  });
  jQuery('#dialog_filter .filter-label a:not(#new_filter)').click(function() {
    jQuery('#dialog_filter').dialog('close');
    jQuery(this).attr('href').match(/#(.*)/);
    var index = RegExp.$1;
    applyFilter(index);
    updateFilterSaveButtons();
    return false;
  });
  jQuery('#dialog_filter .delete-link').click(function() {
      var label = $(this).parents('.filter').find('.apply-link').text();
      var message = trans("Are you sure you want to remove the filter '[_1]'?", label);
      if (confirm(message)) {
          $(this).parents('.filter').addClass('edit-mode').find('.item-ctrl').hide();
          $(this).parents('.filter').find('.filter-label').hide().after( jQuery('<span class="indicator"><img alt="'+mt.screen.trans.LOADING+'" src="<mt:var name="static_uri">images/indicator.white.gif" /></span>') );
          removeFilter(this);
      }
      return false;
  });
  jQuery('#dialog_filter .rename-link').click(openFilterRenameField);
}

function updateFilterSaveButtons ( opts ){
  if ( opts ) {
    if ( opts.allpass    != undefined ) allPass       = opts.allpass;
    if ( opts.new_filter != undefined ) editNewFilter = opts.new_filter;
    if ( opts.system     != undefined ) editSysFilter = opts.system;
  }

  if ( jQuery('#filter-detail div.filteritem').length > 0 ) {
    jQuery('#apply').removeClass('disabled').removeAttr('disabled');

    if ( editSysFilter )
      jQuery('#save').addClass('disabled').attr('disabled', 'disabled');
    else
      jQuery('#save').removeClass('disabled').removeAttr('disabled');

    if ( editNewFilter )
      jQuery('#saveas').hide();
    else
      jQuery('#saveas').show();
  }
  else {
    jQuery('#apply').addClass('disabled').attr('disabled','disabled');
    jQuery('#save').addClass('disabled').attr('disabled', 'disabled');
    jQuery('#saveas').hide();
  }
  if ( allPass ) {
    jQuery('#allpass-filter').hide();
  }
  else {
    jQuery('#allpass-filter').show();
  }
}

function openFilterRenameField() {
  cancelFilterRenameField();
  var $this = jQuery(this);
  $this.parents('.filter').addClass('edit-mode');
  $this.attr('href').match(/#(.*)/);
  var index = RegExp.$1;
  var fid = mt.screen.filters[index].id;
  var $label = $this.parents('.filter').children('.filter-label');
  var $handle = $this.parents('.filter').children('.item-ctrl');
  var text = $label.find('.apply-link').hide().text();
  jQuery('<input type="text" id="filter_'+fid+'" class="text full rename-filter-input" />')
    .val(text)
    .appendTo($label);
  $this.hide().next('.delete-link').hide();
  jQuery('<a href="#'+fid+'" class="tool-link save button">'+mt.screen.trans.SAVE+'</a>').bind('click', function() {
    var name = jQuery('#filter_'+fid).val();
    if (name == text) {
        // Not modified.
        $handle.find('.cancel').click();
        return false;
    }
    if ( !jQuery('#filter_' + fid).mtValidate('dialog') )
        return false;
    $this.parents('.filter').find('.item-ctrl').hide();
    $this.parents('.filter').find('input').hide().after( jQuery('<span class="indicator"><img alt="'+mt.screen.trans.LOADING+'" src="<mt:var name="static_uri">images/indicator.white.gif" /></span>') );
    renameFilter(index, fid, name);
    return false;
  }).appendTo($handle);
  jQuery('<a href="#'+fid+'" class="tool-link cancel button">'+mt.screen.trans.CANCEL+'</a>')
    .bind('click', cancelFilterRenameField )
    .appendTo($handle);
  return false;
}

function cancelFilterRenameField() {
  jQuery('.rename-filter-input').mtUnvalidate();
  jQuery('.filter').removeClass('edit-mode');
  jQuery('.filter-label')
    .find('.apply-link:hidden').show().end()
    .find('input').remove();
  jQuery('.item-ctrl')
    .find('a.save, a.cancel').remove().end()
    .find('a:hidden').css('display','inline-block')
  return false;
}

function renameFilter(index, fid, name) {
  jQuery.ajax({
    type: 'POST',
    url: ScriptURI,
    dataType: 'json',
    data: {
      __mode: 'save_filter',
      datasource: mt.screen.list_type,
      blog_id: BlogID,
      fid: fid,
      label: name,
      items: jQuery.toJSON(mt.filters.filters[index].items),
      list: 0
    },
    success: function(data) {
      if ( !handleMessages(data) ) return;
      filters = data.result.filters;
    },
    complete: function() {
      if ( fid == current_id ) {
          jQuery('#opener').text(name);
      }
      renderFilterList();
    },
    error: function(xhr, status) {
      if ( xhr.status == 401 ) {
        loginAgain(function(){
          renameFilter(index, fid, name);
        });
      }
      else {
        alert( trans('Communication Error ([_1])', xhr.status) );
      }
    }
  });
}

function removeFilter(element) {
  var $node = jQuery(element).parents('li');
  jQuery(element).attr('href').match(/#(.*)/);
  var index = RegExp.$1;
  var remove_current = mt.screen.filters[index].id == current_id;
  if ( remove_current ) {
    updateFilterSaveButtons({ allpass: 1 });
    doApplyFilter(mt.screen.allpass_filter, 1);
    renderList({
      mode: 'delete_filter',
      id: mt.screen.filters[index].id
    });
  }
  else {
    jQuery.ajax({
      type: 'POST',
      url: ScriptURI,
      dataType: 'json',
      data: {
        __mode: 'delete_filter',
        id: mt.screen.filters[index].id,
        datasource: mt.screen.list_type,
        blog_id: BlogID,
        list: 0
      },
      success: function(data) {
        if ( !handleMessages(data) ) return;
        filters = data.result.filters;
      },
      complete: function() {
        renderFilterList();
      },
      error: function(xhr, status) {
        if ( xhr.status == 401 ) {
          loginAgain(function(){
            removeFilter(element);
          });
        }
        else {
          alert( trans('Communication Error ([_1])', xhr.status) );
        }
      }
    });
  }
}

function renderColumns( col, chk ) {
  cols = [];
  var e = jQuery('table.listing-table thead th, table.listing-table tfoot th').hide();
  if (mt.screen.has_list_actions) e.filter('.cb').show();
  jQuery('ul#disp_cols input:checked').each(function() {
    jQuery(this).attr('id').match(/custom-prefs-(.*)/);
    var id = RegExp.$1;
    cols.push(id);
  });
  jQuery('ul#disp_cols input.main:checked').each(function() {
    var id = jQuery(this).val();
    jQuery('table.listing-table th.'+id).show();
  });
  if ( col && chk ) {
    var header = jQuery('table.listing-table thead th.' + col);
    var idx = jQuery('table.listing-table thead th:visible').index(header) - 1;
    jQuery('table.listing-table tr').each( function() {
      jQuery(this).find('td:eq(' + idx + ')').after( '<td class="col"> </td>' );
    });
  }
  else if ( col && !chk ) {
    jQuery('table.listing-table td.' + col).remove();
  }
  jQuery('table.listing-table thead, table.listing-table tfoot').each(function() {
    jQuery(this)
      .find('th')
      .removeClass('first-visible-child')
      .filter(':visible:first')
      .addClass('first-visible-child');
  });
  // Re-render the table for IE.
  if ( window.navigator.userAgent.match(/MSIE/) )
    jQuery('table.listing-table').insertAfter('#listing-table-overlay');
}

function saveChecked(page) {
  checked[page] = [];
  jQuery('table.listing-table tbody tr input:checked').each(function() {
    var id = jQuery(this).parents('tr').attr('id');
    checked[page][id] = 1;
  });
}

function renderPagination(count, limit, page, last, total) {
  var $e = jQuery('.pagination').empty();
  if (count == 0) {
    return;
  }
  var usefirst = false;
  var uselast = false;
  var start;
  if (page > 1) {
    usefirst = true;
    start = (page-1)*limit+1;
  } else {
    start = 1;
  }
  if (total / limit > 1) {
    if (page + 1 <= last) {
      uselast = true;
    }
  }
  currentPage = page;

  if (usefirst) {
    $e.append('<a href="#" class="pagenav start">&laquo; '+mt.screen.trans.FIRST+'</a>')
      .append('<a href="#" class="pagenav to-start">&lsaquo; '+mt.screen.trans.PREV+'</a>');
  } else {
    $e.append('<span class="pagenav start disabled">&laquo; '+mt.screen.trans.FIRST+'</span>')
      .append('<span class="pagenav to-start disabled">&lsaquo; '+mt.screen.trans.PREV+'</span>');
  }
  var end = (page == last) ? total : start+limit-1;
  var page_status = trans('[_1] - [_2] of [_3]', start, end, total);

  $e.append('<span class="current-rows">'+page_status+'</span>')
  if (uselast) {
    $e.append('<a href="#" class="pagenav to-end">'+mt.screen.trans.NEXT+' &rsaquo;</a>')
      .append('<a href="#" class="pagenav end">'+mt.screen.trans.LAST+' &raquo;</a>');
  } else {
    $e.append('<span class="pagenav to-end disabled">'+mt.screen.trans.NEXT+' &rsaquo;</span>')
      .append('<span class="pagenav end disabled">'+mt.screen.trans.LAST+' &raquo;</span>');
  }
  jQuery('a.start').click(function() {
    saveChecked(page);
    renderList('filtered_list', cols, vals, jQuery('#row').val(), 1);
    return false;
  });
  jQuery('a.to-start').click(function() {
    saveChecked(page);
    renderList('filtered_list', cols, vals, jQuery('#row').val(), page-1);
    return false;
  });
  jQuery('a.to-end').click(function() {
    saveChecked(page);
    renderList('filtered_list', cols, vals, jQuery('#row').val(), page+1);
    return false;
  });
  jQuery('a.end').click(function() {
    saveChecked(page);
    renderList('filtered_list', cols, vals, jQuery('#row').val(), last);
    return false;
  });
}

function saveListPrefs() {
  cols = [];
  jQuery('ul#disp_cols input:checked').each(function() {
    jQuery(this).attr('id').match(/custom-prefs-(.*)/);
    var id = RegExp.$1;
    cols.push(id);
  });

  jQuery.ajax({
    type: 'POST',
    url: ScriptURI,
    dataType: 'json',
    data: {
      __mode: 'save_list_prefs',
      datasource: mt.screen.list_type,
      blog_id: BlogID,
      columns: cols.join(','),
      limit: jQuery('#row').val()
    },
    success: function(data) {
      handleMessages(data);
      return false;
    },
    error: function(xhr, status) {
      if ( typeof this_request == 'undefined' || this_request != request_id ) {
          return false;
      }
      if ( xhr.status == 401 ) {
        loginAgain(function(){
          renderList(mode, columns, values, limit, page);
        });
      }
      else {
        alert( trans('Communication Error ([_1])', xhr.status) );
      }
    }
  });
}

function renderList(mode, columns, values, limit, page ) {
  this_request = ++request_id;
  // If the first arg is Object, it's Hash style call
  var args = {};
  if ( typeof mode == 'object' ) {
    args = mode;
    var defaults = {
      mode: 'filtered_list',
      columns: cols,
      values:  vals,
      limit: jQuery('#row').val(),
      page: currentPage
    };
    mode    = ( 'mode' in args )    ? args['mode']    : defaults['mode'];
    columns = ( 'columns' in args ) ? args['columns'] : defaults['columns'];
    values  = ( 'values' in args )  ? args['values']  : defaults['values'];
    limit   = ( 'limit' in args )   ? args['limit']   : defaults['limit'];
    page    = ( 'page' in args )    ? args['page']    : defaults['page'];
    delete args['mode'];
    delete args['columns'];
    delete args['values'];
    delete args['limit'];
    delete args['page'];
  }
  limit = parseInt(limit);
  if ( args['magic_token'] ) {
    args['magic_token'] = MagicToken;
  }
  var params = {
    __mode: mode,
    datasource: mt.screen.list_type,
    blog_id: BlogID,
    columns: columns.join(','),
    limit: limit,
    page: page
  };
  params = jQuery.extend( params, args );

  if (values.length) {
    params['items'] = jQuery.toJSON(values);
  }
  if (jQuery('table.listing-table th.sorted').length) {
    jQuery('table.listing-table th.sorted').find('a').attr('href').match(/#(.*)/);
    params['sort_by'] = RegExp.$1;
    params['sort_order'] = jQuery('table.listing-table th.sorted').find('span').hasClass('desc') ? 'descend' : 'ascend';
  }
  if (jQuery('input[name=filter_id]').val()) {
    params['fid'] = jQuery('input[name=filter_id]').val();
  }
  if (jQuery('input[name=filter_name]').val()) {
    params['label'] = jQuery('input[name=filter_name]').val();
  }

  jQuery('.indicator, #listing-table-overlay').show();
  jQuery('div.pagination').hide();
  jQuery('#msg-block div.msg-error.filtered-list-msg').remove()
  jQuery.ajax({
    type: 'POST',
    url: ScriptURI,
    dataType: 'json',
    data: params,
    success: function(data) {
      if ( this_request != request_id ) {
          return false;
      }

      if ( !handleMessages(data, 'filtered-list-msg' ) ) return;
      if (mt.config.debug_mode && data.result.debug) {
        jQuery('#listing-debug-block').text(data.result.debug);
      }
      jQuery('table.listing-table tbody').empty();
      jQuery('table.listing-table th :checkbox').removeAttr('checked');
      var objs = data.result.objects;
      var count = objs.length;
      var last = data.result.page_max;
      total = parseInt(data.result.count);
      editable_total = parseInt(data.result.editable_count);
      var return_columns = data.result.columns.split(',');
      var return_cols = jQuery.grep( return_columns, function( val, idx ){
        return val.match(/\./);
      }, true );
      var main_cols = {};
      jQuery('ul#disp_cols input:checked').each(function() {
//      jQuery('#disp_cols input.main.checkbox:checked').each(function() {
        main_cols[ jQuery(this).val() ] = 1;
      });
      editable_count_in_page = 0;
      for (var row = 0; row < count; row++) {
        var id = objs[row][0];
        var line = '';
        if ( id ) {
          editable_count_in_page++;
          if (checked[page] && checked[page][id]) {
            line = '<td class="cb col"'+(mt.screen.has_list_actions ? '' : ' style="display: none;"')+'><input type="checkbox" checked="checked" name="id" value="'+id+'" /></td>';
          } else {
            line = '<td class="cb col"'+(mt.screen.has_list_actions ? '' : ' style="display: none;"')+'><input type="checkbox" name="id" value="'+id+'" /></td>';
          }
        }
        else {
          line = '<td class="cb col"'+(mt.screen.has_list_actions ? '' : ' style="display: none;"')+'></td>';
        }
        for (var col = 1, col_length = objs[row].length; col < col_length; col++) {
          var col_id = return_cols[ col - 1 ];
          if ( main_cols[col_id] ) {
              line += '<td class="col '+col_id+' '+mt.screen.col_classes[col_id]+'">' + objs[row][col] + '</td>';
          }
        }
        jQuery('<tr id="'+id+'"' + ( id ? '' : ' class="no-action"' ) + '>'+line+'</tr>').appendTo('table.listing-table tbody');
      }
      jQuery('#resultstats').remove();
      var n = columnLength();
      if (count == 0) {
        var message = trans('No [_1] could be found.', (mt.screen.zero_state ? mt.screen.zero_state : mt.screen.object_label_lc));
        jQuery('<td class="col fullwidth-row" colspan="'+n+'">'+message+'</tr>').appendTo('table.listing-table tbody');
      }
      renderPagination(count, limit, page, last, total);
      filters = data.result.filters;
      if ( data.result.label ) {
        jQuery('#opener').html(data.result.label);
        jQuery('#filter_name').val(data.result.label);
      }
      if ( data.result.id ) {
        jQuery('#filter_id').val(data.result.id);
        current_id = data.result.id;
      }
    },
    complete: function() {
      if ( this_request != request_id ) {
          return false;
      }
      jQuery('.indicator, #listing-table-overlay').hide();
      jQuery('div.pagination').show();

      jQuery('table.listing-table tbody tr:even').addClass('even');
      jQuery('table.listing-table tbody tr:odd').addClass('odd');
      var $checkboxes = jQuery('td :checkbox');
      var $checked = jQuery('td :checked');
      $checked.parents('tr').addClass('selected');
      if ($checkboxes.length && $checkboxes.length == $checked.length) {
        jQuery('table.listing-table th :checkbox').attr('checked', 'checked');
        addSelectAll($checkboxes);
      }
      if (mode == 'save_filter' || mode == 'delete_filter') {
        renderFilterList();
        updateFilterSaveButtons({
          system:     0,
          new_filter: 0
        });
      }

      if (!jQuery('#msg-block .msg-error').length) {
        jQuery('#dialog_save_filter').dialog('close');
      } else {
        if (jQuery('#dialog_save_filter:visible').length) {
          jQuery('.msg-error').clone().appendTo('#dialog-msg-block');
          jQuery('#msg-block').hide();
        }
      }
      jQuery(window).trigger('listReady');
    },
    error: function(xhr, status, error) {
      if ( this_request != request_id ) {
          return false;
      }
      if ( xhr.status == 401 ) {
        loginAgain(function(){
          renderList(mode, columns, values, limit, page);
        });
      }
      else if ( xhr.status == 0 ) {
        // Maybe this is user abort. do nothing.
      }
      else {
        alert( trans('Communication Error ([_1])', xhr.status) );
      }
    }
  });
}

jQuery.fn.mtRenderList = renderList;

function itemValues() {
  var $items = jQuery('#filter-detail .filteritem:not(.error)');
  vals = [];
  $items.each(function() {
    var data = {};
    var fields = [];
    var $types = jQuery(this).find('.filtertype');
    $types.each(function() {
      jQuery(this).attr('class').match(/type-(\w+)/);
      var type = RegExp.$1;
      jQuery(this).find('.item-content').each(function() {
        var args = {};
        jQuery(this).find(':input').each(function() {
          var re = new RegExp(type+'-(\\w+)');
          jQuery(this).attr('class').match(re);
          var key = RegExp.$1;
          args[key] = jQuery(this).val();
        });
        fields.push({'type': type, 'args': args});
      });
    });
    if (fields.length > 1 ) {
      data['type'] = 'pack';
      data['args'] = {
        "op":"and",
        "items":fields
      };
    } else {
      data = fields.pop();
    }
    vals.push(data);
  });
}

function toggleSubField (obj) {
  if ( jQuery(obj).is(':checked') ) {
    jQuery( '#listing-table .' + jQuery(obj).val() ).show();
  } else { 
    jQuery( '#listing-table .' + jQuery(obj).val() ).hide();
  }
}

function addSelectAll($node) {
  if (editable_count_in_page >= editable_total) {
    return false;
  }

  var n = columnLength();
  $node
    .parents('tbody')
    .append('<tr class="select-all"><td class="col fullwidth-row" colspan="'+n+'"></td></tr>')
    .prepend('<tr class="select-all"><td class="col fullwidth-row" colspan="'+n+'"><input type="hidden" name="all_selected" /></td></tr>');
  var select_text = trans('Select all [_1] items', editable_total);
  var cancel_text = trans('All [_1] items are selected', editable_total);
  jQuery('<a href="#"></a>')
    .appendTo('.select-all td')
    .text(select_text)
    .bind('click', function() {
      var $input = jQuery('input[name=all_selected]');
      if ($input.val()) {
        $input.val('');
        jQuery('.select-all td').find('a').text(select_text);
      } else {
        $input.val('1');
        jQuery('.select-all td').append(cancel_text).addClass('highlight').find('a').remove();
      }
      return false;
    });
}

function removeSelectAll($node) {
  $node
    .parents('tbody')
    .find('.select-all')
    .remove();
  jQuery('input[name=all_selected]').val('');
}

function columnLength () {
  return jQuery('#disp_cols').find('input.main:checked').length + (mt.screen.has_list_actions ? 1 : 0);
}

function dateOption($node) {
  var val = $node.val();
  var type;
  switch (val) {
  case 'days':
    type = 'days';
    break;
  case 'before':
  case 'after':
    type = 'date';
    break;
  case 'future':
  case 'past':
    type = 'none';
    break;
  default:
    type = 'range';
  }

  $node.parent('.item-content').find('input').mtUnvalidate();
  $node.parent('.item-content').find('.date-options span.date-option').hide();
  $node.parent('.item-content').find('.date-option.'+type).show();
}

function filterItem(type, datepicker_off) {
  var $item = jQuery(mt.screen.filter_types[type]);
  if ( $item && $item.attr('class') && $item.attr('class').match(/no-edit/) ) {
    $item.find('input').attr('disabled', 1);
    $item.find('select').attr('disabled', 1);
  }
  if ( !datepicker_off ) {
    $item
      .find('.filter-date').each(function() {
          dateOption(jQuery(this));
      }).bind('change', function() {
          dateOption(jQuery(this));
      }).end()
      .find('.date').datepicker({
        dateFormat: 'yy-mm-dd',
        dayNamesMin: mt.screen.trans_DAY_NAMES,
        monthNames: ['- 01','- 02','- 03','- 04','- 05','- 06','- 07','- 08','- 09','- 10','- 11','- 12'],
        showMonthAfterYear: true,
        prevText: '&lt;',
        nextText: '&gt;',
        onSelect: function( dateText, inst ) {
          inst.input.mtValid();
        }
      });
  }
  return $item;
}

var validateErrorMessage;

function validateFilterDetails () {
  if ( validateErrorMessage ) {
    validateErrorMessage.remove();
  }
  var errors = 0;
  jQuery('div#filter-detail div.filteritem').each( function () {
    if ( !jQuery(this).find('input:visible').mtValidate() ) {
      errors++;
      jQuery(this).addClass('highlight error');
    }
    else {
      jQuery(this).removeClass('highlight error');
    }
  })
  if ( errors ) {
    validateErrorMessage = showMessage( trans('[_1] Filter Items have errors', errors ), 'error' );
  }
  return errors ? false : true;
}

function resetFilterDetails() {
  if ( validateErrorMessage ) {
    validateErrorMessage.remove();
  }
  validateErrorMessage = false;
  jQuery('div#filter-detail div.filteritem')
    .find('input, select')
    .mtUnvalidate()
    .end()
    .remove();
}

function validateFilterName (name) {
  var res = true;
  jQuery('a.apply-link').each( function() {
      if ( jQuery(this).text() == name )
          res = false;
  });
  return res;
}

function addItems(items, op) {
  var type;
  var args;
  if ( !items )
      items = [];
  for (var i = 0, length = items.length; i < length; i++) {
    type = items[i].type;
    if (type == 'pack') {
      addItems(items[i].args.items, items[i].args.op);
    }
    var $filteritem = jQuery('.filteritem:first');
    var $filtertype;
    var prev_type;
    if ($filteritem.length) {
      $filtertype = $filteritem.children('.filtertype:last');
      $filtertype.attr('class').match(/type-(\w+)/);
      prev_type = RegExp.$1;
    }
    var $item = filterItem(type);
    $item.find('input').each( function() {
      var id = jQuery(this).attr('id') || jQuery(this).attr('name') || 'input-' + inputCount++;
      jQuery(this)
        .attr('id', id)
        .attr('name', id);
    });


    if (op && type == prev_type) {
      $item
        .insertAfter($filtertype)
        .find('.item-label').addClass('invisible');
    } else {
      var $div = jQuery('<div class="filteritem" />').addClass('itemtype-' . type);
      $item
        .insertAfter('.selectfilter')
        .wrap($div)
        .find('.minus').hide().end();
      jQuery('<span class="close-link clickable remove icon-remove icon16 action-icon">'+mt.screen.REMOVE_ITEM+'</span>')
        .insertAfter($item)
        .bind('click', function() {
          jQuery(this).parent('.filteritem').find('input').mtUnvalidate().end().remove();
          updateItemList();
          updateFilterSaveButtons();
        });
    }
    args = items[i].args;
    for (var key in args) {
      if ( typeof args[key] != 'string' && typeof args[key] != 'number' ) continue;
      // A sort of hack to decode HTML entities using jQuery.
      var decoded = jQuery('<div>').html( args[key] ).text();
      $item.find('.'+type+'-'+key).each( function(){
        if ( jQuery(this).is('input, select') )
            jQuery(this).val( decoded );
        else
            jQuery(this).text( decoded );
      });
    }
    var $node = $item.find('.filter-date');
    if ($node) {
      dateOption($node);
    }
  }
  updateItemList();
  updateFilterSaveButtons();
}

function applyFilter(index, no_render) {
  if (index >= 0 && mt.screen.filters[index].items) {
    var filter = mt.screen.filters[index];
    doApplyFilter(filter, no_render);
    allPass = 0;
  }
}

function doApplyFilter(filter, no_render) {
  jQuery('#filter_name').val('');
  jQuery('#filter_id').val('');
  resetFilterDetails();
  var name = filter.label;
  addItems(filter.items);
  jQuery('#opener').html(name);
  jQuery('#filter_name').val(name);
  jQuery('#filter_id').val(filter.id);
  current_id = filter.id;
  if ( parseInt(filter.can_save) )
    editSysFilter = 0;
  else
    editSysFilter = 1;
  if ( filter.id == '_allpass' )
    allPass = 1;
  jQuery('input[name=filter_id]').val(filter.id);
  itemValues();
  if ( !no_render )
    renderList('filtered_list', cols, vals, jQuery('#row').val(), 1);
}

function doForMarked(formid, action, singlar, plural, phrase, xhr) {
  var $form = jQuery('#'+formid);
  if (!$form.length) {
    return;
  }

  var mode;
  var params = {};
  if ( action == 'itemset_action' ) {
      var $selected = $form.find('option:selected');
      action = $selected.val();
  }

  if (action == '' || action == '0') {
    alert(trans('You must select an action.'));
    return;
  }
  var opt = itemset_options[action];
  if ( !opt )
    return false;
  var xhr = opt['xhr'];
  var mode = opt['mode'] || 'itemset_action';
  if ($form.find('input[name=itemset_action_input]').val()) {
    $form.find('input[name=itemset_action_input]').val('');
  }

  var count = $form.find('input[name=id]').filter(':checked').length;
  if ( jQuery('input[name=all_selected]').val() == 1 ) {
      count = total;
  }
  if (!count) {
    alert(trans('You did not select any [_1] to [_2].', plural, phrase));
    return;
  }
  if (opt['min'] && (count < opt['min'])) {
    alert(trans('You can only act upon a minimum of [_1] [_2].', opt['min'], plural));
    return false;
  } else if (opt['max'] && (count > opt['max'])) {
    alert(trans('You can only act upon a maximum of [_1] [_2].', opt['max'], plural));
    return false;
  } else if (opt['input']) {
    if (input = prompt(opt['input'])) {
      $form.find('[name=itemset_action_input]').val(input);
      params['itemset_action_input'] = input;
    } else {
      return false;
    }
  }

  if (xhr) {
    params['mode'] = mode;
    params['xhr'] = 1;
    params['all_selected'] = jQuery('input[name=all_selected]').val();
    params['magic_token'] = 1;
    params['id'] = $form
        .find('input[name=id]:checked')
        .map(function(){
            return jQuery(this).val();
        })
        .get()
        .join(",");
    params['_type'] = mt.screen.object_type;
  } else {
    jQuery('input[name=return_args]').val(jQuery('input[name=return_args]').val()+'&does_act=1');
  }

  if (action) {
    $form.find('input[name=action_name]').val(action);
      params['action_name'] = action;
  } else {
    $form.find('input[name=action_name]').val('');
  }

  if (vals.length) {
    var items = jQuery.toJSON(vals);
    $form.find('input[name=items]').val(items);
    params['items'] = items;
  }

  if (opt['no_prompt']) {
      // Do always.
  }
  else if (opt['continue_prompt']) {
    if (!confirm(opt['continue_prompt'])) {
      return false;
    }
  }
  else if (phrase) {
    var message = ( count == 1 )
      ? trans('Are you sure you want to [_2] this [_1]?', singlar, phrase)
      : trans('Are you sure you want to [_3] the [_1] selected [_2]?', count, plural, phrase);
    if (!confirm(message)) {
        return;
    }
  }

  $form.find('input[name=__mode]').val(mode);
  if ( xhr )
    renderList(params);
  else if ( opt['dialog'] )
    jQuery.fn.mtDialog.open(ScriptURI + '?' + $form.serialize());
  else {
    $form.unbind('submit.as_apply').submit();
  }
}

function updateItemList () {
  var list = jQuery('#item_list');
  list.find('option').removeAttr('disabled');
  jQuery('#filter-detail').find('.filtertype').each( function() {
    jQuery(this).attr('class').match(/type-(\w+)/);
    var type = RegExp.$1;
    list.find('option[value=' + type + ']').attr('disabled','disabled');
  });
}

jQuery(document).ready( function($) {

    $.event.special.listReady = {
        setup:function( data, ns ) {
            return false;
        },
        teardown:function( ns ) {
            return false;
        }
    };

    $(window).bind( 'ajaxStart', function() {
        $('#msg-block .msg-error').remove();
    });

    $.mtValidateRules['[name=filter_name], .rename-filter-input'] = function (e) {
        return validateFilterName(e.val()) ? true : this.raise(trans('Label "[_1]" is already in use.', e.val() ));
    };

    $('ul#disp_cols .main:checkbox').click(function() {
        var col = $(this).val();
        var checked = $(this).is(':checked');
        renderColumns(col, checked);
        if (checked)
            renderList('filtered_list', cols, vals, $('#row').val(), currentPage);
        else
            saveListPrefs();
        var n = columnLength();
        $('td.fullwidth-row').attr('colspan', n);
    });

    $('ul#disp_cols .sub:checkbox').click(function() {
        toggleSubField(this);
        var n = columnLength();
        $('td.fullwidth-row').attr('colspan', n);
        saveListPrefs();
    });

    $('#reset-display-options').click(function() {
        $('#disp_cols input[type=checkbox]').each(function() {
            if ( $(this).is('.show-default') ) {
                $(this).attr('checked', 'checked');
            }
            else {
                $(this).removeAttr('checked');
            }
        });
        renderColumns();
        renderList({});
        var n = columnLength();
        $('td.fullwidth-row').attr('colspan', n);
        return false;
    });

    $('#row').change(function() {
        $('table.listing-table tbody').empty();
        checked = [];
        renderColumns();
        renderList('filtered_list', cols, vals, $(this).val(), 1);
    });

    $('table.listing-table th :checkbox').click(function() {
        var $checkboxes = $('tr :checkbox');
        if (this.checked) {
            $checkboxes.attr('checked', 'checked');
            addSelectAll($checkboxes);
            $checkboxes.parents('tr').addClass('selected');
        } else {
            $checkboxes.removeAttr('checked');
            removeSelectAll($checkboxes);
            $checkboxes.parents('tr').removeClass('selected');
        }
    });
    
    $('#item_list').change(function() {
        var type = $('#item_list').val();
        if ( !type ) return false;
        var $item = filterItem(type);
        $item
            .insertAfter('.selectfilter')
            .wrap('<div class="filteritem" />')
            .find('.minus').hide().end()
            .find('input').each( function() {
                var id = $(this).attr('id') || $(this).attr('name') || 'input-' + inputCount++;
                $(this)
                    .attr('id', id)
                    .attr('name', id);
            });
        $('#item_list').attr('selectedIndex', 0);
        $('<span class="close-link clickable remove icon-remove icon16 action-icon">'+mt.screen.trans.REMOVE_ITEM+'</span>')
            .insertAfter($item)
            .bind('click', function() {
                $(this).parent('.filteritem').find('input').mtUnvalidate().end().remove();
                updateItemList();
                updateFilterSaveButtons();
            });
        if ( allPass ) {
            $('#filter_id').val('');
            $('#opener').text(mt.screen.trans.UNKNOWN_FILTER);
            editNewFilter = 1;
            editSysFilter = 0;
            allPass       = 0;
        }
        updateItemList();
        updateFilterSaveButtons({ allpass: false });
        return false;
    });
    
    $('#apply').click(function() {
        validateFilterDetails();
        $('input[name=filter_id]').val('');
        itemValues()
        renderList('filtered_list', cols, vals, $('#row').val(), 1);
        return false;
    });
    
    $('#'+mt.screen.object_type+'-listing-form').bind('submit.as_apply', function() {
        $('#apply').click();
        return false;
    });

    $('#save').click(function() {
        validateFilterDetails();
        if ($('#filter_id').val() && $('#filter_id').val().match(/^[1-9][0-9]*$/) ) {
            // Overwrite current filter.
            $('input[name=filter_name]').val($('#filter_name').val());
            $('input[name=filter_id]').val($('#filter_id').val());
            itemValues()
            renderList('save_filter', cols, vals, $('#row').val(), 1);
        } else {
            // Create new filter.
            var temp_base = 1;
            var temp;
            while ( 1 ) {
                temp = trans('[_1] - Filter [_2]', mt.screen.object_label, temp_base++);
                if ( 0 == $.grep(mt.screen.filters, function(f){ return f.label == temp }).length )
                    break;
            }
            $('input[name=filter_name]').mtUnvalidate().val(temp);
            $('input[name=filter_id]').val('');
            $('#dialog_save_filter').dialog({
                title: trans('Save Filter'),
                dialogClass: 'save',
                width: 450,
                modal: true,
                resizable: false,
                draggable: false,
                closeOnEscape: false,
                open: function(){
                    $('input[name=filter_name]').focus();
                }
            }).dialog('open');
        }
        return false;
    });

    $('#saveas').click(function() {
        validateFilterDetails();
        $('input[name=filter_name]').mtUnvalidate().val($('#opener').text());
        $('input[name=filter_id]').val('');
        $('#dialog_save_filter')
            .dialog({
                title: trans('Save As Filter'),
                dialogClass: 'save',
                width: 450,
                modal: true,
                resizable: false,
                open: function () {
                    $('input[name=filter_name]').focus();
                }
            }).dialog('open');
        return false;
    });

    $('#dialog_filter').dialog({
        autoOpen: false,
        title: trans('Select Filter'),
        width: 380,
        resizable: false
    });
    
    $('#opener').click(function() {
        $('#dialog_filter').dialog('open');
        return false;
    });
    
    $('#dialog_save_filter').dialog({
        autoOpen: false,
        dialogClass: 'save',
        width: 450,
        minHeight: 100
    });
    
    // When the enter key is pressed, click the primary button instead of submitting.
    $('#dialog_save_filter form').submit(function() {
        $('button.primary', this).click();
        return false;
    });
    
    $('#save-filter').click(function() {
        if ( !$('input[name=filter_name]').mtValidate('dialog') )
            return false;
        var name = $('input[name=filter_name]').val();
        itemValues();
        $(window).one('listReady', function() {
            updateFilterSaveButtons({ new_filter: 0 });
        });
        renderList('save_filter', cols, vals, $('#row').val(), 1);
        return false;
    });
    
    $('#cancel-save-filter').click(function() {
        $(this).parents().dialog('close');
    });
    
    $('#allpass-filter').click( function() {
        allPass = 1;
        $('#filter-detail').hide();
        $('#filter').removeClass('active');
        doApplyFilter(mt.screen.allpass_filter);
        return false;
    });

    $('.action_selector').change(function() {
        var selected = $(this).val();
        $('.action_selector').val(selected);
    });
    
    $('button.mt-'+mt.screen.object_type+'-listing-form-action').click(function() {
        var id = mt.screen.object_type+'-listing-form';
        var singlar = mt.screen.singular;
        var plural = mt.screen.plural;
        var phrase = mt.screen.trans.ACT_UPON;
        doForMarked(id, 'itemset_action', singlar, plural, phrase);
        return false;
    });
    
    $('.actions-bar a.button').click(function() {
        $(this).attr('href').match(/#(.*)/);
        var action = RegExp.$1;
        var id = mt.screen.object_type+'-listing-form';
        var singlar = mt.screen.singular;
        var plural = mt.screen.plural;
        var phrase = mt.screen.button_messages[action];
        doForMarked(id, action, singlar, plural, phrase);
        return false;
    });

    $('.filtertype .minus').live('click', function() {
        var $item = $(this).parents('.filteritem');
        $(this).parents('.filtertype').find('input').mtUnvalidate().end().remove();
        if ( $item.find('.filtertype').length == 1 ) {
            $item.find('.minus').hide();
        }
    });
    
    $('.filtertype .plus').live('click', function() {
        var op = 'and';
        $(this).parents('.filteritem').addClass(op);
        var $filtertype = $(this).parents('.filtertype');
        var $filteritem = $(this).parents('.filteritem');
        $filtertype.attr('class').match(/type-(\w+)/);
        var type = RegExp.$1;
        var $node = filterItem(type, true);
        var $clone = $node.clone(true);
        $clone.insertAfter($filtertype)
            .find('.item-label').addClass('invisible');
        
        $clone.find('.filter-date').each(function() {
            dateOption($(this));
        }).bind('change', function() {
            dateOption($(this));
        }).end()
            .find('.date').datepicker({
                dateFormat: 'yy-mm-dd',
                dayNamesMin: mt.screen.trans.DAY_NAMES,
                monthNames: ['- 01','- 02','- 03','- 04','- 05','- 06','- 07','- 08','- 09','- 10','- 11','- 12'],
                showMonthAfterYear: true,
                prevText: '&lt;',
                nextText: '&gt;'
            });
        $filteritem.find('.minus').show();
    });
    
    $(window).bind('listReady', function(){
        $('ul#disp_cols .sub:checkbox').each(function () {
            toggleSubField(this);
        });
        $('a.action-link.mt-open-dialog').mtDialog();
    });

    var line = '<th class="col head cb"' + (mt.screen.has_list_actions ? '' : ' style="display: none;"') + '><input type="checkbox" /></th>';
    var table = $('table.listing-table')[0];

    for (i=0;i<mt.screen.list_columns.length;i++) {
        var col = mt.screen.list_columns[i];
        line += '<th class="col head '+col.id+(col.is_primary ? ' primary' : '')+(typeof col.col_class != 'undefined' ? ' ' + col.col_class : '')+'">'+(col.is_sortable ? '<a href="#'+col.id+'" class="sort-link"><span class="col-label">'+col.label+'</span><span class="sm"></span></a>' : '<span class="col-label">'+col.label+'</span>')+'</th>';
        if (mt.screen.default_sort_order == "descend") {
            $.data(table, col.id, 'desc');
        } else {
            $.data(table, col.id, 'asc');
        }
    }

    $('table.listing-table thead, table.listing-table tfoot').append('<tr>');
    $(line).appendTo('table.listing-table thead tr, table.listing-table tfoot tr');

    var filter_types = {};
    for (i=0;i<mt.screen.filter_types;i++) {
        var fltr = mt.screen.filter_types[i];
        filter_types[ fltr.type ] = '<div class="filtertype type-'+fltr.type+(fltr.is_editable ? '' : 'no-edit')+(typeof fltr.base_type != 'undefined' ? ' base-'+fltr.base_type : '')+'"><div class="item-content">'+fltr.field+(fltr.is_singleton ? '' : '<span class="item-ctrl"><span class="item-action plus clickable icon-plus icon16 action-icon">'+mt.screen.trans.ADD+'</span><span class="item-action minus clickable icon-minus icon16 action-icon">'+mt.screen.trans.REMOVE+'</span></span>')+'</div></div>';
    }

    $('#filter_types').hide();
    if (!mt.screen.open_filter_panel) $('#filter-detail').hide();
    $('.filter-block').mtToggleField( mt.screen.open_filter_panel ? {default_hide: false} : {} );

    addItems(mt.screen.initial_filter.items);
    $('#opener').html(mt.screen.initial_filter.label);
    $('#filter_name').val(mt.screen.initial_filter.label);
    $('#filter_id').val(mt.screen.initial_filter.id);
    $('input[name=filter_id]').val(mt.screen.initial_filter.id);
    if ( mt.screen.initial_filter.id == '_allpass' )
        allPass = 1;
    $('input[name=filter_name]').val(mt.screen.initial_filter.label);
    editSysFilter = !parseInt(mt.screen.initial_filter.can_edit);
    if ( $('#disp_cols li:not(.hidden)').size() == 0 )
        $('#display_columns-field, #reset-display-options').hide();
    itemValues()
    renderColumns();
    renderFilterList();

    $('table.listing-table thead a, tfoot a').click(function() {
        var url = $(this).attr('href');
        var $th = $('a[href=\''+url+'\']').parents('th');
        if ($th.hasClass('sorted')) {
            var $order = $th.find('span');
            if ($order.hasClass('desc')) {
                $order.removeClass('desc').addClass('asc');
            } else {
                $order.removeClass('asc').addClass('desc');
            }
        } else {
            $('table.listing-table thead th, tfoot th').removeClass('sorted').find('span.sm').removeClass('asc desc');
            $th.addClass('sorted').find('span.sm').remove();
            url.match(/#(.*)/);
            $('<span class="sm '+$.data(table, RegExp.$1)+'"></span>').appendTo($th.find('.sort-link'));
        }
        checked = [];
        renderColumns();
        renderList('filtered_list', cols, vals, $('#row').val(), 1);
        return false;
    });

    // This must be located after the listeners and handlers are registered for the page
    if (typeof mt.screen.default_sort_key != 'undefined') {
        var initial_sort_button = $('table.listing-table thead th.'+mt.screen.default_sort_key+' a.sort-link');
        if ( initial_sort_button.length ) {
            initial_sort_button.click();
        } else {
            renderList('filtered_list', cols, vals, $('#row').val(), 1);
        }
    } else {
        renderList('filtered_list', cols, vals, $('#row').val(), 1);
    }
    updateFilterSaveButtons();

    if (mt.screen.has_list_actions) {
        $('table.listing-table tbody').selectable({
            filter: 'tr',
            cancel: 'tr.no-action, a, .select-all, .text, .can-select, button, pre, :input:not([name=id])',
            selected: function(event, ui) {
                var $checkboxes = $(ui.selected).find(':checkbox');
                if ($checkboxes.attr('checked')) {
                    $(ui.selected).removeClass('selected');
                    $checkboxes.removeAttr('checked');
                } else {
                    $(ui.selected).addClass('selected');
                    $checkboxes.attr('checked', 'checked');
                }
                if ($('table.listing-table td :checkbox').length == $('table.listing-table td :checked').length) {
                    $('table.listing-table th :checkbox').attr('checked', 'checked');
                    if (!$('table.listing-table tr.select-all').length) {
                        addSelectAll($checkboxes);
                    }
                } else {
                    $('table.listing-table th :checkbox').removeAttr('checked');
                    removeSelectAll($checkboxes);
                }
            }
        });
    }

    if (typeof mt.screen.system_messages != 'undefined') {
        for ( var i=0; i < mt.screen.system_messages.length; i++ ) {
            var message = system_messages[i];
            showMessage( message.msg, message.cls );
        }
    }

});