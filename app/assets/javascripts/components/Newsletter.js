define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var Newsletter,
    defaultConfig = {};

  Newsletter = function($el, config) {
    Newsletter.baseConstructor.call(this, $el, config, defaultConfig);
  };

  /**
   * Inherit from base module, for shared methods and interface
   */
  DoughBaseComponent.extend(Newsletter);

  Newsletter.componentName = 'Newsletter';

  /**
   * @param {Promise} initialised
   */
  Newsletter.prototype.init = function(initialised) {
    var $component;

    this.initProps();
    $component = this._returnComponentJqueryDOM();

    if (this.$el.hasClass('news-signup-inpage--delete')) {
      $component.remove();
      throw new Error('Removed from DOM during initialise');
    }

    this._initialisedSuccess(initialised);
    this.showInArticle();
    return this;
  };

  Newsletter.prototype.initProps = function() {
    this.$form = this.$el.find('form');
    this.isInPageArticle = (this.$form.parents('.news-signup-inpage').length === 1);
    this.mainClassName = this.$el[0].className.split(/\s+/)[0];
  };

  Newsletter.prototype.showInArticle = function() {
    this.moveToArticle();
    this.$el.addClass(this.mainClassName + '--with-image ' + this.mainClassName + '--in-article');
  };

  Newsletter.prototype.moveToArticle = function() {
    var $article = $('[data-dough-newsletter-article]'),
      placed = false,
      minimumPosition = $article[0].offsetHeight / 4,
      $component = this._returnComponentJqueryDOM();

    this.$el.css('clear', 'both');

    $article.find('> h2, > h3').each($.proxy(function(i, el) {
      if (el.offsetTop >= minimumPosition) {
        $component.insertBefore(el);
        placed = true;
        return false;
      }
    }, this));

    if (!placed) {
      $component.insertAfter($article.children().last());
    }
  };

  Newsletter.prototype._returnComponentJqueryDOM = function() {
    var $component;

    if (this.isInPageArticle) {
      // If this is the newer in-page article, then grab it's parent layout container
      $component = this.$el.parent('.l-news-signup-inpage');
    }
    else {
      $component = this.$el;
    }

    return $component;

  };

  return Newsletter;
});
