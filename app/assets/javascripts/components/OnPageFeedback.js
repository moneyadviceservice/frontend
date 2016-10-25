define(['jquery', 'DoughBaseComponent', 'common'], function($, DoughBaseComponent, MAS) {
  'use strict';

  var OnPageFeedback;
  
  OnPageFeedback = function($el, config) {
    OnPageFeedback.baseConstructor.call(this, $el, config, {});

    this.interactionBtn = $el.find('[data-dough-feedback]');
    this.pages = $el.find('[data-dough-feedback-page]');
    this.shareBtns = $el.find('[data-dough-feedback-share] .social-sharing__item__icon');
    this.submitBtn = $el.find('[data-dough-feedback-submit]');
    this.ajaxUrl = $el.attr('data-dough-on-page-feedback-post');
    this.likeCount = $el.find('[data-dough-feedback-like-count]');
    this.dislikeCount = $el.find('[data-dough-feedback-dislike-count]');
  };

  DoughBaseComponent.extend(OnPageFeedback);
  OnPageFeedback.componentName = 'OnPageFeedback';

  OnPageFeedback.prototype._submitInteraction = function(interaction) {
    var isLiked = (interaction === 'positive') ? true : false;
    
    var postObject = {
      liked: isLiked
    };

    var submitInteraction = $.post(this.ajaxUrl, postObject, function(data){
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

    this._showPage('results');
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
    this._showPage('results');
  };

  OnPageFeedback.prototype._updateCount = function(data) {
    var countResponse = data;

    this.likeCount.text(countResponse.likes_count);
    this.dislikeCount.text(countResponse.dislikes_count);
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
    this.shareBtns.on('click', function() {
      self._share($(this).attr('data-dough-shared-on'));
    });
    this.submitBtn.on('click', $.proxy(this._submitComment, this));
  };

  OnPageFeedback.prototype.init = function(initialised) {
    this._bindHandlers();
    this._initialisedSuccess(initialised);
  };

  return OnPageFeedback;
});
