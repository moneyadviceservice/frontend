define(
  ['jquery', 'common'],
  function($, MAS) {
    'use strict';

    var COMPONENT_SELECTOR = '.want-to-talk',
        SIDE_PARENT_SELECTOR = '.l-article-3col-right',
        INLINE_PARENT_SELECTOR = '[role="main"] > p:first',
        MAIN_CONTENT_SELECTOR = '.l-article-3col-main',
        BODY_SELECTOR = '.want-to-talk__body',
        INLINE_CLASS = 'want-to-talk--inline',
        SIDEBAR_CLASS = 'want-to-talk--sidebar',
        FIXED_CLASS = 'want-to-talk--fixed',
        BOTTOM_CLASS = 'want-to-talk--bottom',
        OPEN_CLASS = 'want-to-talk--open',
        INITIALISED_CLASS = 'want-to-talk--initialised',
        TRIGGER_SELECTOR = '.want-to-talk__trigger__button, .want-to-talk__title',
        LABEL_SELECTOR = '.want-to-talk__trigger__button__text',
        TEL_LINK_SELECTOR = '.want-to-talk__body__phone',
        TRACK_CATEGORY = 'TriagePhase1',
        ARIA_EXPANDED = 'aria-expanded',
        ARIA_HIDDEN = 'aria-hidden',
        I18N_OPEN = 'Open',
        I18N_CLOSE = 'Close',

        w = window,
        $sidebarEl,
        contentHeight,
        topMargin,
        top,
        bottom,
        isFixed,
        isAtBottom,
        isInSidebar;

    function init() {
      var $inlineEl;

      $sidebarEl = $(COMPONENT_SELECTOR);

      if (!$sidebarEl.length) {
        MAS.log('wantToTalk: Could not find `' + COMPONENT_SELECTOR + '`');
        return;
      }

      $inlineEl = $sidebarEl.clone();
      $inlineEl.addClass(INLINE_CLASS);
      $(INLINE_PARENT_SELECTOR).after($inlineEl);

      $sidebarEl
        .addClass(INITIALISED_CLASS)
        .addClass(SIDEBAR_CLASS);
      $inlineEl.addClass(INITIALISED_CLASS);

      initAccessibility($sidebarEl, SIDEBAR_CLASS);
      initAccessibility($inlineEl, INLINE_CLASS);

      measureDOM();
      showElement();
      positionComponent();

      $(w)
        .on('resize', debounce(handleResize, 200))
        .on('scroll', handleScroll);

      $(document)
        .on('click', TRIGGER_SELECTOR, handleTriggerClick)
        .on('click', TEL_LINK_SELECTOR, handleTelLinkClick);
    }

    function measureDOM() {
      var $prev = $sidebarEl.prev();

      contentHeight = $(MAIN_CONTENT_SELECTOR).height();
      topMargin = parseInt($(SIDE_PARENT_SELECTOR).css('marginTop'), 10);

      top = ($prev.length) ?
        $prev.offset().top + $prev.height() + parseInt($prev.css('marginTop'), 10) +
          parseInt($prev.css('marginBottom'), 10) :
        $(SIDE_PARENT_SELECTOR).offset().top;

      bottom = $(SIDE_PARENT_SELECTOR).offset().top + contentHeight - topMargin
         - $sidebarEl.height();

      if (isInSidebar) {
        $(SIDE_PARENT_SELECTOR).css('height', contentHeight - topMargin);
        $sidebarEl.css('width', $(SIDE_PARENT_SELECTOR).width());
      }
    }

    function showInline() {
      $(SIDE_PARENT_SELECTOR).css('height', 'auto');
    }

    function showInSidebar() {
      $(SIDE_PARENT_SELECTOR).css('height', contentHeight - topMargin);
      $sidebarEl.css('width', $(SIDE_PARENT_SELECTOR).width());
    }

    function isMQMedium() {
      return $sidebarEl.is(':visible');
    }

    function showElement() {
      if (!isInSidebar && isMQMedium()) {
        showInSidebar();
        isInSidebar = true;
        return;
      }

      if (isInSidebar && !isMQMedium()) {
        showInline();
        isInSidebar = false;
        return;
      }
    }

    function positionComponent() {
      var scrollTop;

      if (!isInSidebar) {
        return;
      }

      scrollTop = $(w).scrollTop();

      if (!isFixed && !isAtBottom && scrollTop > top) {
        $sidebarEl.addClass(FIXED_CLASS);
        isFixed = true;
        return;
      }

      if (isFixed) {
        if (scrollTop < top) {
          $sidebarEl.removeClass(FIXED_CLASS);
          isFixed = false;
          return;
        }

        if (scrollTop > bottom) {
          $sidebarEl
            .removeClass(FIXED_CLASS)
            .addClass(BOTTOM_CLASS);
          isFixed = false;
          isAtBottom = true;
          return;
        }
      }

      if (isAtBottom && scrollTop < bottom) {
        $sidebarEl
          .addClass(FIXED_CLASS)
          .removeClass(BOTTOM_CLASS);
        isAtBottom = false;
      }
    }

    function handleResize() {
      measureDOM();
      showElement();
      positionComponent();
    }

    function handleScroll() {
      if (!isInSidebar) {
        return;
      }

      positionComponent();
    }

    function track(action, label) {
      MAS.publish('analytics:trigger', {
        event: 'gaEvent',
        gaEventCat: TRACK_CATEGORY,
        gaEventAct: action,
        gaEventLab: label
      });
    }

    function debounce(func, wait) {
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
    }

    function handleTriggerClick(e) {
      var $el = $(e.target).closest(COMPONENT_SELECTOR),
          $trigger = $el.find(TRIGGER_SELECTOR),
          $label = $el.find(LABEL_SELECTOR),
          $body = $el.find(BODY_SELECTOR);

      if ($el.hasClass(OPEN_CLASS)) {
        $el.removeClass(OPEN_CLASS);
        $trigger.attr(ARIA_EXPANDED, 'false');
        $label.text($el.attr('data-open') || I18N_OPEN);
        $body.attr(ARIA_HIDDEN, 'true');
        track('Click', 'Close');
      } else {
        $el.addClass(OPEN_CLASS);
        $trigger.attr(ARIA_EXPANDED, 'true');
        $label.text($el.attr('data-close') || I18N_CLOSE);
        $body.attr(ARIA_HIDDEN, 'false');
        track('Click', 'Open');
      }

      if ($el.hasClass(SIDEBAR_CLASS)) {
        // wait for CSS transition
        setTimeout(function() {
          measureDOM();
          positionComponent();
        }, 400);
      }
    }

    function handleTelLinkClick() {
      track('Click', 'PhoneNumber');
    }

    function initAccessibility($el, id) {
      $el.find(BODY_SELECTOR).attr('id', id);

      $el.find(TRIGGER_SELECTOR)
        .attr('aria-controls', id)
        .attr(ARIA_EXPANDED, 'false');
    }

    return function () {
      w.masInitWantToTalk = init;
    };
  }
);
