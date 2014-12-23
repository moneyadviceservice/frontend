/**
 * Hide/show elements based on `:checked` status of `trigger` inputs
 * If no inputs are `:checked`, the `target` container element is also hidden
 * Elements to hide should have `data-dough-input-filter=[ID_OF_TRIGGER_INPUT]` attribute
 *
 * @param  {function} $
 * @return {function} DoughBaseComponent
 * @private
 */
define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var defaultConfig = {
    visibleClass: 'is-visible',
    checkedClass: 'input-filter--is-checked',
    trigger: 'input[type=radio], input[type=checkbox]',
    triggerContainer: '.input-filter',
    jumpTo: null
  },

    /**
   * Call base constructor
   * @constructor
   */
  InputFilters = function ($el, config) {
    InputFilters.baseConstructor.call(this, $el, config, defaultConfig);
  };

  DoughBaseComponent.extend(InputFilters);

  InputFilters.prototype.init = function() {
    this.$el.on('change', this.config.trigger, $.proxy(this._onChange, this));

    this.refresh();
    return this;
  };

  InputFilters.prototype.refresh = function() {
    var config = this.config,
        $target = $(config.target),
        onePanelVisible = false,
        panelsMethod;

    this.$el.find(config.trigger).each(function(index, input) {
      var $input = $(input),
          isChecked = $input.is(':checked'),
          method = isChecked ? 'addClass' : 'removeClass',
          $panel = $('[data-dough-input-filter=' + $input.attr('id') + ']');

      if (isChecked) {
        onePanelVisible = true;
      }

      $panel[method](config.visibleClass);
      $input.parent(config.triggerContainer)[method](config.checkedClass);
    });

   panelsMethod = onePanelVisible ? 'addClass' : 'removeClass';
   $target[panelsMethod](config.visibleClass);
  };

  InputFilters.prototype._onChange = function (e) {
    var $input = $(e.currentTarget),
        focus = $input.is(':focus');

    this.refresh();

    if (this.config.jumpTo) {
      window.location = '#' + this.config.jumpTo;

      if (focus) {
        $input.focus();
      }
    }
  };


  return InputFilters;

});
