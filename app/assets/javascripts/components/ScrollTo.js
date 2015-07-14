define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var ScrollTo = function($el, config) {
    ScrollTo.baseConstructor.call(this, $el, config);
    var self = this;

    $el.on('click', 'button:not(.is-active)', function() {
      self.anchor = $el.data('anchor');

      if(typeof self.anchor !== 'undefined') {
        $('html, body').animate({
          scrollTop: $('#' + self.anchor).offset().top
        }, 
        250, 
        function() {
          window.location.href = '#' + self.anchor;
        });          
      }
    });
  };

  /**
   * Inherit from base module, for shared methods and interface
   */
  DoughBaseComponent.extend(ScrollTo);

  /**
   * Set up and populate the model from the form inputs
   * @param {Promise} initialised
   */
  ScrollTo.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  return ScrollTo;
});
