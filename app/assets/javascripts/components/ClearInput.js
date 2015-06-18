define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var ClearInput,
      defaultConfig = {
        uiEvents: {
          'keyup [data-dough-clear-input]' : 'updateResetButton',
          'click [data-dough-clear-input-button]' : 'resetForm'
        }
      };

  ClearInput = function($el, config) {
    ClearInput.baseConstructor.call(this, $el, config, defaultConfig);

    this.$resetInput = this.$el.find('[data-dough-clear-input]');
    this.$resetButton = this.$el.find('[data-dough-clear-input-button]');

    this.updateResetButton();
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(ClearInput);

  ClearInput.componentName = 'ClearInput';

  /**
  * Set up and populate the model from the form inputs
  * @param {Promise} initialised
  */
  ClearInput.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
  };

  ClearInput.prototype.updateResetButton = function() {
    var fn = this.$resetInput.val() === '' ? 'removeClass' : 'addClass';
    this.$resetButton[fn]('is-active');
  };

// We are progressively enhancing the form with JS. The CSS button, type 'reset'
// resets the form faster than the JS can run, so we need to invoke reset() to ensure the correct behaviour.

  ClearInput.prototype.resetForm = function(e) {
    this.$resetInput.val('');
    this.updateResetButton();
    this.$resetInput.focus();
    e.preventDefault();
  };

  return ClearInput;

});
