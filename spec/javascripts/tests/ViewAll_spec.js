describe('ViewAll', function () {
  'use strict';

  describe("default behaviour", function(){
    beforeEach(function (done){
      var self = this;

      requirejs(['jquery', 'ViewAll'], function ($, ViewAll) {
        self.$html = $(window.__html__['spec/javascripts/fixtures/ViewAllDefault.html']).appendTo('body');
        self.component = self.$html.find('[data-dough-component="ViewAll"]');
        self.trigger = self.$html.find('[data-dough-view-all-trigger]');

        self.ViewAll = new ViewAll(self.component).init();
        done();
      }, done);
    });

    afterEach(function () {
      this.$html.remove();
    });

    it('has more than 5 items', function() {
      var items = this.$html.find('[data-dough-view-all-item]');
      expect(items.length).to.equal(6);
    });

    it('only displays the first 5 items', function() {
      var visibleItems = this.$html.find('[data-dough-view-all-item]:not(.view-all__item--hidden)');
      expect(visibleItems.length).to.equal(5);
    });

    it('displays the View all link', function() {
      expect(this.trigger.hasClass('view-all__trigger--hidden')).to.be.false;
    });

    describe('invoking the trigger', function() {
      beforeEach(function() {
        this.trigger.click();
      });

      it('displays all the items', function() {
        var visibleItems = this.$html.find('[data-dough-view-all-item]:not(.view-all__item--hidden)');
        expect(visibleItems.length).to.equal(6);
      });

      it('hides the trigger', function() {
        expect(this.trigger.hasClass('view-all__trigger--hidden')).to.be.true;
      });
    });
  });

  describe("fewer than default initial number of items to display", function(){
    beforeEach(function (done){
      var self = this;

      requirejs(['jquery', 'ViewAll'], function ($, ViewAll) {
        self.$html = $(window.__html__['spec/javascripts/fixtures/ViewAllFewer.html']).appendTo('body');
        self.component = self.$html.find('[data-dough-component="ViewAll"]');
        self.trigger = self.$html.find('[data-dough-view-all-trigger]');

        self.ViewAll = new ViewAll(self.component).init();
        done();
      }, done);
    });

    afterEach(function () {
      this.$html.remove();
    });

    it('has 5 items', function() {
      var items = this.$html.find('[data-dough-view-all-item]');
      expect(items.length).to.equal(5);
    });

    it('displays all 5 items', function() {
      var visibleItems = this.$html.find('[data-dough-view-all-item]:not(.view-all__item--hidden)');
      expect(visibleItems.length).to.equal(5);
    });

    it('does not display the View all link', function() {
      expect(this.trigger.hasClass('view-all__trigger--hidden')).to.be.true;
    });
  });

  describe("custom behaviour", function(){
    beforeEach(function (done){
      var self = this;

      requirejs(['jquery', 'ViewAll'], function ($, ViewAll) {
        self.$html = $(window.__html__['spec/javascripts/fixtures/ViewAllCustom.html']).appendTo('body');
        self.component = self.$html.find('[data-dough-component="ViewAll"]');
        self.trigger = self.$html.find('[data-dough-view-all-trigger]');

        self.ViewAll = new ViewAll(self.component, self.component.data('dough-view-all-config')).init();
        done();
      }, done);
    });

    afterEach(function () {
      this.$html.remove();
    });

    it('has all items', function() {
      var items = this.$html.find('[data-dough-view-all-item]');
      expect(items.length).to.equal(4);
    });

    it('only displays the first 3 items', function() {
      var visibleItems = this.$html.find('[data-dough-view-all-item]:not(.view-all__item--hidden)');
      expect(visibleItems.length).to.equal(3);
    });

    it('displays the View all link', function() {
      expect(this.trigger.hasClass('view-all__trigger--hidden')).to.be.false;
    });

    describe('invoking the trigger', function() {
      beforeEach(function() {
        this.trigger.click();
      });

      it('displays all the items', function() {
        var visibleItems = this.$html.find('[data-dough-view-all-item]:not(.view-all__item--hidden)');
        expect(visibleItems.length).to.equal(4);
      });

      it('hides the trigger', function() {
        expect(this.trigger.hasClass('view-all__trigger--hidden')).to.be.true;
      });
    });
  });
});
