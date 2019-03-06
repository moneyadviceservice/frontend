describe('OnPageFeedback', function() {

  'use strict';
  var server;

  beforeEach(function(done) {
    var self = this;
    requirejs(
      ['jquery', 'OnPageFeedback', 'jquerymigrate'],
      function($, OnPageFeedback, jquerymigrate) {
        self.$html = $(window.__html__['spec/javascripts/fixtures/OnPageFeedback.html']).appendTo('body');
        self.component = self.$html.find('[data-dough-component="OnPageFeedback"]');
        self.interactionBtn = self.$html.find('[data-dough-feedback]');
        self.pages = self.$html.find('[data-dough-feedback-page]');
        self.shareBtns = self.$html.find('[data-dough-feedback-share] .social-sharing__item__icon');
        self.submitBtn = self.$html.find('[data-dough-feedback-submit]');
        self.likesElement = self.$html.find('[data-dough-feedback-like-count]');
        self.dislikesElement = self.$html.find('[data-dough-feedback-dislike-count]');

        // Override _getPageId, since we don't have a DOM for it to access
        OnPageFeedback.prototype._getPageId = function() { return '1' };

        localStorage.clear();
        self.OnPageFeedback = new OnPageFeedback(self.$html).init();

        server = sinon.fakeServer.create();
        var serverResponse = '{"id":13,"page_id":1,"liked":true,"likes_count":12,"dislikes_count":5}';
        server.respondWith('POST', 'initial-feedback-endpoint',
          [201, { 'Content-Type': 'application/json' },
          serverResponse]);
        server.respondWith('PATCH', 'initial-feedback-endpoint',
          [201, { 'Content-Type': 'application/json' },
          serverResponse]);

        done();
      }, done);
  });

  describe('Hiding and showing pages', function(){

    it('should only show the first step', function() {
      expect(this.pages.eq(0)).to.not.have.class('is-hidden');
      expect(this.pages.eq(1)).to.have.class('is-hidden');
      expect(this.pages.eq(2)).to.have.class('is-hidden');
    });

    it('shows the positive step after clicking positive button', function() {
      this.interactionBtn.filter('[data-dough-feedback=positive]').trigger('click');
      server.respond();
      expect(this.pages.filter('[data-dough-feedback-page=positive]')).to.not.have.class('is-hidden');
    });

    it('shows the negative step after clicking negative button', function() {
      this.interactionBtn.filter('[data-dough-feedback=negative]').trigger('click');
      server.respond();
      expect(this.pages.filter('[data-dough-feedback-page=negative]')).to.not.have.class('is-hidden');
    });

    it('shows the results step after clicking share button', function() {
      this.interactionBtn.filter('[data-dough-feedback=positive]').trigger('click');
      server.respond();
      this.shareBtns.trigger('click');
      expect(this.pages.filter('[data-dough-feedback-page=results]')).to.not.have.class('is-hidden');
    });
  });

  afterEach(function () {
    this.$html.remove();
    server.restore();
  });

});
