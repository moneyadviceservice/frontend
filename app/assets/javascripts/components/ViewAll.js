/**
 * # ViewAll
 *
 * Dough component to display an initial set of items,
 * and show the remaining items upon a trigger being invoked.
 *
 * @module ViewAll
 * @returns {class} ViewAll
 */

define(['jquery', 'DoughBaseComponent'],
       function($, DoughBaseComponent) {
  'use strict';

  var ViewAllProto,
      defaultConfig = {
        initialNumberOfItemsToDisplay: 5,
        itemSelector: '[data-dough-view-all-item]',
        triggerSelector: '[data-dough-view-all-trigger]'
      };

  /**
   * @constructor
   * @extends {DoughBaseComponent}
   * @param {HTMLElement} $el    Element with dough-component on it
   * @param {Object}             config Hash of config options
   */
  function ViewAll($el, config) {
    ViewAll.baseConstructor.call(this, $el, config, defaultConfig);
  }

  /**
   * Inherit from base module, for shared methods and interface
   */
  DoughBaseComponent.extend(ViewAll);
  ViewAll.componentName = 'ViewAll';
  ViewAllProto = ViewAll.prototype;

  /**
   * Init function
   *
   * Set up listeners and accept promise
   *
   * @param {Object} initialised Promise passed from eventsWithPromises (RSVP Promise).
   * @returns {ViewAll}
   */
  ViewAllProto.init = function(initialised) {
    this._hideAdditionalItems();
    this._displayTrigger();
    this._bindTriggerEvent();
    this._initialisedSuccess(initialised);
    return this;
  };

  /**
   * _hideAdditionalItems
   *
   * If there are more items than the initial number to display, it
   * applies a style to hide them.
   *
   * @private
   */
  ViewAllProto._hideAdditionalItems = function() {
    var count = this.config.initialNumberOfItemsToDisplay - 1;
    var selector = this.config.itemSelector + ':gt('+ count +')';
    this.$find(selector).addClass('view-all__item--hidden');
  };

  /**
   * _displayTrigger
   *
   * If additional items are still to be displayed, removes the
   * class which hides the trigger
   *
   * @private
   */
  ViewAllProto._displayTrigger = function() {
    if(this._moreItemsToDisplay()) {
      this.$trigger().removeClass('view-all__trigger--hidden');
    }
  }

  /**
   * _bindTriggerEvent
   *
   * Attaches a click event to each trigger to display the
   * remaining additional items.
   *
   * @private
   */
  ViewAllProto._bindTriggerEvent = function() {
    var self = this;
    this.$trigger().on('click', function(e) {
      e.preventDefault();

      self.$items().removeClass('view-all__item--hidden');
      self.$trigger().addClass('view-all__trigger--hidden');
    });
  }

  /**
   * $items
   *
   * Finds all of the items for the current component
   *
   * @returns {jQueryElements}
   */
  ViewAllProto.$items = function() {
    return this.$find(this.config.itemSelector);
  };

  /**
   * $trigger
   *
   * Finds the trigger element for the component
   *
   * @returns {jQueryElement}
   */
  ViewAllProto.$trigger = function() {
    return this.$find(this.config.triggerSelector);
  };

  /**
   * $find
   *
   * Sets up the page to only display the first set of visible items
   *
   * @param {String} Element selector
   * @returns {HTMLElement} DOM element scoped to the component's parent element
   */
  ViewAllProto.$find = function(selector) {
    return this.$el.find(selector);
  };

  /**
   * _moreItemsToDisplay
   *
   * Boolean which determines if there are additional items to display.
   *
   * @returns {Boolean}
   * @private
   */
  ViewAllProto._moreItemsToDisplay = function() {
    return this.$items().length > this.config.initialNumberOfItemsToDisplay
  }

  return ViewAll;
});
