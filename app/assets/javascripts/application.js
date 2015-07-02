// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or vendor/assets/javascripts of plugins, if any, can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require jquery.min
//= require turbolinks
//= require foundation
//= require_tree .
$(function() {
  $(document).foundation();

  $(document).ready(function(){
    var clickOnPopupLink = function(){
      $('body').on('click', '.static-popup-link', function(){
        $('#show_app_modal').modal('show');
      });
    }

    clickOnPopupLink();

  });

  $(document).ready(function() {
    $('#mesapps_modal').click(function(e) {
      var url = $(this).attr('href');
      var dialog_form = $('<div id="dialog-form">Loading form...</div>').dialog({
        autoOpen: false,
        width: 520,
        modal: true,
        open: function() {
          return $(this).load(url + ' #content');
        },
        close: function() {
          $('#dialog-form').remove();
        }
      });
      dialog_form.dialog('open');
      e.preventDefault();
    });

  });
