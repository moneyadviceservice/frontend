//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {


  $('body').addClass('js');

  $(".navToggle").on("click", function(e){
    $('.primaryNav-list').slideToggle();
  });


  $(".has-subMenu").on("click", function(e){
    $(this).find('.primaryNav-subMenu', this).slideToggle();
    e.preventDefault();
  });


  $(".has-subMenu li a").on("click", function(e){
    console.log(this);
    e.stopPropagation();
  });

});