define(['jquery', 'featureDetect', 'DoughBaseComponent', 'common'], function($, FeatureDetect, DoughBaseComponent, MAS) {
  'use strict';

  var OnPageFeedback;
  
  OnPageFeedback = function($el, config) {
    OnPageFeedback.baseConstructor.call(this, $el, config, {});

    this.interactionBtn = $el.find('[data-dough-feedback]');
    this.pages = $el.find('[data-dough-feedback-page]');
    this.shareBtns = $el.find('[data-dough-feedback-share] .social-sharing__item__icon');
    this.submitBtn = $el.find('[data-dough-feedback-submit]');
    this.submitForm = $el.find('[data-dough-feedback-form]');
    this.ajaxUrl = $el.attr('data-dough-on-page-feedback-post');
    this.likeCount = $el.find('[data-dough-feedback-like-count]');
    this.dislikeCount = $el.find('[data-dough-feedback-dislike-count]');
    this.likeElement = $el.find('[data-dough-feedback-like-count]');
    this.dislikeElement = $el.find('[data-dough-feedback-dislike-count]');
    this.pageId = window.location.pathname.match(/^.*\/([a-zA-Z0-9-_]+)$/)[1];
  };

  DoughBaseComponent.extend(OnPageFeedback);
  OnPageFeedback.componentName = 'OnPageFeedback';

  OnPageFeedback.prototype._submitInteraction = function(interaction) {
    var isLiked = (interaction === 'positive') ? true : false;
    
    var postObject = {
      liked: isLiked
    };

    var submitInteraction = $.post(this.ajaxUrl, postObject, function(data){
      this._storeLastInteraction(interaction);
      this._showPage(interaction);
      this._updateCount(data);
    }.bind(this))
    .fail(function() {
      MAS.warn('failed to submit like / dislike');
    }.bind(this));
  };

  OnPageFeedback.prototype._share = function(share) {
    var submitShare = $.ajax({
      url: this.ajaxUrl,
      type: 'PATCH',
      data: {'shared_on': share}    
    });
    submitShare.fail(function(status){
      MAS.warn('failed to submit share');
    });

    this._storeLastInteraction('share');
    this._showPage('results');
    this._animateResult('like');
  };

  OnPageFeedback.prototype._submitComment = function() {
    var userComment = $('[data-dough-feedback-comment]').val(),
    submitFeedback = $.ajax({
      url: this.ajaxUrl,
      type: 'PATCH',
      data: {'comment': userComment}
    });

    submitFeedback.fail(function(status){
      MAS.warn('failed to submit comment');
    });
    this._storeLastInteraction('comment');
    this._showPage('results');
    this._animateResult('dislike');
  };

  OnPageFeedback.prototype._animateResult = function(interaction) {
    var el,
    total;

    if (interaction === 'like') {
      el = this.likeElement;
    } else {
      el = this.dislikeElement;
    };

    total = parseInt(el.text());
    el.text(total - 1);

    window.setTimeout(function(){
      el.closest('.on-page-feedback__results-item').addClass('is-animating');
    }.bind(this), 300);
    window.setTimeout(function(){
      el.text(total);
    }.bind(this), 600);
  };


  OnPageFeedback.prototype._updateCount = function(data) {
    var countResponse = data;

    this.likeElement.text(countResponse.likes_count);
    this.dislikeElement.text(countResponse.dislikes_count);
  };

  OnPageFeedback.prototype._showPage = function(pageName) {
    this.pages.addClass('is-hidden');
    this.pages.filter('[data-dough-feedback-page=' + pageName + ']').removeClass('is-hidden');
  };

  OnPageFeedback.prototype._storeLastInteraction = function(interaction) {
    localStorage.setItem('MAS.onPageFeedback.' + this.pageId, interaction);
  };

  OnPageFeedback.prototype._checkForStoredState = function() {
    var lastInteraction = localStorage['MAS.onPageFeedback.' + this.pageId];

    if (typeof lastInteraction != 'undefined') {
      switch (lastInteraction) {
        case 'positive':
        case 'negative':
          this._showPage(lastInteraction);
          break;
        case 'share':
        case 'comment':
          this._showPage('results');
          break;
      }
    }
  };

  OnPageFeedback.prototype._bindHandlers = function() {
    var self = this;

    this.interactionBtn.on('click', function(e) {
      e.preventDefault();
      self._submitInteraction($(this).attr('data-dough-feedback'));
    });
    this.shareBtns.on('click', function() {
      self._share($(this).attr('data-dough-shared-on'));
    });
    this.submitForm.on('submit', $.proxy(function(e){
      e.preventDefault;
      // Only submit the form if there are no validation errors
      if (this.submitForm.find('.is-errored').length === 0) {
        this._submitComment();
      };
      return false;
    }, this));
  };

  OnPageFeedback.prototype.init = function(initialised) {
    if (!FeatureDetect.localstorage) return

    this._bindHandlers();
    this._checkForStoredState();
    this._initialisedSuccess(initialised);
  };

  return OnPageFeedback;
});
