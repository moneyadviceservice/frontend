define(['jquery', 'DoughBaseComponent', 'eventsWithPromises'], function($, DoughBaseComponent, eventsWithPromises) {
  'use strict';

  var StickyColumn,
      defaultConfig = {
        selectors: {
          mainContent: '.l-article-3col-main',
          parent: '.l-article-3col-right'
        },
        classes: {
          fixed: 'related-links--desktop-fixed',
          bottom: 'related-links--desktop-bottom'
        }
      };

  StickyColumn = function($el, config) {
    StickyColumn.baseConstructor.call(this, $el, config, defaultConfig);

    this.contentHeight = 0;
    this.topMargin = 0;
    this.top = 0;
    this.bottom = 0;
    this.isFixed = false;
    this.isAtBottom = false;
    this.isInSidebar = false;
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(StickyColumn);

  /**
   * Initialize the component
   * @param {Promise} initialised
   * @return {StickyColumn}
   */
  StickyColumn.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);

    this._bindEvents();
    this._measureDom();
    this._showElement();
    this._positionComponent();

    return this;
  };

  /**
   * setup resize and scroll events to handle change in dimensions
   */
  StickyColumn.prototype._bindEvents = function() {
    $(window)
    .on('resize', this._debounce($.proxy(this._handleResize, this), 200))
    .on('scroll', $.proxy(this._handleScroll, this));

    eventsWithPromises.subscribe('toggler:toggled', $.proxy(this._handleSectionToggle, this));
  };

  /**
   * Test whether the element is visible on the page
   * @return {Boolean}
   */
  StickyColumn.prototype._isElementVisible = function($el) {
    return $el.is(':visible');
  };

  /**
   * Recalculate offsets based on content height and sticky column's contents
   */
  StickyColumn.prototype._measureDom = function() {
    this.$parent = $(this.config.selectors.parent);
    this.contentHeight = $(this.config.selectors.mainContent).height();
    this.topMargin = parseInt(this.$parent.css('marginTop'), 10);
    this.top = this.$parent.offset().top;
    this.bottom = this.$parent.offset().top + this.contentHeight - this.topMargin - this.$el.height();

    if (this.isInSidebar) {
      this._showInSidebar();
    }
  };

  /**
   * Works out whether the sticky component is in the right side bar or not
   */
  StickyColumn.prototype._showElement = function() {
    if (!this.isInSidebar && this._isElementVisible(this.$el)) {
      this._showInSidebar();
      this.isInSidebar = true;
      return;
    }

    if (this.isInSidebar && !this._isElementVisible(this.$el)) {
      this._hide();
      this.isInSidebar = false;
    }
  };

  /**
   * calculates the height of the parent container and the width of the sticky element
   * @return {[type]}
   */
  StickyColumn.prototype._showInSidebar = function() {
    this.$parent.css('height', this.contentHeight - this.topMargin);
    this.$el.css('width', this.$parent.width());
  }

  /**
   * reset the parent container back to it's original height
   * @return {[type]}
   */
  StickyColumn.prototype._hide = function() {
    this.$parent.css('height', 'auto');
  };

  /**
   * Work out the position of the container in the context of the scroll of the page
   */
  StickyColumn.prototype._positionComponent = function() {
    var scrollTop;

    if (!this.isInSidebar) {
      return;
    }

    scrollTop = $(window).scrollTop();

    if (!this.isFixed && !this.isAtBottom && scrollTop > this.top) {
      this.$el.addClass(this.config.classes.fixed);
      this.isFixed = true;
      this._positionComponent();
      return;
    }

    if (this.isFixed) {
      if (scrollTop < this.top) {
        this.$el.removeClass(this.config.classes.fixed);
        this.isFixed = false;
        return;
      }

      if (scrollTop > this.bottom) {
        this.$el
          .removeClass(this.config.classes.fixed)
          .addClass(this.config.classes.bottom);
        this.isFixed = false;
        this.isAtBottom = true;
        return;
      }
    }

    if (this.isAtBottom && scrollTop < this.bottom) {
      this.$el
        .addClass(this.config.classes.fixed)
        .removeClass(this.config.classes.bottom);
      this.isAtBottom = false;
      return;
    }
  };

  /**
   * Limit the amount of times a function is called within a set period
   * @param  {function}
   * @param  {int}
   * @return {function}
   */
  StickyColumn.prototype._debounce = function(func, wait) {
    var timeout;

    return function() {
      var context = this, args = arguments,
          later = function () {
            timeout = null;
            func.apply(context, args);
          };
      clearTimeout(timeout);
      timeout = setTimeout(later, wait);
    };
  };

  /**
   * Handle when the browser viewport changes size
   * @param  {Event}
   */
  StickyColumn.prototype._handleResize = function(e) {
    this._measureDom();
    this._showElement();
    this._positionComponent();
  };

  /**
   * Handles when the browser window is scrolled
   */
  StickyColumn.prototype._handleScroll = function() {
    if (!this.isInSidebar) {
      return;
    }

    this._positionComponent();
  };

  /**
   * Handles when a dough collapsible item is toggled
   * @param  {Event}
   */
  StickyColumn.prototype._handleSectionToggle = function(e) {
    if (e.emitter.$el.parents(this.$el).length > 0) {
      this._handleResize();
    }
  };

  return StickyColumn;
});
