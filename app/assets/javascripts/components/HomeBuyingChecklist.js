define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var HomeBuyingChecklist,
      defaultConfig = {
        localStorageNamespace: "buying_checklist_"
      };

  function HomeBuyingChecklist($el, config) {
    HomeBuyingChecklist.baseConstructor.call(this, $el, config, defaultConfig);

    this.$inputs = this.$el.find('[data-dough-input-value]');
    this.$result = this.$el.find('[data-dough-input-result]');
  };

  /**
   * Inherit from base module, for shared methods and interface
   * @type {[type]}
   * @private
   */

  DoughBaseComponent.extend(HomeBuyingChecklist);
  HomeBuyingChecklist.componentName = 'HomeBuyingChecklist';

  HomeBuyingChecklist.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setInitialValues();
    this._addValues();
    this._setUpEvents();
  };

  HomeBuyingChecklist.prototype._setInitialValues = function() {
    var ns = this.config.localStorageNamespace;

    this.$inputs.each(function( i, input ) {
      input.value = localStorage.getItem(ns+i);
    });
  };

  HomeBuyingChecklist.prototype._addValues = function() {
    var ns = this.config.localStorageNamespace;
    var total = 0;

    this.$inputs.each(function( i, input ) {
      var value = parseInt(input.value) || 0;
      total += value;
      localStorage.setItem(ns+i, value)
    });

    this.$result.val(total);
  };

  HomeBuyingChecklist.prototype._setUpEvents = function() {
    var _this = this;

    var addValuesCallback = function() {
      _this._addValues();
    };
    this.$inputs.keyup(addValuesCallback);
    this.$inputs.change(addValuesCallback);

    this.$inputs.each(function( i, input ) {
      var $input = $(input);
      var $message = $input.siblings('[data-dough-input-message]');
      $input.focus(function() {
        $message.removeClass('home-buying-checklist__callout-inactive');
        $message.addClass('home-buying-checklist__callout-active');
      }).blur(function() {
        $message.removeClass('home-buying-checklist__callout-active');
        $message.addClass('home-buying-checklist__callout-inactive');
      });
    });
  };

  return HomeBuyingChecklist;
});
