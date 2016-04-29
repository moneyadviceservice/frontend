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
    this.initProps();

    this._initialisedSuccess(initialised);
    this.showInArticle();
    return this;
  };

  Newsletter.prototype.initProps = function() {
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
      $component = this.$el;

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

  return Newsletter;
});
