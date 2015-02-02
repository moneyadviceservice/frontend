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
  * Set up and populate the model from the form inputs
  * @param {Promise} initialised
  */
  Newsletter.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this.showInArticle($);
  };

  Newsletter.prototype.showInArticle = function($) {
    var $panel = this.getPanel($);
    var $article = $('.editorial main');

    if (!$panel.length || !$article.length) {
      setTimeout(function () {
        this.showInArticle($);
      }, 50);
      return;
    }

    this.moveToArticle($panel, $article, $);

    $panel.addClass('news-signup-test--with-image news-signup-test--in-article');
  };

  Newsletter.prototype.moveToArticle = function($form, $article, $) {
    var article = $article[0];
    var placed = false;
    var minimumPosition;

    minimumPosition = article.offsetHeight / 4;

    $form.css('clear', 'both');

    $article.find('> h2, > h3').each(function (i, el) {
      if (placed) {
        return;
      }

      if (el.offsetTop >= minimumPosition) {
        $form.insertBefore(el);
        placed = true;
      }
    });

    if (!placed) {
      $form.insertAfter($article.children().last());
    }
  };

  Newsletter.prototype.getPanel = function($) {
    return $('.news-signup-test');
  };

  return Newsletter;
});
