define(['jquery', 'DoughBaseComponent', 'mediaQueries', 'utilities'], function($, DoughBaseComponent, mediaQueries, utilities) {
  'use strict';

  var Breadcrumbs;

  Breadcrumbs = function($el, config) {
    Breadcrumbs.baseConstructor.call(this, $el, config);

    this.$breadcrumbs = this.$el;
  };

  /**
  * Inherit from base module, for shared methods and interface
   */
  DoughBaseComponent.extend(Breadcrumbs);
  Breadcrumbs.componentName = 'Breadcrumbs';

  /**
  * Initialize the component
   */
  Breadcrumbs.prototype.init = function(initialised) {
    console.log('init!');

    this._initialisedSuccess(initialised);
    this._bindEvents();
    this._setVisibility();

    return this;
  };

  /**
   * Set up events
   */
  Breadcrumbs.prototype._bindEvents = function() {
    $(window).on('resize', utilities.debounce($.proxy(this._setVisibility, this), 100));
  }

  /**
   * Set aria-hidden to be true for small screenwidth
   * Set HTML5 hidden property to be 'hidden' for small screenwidth
   */
  Breadcrumbs.prototype._setVisibility = function() {
    console.log('_setUpAria!');

    if (mediaQueries.atSmallViewport()) {
      this.$breadcrumbs
        .attr('aria-hidden', true)
        .prop('hidden', 'hidden');
    } else {
      this.$breadcrumbs
        .attr('aria-hidden', false)
        .removeProp('hidden');
    }
  }

  return Breadcrumbs;
});

