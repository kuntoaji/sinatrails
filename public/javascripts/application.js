$(function(){
 // http://github.com/rails/jquery-ujs/blob/master/src/rails.js
  $('a[data-confirm],input[data-confirm]').live('click', function () {
      var el = $(this);
      //if (el.triggerAndReturn('confirm')) {
          if (!confirm(el.attr('data-confirm'))) {
              return false;
          }
      //}
  });

  // http://github.com/rails/jquery-ujs/blob/master/src/rails.js
  $('a[data-method]:not([data-remote])').live('click', function (e){
    var link = $(this),
      href = link.attr('href'),
      id = href.split("/")[1];
      method = link.attr('data-method'),
      form = $('<form method="post" action="'+href+'"></form>'),
      metadata_input = '<input name="_method" value="'+method+'" type="hidden" />';
      metadata_input += '<input name="id" value="'+id+'" type="hidden" />';

    form.hide()
        .append(metadata_input)
        .appendTo('body');

    e.preventDefault();
    form.submit();
  });
});
