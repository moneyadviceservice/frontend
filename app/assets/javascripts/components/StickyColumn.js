define(['jquery', 'DoughBaseComponent', 'eventsWithPromises'], function($, DoughBaseComponent, eventsWithPromises) {
  'use strict';

  var StickyColumn,
      defaultConfig = {},
      $parent,
      contentHeight,
      topMargin,
      top,
      bottom,
      isFixed,
      isAtBottom,
      isInSidebar,
      mainContentSelector = '.l-article-3col-main',
      parentSelector = '.l-article-3col-right',
      fixedClass = 'related-links--desktop-fixed',
      bottomClass = 'related-links--desktop-bottom';

  StickyColumn = function($el, config) {
    StickyColumn.baseConstructor.call(this, $el, config, defaultConfig);
  };

  /**
  * Inherit from base module, for shared methods and interface
  */
  DoughBaseComponent.extend(StickyColumn);

  /**
   * [init description]
   * @param  {[type]}
   * @return {[type]}
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
   * [_bindEvents description]
   * @return {[type]}
   */
  StickyColumn.prototype._bindEvents = function() {
    $(window)
    .on('resize', this._debounce($.proxy(this._handleResize, this), 200))
    .on('scroll', $.proxy(this._handleScroll, this));

    eventsWithPromises.subscribe('toggler:toggled', $.proxy(this._handleSectionToggle, this));
  };

  /**
   * [_isMQMedium description]
   * @return {Boolean}
   */
  StickyColumn.prototype._isMQMedium = function() {
    return this.$el.is(':visible');
  }

  /**
   * [_measureDom description]
   * @return {[type]}
   */
  StickyColumn.prototype._measureDom = function() {
    $parent = $(parentSelector);
    contentHeight = $(mainContentSelector).height();
    topMargin = parseInt($parent.css('marginTop'), 10);
    top = $parent.offset().top;
    bottom = $parent.offset().top + contentHeight - topMargin - this.$el.height();

    if (isInSidebar) {
      this._showInSidebar();
    }
  };

  /**
   * [_showElement description]
   * @return {[type]}
   */
  StickyColumn.prototype._showElement = function() {
    if (!isInSidebar && this._isMQMedium()) {
      this._showInSidebar();
      isInSidebar = true;
      return;
    }

    if (isInSidebar && !this._isMQMedium()) {
      this._hide();
      isInSidebar = false;
    }
  };

  /**
   * [_showInSidebar description]
   * @return {[type]}
   */
  StickyColumn.prototype._showInSidebar = function() {
    $parent.css('height', contentHeight - topMargin);
    this.$el.css('width', $parent.width());
  }

  /**
   * [_hide description]
   * @return {[type]}
   */
  StickyColumn.prototype._hide = function() {
    $parent.css('height', 'auto');
  };

  /**
   * [_positionComponent description]
   * @return {[type]}
   */
  StickyColumn.prototype._positionComponent = function() {
    var scrollTop;

    if (!isInSidebar) {
      return;
    }

    scrollTop = $(window).scrollTop();

    if (!isFixed && !isAtBottom && scrollTop > top) {
      this.$el.addClass(fixedClass);
      isFixed = true;
      this._positionComponent();
      return;
    }

    if (isFixed) {
      if (scrollTop < top) {
        this.$el.removeClass(fixedClass);
        isFixed = false;
        return;
      }

      if (scrollTop > bottom) {
        this.$el
          .removeClass(fixedClass)
          .addClass(bottomClass);
        isFixed = false;
        isAtBottom = true;
        return;
      }
    }

    if (isAtBottom && scrollTop < bottom) {
      this.$el
        .addClass(fixedClass)
        .removeClass(bottomClass);
      isAtBottom = false;
      return;
    }
  };

  /**
   * [_debounce description]
   * @param  {[type]}
   * @param  {[type]}
   * @return {[type]}
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
   * [_handleResize description]
   * @param  {[type]}
   * @return {[type]}
   */
  StickyColumn.prototype._handleResize = function(e) {
    this._measureDom();
    this._showElement();
    this._positionComponent();
  };

  /**
   * [_handleScroll description]
   * @return {[type]}
   */
  StickyColumn.prototype._handleScroll = function() {
    if (!isInSidebar) {
      return;
    }

    this._positionComponent();
  };

  /**
   * [_handleSectionToggle description]
   * @param  {[type]}
   * @return {[type]}
   */
  StickyColumn.prototype._handleSectionToggle = function(e) {
    if (e.emitter.$el.parents(this.$el).length > 0) {
      this._handleResize();
    }
  };

  return StickyColumn;
});
