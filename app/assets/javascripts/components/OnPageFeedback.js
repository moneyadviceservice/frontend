define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var OnPageFeedback;
  
  OnPageFeedback = function($el, config) {
    OnPageFeedback.baseConstructor.call(this, $el, config, {});

    this.interactionBtn = $el.find('[data-dough-feedback]');
    this.pages = $el.find('[data-dough-feedback-page]');
    this.shareBtns = $el.find('[data-dough-feedback-share] .social-sharing__item__icon');
    this.submitBtn = $el.find('[data-dough-feedback-submit]');
    this.ajaxUrl = $el.attr('data-dough-on-page-feedback-post');
  };

  DoughBaseComponent.extend(OnPageFeedback);
  OnPageFeedback.componentName = 'OnPageFeedback';

  OnPageFeedback.prototype._submitInteraction = function(interaction) {
    var isLiked = (interaction === 'positive') ? true : false;
    
    var postObject = {
        liked: isLiked
      };
      
      $.post(this.ajaxUrl, postObject, function(data){
        this._showPage(interaction);
      }.bind(this))
      .fail(function() {
        console.log('SOMETHING WENT WRONG');
      }.bind(this));

  };

  OnPageFeedback.prototype._share = function() {
    // TODO: Do we need to track 'shares'? I can't remember.
    this._showPage('results');
  };

  OnPageFeedback.prototype._submitComment = function() {
    // TODO: another AJAX call here with the comment
    this._showPage('results');
  };

  OnPageFeedback.prototype._showPage = function(pageName) {
    this.pages.addClass('is-hidden');
    this.pages.filter('[data-dough-feedback-page=' + pageName + ']').removeClass('is-hidden');
  };

  OnPageFeedback.prototype._bindHandlers = function() {
    var self = this;
    this.interactionBtn.on('click', function(e) {
      e.preventDefault();
      self._submitInteraction($(this).attr('data-dough-feedback'));
    });
    this.shareBtns.on('click', $.proxy(this._share, this));
    this.submitBtn.on('click', $.proxy(this._submitComment));
  };

  OnPageFeedback.prototype.init = function(initialised) {
    this._bindHandlers();
    this._initialisedSuccess(initialised);
  };

  return OnPageFeedback;
});
