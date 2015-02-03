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

  /**
  * @param {Promise} initialised
  */
  Newsletter.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this.showInArticle();
    return this;
  };

  Newsletter.prototype.showInArticle = function() {
    var $panel = this.getPanel();
    var $article = $('[data-article]');

    this.moveToArticle($panel, $article);

    $panel.addClass('news-signup-test--with-image news-signup-test--in-article');
  };

  Newsletter.prototype.moveToArticle = function($panel, $article) {
    var article = $article[0],
        placed = false,
        minimumPosition = article.offsetHeight / 4;

    $panel.css('clear', 'both');

    $article.find('> h2, > h3').each(function (i, el) {
      if (el.offsetTop >= minimumPosition) {
        $panel.insertBefore(el);
        placed = true;
        return false;
      }
    });

    if (!placed) {
      $panel.insertAfter($article.children().last());
    }
  };

  Newsletter.prototype.getPanel = function() {
    return $('[data-dough-component="Newsletter"]');
  };

  return Newsletter;
});
