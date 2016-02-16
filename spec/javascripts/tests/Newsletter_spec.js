describe('Newsletter', function () {

  'use strict';

  afterEach(function() {
    this.$html.remove();
  });

  describe('injecting newsletter form into an article with h2', function() {
    beforeEach(function(done) {
      var self = this;
      requirejs(
        ['jquery', 'componentLoader'],
        function($, componentLoader) {
          self.componentLoader = componentLoader;

          self.$html = $(window.__html__['spec/javascripts/fixtures/Newsletter.html']).filter('#fixture-1').appendTo('body');

          self.componentLoader.init(self.$html).then(function() {
            done();
          });
        }
      );
    });

    it('adds classes to the newsletter panel', function() {
      var panel = this.$html.find('[data-dough-component="Newsletter"]');

      expect(panel).to.have.class('--with-image');
      expect(panel).to.have.class('--in-article');
    });

    it('moves the panel into position', function() {
      var panelNextToHeader = this.$html.find('[data-dough-component="Newsletter"] + h2');
      expect(panelNextToHeader.length).to.be.equal(1);
    });
  });

  describe('injecting newsletter form into an article with h3', function() {
    beforeEach(function(done) {
      var self = this;
      requirejs(
        ['jquery', 'componentLoader'],
        function($, componentLoader) {
          self.componentLoader = componentLoader;

          self.$html = $(window.__html__['spec/javascripts/fixtures/Newsletter.html']).filter('#fixture-2').appendTo('body');

          self.componentLoader.init(self.$html).then(function() {
            done();
          });
        }
      );
    });

    it('moves the panel into position', function() {
      var panelNextToHeader = this.$html.find('[data-dough-component="Newsletter"] + h3');
      expect(panelNextToHeader.length).to.be.equal(1);
    });
  });

  describe('injecting newsletter form into an article without headers', function() {
    beforeEach(function(done) {
      var self = this;
      requirejs(
        ['jquery', 'componentLoader'],
        function($, componentLoader) {
          self.componentLoader = componentLoader;

          self.$html = $(window.__html__['spec/javascripts/fixtures/Newsletter.html']).filter('#fixture-3').appendTo('body');

          self.componentLoader.init(self.$html).then(function() {
            done();
          });
        }
      );
    });

    it('moves the panel into position', function() {
      var panelAtEnd = this.$html.find('p:last-of-type + [data-dough-component="Newsletter"]');
      expect(panelAtEnd.length).to.be.equal(1);
    });
  });
});
