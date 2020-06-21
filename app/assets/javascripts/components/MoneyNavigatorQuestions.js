define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorQuestions;
  
  MoneyNavigatorQuestions = function($el, config) {
    MoneyNavigatorQuestions.baseConstructor.call(this, $el, config);

    this.$submitBtn = this.$el.find('[data-submit]'); 
    this.$questions = this.$el.find('[data-question]'); 
    this.$multipleQuestions = this.$el.find('[data-question-multiple]'); 
    this.activeClass = 'question--active'; 
    this.dataLayer = window.dataLayer; 
  };

  DoughBaseComponent.extend(MoneyNavigatorQuestions);

  MoneyNavigatorQuestions.componentName = 'MoneyNavigatorQuestions';

  MoneyNavigatorQuestions.prototype.init = function(initialised) {
    this._updateDOM(this.dataLayer); 
    this._setUpMultipleQuestions(); 
    this._setUpValidation(); 
    this._initialisedSuccess(initialised);
  };

  MoneyNavigatorQuestions.prototype._setUpValidation = function() {
    var _this = this; 

    this.$questions.each(function() {
      var question = this; 
      var $inputs = $(question).find('input'); 

      $inputs.on('change', function() {
        var checkedInputs = []; 

        $inputs.each(function() {
          if (this.checked) {
            checkedInputs.push(this); 
          }
        }); 

        if (checkedInputs.length == 0) {
          _this._handleValidation(question); 
        } else if ($(question).find('[data-error-message]').length > 0) {
          _this._handleValidation(question, 'reset');           
        }
      }); 
    })
  }; 

  MoneyNavigatorQuestions.prototype._handleValidation = function(question, options) {
    if (options == 'reset') {
      $(question).find('[data-error-message]').remove(); 
      $(question).find('[data-continue]').attr('disabled', false); 
    } else {
      $(question).find('legend').after('<p class="question__error" data-error-message>Please answer this question before continuing</p>'); 
      $(question).find('[data-continue]').attr('disabled', true); 
    }
  }

  MoneyNavigatorQuestions.prototype._updateAnalytics = function(btn, dataLayer) {
    var question = $(btn).parents('[data-question-id]'); 
    var eventAction = $(question).data('questionId').toUpperCase(); 
    var eventLabel; 
    var eventResponse = ''; 
    var inputs = $(btn).parents('[data-question-id]').find('input[type="radio"], input[type="checkbox"]'); 
    var inputsCheckedValues = []; 
    var inputsCheckedText = []; 

    for (var i = 0, length = inputs.length; i < length; i++) {
      if (inputs[i].checked) {
        inputsCheckedValues.push(eventAction + inputs[i].value.toUpperCase()); 
        eventResponse = $(inputs[i]).siblings('label').text(); 
      }
    }; 

    if (inputsCheckedValues.length > 0) {
      eventLabel = inputsCheckedValues.join('-'); 
    } else {
      eventLabel = inputsCheckedValues[0];
    }

    if (dataLayer) {
      dataLayer.push({
        event: 'gtm_question_answered',
        eventCategory: 'MNT_Diagnostic', 
        eventAction: eventAction,
        eventLabel: eventLabel 
      });

      // For testing purposes only
      console.log('dataLayer: ', dataLayer); 
    }

    if ($(question).data('question-custom') !== undefined) {
      dataLayer.push({
        event: 'gtm_question_custom',
        eventCategory: 'MNT_Diagnostic', 
        eventQuestion: $(question).find('legend').text(),
        eventResponse: eventResponse.trim()
      });

      // For testing purposes only
      console.log('dataLayer: ', dataLayer);       
    }

    if ($(btn).data('submit')) {
      var eventLabels = []; 

      for (var i = 0, length = dataLayer.length; i < length; i++) {
        if (dataLayer[i].eventLabel) {
          eventLabels.push(dataLayer[i].eventLabel); 
        }
      }

      eventLabel = eventLabels.join('_'); 

      dataLayer.push({
        event: 'gtm_questions_submit',
        eventCategory: 'MNT_Diagnostic', 
        eventAction: 'submit',
        eventLabel: eventLabel 
      });

      // For testing purposes only
      console.log('dataLayer: ', dataLayer); 
    }
  }; 

  MoneyNavigatorQuestions.prototype._updateDOM = function(dataLayer) {
    var _this = this; 
    var dataLayer = dataLayer; 

    // Removes submit button
    this.$submitBtn.remove(); 

    for (var i = 0, length = this.$questions.length; i < length; i++) {
      var question = this.$questions[i]; 

      if (i === 0) {
        // Adds get-started button to first question
        $(question).find('.question__content').append('<div class="question__actions"><button class="button button--start" data-get-started="true">Continue</button></div>'); 
         // Adds active class to first question
        $(question).addClass(_this.activeClass); 
      } else if (i === (length - 1)) {
          // Adds submit button to last question
          $(question).find('.question__content')
            .append('<div class="question__actions"><button data-submit="true" class="button button--continue">Submit</button><button data-back="true" class="button button--back">Back</button></div>')
      } else {
        // Adds continue and back buttons to all other questions
        $(question).find('.question__content')
          .append('<div class="question__actions"><button data-continue="true" class="button button--continue">Continue</button><button data-back="true" class="button button--back">Back</button></div>')
      }
    }; 

    var buttons = this.$el.find('button'); 

    buttons.on('click', function(e, options) {
      if ($(this).data('get-started')) {
        e.preventDefault(); 
        _this._updateDisplay('next'); 
        _this._updateAnalytics(e.target, dataLayer); 
        _this._scrollToTop(); 
      } else if ($(this).data('continue')) {
        e.preventDefault(); 
        _this._updateDisplay('next'); 
        _this._updateAnalytics(e.target, dataLayer); 
        _this._scrollToTop(); 
      } else if ($(this).data('submit')) {
        if (options == 'preventDefault') {
          e.preventDefault(); 
        }
        _this._updateAnalytics(e.target, dataLayer); 
      } else if ($(this).data('back')) {
        e.preventDefault(); 
        _this._updateDisplay('prev'); 
        _this._scrollToTop(); 
      }
    }); 
  }

  MoneyNavigatorQuestions.prototype._scrollToTop = function() {
    $('html, body').animate({
        scrollTop: $('#money_navigator__questions').offset().top
      }, 250
    );          
  }; 

  MoneyNavigatorQuestions.prototype._updateDisplay = function(dir) {
    var activeIndex, questionClasses = []; 

    this.$questions.each(function() {
      questionClasses.push(this.className); 
    }); 

    activeIndex = questionClasses.indexOf('l-money_navigator__question ' + this.activeClass); 

    $(this.$questions[activeIndex]).removeClass(this.activeClass); 

    if (dir === 'next') {
      $(this.$questions[activeIndex + 1]).addClass(this.activeClass); 
    } else {
      $(this.$questions[activeIndex - 1]).addClass(this.activeClass); 
    }
  }

  MoneyNavigatorQuestions.prototype._setUpMultipleQuestions = function() {
    var _this = this; 

    this.$multipleQuestions.each(function() {
      var inputs = $(this).find('input[type="checkbox"]'); 

      $(inputs[0]).on('change', function(e) {
        _this._updateMultipleQuestions(e.target); 
      }); 

      for (var i = 0, length = inputs.length; i < length; i++) {
        if (i > 0) {
          inputs[i].disabled = true; 
        }
      }
    }); 
  }

  MoneyNavigatorQuestions.prototype._updateMultipleQuestions = function(input) {
    var responses = $(input).parents('[data-response]').siblings('[data-response]'); 

    responses.each(function() {
      $(this).find('input[type="checkbox"]').each(function() {
        if (input.checked) {
          this.disabled = true; 
        } else {
          this.disabled = false; 
        }
      })
    })
  }

  return MoneyNavigatorQuestions; 
}); 
