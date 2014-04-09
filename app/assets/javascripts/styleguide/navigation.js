require(['jquery'], function ($) {
  'use strict';

  $(document).ready(function() {

    $('.styleguide-nav-container').prepend('<button class="styleguide-nav__toggle">Menu</button>');

    $('.styleguide-nav__toggle').on('click', function(){
      $('.styleguide-nav').slideToggle();
    });

    $('.has-sub-menu').on('click', function(e){
      $('.styleguide-nav__submenu', this).slideToggle();
      e.preventDefault();
    });


    $('.has-sub-menu li a').on('click', function(e){
      e.stopPropagation();
    });

  });
});
