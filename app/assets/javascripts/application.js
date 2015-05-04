// This is a manifest file that'll be compiled into application.js, which will include all the files
// listed below.
//
// Any JavaScript/Coffee file within this directory, lib/assets/javascripts, vendor/assets/javascripts,
// or any plugin's vendor/assets/javascripts directory can be referenced here using a relative path.
//
// It's not advisable to add code directly here, but if you do, it'll appear at the bottom of the
// compiled file.
//
// Read Sprockets README (https://github.com/sstephenson/sprockets#sprockets-directives) for details
// about supported directives.
//
//= require jquery
//= require jquery_ujs
//= require twitter/bootstrap
//= require turbolinks
//= require ckeditor/init
//= require modernizr
//= require jquery.themepunch.tools.min
//= require jquery.themepunch.revolution
//= require isotope.pkgd
//= require owl.carousel
//= require magnific-popup
//= require jquery.appear
//= require jquery.countTo
//= require jquery.parallax
//= require jquery.validate
//= require template
//= require custom
//= require jquery-ui/datepicker
//= require chosen-jquery
//= require social-share-button

var ready = function(){
  // datepicker
  $( ".datepicker" ).datepicker({dateFormat: 'yy-mm-dd'});
  // enable chosen js
  $('.chosen-select').chosen({
    search_contains: true,
    allow_single_deselect: true,
    no_results_text: 'No results matched',
    width: '200px',
  });
  $(".chosen-select").trigger('chosen:updated');
};

$(document).ready(ready);
$(document).on('page:load', ready);