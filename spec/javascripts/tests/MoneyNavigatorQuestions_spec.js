describe('MoneyNavigatorQuestions', function() {
  'use strict';

  var dataLayer = [{'Responsive page': 'Yes', 'event': 'Responsive page'}]; 
  var dataLayerMock = sinon.mock(dataLayer);

  beforeEach(function(done) {
    var self = this;

    fixture.setBase('spec/javascripts/fixtures');

    requirejs(
        ['jquery', 'MoneyNavigatorQuestions'],
        function($, MoneyNavigatorQuestions) {
          fixture.load('MoneyNavigatorQuestions.html');
          self.component = $(fixture.el).find('[data-dough-component="MoneyNavigatorQuestions"]');
          self.obj = new MoneyNavigatorQuestions(self.component);
          self.banner = $('#fixture_container').find('[data-banner]'); 
          self.questions = self.component.find('[data-question]'); 
          self.activeClass = self.obj.activeClass; 
          self.hiddenClass = self.obj.hiddenClass; 
          self.skipQuestions = self.obj.skipQuestions; 

          done();
        }, done);
  });

  afterEach(function() {
    fixture.cleanup();
  });

  describe('Initialisation', function() {
    it('Calls the correct methods when the component is initialised', function() {
      var updateDOMStub = sinon.stub(this.obj, '_updateDOM'); 
      var setUpMultipleQestionsStub = sinon.stub(this.obj, '_setUpMultipleQuestions'); 
      var setUpValidationStub = sinon.stub(this.obj, '_setUpValidation'); 
      var setUpJourneyLogicStub = sinon.stub(this.obj, '_setUpJourneyLogic'); 
      
      this.obj.init();

      expect(updateDOMStub.calledOnce).to.be.true;
      expect(setUpMultipleQestionsStub.calledOnce).to.be.true; 
      expect(setUpValidationStub.calledOnce).to.be.true; 
      expect(setUpJourneyLogicStub.calledOnce).to.be.true; 

      updateDOMStub.restore(); 
      setUpMultipleQestionsStub.restore(); 
      setUpValidationStub.restore(); 
      setUpJourneyLogicStub.restore(); 
    });
  });

  describe('setUpJourneyLogic method', function() {
    it('Checks that the addJourneyData method is called with the correct arguments', function() {
      var addJourneyDataSpy = sinon.spy(this.obj, '_addJourneyData'); 
      var question = this.questions[1]; 
      var inputs = $(question).find('input[type=radio]'); 

      // On load the first input is checked, Q3 is skipped
      inputs[0].checked = true; 
      this.obj.init(); 
      expect(addJourneyDataSpy.calledWith([3])).to.be.true; 

      // When a selection is made on Q1: 
      // If A2 is selected go to Q3 then Q4 (Q2 is skipped)
      inputs[0].checked = false; 
      inputs[1].checked = true; 
      $(inputs[1]).trigger('change'); 
      expect(addJourneyDataSpy.calledWith([2])).to.be.true; 

      // If A3 is selected go to Q4 (Q2 & Q3 are skipped)
      inputs[1].checked = false; 
      inputs[2].checked = true; 
      $(inputs[2]).trigger('change'); 
      expect(addJourneyDataSpy.calledWith([2, 3])).to.be.true; 

      // If A4 is selected go to Q4 (Q2 & Q3 are skipped)
      inputs[2].checked = false; 
      inputs[3].checked = true; 
      $(inputs[3]).trigger('change'); 
      expect(addJourneyDataSpy.calledWith([2, 3])).to.be.true; 

      // If A1 is selected go to Q2 then Q4 (Q3 is skipped)
      inputs[3].checked = false; 
      inputs[0].checked = true; 
      $(inputs[0]).trigger('change'); 
      expect(addJourneyDataSpy.calledWith([2])).to.be.true; 

      addJourneyDataSpy.restore(); 
    }); 
  }); 

  describe('addJourneyData method', function() {
    it('Checks that the data-value is added/removed to/from appropriate elements', function() {
      // Q2 is skipped
      $(this.questions).data('question-skip', false); 
      this.obj._addJourneyData([2]); 
      expect ($(this.questions[2]).data('question-skip')).to.be.true; 
      expect ($(this.questions[3]).data('question-skip')).to.be.false; 

      // Q3 is skipped
      $(this.questions).data('question-skip', false); 
      this.obj._addJourneyData([3]); 
      expect ($(this.questions[2]).data('question-skip')).to.be.false; 
      expect ($(this.questions[3]).data('question-skip')).to.be.true; 

      // Q2 & Q3 are skipped
      $(this.questions).data('question-skip', false); 
      this.obj._addJourneyData([2, 3]); 
      expect ($(this.questions[2]).data('question-skip')).to.be.true; 
      expect ($(this.questions[3]).data('question-skip')).to.be.true; 
    }); 
  }); 

  describe('setUpValidation method', function() {
    it ('Sets up the method', function() {
      this.obj._setUpValidation();

      var handleValidationSpy = sinon.spy(this.obj, '_handleValidation')
      var question = this.questions[2]; 
      var inputs = $(question).find('input'); 

      inputs[0].checked = true; 
      inputs[1].checked = true; 
      expect(handleValidationSpy.calledWith(question)).to.be.false; 

      inputs[1].checked = false; 
      $(inputs[1]).trigger('change');
      expect(handleValidationSpy.calledWith(question)).to.be.false; 

      inputs[0].checked = false; 
      $(inputs[0]).trigger('change');
      expect(handleValidationSpy.calledWith(question)).to.be.true; 

      inputs[0].checked = true; 
      $(inputs[0]).trigger('change');
      expect(handleValidationSpy.calledWith(question, 'reset')).to.be.true; 

      handleValidationSpy.restore(); 
    }); 
  }); 

  describe('handleValidation method', function() {
    it ('Checks the error message is added', function() {
      var question = this.questions[2]; 

      this.obj._updateDOM(); 

      this.obj._handleValidation(question); 
      expect($(question).find('[data-error-message]').length).to.equal(1); 
      expect($(question).find('[data-continue]')[0].disabled).to.be.true; 

      this.obj._handleValidation(question, 'reset'); 
      expect($(question).find('[data-error-message]').length).to.equal(0); 
      expect($(question).find('[data-continue]')[0].disabled).to.be.false; 
    }); 
  }); 

  describe('udpateAnalytics method', function() {
    var dataLayer = dataLayerMock.object;

    beforeEach(function() {
      this.obj._updateDOM(); 
    }); 

    it('Checks the dataLayer object is updated correctly when the get started button is clicked', function() {
      var $getStartedBtn = this.component.find('[data-get-started]'), 
          inputs = this.component.find('input[name="questions[q0]"]'); 

      inputs[0].checked = true;
      this.obj._updateAnalytics($getStartedBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(2); 
      expect(dataLayer[dataLayer.length - 1].eventAction).to.equal('Q0'); 
      expect(dataLayer[dataLayer.length - 1].eventLabel).to.equal('Q0A1'); 

      inputs[2].checked = true;
      this.obj._updateAnalytics($getStartedBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(3); 
      expect(dataLayer[dataLayer.length - 1].eventAction).to.equal('Q0'); 
      expect(dataLayer[dataLayer.length - 1].eventLabel).to.equal('Q0A3'); 
    }); 

    it('Checks the dataLayer object is updated correctly when the continue button is clicked for single response questions', function() {
      var $continueBtn = this.component.find('[data-question-id="q1"]').find('[data-continue]'); 
      var inputs = this.component.find('input[name="questions[q1]"]'); 

      inputs[0].checked = true;
      this.obj._updateAnalytics($continueBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(5); 
      expect(dataLayer[dataLayer.length - 2].eventAction).to.equal('Q1'); 
      expect(dataLayer[dataLayer.length - 2].eventLabel).to.equal('Q1A1'); 

      expect(dataLayer.length).to.equal(5); 
      expect(dataLayer[dataLayer.length - 1].event).to.equal('gtm_question_custom'); 
      expect(dataLayer[dataLayer.length - 1].eventQuestion).to.equal('A custom question'); 
      expect(dataLayer[dataLayer.length - 1].eventResponse).to.equal('A custom response'); 

      inputs[1].checked = true;
      this.obj._updateAnalytics($continueBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(7); 
      expect(dataLayer[dataLayer.length - 2].eventAction).to.equal('Q1'); 
      expect(dataLayer[dataLayer.length - 2].eventLabel).to.equal('Q1A2'); 

      expect(dataLayer.length).to.equal(7); 
      expect(dataLayer[dataLayer.length - 1].event).to.equal('gtm_question_custom'); 
      expect(dataLayer[dataLayer.length - 1].eventQuestion).to.equal('A custom question'); 
      expect(dataLayer[dataLayer.length - 1].eventResponse).to.equal('Another custom response'); 
    }); 

    it('Checks the dataLayer object is updated correctly when the continue button is clicked for multiple response questions', function() {
      var $continueBtn = this.component.find('[data-question-id="q2"]').find('[data-continue]'); 
      var inputs = this.component.find('input[name="questions[q2][]"]'); 

      inputs[0].checked = true;
      this.obj._updateAnalytics($continueBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(8); 
      expect(dataLayer[dataLayer.length - 1].eventAction).to.equal('Q2'); 
      expect(dataLayer[dataLayer.length - 1].eventLabel).to.equal('Q2A1'); 

      inputs[0].checked = false;
      inputs[1].checked = true;
      this.obj._updateAnalytics($continueBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(9); 
      expect(dataLayer[dataLayer.length - 1].eventAction).to.equal('Q2'); 
      expect(dataLayer[dataLayer.length - 1].eventLabel).to.equal('Q2A2'); 

      inputs[2].checked = true;
      this.obj._updateAnalytics($continueBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(10); 
      expect(dataLayer[dataLayer.length - 1].eventAction).to.equal('Q2'); 
      expect(dataLayer[dataLayer.length - 1].eventLabel).to.equal('Q2A2-Q2A3'); 
    }); 

    it('Checks the dataLayer object is updated correctly when the submit button is clicked', function() {
      var $submitBtn = this.component.find('[data-question-id="q5"]').find('[data-submit]'); 
      var inputs = this.component.find('input[name="questions[q5]"]'); 

      inputs[0].checked = true;
      this.obj._updateAnalytics($submitBtn[0], dataLayerMock.object);

      expect(dataLayer.length).to.equal(12); 
      expect(dataLayer[dataLayer.length - 2].eventAction).to.equal('Q5'); 
      expect(dataLayer[dataLayer.length - 2].eventLabel).to.equal('Q5A1'); 
      expect(dataLayer[dataLayer.length - 1].eventAction).to.equal('submit');
      expect(dataLayer[dataLayer.length - 1].eventLabel).to.equal('Q0A1_Q0A3_Q1A1_Q1A2_Q2A1_Q2A2_Q2A2-Q2A3_Q5A1'); 
    }); 
  }); 

  describe('updateDOM method', function() {
    it('Makes correct changes to the DOM', function() {
      this.obj._updateDOM(); 

      expect($(this.questions[0]).find('[data-get-started]').length).to.equal(1); 
      expect($(this.questions[1]).find('[data-get-started]').length).to.equal(0); 
      expect($(this.questions[2]).find('[data-get-started]').length).to.equal(0); 
      expect($(this.questions[5]).find('[data-get-started]').length).to.equal(0); 

      expect($(this.questions[0]).find('[data-continue]').length).to.equal(0); 
      expect($(this.questions[1]).find('[data-continue]').length).to.equal(1); 
      expect($(this.questions[2]).find('[data-continue]').length).to.equal(1); 
      expect($(this.questions[5]).find('[data-continue]').length).to.equal(0); 

      expect($(this.questions[0]).find('[data-back]').length).to.equal(0); 
      expect($(this.questions[1]).find('[data-back]').length).to.equal(1); 
      expect($(this.questions[2]).find('[data-back]').length).to.equal(1); 
      expect($(this.questions[5]).find('[data-back]').length).to.equal(1); 

      expect($(this.questions[0]).find('[data-submit]').length).to.equal(0); 
      expect($(this.questions[1]).find('[data-submit]').length).to.equal(0); 
      expect($(this.questions[2]).find('[data-submit]').length).to.equal(0); 
      expect($(this.questions[5]).find('[data-submit]').length).to.equal(1); 

      expect($(this.questions[0]).hasClass(this.activeClass)).to.be.true; 
      expect($(this.questions[1]).hasClass(this.activeClass)).to.be.false; 
      expect($(this.questions[2]).hasClass(this.activeClass)).to.be.false; 
    }); 
  }); 

  describe('Button events', function() {
    beforeEach(function() {
      this.updateAnalyticsSpy = sinon.spy(this.obj, '_updateAnalytics'); 
      this.updateDisplaySpy = sinon.spy(this.obj, '_updateDisplay'); 
      this.scrollToTop = sinon.stub(this.obj, '_scrollToTop'); 
      this.obj._updateDOM(dataLayerMock.object); 
    }); 

    afterEach(function() {
      this.updateAnalyticsSpy.restore(); 
      this.updateDisplaySpy.restore(); 
      this.scrollToTop.restore(); 
    }); 

    describe('Get started button', function() {
      it('Calls the correct methods with the correct arguments when clicked', function() {
        var $getStartedBtn = this.component.find('[data-get-started]'); 

        $getStartedBtn.trigger('click'); 

        expect(this.updateDisplaySpy.calledWith('next')).to.be.true; 
        expect(this.updateAnalyticsSpy.calledWith($getStartedBtn[0], dataLayerMock.object)).to.be.true; 
        expect(this.scrollToTop.called).to.be.true; 
      }); 
    }); 

    describe('Continue button', function() {
      it('Calls the correct methods with the correct arguments when clicked', function() {
        var $continueBtn = this.component.find('[data-continue]'); 

        $continueBtn.trigger('click'); 

        expect(this.updateDisplaySpy.calledWith('next')).to.be.true; 
        expect(this.updateAnalyticsSpy.calledWith($continueBtn[0], dataLayerMock.object)).to.be.true; 
        expect(this.scrollToTop.called).to.be.true; 
      }); 
    }); 

    describe('Back button', function() {
      it('Calls the correct methods with the correct arguments when clicked', function() {
        var $backBtn = this.component.find('[data-back]'); 

        $backBtn.trigger('click'); 

        expect(this.updateDisplaySpy.calledWith('prev')).to.be.true; 
        expect(this.scrollToTop.called).to.be.true; 
      }); 
    }); 

    describe('Submit button', function() {
      it('Calls the correct method with the correct argument when clicked', function() {
        var $submitBtn = this.component.find('[data-submit]'); 

        $submitBtn.trigger('click', 'preventDefault'); 

        expect(this.updateAnalyticsSpy.calledWith($submitBtn[0], dataLayerMock.object)).to.be.true; 
      }); 
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

      // Q1 is skipped
      $(this.questions[1]).data('question-skip', true); 

      this.obj._updateDisplay('next'); 
      expect($(this.questions[0]).hasClass(this.activeClass)).to.be.false; 
      expect($(this.questions[1]).hasClass(this.activeClass)).to.be.false; 
      expect($(this.questions[2]).hasClass(this.activeClass)).to.be.true; 

      this.obj._updateDisplay('prev'); 
      expect($(this.questions[0]).hasClass(this.activeClass)).to.be.true; 
      expect($(this.questions[1]).hasClass(this.activeClass)).to.be.false; 
      expect($(this.questions[2]).hasClass(this.activeClass)).to.be.false; 
    }); 

    // TODO: Fix this test (in Tech Debt)
    xit('Shows/hides the banner when active question is/not Q0', function() {
      var hiddenClass = 'l-money_navigator__banner' + '--' + this.hiddenClass; 

      this.obj._updateDOM(); 

      this.obj._updateDisplay('next');
      expect(this.banner.hasClass(hiddenClass)).to.be.true; 

      this.obj._updateDisplay('next');
      expect(this.banner.hasClass(hiddenClass)).to.be.true; 

      this.obj._updateDisplay('prev');
      expect(this.banner.hasClass(hiddenClass)).to.be.true; 

      this.obj._updateDisplay('prev');
      expect(this.banner.hasClass(hiddenClass)).to.be.false; 
    }); 

    it('Updates the counter to the correct value for the active question', function() {
      this.obj._updateDOM(); 

      this.obj._updateDisplay('next');
      expect($(this.questions[1]).find('.question__counter').text()).to.equal('Completed 17%'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[2]).find('.question__counter').text()).to.equal('Completed 33%'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[3]).find('.question__counter').text()).to.equal('Completed 50%'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[4]).find('.question__counter').text()).to.equal('Completed 67%'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[5]).find('.question__counter').text()).to.equal('Completed 83%'); 
    }); 
  }); 

  describe.only('setUpMultipleQuestions method', function() {
    beforeEach(function() {
      var multipleQuestion = this.questions[2]; 
      var inputs = $(multipleQuestion).find('input[type="checkbox"]');

      this.response_no = $(inputs[1]).parents('[data-response]'); 
      this.obj._setUpMultipleQuestions(); 
    }); 

    it('Adds classname to `No` response', function() {
      expect($(this.response_no).hasClass('question__response__no')).to.be.true; 
    }); 

    it('Positions `No` response correctly in the DOM', function() {
      expect(this.response_no.prev().prop('tagName').toUpperCase()).to.equal('LEGEND'); 
    }); 

    it('Adds `Yes` response after `No`', function() {
      expect(this.response_no.next().prop('tagName').toUpperCase()).to.equal('DIV'); 
      expect(this.response_no.next().hasClass('question__response__yes')).to.be.true; 
    }); 

    it('Sets `Yes` as the default input', function() {
      var inputs = $(this.questions[2]).find('input[type=checkbox]'); 

      expect(inputs[0].checked).to.be.false; 
      expect(inputs[1].checked).to.be.true; 
    }); 

    it('Calls the correct methods when `Yes` & `No` checkbox states are changed', function() {
      var updateMultipleQuestionSpy = sinon.spy(this.obj, '_updateMultipleQuestion'); 
      var inputs = $(this.questions[2]).find('input[type=checkbox]'); 

      $(inputs[0]).trigger('change'); 
      expect(updateMultipleQuestionSpy.calledWith(inputs[0])).to.be.true; 

      $(inputs[1]).trigger('change'); 
      expect(updateMultipleQuestionSpy.calledWith(inputs[1])).to.be.true; 

      updateMultipleQuestionSpy.restore(); 
    })
  }); 

  describe('updateMultipleQuestion method', function() {
    it('Updates the state of inputs correctly when called', function() {
      var multipleQuestion = this.questions[2]; 
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

  dataLayerMock.verify(); 
});
