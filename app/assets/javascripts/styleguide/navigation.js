$(document).ready(function() {

  $('.primaryNav').prepend('<button class="navToggle">Menu</button>');

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
