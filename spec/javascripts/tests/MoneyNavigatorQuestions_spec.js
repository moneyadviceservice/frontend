describe('MoneyNavigatorQuestions', function() {
  'use strict';

  var dataLayer = [{'Responsive page': 'Yes', 'event': 'Responsive page'}]; 
  var dataLayerMock = sinon.mock(dataLayer);

  beforeEach(function(done) {
    var self = this;

    requirejs(
        ['jquery', 'MoneyNavigatorQuestions'],
        function($, MoneyNavigatorQuestions) {
          self.$html = $(window.__html__['spec/javascripts/fixtures/MoneyNavigatorQuestions.html']).appendTo('body');
          self.component = self.$html.find('[data-dough-component="MoneyNavigatorQuestions"]');
          self.obj = new MoneyNavigatorQuestions(self.component);
          self.banner = $(self.component).parents().find('[data-banner]'); 
          self.questions = self.component.find('[data-question]'); 
          self.activeClass = self.obj.activeClass; 
          self.inactiveClass = self.obj.inactiveClass; 
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
      var setUpMultipleQuestionsStub = sinon.stub(this.obj, '_setUpMultipleQuestions'); 
      var setUpGroupedQuestionsStub = sinon.stub(this.obj, '_setUpGroupedQuestions'); 
      var setUpJourneyLogicStub = sinon.stub(this.obj, '_setUpJourneyLogic'); 
      var setUpKeyboardEventsStub = sinon.stub(this.obj, '_setUpKeyboardEvents'); 
      
      this.obj.init();

      expect(updateDOMStub.calledOnce).to.be.true;
      expect(setUpMultipleQuestionsStub.calledOnce).to.be.true; 
      expect(setUpGroupedQuestionsStub.calledOnce).to.be.true; 
      expect(setUpJourneyLogicStub.calledOnce).to.be.true; 
      expect(setUpKeyboardEventsStub.calledOnce).to.be.true; 

      updateDOMStub.restore(); 
      setUpMultipleQuestionsStub.restore(); 
      setUpGroupedQuestionsStub.restore(); 
      setUpJourneyLogicStub.restore(); 
      setUpKeyboardEventsStub.restore(); 
    });
  });

  describe('setUpGroupedQuestions method', function() {
    beforeEach(function() {
      this.groupedQuestion = this.questions[3]; 
      this.updateGroupedQuestionsDisplaySpy = sinon.spy(this.obj, '_updateGroupedQuestionsDisplay'); 
      this.obj._updateDOM(); 
      this.obj._setUpGroupedQuestions(); 
    }); 

    afterEach(function() {
      this.updateGroupedQuestionsDisplaySpy.restore(); 
    }); 

    it('Adds new control options and collections for each group', function() {
      expect($(this.groupedQuestion).find('[data-response-group-control]').length).to.equal(2); 
      expect($(this.groupedQuestion).find('[data-reset]').length).to.equal(2); 

      var collections = $(this.groupedQuestion).find('[data-response-collection]'); 

      expect(collections.length).to.equal(2); 
      expect($(collections[0]).find('[data-response]').length).to.equal(3); 
      expect($(collections[1]).find('[data-response]').length).to.equal(2); 
    }); 

    it ('Checks that the correct method is called when the `response-control` options are activated', function() {
      var responseControls = $(this.groupedQuestion).find('[data-response-controls]'); 
      var inputs = $(responseControls).find('input'); 

      $(inputs[0]).trigger('change'); 
      expect(this.updateGroupedQuestionsDisplaySpy.calledOnce).to.be.true; 
      expect(this.updateGroupedQuestionsDisplaySpy.calledWith(inputs[0])).to.be.true; 

      $(inputs[1]).trigger('change'); 
      expect(this.updateGroupedQuestionsDisplaySpy.calledTwice).to.be.true; 
      expect(this.updateGroupedQuestionsDisplaySpy.calledWith(inputs[1])).to.be.true; 

      $(inputs[2]).trigger('change'); 
      expect(this.updateGroupedQuestionsDisplaySpy.calledThrice).to.be.true; 
      expect(this.updateGroupedQuestionsDisplaySpy.calledWith(inputs[2])).to.be.true; 
    }); 

    it ('Checks that the correct method is called when the `reset` option is activated', function() {
      var responseCollections = $(this.groupedQuestion).find('[data-response-collection]'); 
      var resetBtn = $(responseCollections[0]).find('[data-reset]'); 
      var backBtn = $(this.groupedQuestion).find('[data-back]'); 

      $(resetBtn).trigger('click'); 

      expect(this.updateGroupedQuestionsDisplaySpy.calledOnce).to.be.true; 
      expect(this.updateGroupedQuestionsDisplaySpy.calledWith(resetBtn[0])).to.be.true; 
    }); 
  }); 

  describe('updateGroupedQuestionsDisplay method', function() {
    beforeEach(function() {
      this.groupedQuestion = this.questions[3]; 

      this.obj._updateDOM(); 
      this.obj._setUpGroupedQuestions(); 

      // Controls
      var $controls = $(this.groupedQuestion).find('.response__controls'); 
      this.control_default = $controls.find('[data-response]').find('input')[0];
      this.control_1 = $controls.find('#control_1')[0]; 
      this.control_2 = $controls.find('#control_2')[0]; 

      // Collections
      var collections = $(this.groupedQuestion).find('.question__response--collection'); 
      this.collection_1_1 = $(collections[0]).find('input')[0]; 
      this.collection_1_2 = $(collections[0]).find('input')[1]; 
      this.collection_1_3 = $(collections[0]).find('input')[2]; 
      this.collection_2_1 = $(collections[1]).find('input')[0]; 
      this.collection_2_2 = $(collections[1]).find('input')[1]; 

      // Resets
      this.collection_1_reset = $(collections[0]).find('[data-reset]')[0]; 
      this.collection_2_reset = $(collections[1]).find('[data-reset]')[0]; 

      // Continue
      this.continue = $(this.groupedQuestion).find('[data-continue]'); 
    }); 

    xit('Adds the correct classes to groups when called', function() {
      this.obj._updateGroupedQuestionsDisplay(this.control_1); 
      expect($(this.groupedQuestion).find('[data-response-controls]').hasClass(this.inactiveClass)).to.be.true; 
      expect($(this.groupedQuestion).find('[data-response-collection="1"]').hasClass(this.inactiveClass)).to.be.false; 
      expect($(this.groupedQuestion).find('[data-response-collection="2"]').hasClass(this.inactiveClass)).to.be.true; 

      this.obj._updateGroupedQuestionsDisplay(this.control_2); 
      expect($(this.groupedQuestion).find('[data-response-controls]').hasClass(this.inactiveClass)).to.be.true; 
      expect($(this.groupedQuestion).find('[data-response-collection="1"]').hasClass(this.inactiveClass)).to.be.true; 
      expect($(this.groupedQuestion).find('[data-response-collection="2"]').hasClass(this.inactiveClass)).to.be.false; 

      this.obj._updateGroupedQuestionsDisplay(this.collection_1_reset); 
      expect($(this.groupedQuestion).find('[data-response-controls]').hasClass(this.inactiveClass)).to.be.false; 
      expect($(this.groupedQuestion).find('[data-response-collection="1"]').hasClass(this.inactiveClass)).to.be.true; 
      expect($(this.groupedQuestion).find('[data-response-collection="2"]').hasClass(this.inactiveClass)).to.be.true; 

      this.obj._updateGroupedQuestionsDisplay(this.collection_2_reset); 
      expect($(this.groupedQuestion).find('[data-response-controls]').hasClass(this.inactiveClass)).to.be.false; 
      expect($(this.groupedQuestion).find('[data-response-collection="1"]').hasClass(this.inactiveClass)).to.be.true; 
      expect($(this.groupedQuestion).find('[data-response-collection="2"]').hasClass(this.inactiveClass)).to.be.true; 
    }); 

    it('Sets the correct states on the input elements when called', function() {
      this.obj._updateGroupedQuestionsDisplay(this.control_1); 
      expect(this.control_default.checked).to.be.false; 
      expect(this.control_1.checked).to.be.true; 
      expect(this.control_2.checked).to.be.false; 

      this.obj._updateGroupedQuestionsDisplay(this.control_2); 
      expect(this.control_default.checked).to.be.false; 
      expect(this.control_1.checked).to.be.false; 
      expect(this.control_2.checked).to.be.true; 

      this.obj._updateGroupedQuestionsDisplay(this.control_default); 
      expect(this.control_default.checked).to.be.true; 
      expect(this.control_1.checked).to.be.false; 
      expect(this.control_2.checked).to.be.false; 
    }); 

    it('Sets the correct state on the `Continue` button when called', function() {
      this.control_default.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.control_default); 
      expect(this.continue[0].disabled).to.be.false; 

      this.control_default.checked = false; 
      this.control_1.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.control_1); 
      expect(this.continue[0].disabled).to.be.true; 

      this.control_1.checked = false; 
      this.control_2.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.control_2); 
      expect(this.continue[0].disabled).to.be.true; 

      this.control_2.checked = false; 
      this.collection_1_1.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.collection_1_1); 
      expect(this.continue[0].disabled).to.be.false; 

      this.collection_1_1.checked = false; 
      this.collection_1_2.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.collection_1_2); 
      expect(this.continue[0].disabled).to.be.false; 

      this.collection_1_2.checked = false; 
      this.collection_2_1.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.collection_2_1); 
      expect(this.continue[0].disabled).to.be.false; 

      this.collection_2_1.checked = false; 
      this.collection_2_2.checked = true; 
      this.obj._updateGroupedQuestionsDisplay(this.collection_2_2); 
      expect(this.continue[0].disabled).to.be.false; 
    }); 

    it('Sets focus correctly for keyboard a11y when called', function() {
      // Selecting control group input moves focus to relevant collection and sets input tabinex to 0
      $(this.control_default).focus(); 

      this.obj._updateGroupedQuestionsDisplay(this.control_1);
      expect(this.collection_1_1 === document.activeElement).to.be.true; 
      expect($(this.collection_1_1).attr('tabindex') == 0).to.be.true; 
      expect(this.collection_2_1 === document.activeElement).to.be.false; 
      expect($(this.collection_2_1).attr('tabindex') == -1).to.be.true; 

      this.obj._updateGroupedQuestionsDisplay(this.control_2);
      expect(this.collection_1_1 === document.activeElement).to.be.false; 
      expect($(this.collection_1_1).attr('tabindex') == -1).to.be.true; 
      expect(this.collection_2_1 === document.activeElement).to.be.true; 
      expect($(this.collection_2_1).attr('tabindex') == 0).to.be.true; 

      // Selecting reset on a collection returns focus to selected control input and sets input tabinex to -1
      $(this.control_2).attr('checked', true); 
      this.obj._updateGroupedQuestionsDisplay(this.collection_2_reset);
      expect(this.control_2 === document.activeElement).to.be.true; 
      expect($(this.collection_1_1).attr('tabindex') == -1).to.be.true;
      expect($(this.collection_2_1).attr('tabindex') == -1).to.be.true; 

      $(this.control_2).attr('checked', false); 
      $(this.control_1).attr('checked', true); 
      this.obj._updateGroupedQuestionsDisplay(this.collection_1_reset);
      expect(this.control_1 === document.activeElement).to.be.true; 
      expect($(this.collection_1_1).attr('tabindex') == -1).to.be.true;
      expect($(this.collection_2_1).attr('tabindex') == -1).to.be.true; 
    }); 

    xit('Updates tabindex value on Reset button when collection is active/inactive', function() {
      $(this.control_default).focus(); 

      this.obj._updateGroupedQuestionsDisplay(this.control_1);
      expect($(this.collection_1_reset).attr('tabindex') == 0).to.be.true; 
      expect($(this.collection_2_reset).attr('tabindex') == -1).to.be.true; 

      this.obj._updateGroupedQuestionsDisplay(this.control_2);
      expect($(this.collection_1_reset).attr('tabindex') == -1).to.be.true; 
      expect($(this.collection_2_reset).attr('tabindex') == 0).to.be.true; 

      this.obj._updateGroupedQuestionsDisplay(this.collection_2_reset);
      expect($(this.collection_1_reset).attr('tabindex') == -1).to.be.true; 
      expect($(this.collection_2_reset).attr('tabindex') == -1).to.be.true; 
    }); 
  });

  describe('setUpKeyboardEvents method', function() {
    var event = $.Event('keydown'),
        keyCode; 

    beforeEach(function() {
      this.groupedQuestion = this.questions[3]; 

      this.obj._updateDOM(); 
      this.obj._setUpGroupedQuestions(); 
      this.obj._setUpKeyboardEvents(); 

      // Collections
      var collections = $(this.groupedQuestion).find('.question__response--collection'); 
      this.collection_1_1 = $(collections[0]).find('input')[0]; 
      this.collection_1_2 = $(collections[0]).find('input')[1]; 
      this.collection_1_3 = $(collections[0]).find('input')[2]; 
      this.collection_2_1 = $(collections[1]).find('input')[0]; 
      this.collection_2_2 = $(collections[1]).find('input')[1]; 
    }); 

    it('Moves focus within each collection with down arrow key', function() {
      keyCode = 40; 
      event.keyCode = keyCode; 

      $(this.collection_1_1).focus();

      $(this.collection_1_1).trigger(event); 
      expect(this.collection_1_1 === document.activeElement).to.be.false; 
      expect(this.collection_1_2 === document.activeElement).to.be.true; 

      $(this.collection_1_2).trigger(event); 
      expect(this.collection_1_2 === document.activeElement).to.be.false; 
      expect(this.collection_1_3 === document.activeElement).to.be.true; 

      $(this.collection_1_3).trigger(event); 
      expect(this.collection_1_3 === document.activeElement).to.be.false; 
      expect(this.collection_1_1 === document.activeElement).to.be.true; 

      $(this.collection_2_1).focus();

      $(this.collection_2_1).trigger(event); 
      expect(this.collection_2_1 === document.activeElement).to.be.false; 
      expect(this.collection_2_2 === document.activeElement).to.be.true; 

      $(this.collection_2_2).trigger(event); 
      expect(this.collection_2_2 === document.activeElement).to.be.false; 
      expect(this.collection_2_1 === document.activeElement).to.be.true; 
    }); 

    it('Moves focus within each collection with right arrow key', function() {
      keyCode = 39; 
      event.keyCode = keyCode; 

      $(this.collection_1_1).focus();

      $(this.collection_1_1).trigger(event); 
      expect(this.collection_1_1 === document.activeElement).to.be.false; 
      expect(this.collection_1_2 === document.activeElement).to.be.true; 

      $(this.collection_1_2).trigger(event); 
      expect(this.collection_1_2 === document.activeElement).to.be.false; 
      expect(this.collection_1_3 === document.activeElement).to.be.true; 

      $(this.collection_1_3).trigger(event); 
      expect(this.collection_1_3 === document.activeElement).to.be.false; 
      expect(this.collection_1_1 === document.activeElement).to.be.true; 

      $(this.collection_2_1).focus();

      $(this.collection_2_1).trigger(event); 
      expect(this.collection_2_1 === document.activeElement).to.be.false; 
      expect(this.collection_2_2 === document.activeElement).to.be.true; 

      $(this.collection_2_2).trigger(event); 
      expect(this.collection_2_2 === document.activeElement).to.be.false; 
      expect(this.collection_2_1 === document.activeElement).to.be.true; 
    }); 

    it('Moves focus within each collection with up arrow key', function() {
      keyCode = 38; 
      event.keyCode = keyCode; 

      $(this.collection_1_3).focus();

      $(this.collection_1_3).trigger(event); 
      expect(this.collection_1_3 === document.activeElement).to.be.false; 
      expect(this.collection_1_2 === document.activeElement).to.be.true; 

      $(this.collection_1_2).trigger(event); 
      expect(this.collection_1_2 === document.activeElement).to.be.false; 
      expect(this.collection_1_1 === document.activeElement).to.be.true; 

      $(this.collection_1_1).trigger(event); 
      expect(this.collection_1_1 === document.activeElement).to.be.false; 
      expect(this.collection_1_3 === document.activeElement).to.be.true; 

      $(this.collection_2_2).focus();

      $(this.collection_2_2).trigger(event); 
      expect(this.collection_2_2 === document.activeElement).to.be.false; 
      expect(this.collection_2_1 === document.activeElement).to.be.true; 

      $(this.collection_2_1).trigger(event); 
      expect(this.collection_2_1 === document.activeElement).to.be.false; 
      expect(this.collection_2_2 === document.activeElement).to.be.true; 
    }); 

    it('Moves focus within each collection with left arrow key', function() {
      keyCode = 37; 
      event.keyCode = keyCode; 

      $(this.collection_1_3).focus();

      $(this.collection_1_3).trigger(event); 
      expect(this.collection_1_3 === document.activeElement).to.be.false; 
      expect(this.collection_1_2 === document.activeElement).to.be.true; 

      $(this.collection_1_2).trigger(event); 
      expect(this.collection_1_2 === document.activeElement).to.be.false; 
      expect(this.collection_1_1 === document.activeElement).to.be.true; 

      $(this.collection_1_1).trigger(event); 
      expect(this.collection_1_1 === document.activeElement).to.be.false; 
      expect(this.collection_1_3 === document.activeElement).to.be.true; 

      $(this.collection_2_2).focus();

      $(this.collection_2_2).trigger(event); 
      expect(this.collection_2_2 === document.activeElement).to.be.false; 
      expect(this.collection_2_1 === document.activeElement).to.be.true; 

      $(this.collection_2_1).trigger(event); 
      expect(this.collection_2_1 === document.activeElement).to.be.false; 
      expect(this.collection_2_2 === document.activeElement).to.be.true; 
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
      var multipleQuestion = this.questions[2]; 

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

      expect($(multipleQuestion).find('[data-continue]')[0].disabled).to.be.true; 
      expect($(multipleQuestion).find('[data-back]')[0].disabled).to.be.false; 
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

      // Q2 is skipped
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

    it('Adds focus to correct element when `back` button is clicked', function() {
      $(this.questions[4]).addClass(this.activeClass); 

      this.obj._updateDisplay('prev'); 
      expect($(this.questions[3])[0] === document.activeElement).to.be.true; 

      // Q3 is skipped
      $(this.questions[2]).data('question-skip', true); 
      this.obj._updateDisplay('prev'); 
      expect($(this.questions[2])[0] === document.activeElement).to.be.false; 
      expect($(this.questions[1])[0] === document.activeElement).to.be.true; 
    }); 

    it('Shows/hides the banner when active question is/not Q0', function() {
      var hiddenClass = 'l-money_navigator__banner' + '--' + this.hiddenClass; 

      this.obj._updateDOM(); 

      this.obj._updateDisplay('next');
      expect(this.$html.find('[data-banner]')[0].className.indexOf(hiddenClass)).to.be.above(-1); 

      this.obj._updateDisplay('next');
      expect(this.$html.find('[data-banner]')[0].className.indexOf(hiddenClass)).to.be.above(-1); 

      this.obj._updateDisplay('prev');
      expect(this.$html.find('[data-banner]')[0].className.indexOf(hiddenClass)).to.be.above(-1); 

      this.obj._updateDisplay('prev');
      expect(this.$html.find('[data-banner]')[0].className.indexOf(hiddenClass)).to.equal(-1); 
    }); 

    it('Updates the counter to the correct value for the active question', function() {
      this.obj._updateDOM(); 

      this.obj._updateDisplay('next');
      expect($(this.questions[1]).find('.question__counter').text()).to.equal('17% completed'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[2]).find('.question__counter').text()).to.equal('33% completed'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[3]).find('.question__counter').text()).to.equal('50% completed'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[4]).find('.question__counter').text()).to.equal('67% completed'); 

      this.obj._updateDisplay('next');
      expect($(this.questions[5]).find('.question__counter').text()).to.equal('83% completed'); 
    }); 
  }); 

  describe('setUpMultipleQuestions method', function() {
    beforeEach(function() {
      var multipleQuestion = this.questions[2]; 
      var inputs = $(multipleQuestion).find('input[type="checkbox"]');

      this.response_no = $(inputs[1]).parents('[data-response]'); 
      this.obj._setUpMultipleQuestions(); 
    }); 

    it('Adds classname to `No` response', function() {
      expect($(this.response_no).hasClass('button--no')).to.be.true; 
    }); 

    it('Positions `No` response correctly in the DOM', function() {
      expect(this.response_no.parent().hasClass('content__inner')).to.be.true; 
    }); 

    it('Adds `Yes` response after `No`', function() {
      expect(this.response_no.next().prop('tagName').toUpperCase()).to.equal('DIV'); 
      expect(this.response_no.next().hasClass('button--yes')).to.be.true; 
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
    }); 
  }); 

  describe('updateMultipleQuestion method', function() {
    beforeEach(function() {
      this.obj._updateDOM(); 
      this.obj._setUpMultipleQuestions(); 

      var multipleQuestion = this.questions[2]; 
      this.inputs = $(multipleQuestion).find('input[type="checkbox"]');
      this.continueBtn = $(multipleQuestion).find('[data-continue]'); 
    }); 

    it('Updates the state of `Yes` & `No` inputs correctly when called', function() {
      // `No` is checked
      this.inputs[0].checked = true; 
      this.inputs[1].checked = true; 
      this.obj._updateMultipleQuestion(this.inputs[0]); 
      expect(this.inputs[0].checked).to.be.true; 
      expect(this.inputs[1].checked).to.be.false; 
      expect(this.inputs[2].disabled).to.be.true; 

      // `Yes` is checked
      this.inputs[0].checked = true; 
      this.inputs[1].checked = true; 
      this.obj._updateMultipleQuestion(this.inputs[1]); 
      expect(this.inputs[0].checked).to.be.false; 
      expect(this.inputs[1].checked).to.be.true; 
      expect(this.inputs[2].disabled).to.be.false; 
    }); 

    describe('When no further options are selected', function() {
      it('Updates the state of the `Continue` button correctly when Yes/No are changed', function() {
        // `No` is checked
        this.inputs[0].checked = true; 
        this.inputs[1].checked = false; 
        this.inputs[2].checked = false; 
        this.obj._updateMultipleQuestion(this.inputs[0]); 
        expect(this.continueBtn[0].disabled).to.be.false; 

        // `Yes` is checked
        this.inputs[0].checked = false; 
        this.inputs[1].checked = true; 
        this.inputs[2].checked = false; 
        this.obj._updateMultipleQuestion(this.inputs[1]); 
        expect(this.continueBtn[0].disabled).to.be.true; 
      });
    }); 

    describe('When one or more further options are selected', function() {
      it('Updates the state of the `Continue` button correctly when Yes/No are changed', function() {
        // `Further option` is checked
        // `No` is checked
        this.inputs[0].checked = true; 
        this.inputs[1].checked = false; 
        this.inputs[2].checked = true; 
        this.obj._updateMultipleQuestion(this.inputs[0]); 
        expect(this.continueBtn[0].disabled).to.be.false; 

        // `Further option` is checked
        // `Yes` is checked
        this.inputs[0].checked = false; 
        this.inputs[1].checked = true; 
        this.inputs[2].checked = true; 
        this.obj._updateMultipleQuestion(this.inputs[1]); 
        expect(this.continueBtn[0].disabled).to.be.false; 
      }); 

      it('Updates the state of the `Continue` button correctly when a further option is changed', function() {
        // `No` is checked
        // `Further option` is checked
        this.inputs[0].checked = true; 
        this.inputs[1].checked = false; 
        this.inputs[2].checked = true; 
        this.obj._updateMultipleQuestion(this.inputs[2]); 
        expect(this.continueBtn[0].disabled).to.be.false; 

        // `Yes` is checked
        // `Further option` is unchecked
        this.inputs[0].checked = false; 
        this.inputs[1].checked = true; 
        this.inputs[2].checked = false; 
        this.obj._updateMultipleQuestion(this.inputs[2]); 
        expect(this.continueBtn[0].disabled).to.be.true; 
      }); 
    }); 
  }); 

  dataLayerMock.verify(); 
});
