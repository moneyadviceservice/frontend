describe('MoneyNavigatorResults', function() {
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
          self.hiddenClass  = self.obj.hiddenClass; 

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

  describe.only('updateDOM method', function() {
    it('Makes the correct changes to the DOM when called', function() {
      var _this = this;

      this.obj._updateDOM(); 

      this.$headingContent.each(function() {
        expect($(this).hasClass(_this.hiddenClass)).to.be.true; 
      }); 
    }); 
  }); 
});
