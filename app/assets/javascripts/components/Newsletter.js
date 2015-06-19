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
    this._initialisedSuccess(initialised);
    this.showInArticle();
    return this;
  };

  Newsletter.prototype.showInArticle = function() {
    this.moveToArticle();
    this.$el.addClass('news-signup-test--with-image news-signup-test--in-article');
  };

  Newsletter.prototype.moveToArticle = function() {
    var $article = $('[data-dough-newsletter-article]'),
        placed = false,
        minimumPosition = $article[0].offsetHeight / 4;

    this.$el.css('clear', 'both');

    $article.find('> h2, > h3').each($.proxy(function (i, el) {
      if (el.offsetTop >= minimumPosition) {
        this.$el.insertBefore(el);
        placed = true;
        return false;
      }
    }, this));

    if (!placed) {
      this.$el.insertAfter($article.children().last());
    }
  };

  return Newsletter;
});
