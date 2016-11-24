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
    this.likeElement = $el.find('[data-dough-feedback-like-container]');
    this.dislikeElement = $el.find('[data-dough-feedback-dislike-container]');
    this.pageId = this._getPageId();
    this.currentPage = 'start';
  };

  DoughBaseComponent.extend(OnPageFeedback);
  OnPageFeedback.componentName = 'OnPageFeedback';

  OnPageFeedback.prototype._getPageId = function() {
    return window.location.pathname.match(/^.*\/([a-zA-Z0-9-_]+)$/)[1];
  }

  OnPageFeedback.prototype._submitInteraction = function(interaction) {
    var isLiked = (interaction === 'positive') ? true : false;
    
    var postObject = {
      liked: isLiked
    };

    var submitInteraction = $.post(this.ajaxUrl, postObject, function(data){
      this._showPage(interaction);
      this._storeState();
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
    this._animateResult('like');
    this._storeState();
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
    this._animateResult('dislike');
    this._storeState();
  };

  OnPageFeedback.prototype._animateResult = function(interaction) {
    var el,
    total;

    if (interaction === 'like') {
      el = this.likeElement;
    } else {
      el = this.dislikeElement;
    };

    window.setTimeout(function(){
      el.closest('.on-page-feedback__results-item').addClass('is-animating');
    }.bind(this), 300);
  };

  OnPageFeedback.prototype._showPage = function(pageName) {
    this.pages.addClass('is-hidden');
    this.pages.filter('[data-dough-feedback-page=' + pageName + ']').removeClass('is-hidden');
    this.currentPage = pageName;
  };

  OnPageFeedback.prototype._restoreState = function() {
    var data = localStorage['MAS.onPageFeedback.' + this.pageId];

    if (typeof(data) != 'undefined') {
      var json = JSON.parse(data)

      // Ignore stored data if more than 30 days old
      if (json.time > (Date.now() - (30*24*60*60*1000))) {
        this.currentPage = json.current_page;
      }
    }
  };

  OnPageFeedback.prototype._storeState = function() {
    var data = {
      time: Date.now(),
      current_page: this.currentPage
    }

    localStorage['MAS.onPageFeedback.' + this.pageId] = JSON.stringify(data);
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
    this._restoreState();

    if (this.currentPage === 'results') {
      return;
    } else if (this.currentPage != 'start') {
      this._showPage(this.currentPage);
    }

    this._initialisedSuccess(initialised);
  };

  return OnPageFeedback;
});
