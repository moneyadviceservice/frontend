$(document).ready(function() {

  $('.styleguide-nav').prepend('<button class="styleguide-nav__toggle">Menu</button>');

  $(".styleguide-nav__toggle").on("click", function(e){
    $('.styleguide-nav__list').slideToggle();
  });

  $(".has-sub-menu").on("click", function(e){
    $('.styleguide-nav__sub-menu', this).slideToggle();
    e.preventDefault();
  });


  $(".has-sub-menu li a").on("click", function(e){
    e.stopPropagation();
  });

});
