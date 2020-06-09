describe.only('MoneyNavigatorResults', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    fixture.setBase('spec/javascripts/fixtures');

    requirejs(
        ['jquery', 'MoneyNavigatorResults'],
        function($, MoneyNavigatorResults) {
          fixture.load('MoneyNavigatorResults.html');
          self.component = $(fixture.el).find('[data-dough-component="MoneyNavigatorResults"]');
          self.obj = new MoneyNavigatorResults(self.component);
          self.$headingContent = self.component.find('[data-heading-content]'); 
          self.$headingTitles = self.component.find('[data-heading-title]'); 
          self.$sections = self.component.find('[data-section]'); 
          self.hiddenClass  = self.obj.hiddenClass; 
          self.collapsedClass = self.obj.collapsedClass; 

          done();
        }, done);
  });

  afterEach(function() {
    fixture.cleanup();
  });

  describe('Initialisation', function() {
    it('Calls the correct methods when the component is initialised', function() {
      var updateDOMStub = sinon.stub(this.obj, '_updateDOM'); 

      this.obj.init();

      expect(updateDOMStub.calledOnce).to.be.true; 

      updateDOMStub.restore(); 
    });
  });

  describe('updateDOM method', function() {
    it('Makes the correct changes to the DOM when called', function() {
      var _this = this;

      this.obj._updateDOM(); 

      this.$headingContent.each(function() {
        expect($(this).hasClass(_this.hiddenClass)).to.be.true; 
      }); 

      this.$sections.each(function() {
        expect($(this).hasClass(_this.collapsedClass)).to.be.true; 
        expect($(this).find('.section__title__icon').length).to.equal(1); 
      }); 

      this.$headingTitles.each(function() {
        expect($(this).find('.heading__title__icon').length).to.equal(1); 
      }); 
    }); 
  }); 
});
