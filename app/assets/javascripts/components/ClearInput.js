define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var ClearInput,
      uiEvents = {
      'keydown [data-dough-clear-input]' : 'updateResetButton',
      'click [data-dough-clear-input-button]' : 'resetForm'
      };

  ClearInput = function($el, config) {
    var _this = this;
    this.uiEvents = uiEvents;
    ClearInput.baseConstructor.call(this, $el, config);

    this.$resetInput = this.$el.find('[data-dough-clear-input]');
    this.$resetButton = this.$el.find('[data-dough-clear-input-button]');
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

  ClearInput.prototype.updateResetButton = function() {
    var fn = (this.$resetInput.val() == '') ? 'removeClass' : 'addClass';
    this.$resetButton[fn]('is-active');
  };

  ClearInput.prototype.resetForm = function() {
    this.$el[0].reset();
    this.updateResetButton();
  };

  return ClearInput;

});
