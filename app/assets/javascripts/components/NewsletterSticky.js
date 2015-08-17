define([
  'jquery',
  'DoughBaseComponent',
  'eventsWithPromises',
  'utilities',
  'common'
], function(
  $,
  DoughBaseComponent,
  eventsWithPromises,
  utilities,
  MAS
) {
  'x use strict';

  var NewsletterSticky,
      defaultConfig = {
        appearsAfterPercentage: 40,
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
    this._setVars();

    this._setListeners(true);
    this._handleScroll();

    return this;
  };

  /**
   * Sets up local variables for the sticky newsletter component
   */
  NewsletterSticky.prototype._setVars = function() {
    this.closeButton = this.$el.find(this.config.closeClassSelector);
    this.window = $(window);
  };

  /**
   * Turn on and off the events
   * @param {Boolean} isActive true=on false=off
   */
  NewsletterSticky.prototype._setListeners = function(isActive) {
    this._setScrollListener(isActive);
    this.closeButton[isActive ? 'on' : 'off']('click', $.proxy(this._handleCloseClick, this));
    this.$el[isActive ? 'on' : 'off']('click', '.button--done', $.proxy(this._handleCloseClick, this));
  };

  /**
   * Sets the scroll event on the window on or off
   * @param {Boolean} isActive true=on false=off
   */
  NewsletterSticky.prototype._setScrollListener = function(isActive) {
    $(window)[isActive ? 'on' : 'off']('scroll.newsletter', this._scrollDebounceMethod(isActive));
  };

  /**
   * Limit the amount of times the _handleScroll method is called
   * @param  {Boolean} isActive true=on false=off
   * @returns {Function|null}
   */
  NewsletterSticky.prototype._scrollDebounceMethod = function(isActive) {
    return isActive ? utilities.debounce($.proxy(this._handleScroll, this), 100) : null;
  };

  /**
   * Make the newsletter module display if scroll is over a certain percentage
   */
  NewsletterSticky.prototype._handleScroll = function () {
      if (this._hasScrolledOverPercentage(this.config.appearsAfterPercentage)) {
          this.$el.addClass(this.config.visibleClassName);
          this._setScrollListener(false);

      }
      else {
          return;
      }

  };

  /**
   * Works out whether the window has scrolled further than a given percentage
   * @return {Boolean}
   */
  NewsletterSticky.prototype._hasScrolledOverPercentage = function() {
      var percentScrolled;
      percentScrolled = this._pageScrolledTo().percentage;

      return (percentScrolled >= this.config.appearsAfterPercentage);
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
   * @deprecated This is no longer used internally, will leave this until production release.
   */
  NewsletterSticky.prototype._scrollThreshold = function () {
    return $(document).height() * (this.config.appearsAfterPercentage / 100);
  };

  /**
   * Returns an Object holding the pixels and percentage of the page that has been scrolled.
   * e.g. return {pixels : x, percentage: n% }
   * @return {Object}
   */
  NewsletterSticky.prototype._pageScrolledTo = function () {
    var scrollData = {},
      scrollTop = $(window).scrollTop(),
      pageHeight = $(document).height(),
      viewPortHeight = $(window).height(),
      scrollPercent = (scrollTop / (pageHeight - viewPortHeight)) * 100;

    scrollData.pixels = scrollTop;
    scrollData.percentage = scrollPercent;

    return scrollData;
  };

  /**
   * Handles what happens when the close button is pressed
   * @param  {Event} e The click event object
   */
  NewsletterSticky.prototype._handleCloseClick = function(e) {
    e.preventDefault();
    this._close();

    MAS.publish('analytics:trigger', {
      event: 'gaEvent',
      gaEventCat: 'Newsletter SignUp Sticky',
      gaEventAct: 'Click',
      gaEventLab: 'Close button'
    });
  };

  /**
   * Closing the panel and no longer listening for events
   */
  NewsletterSticky.prototype._close = function() {
    this.$el.removeClass(this.config.visibleClassName);
    this.closeButton.addClass(this.config.closedClassName);
    this._setListeners(false);
  };

  return NewsletterSticky;
});
