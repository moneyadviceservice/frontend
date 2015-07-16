define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var ScrollToProto,
    defaultConfig = {
      selectors: {
        activeClass: 'is-active',
        anchorDataAttribute: 'anchor'
      }
    };

  var ScrollTo = function($el, config) {
    ScrollTo.baseConstructor.call(this, $el, config, defaultConfig);
  };

  /**
   * Inherit from base module, for shared methods and interface
   */
  DoughBaseComponent.extend(ScrollTo);

  ScrollTo.componentName = 'ScrollTo';

  ScrollToProto = ScrollTo.prototype;

  /**
   * Set up and populate the model from the form inputs
   * @param {Promise} initialised
   */
  ScrollToProto.init = function(initialised) {
    this._addListeners();
    this._initialisedSuccess(initialised);
  };

  ScrollToProto._addListeners = function() {
    var self = this;

    this.$el.on('click', 'button:not(.' + this.config.selectors.activeClass + ')', function() {
      self.anchor = self.$el.data(self.config.selectors.anchorDataAttribute);

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

  return ScrollTo;
});
