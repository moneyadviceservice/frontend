describe.only('MoneyNavigatorQuestions', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    fixture.setBase('spec/javascripts/fixtures');

    requirejs(
        ['jquery', 'MoneyNavigatorQuestions'],
        function($, MoneyNavigatorQuestions) {
          fixture.load('MoneyNavigatorQuestions.html');
          self.component = $(fixture.el).find('[data-dough-component="MoneyNavigatorQuestions"]');
          self.obj = new MoneyNavigatorQuestions(self.component);
          self.questions = self.component.find('[data-question]'); 

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
    it('Makes correct changes to the DOM', function() {
      this.obj._updateDOM(); 

      expect(this.component.find('[data-submit]').length).to.equal(0);

      expect($(this.questions[0]).find('[data-get-started]').length).to.equal(1); 
      expect($(this.questions[1]).find('[data-get-started]').length).to.equal(0); 
      expect($(this.questions[2]).find('[data-get-started]').length).to.equal(0); 

      expect($(this.questions[0]).find('[data-continue]').length).to.equal(0); 
      expect($(this.questions[1]).find('[data-continue]').length).to.equal(1); 
      expect($(this.questions[2]).find('[data-continue]').length).to.equal(1); 

      expect($(this.questions[0]).find('[data-back]').length).to.equal(0); 
      expect($(this.questions[1]).find('[data-back]').length).to.equal(1); 
      expect($(this.questions[2]).find('[data-back]').length).to.equal(1); 

      expect($(this.questions[0]).hasClass('question--active')).to.be.true; 
      expect($(this.questions[1]).hasClass('question--active')).to.be.false; 
      expect($(this.questions[2]).hasClass('question--active')).to.be.false; 
    }); 
  }); 

  describe('Get started button', function() {
    it('Calls the correct method with the correct argument when clicked', function() {
      var updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay'); 

      this.obj._updateDOM(); 
      this.component.find('[data-get-started]').click(); 

      expect(updateDisplaySpy.calledWith('next')).to.be.true; 

      updateDisplaySpy.restore(); 
    }); 
  }); 

  describe('Continue button', function() {
    it('Calls the correct method with the correct argument when clicked', function() {
      var updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay'); 

      this.obj._updateDOM(); 
      this.component.find('[data-continue]').click(); 

      expect(updateDisplaySpy.calledWith('next')).to.be.true; 

      updateDisplaySpy.restore(); 
    }); 
  }); 

  describe('Back button', function() {
    it('Calls the correct method with the correct argument when clicked', function() {
      var updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay'); 

      this.obj._updateDOM(); 
      this.component.find('[data-back]').click(); 

      expect(updateDisplaySpy.calledWith('prev')).to.be.true; 

      updateDisplaySpy.restore(); 
    }); 
  }); 
});
