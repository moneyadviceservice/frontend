define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var ClearInput;

  ClearInput = function($el, config) {
    ClearInput.baseConstructor.call(this, $el, config);
    $('<button class="button button--primary">' + this.config.label + '</button>')
        .appendTo($el)
        .click(function() {
          window.print();
        });
  };

  /**
   * Inherit from base module, for shared methods and interface
   */
  DoughBaseComponent.extend(ClearInput);

  /**
   * Set up and populate the model from the form inputs
   * @param {Promise} initialised
   */
  ClearInput.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  return ClearInput;

});
