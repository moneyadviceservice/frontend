describe.only('MoneyNavigatorQuestions', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    fixture.setBase('spec/javascripts/fixtures');

    requirejs(
        ['jquery', 'MoneyNavigatorQuestions'],
        function($, MoneyNavigatorQuestions) {
          var dataLayer = [{'Responsive page': 'Yes', 'event': 'Responsive page'}]; 

          fixture.load('MoneyNavigatorQuestions.html');
          self.component = $(fixture.el).find('[data-dough-component="MoneyNavigatorQuestions"]');
          self.obj = new MoneyNavigatorQuestions(self.component);
          self.questions = self.component.find('[data-question]'); 
          self.activeClass = self.obj.activeClass; 
          self.dataLayerMock = sinon.mock(dataLayer);

          done();
        }, done);
  });

  afterEach(function() {
    fixture.cleanup();
    this.dataLayerMock.verify(); 
  });

  describe('Initialisation', function() {
    it('Calls the correct methods when the component is initialised', function() {
      var updateDOMStub = sinon.stub(this.obj, '_updateDOM'); 
      var setUpMultipleQestionsStub = sinon.stub(this.obj, '_setUpMultipleQuestions'); 
      
      this.obj.init();

      expect(updateDOMStub.calledOnce).to.be.true;
      expect(setUpMultipleQestionsStub.calledOnce).to.be.true; 

      updateDOMStub.restore(); 
      setUpMultipleQestionsStub.restore(); 
    });
  });

  describe('udpateAnalytics method', function() {
    it('Checks the dataLayer object is updated correctly when the get started button is clicked', function() {
      this.obj._updateDOM(); 

      var $getStartedBtn = this.component.find('[data-get-started]'); 
      var inputs = this.component.find('input[name="questions[q0]"]'); 

      inputs[0].checked = true;
      this.obj._updateAnalytics($getStartedBtn[0], this.dataLayerMock.object);

      var dataLayer = this.dataLayerMock.object; 
      var eventAction = dataLayer[dataLayer.length - 1].eventAction; 
      var eventLabel = dataLayer[dataLayer.length - 1].eventLabel; 

      expect(dataLayer.length).to.equal(2); 
      expect(eventAction).to.equal('Q0'); 
      expect(eventLabel).to.equal('Q0A1'); 

      inputs[2].checked = true;
      this.obj._updateAnalytics($getStartedBtn[0], this.dataLayerMock.object);

      var dataLayer = this.dataLayerMock.object; 
      var eventAction = dataLayer[dataLayer.length - 1].eventAction; 
      var eventLabel = dataLayer[dataLayer.length - 1].eventLabel; 

      expect(dataLayer.length).to.equal(3); 
      expect(eventAction).to.equal('Q0'); 
      expect(eventLabel).to.equal('Q0A3'); 
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

      expect($(this.questions[0]).hasClass(this.activeClass)).to.be.true; 
      expect($(this.questions[1]).hasClass(this.activeClass)).to.be.false; 
      expect($(this.questions[2]).hasClass(this.activeClass)).to.be.false; 
    }); 
  }); 

  describe('Get started button', function() {
    it('Calls the correct methods with the correct arguments when clicked', function() {
      this.obj._updateDOM(this.dataLayerMock.object); 

      var updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay'); 
      var updateAnalyticsSpy = sinon.spy(this.obj, '_updateAnalytics'); 
      var $getStartedBtn = this.component.find('[data-get-started]'); 

      $getStartedBtn.trigger('click'); 

      expect(updateDisplaySpy.calledWith('next')).to.be.true; 
      expect(updateAnalyticsSpy.calledWith($getStartedBtn[0], this.dataLayerMock.object)).to.be.true; 

      updateDisplaySpy.restore(); 
      updateAnalyticsSpy.restore(); 
    }); 
  }); 

  describe('Continue button', function() {
    it('Calls the correct method with the correct argument when clicked', function() {
      var updateDisplaySpy;

      this.obj._updateDOM(); 

      updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay');
      this.component.find('[data-continue]').first().trigger('click'); 
      expect(updateDisplaySpy.calledWith('next')).to.be.true; 
      updateDisplaySpy.restore(); 

      updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay');
      this.component.find('[data-continue]').last().trigger('click', 'preventDefault'); 
      expect(updateDisplaySpy.calledWith('next')).to.be.false; 
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

  describe('updateDisplay method', function() {
    it('Adds/removes the active class from the correct question', function() {
      $(this.questions[0]).addClass(this.activeClass); 

      this.obj._updateDisplay('next'); 

      expect($(this.questions[0]).hasClass(this.activeClass)).to.be.false; 
      expect($(this.questions[1]).hasClass(this.activeClass)).to.be.true; 

      this.obj._updateDisplay('prev'); 

      expect($(this.questions[0]).hasClass(this.activeClass)).to.be.true; 
      expect($(this.questions[1]).hasClass(this.activeClass)).to.be.false; 
    }); 
  }); 

  describe('setUpMultipleQuestions method', function() {
    beforeEach(function() {
      var multipleQuestion = this.questions[1]; 

      this.responses = $(multipleQuestion).find('input');
      this.obj._setUpMultipleQuestions(); 
    }); 

    it('Adds the expected states when the method is called', function() {
      expect(this.responses[0].disabled).to.be.false; 
      expect(this.responses[1].disabled).to.be.true; 
      expect(this.responses[2].disabled).to.be.true; 
    });

    it('Calls the correct methods when the first checkbox state is changed', function() {
      var updateMultipleQuestionsSpy = sinon.spy(this.obj, '_updateMultipleQuestions'); 
      $(this.responses[0]).trigger('change'); 
      expect(updateMultipleQuestionsSpy.calledWith(this.responses[0])).to.be.true; 
      updateMultipleQuestionsSpy.restore(); 

      var updateMultipleQuestionsSpy = sinon.spy(this.obj, '_updateMultipleQuestions'); 
      $(this.responses[1]).trigger('change'); 
      expect(updateMultipleQuestionsSpy.calledWith(this.responses[0])).to.be.false; 
      updateMultipleQuestionsSpy.restore(); 
    })
  }); 

  describe('updateMultipleQuestions method', function() {
    it('Updates the state of inputs correctly when called', function() {
      var multipleQuestion = this.questions[1]; 
      var responses = $(multipleQuestion).find('input[type="checkbox"]');

      this.obj._setUpMultipleQuestions(); 

      responses[0].checked = false; 

      this.obj._updateMultipleQuestions(responses[0]); 

      expect(responses[1].disabled).to.be.false; 
      expect(responses[2].disabled).to.be.false; 

      responses[0].checked = true; 

      this.obj._updateMultipleQuestions(responses[0]); 

      expect(responses[1].disabled).to.be.true; 
      expect(responses[2].disabled).to.be.true; 
    }); 
  }); 
});
