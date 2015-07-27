define(['jquery', 'DoughBaseComponent', 'eventsWithPromises', 'utilities'], function($, DoughBaseComponent, eventsWithPromises, utilities) {
  'use strict';

  var NewsletterSticky,
      defaultConfig = {
        appearsAfterPercentage: 50,
        visibleClassName: 'news-signup-sticky--visible',
        closeClassSelector: '.news-signup-sticky__close',
        closedClassName: 'news-signup-sticky__close--closed'
      };

  NewsletterSticky = function($el, config) {
    NewsletterSticky.baseConstructor.call(this, $el, config, defaultConfig);
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(NewsletterSticky);

  NewsletterSticky.componentName = 'NewsletterSticky';

  /**
   * Initialize the component
   * @param {Promise} initialised
   * @return {NewsletterSticky}
   */
  NewsletterSticky.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this.closeButton = this.$el.find(this.config.closeClassSelector);
    this.window = $(window);

    this._setListeners(true);
    this._handleScroll();

    return this;
  };

  /**
   * Turn on and off the events
   * @param {Boolean} isActive true=on false=off
   */
  NewsletterSticky.prototype._setListeners = function(isActive) {
    this._setScrollListener(isActive);
    this.closeButton[isActive ? 'on' : 'off']('click', $.proxy(this._handleCloseClick, this));
  };

  /**
   * Sets the scroll event on the window on or off
   * @param {Boolean} isActive true=on false=off
   */
  NewsletterSticky.prototype._setScrollListener = function(isActive) {
    $(window)[isActive ? 'on' : 'off']('scroll.newsletter', this._scrollDebounceMethod(isActive));
  }

  /**
   * Limit the amount of times the _handleScroll method is called
   * @param  {Boolean} isActive true=on false=off
   * @returns {Function|null}
   */
  NewsletterSticky.prototype._scrollDebounceMethod = function(isActive) {
    return isActive ? utilities.debounce($.proxy(this._handleScroll, this), 100) : null
  };

  /**
   * Make the newsletter module display if scroll is over a certain percentage
   */
  NewsletterSticky.prototype._handleScroll = function() {
    if (!this._hasScrolledOverPercentage(this.config.appearsAfterPercentage)) {
      return;
    }

    this.$el.addClass(this.config.visibleClassName);
    this._setScrollListener(false);
  };

  /**
   * Works out whether the window has scrolled further than a given percentage
   * @param  {Number}  percentage Number in percentage terms
   * @return {Boolean}
   */
  NewsletterSticky.prototype._hasScrolledOverPercentage = function(percentage) {
    return this._windowScrollTop() > this._scrollThreshold() ? true : false;
  };

  /**
   * Returns the window's scroll top number
   * @return {Number}
   */
  NewsletterSticky.prototype._windowScrollTop = function() {
    return $(window).scrollTop();
  };

  /**
   * Works out the amount of pixels that is needed to be scrolled to before the
   * newsletter displays
   * @return {Number}
   */
  NewsletterSticky.prototype._scrollThreshold = function() {
    return $(document).height() * (this.config.appearsAfterPercentage / 100);
  }

  /**
   * Handles what happens when the close button is pressed
   * @param  {Event} e The click event object
   */
  NewsletterSticky.prototype._handleCloseClick = function(e) {
    e.preventDefault();
    this.$el.removeClass(this.config.visibleClassName);
    this.closeButton.addClass(this.config.closedClassName);
    this._setListeners(false);
  };

  return NewsletterSticky;
});
