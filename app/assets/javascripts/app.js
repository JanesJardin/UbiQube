Jquery.createApp=function(){
    $('#create_app').click(function(e){
      var url=$(this).attr('href');
      var dialog_form=$('<div id="dialog-form">Loading form...</div>').dialog({
            autoOpen: false,
            width:520,
            modal:false,
            open: function(){
              return $(this).load(url+' #content');
            },
            close: function(){
              $('#dialog-form').remove();
            }
    });
    dialog_form.dialog('open');
    e.preventDefautlt();
});