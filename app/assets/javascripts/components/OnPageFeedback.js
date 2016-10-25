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

  OnPageFeedback.prototype._share = function(share) {

    // Get the title text from the clicked share element
    var shareSource = $(share.target).find('title').text(),

    // Split this to get the last word (Facebook, Twitter, Email)
    shareValue = shareSource.split(" ").pop();
    
    var submitShare = $.ajax({
      url: this.ajaxUrl,
      type: 'PATCH',
      data: {'shared_on': shareValue},
      success: $.proxy(this._updateCount)    
    });

    submitShare.fail(function(status){
      console.log('Failed to send share');
    });

    this._showPage('results');
  };

  OnPageFeedback.prototype._submitComment = function() {
    var userComment = $('[data-dough-feedback-comment]').val(),
        submitFeedback = $.ajax({
          url: this.ajaxUrl,
          type: 'PATCH',
          data: {'comment': userComment},
          success: $.proxy(this._updateCount)
        });

    submitFeedback.fail(function(status){
      console.log('Failed to send feedback: "' + userComment + '"');
    });

    this._showPage('results');
  };

  OnPageFeedback.prototype._updateCount = function(data) {
    var likeCount     = $('[data-dough-feedback-like-count]'),
        dislikeCount  = $('[data-dough-feedback-dislike-count]'),
        countResponse = data;

    likeCount.text(countResponse.likes_count);
    dislikeCount.text(countResponse.dislikes_count);
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
    this.submitBtn.on('click', $.proxy(this._submitComment, this));
  };

  OnPageFeedback.prototype.init = function(initialised) {
    this._bindHandlers();
    this._initialisedSuccess(initialised);
  };

  return OnPageFeedback;
});
