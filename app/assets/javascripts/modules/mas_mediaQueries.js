
define(['jquery', 'common'], function ($, MAS) {

    'use strict';

    var current = false,
        testElement = $('<div class="js-mediaquery-test" />');

    $('body').append(testElement);

    // Add debounce for performance
    function debounce(func, wait, immediate) {
      var timeout;
      return function() {
        var context = this, args = arguments;
        var later = function() {
          timeout = null;
          if (!immediate) func.apply(context, args);
        };
        var callNow = immediate && !timeout;
        clearTimeout(timeout);
        timeout = setTimeout(later, wait);
        if (callNow) func.apply(context, args);
      };
    }

    function checkSize(){
      var newSize = getSize();
      if(newSize !== current){
        current = newSize;
        MAS.publish('mediaquery/resize', newSize);
      }
    }

    function getSize(){
      return window.getComputedStyle(testElement[0],':after').getPropertyValue('content');
    }

    // Create the listener function
    var updateLayout = debounce(checkSize, 500);

    // Add the event listener
    window.addEventListener('resize', updateLayout, false);
    // Run to get initial value;
    checkSize();

    return current;
  }
);