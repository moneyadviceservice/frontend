//= require jquery
//= require jquery_ujs
//= require_tree .

$(document).ready(function() {

  $('body').addClass('js');

  $('.primaryNav').prepend('<button class="navToggle">Menu <span class="navIcon">&#9660;</span></button>');

  $(".navToggle").on("click", function(e){
    $('.primaryNav-list').slideToggle();
  });

  $(".has-subMenu").on("click", function(e){
    $('.primaryNav-subMenu', this).slideToggle();
    e.preventDefault();
  });


  $(".has-subMenu li a").on("click", function(e){
    e.stopPropagation();
  });

});