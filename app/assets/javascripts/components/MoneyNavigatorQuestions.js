define(['jquery', 'DoughBaseComponent'], function ($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorQuestions,
    i18nStrings = {
      continue_btn: 'Continue',
      back_btn: 'Back',
      submit_btn: 'Submit',
    };

  MoneyNavigatorQuestions = function ($el, config) {
    MoneyNavigatorQuestions.baseConstructor.call(this, $el, config);

    this.i18nStrings =
      config && config.i18nStrings ? config.i18nStrings : i18nStrings;
    this.$submitBtn = this.$el.find('[data-submit]');
    this.$questions = this.$el.find('[data-question]');
    this.$multipleQuestions = this.$el.find('[data-question-multiple]');
    this.banner = $(document).find('[data-banner]'); // this.$el.parents('[data-banner]');
    this.activeClass = 'question--active';
    this.hiddenClass = 'is-hidden';
    this.dataLayer = window.dataLayer;
    this.skipQuestions = [
      {
        // When a response is selected on Q1:
        // If A1 is selected go to Q2 then Q4 (Q3 is skipped)
        // If A2 is selected go to Q3 then Q4 (Q2 is skipped)
        // If A3 is selected go to Q4 (Q2 & Q3 are skipped)
        // If A4 is selected go to Q4 (Q2 & Q3 are skipped)
        num: 1,
        responses: {
          A1: [3],
          A2: [2],
          A3: [2, 3],
          A4: [2, 3],
        },
      },
    ];
  };

  DoughBaseComponent.extend(MoneyNavigatorQuestions);

  MoneyNavigatorQuestions.componentName = 'MoneyNavigatorQuestions';

  MoneyNavigatorQuestions.prototype.init = function (initialised) {
    this._updateDOM(this.dataLayer);
    this._setUpMultipleQuestions();
    this._setUpValidation();
    this._setUpJourneyLogic();
    this._initialisedSuccess(initialised);
  };

  /**
   *  This method sets up customised journeys through the questions
   *  It calls the _addJourneyData method in response to user input
   */
  MoneyNavigatorQuestions.prototype._setUpJourneyLogic = function () {
    var _this = this;
    var setJourney = function (input) {
      _this.skipQuestions.forEach(function (question) {
        var thisQuestion = _this.$questions[question.num];

        if (input) {
          var skippedQuestions = question.responses[input.value.toUpperCase()];

          _this._addJourneyData(skippedQuestions);
        } else {
          var inputs = $(thisQuestion).find('input');

          for (var i = 0, length = inputs.length; i < length; i++) {
            if (inputs[i].checked) {
              var skippedQuestion =
                question.responses[inputs[i].value.toUpperCase()];

              _this._addJourneyData(skippedQuestion);
            }
          }
        }
      });
    };

    // On load
    setJourney();

    // User selects a response from a question
    var question = this.$questions[1];
    var $inputs = $(question).find('input[type="radio"]');

    $(question).on('change', function (e) {
      setJourney(e.target);
    });
  };

  /**
   *  This method adds a `question-skip` dataset value to questions
   *  that should not be part of the current journey
   */
  MoneyNavigatorQuestions.prototype._addJourneyData = function (questions) {
    var _this = this;

    this.$questions.data('question-skip', false);

    questions.forEach(function (index) {
      $(_this.$questions[index]).data('question-skip', true);
    });
  };

  MoneyNavigatorQuestions.prototype._setUpValidation = function () {
    var _this = this;

    this.$questions.each(function () {
      var question = this;
      var $inputs = $(question).find('input');

      $inputs.on('change', function () {
        var checkedInputs = [];

        $inputs.each(function () {
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
    });
  };

  MoneyNavigatorQuestions.prototype._handleValidation = function (
    question,
    options
  ) {
    if (options == 'reset') {
      $(question).find('[data-error-message]').remove();
      $(question).find('[data-continue]').attr('disabled', false);
    } else {
      $(question)
        .find('legend')
        .after(
          '<p class="question__error" data-error-message>Please answer this question before continuing</p>'
        );
      $(question).find('[data-continue]').attr('disabled', true);
    }
  };

  MoneyNavigatorQuestions.prototype._updateAnalytics = function (
    btn,
    dataLayer
  ) {
    var question = $(btn).parents('[data-question-id]');
    var eventAction = $(question).data('questionId').toUpperCase();
    var eventLabel;
    var eventResponse = '';
    var inputs = $(btn)
      .parents('[data-question-id]')
      .find('input[type="radio"], input[type="checkbox"]');
    var inputsCheckedValues = [];
    var inputsCheckedText = [];

    for (var i = 0, length = inputs.length; i < length; i++) {
      if (inputs[i].checked) {
        inputsCheckedValues.push(eventAction + inputs[i].value.toUpperCase());
        eventResponse = $(inputs[i]).siblings('label').text();
      }
    }

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
        eventLabel: eventLabel,
      });
    }

    if ($(question).data('question-custom') !== undefined) {
      dataLayer.push({
        event: 'gtm_question_custom',
        eventCategory: 'MNT_Diagnostic',
        eventQuestion: $(question).find('legend').text(),
        eventResponse: eventResponse.trim(),
      });
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
        eventLabel: eventLabel,
      });
    }
  };

  MoneyNavigatorQuestions.prototype._updateDOM = function (dataLayer) {
    var _this = this;
    var dataLayer = dataLayer;

    // Removes submit button
    this.$submitBtn.remove();

    for (var i = 0, length = this.$questions.length; i < length; i++) {
      var question = this.$questions[i];

      if (i === 0) {
        // Adds get-started button to first question
        $(question)
          .find('.question__content')
          .append(
            '<div class="question__actions"><button class="button button--start" data-get-started="true">' +
              this.i18nStrings.continue_btn +
              '</button></div>'
          );
        // Adds active class to first question
        $(question).addClass(_this.activeClass);
      } else if (i === length - 1) {
        // Adds submit button to last question
        $(question)
          .find('.question__content')
          .append(
            '<div class="question__actions"><button data-submit="true" class="button button--continue">' +
              this.i18nStrings.submit_btn +
              '</button><button data-back="true" class="button button--back">' +
              this.i18nStrings.back_btn +
              '</button></div>'
          );
      } else {
        // Adds continue and back buttons to all other questions
        $(question)
          .find('.question__content')
          .append(
            '<div class="question__actions"><button data-continue="true" class="button button--continue">' +
              this.i18nStrings.continue_btn +
              '</button><button data-back="true" class="button button--back">' +
              this.i18nStrings.back_btn +
              '</button></div>'
          );
      }
    }

    var buttons = this.$el.find('button');

    buttons.on('click', function (e, options) {
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
  };

  MoneyNavigatorQuestions.prototype._scrollToTop = function () {
    $('html, body').animate(
      {
        scrollTop: $('#money_navigator__questions').offset().top,
      },
      250
    );
  };

  MoneyNavigatorQuestions.prototype._updateDisplay = function (dir) {
    var activeIndex,
      progress,
      totalQuestions,
      questions = [],
      questionClasses = [];

    this.$el.find('[data-question]').each(function () {
      if (!$(this).data('question-skip')) {
        questions.push(this);
      }
    });

    totalQuestions = questions.length;

    $(questions).each(function () {
      questionClasses.push(this.className);
    });

    activeIndex = questionClasses.indexOf(
      'l-money_navigator__question ' + this.activeClass
    );

    $(questions[activeIndex]).removeClass(this.activeClass);

    if (dir === 'next') {
      activeIndex++;
    } else {
      activeIndex--;
    }

    progress = Math.round((activeIndex / totalQuestions) * 100);

    $(questions[activeIndex])
      .addClass(this.activeClass)
      .find('.question__counter')
      .text('Completed ' + progress + '%');

    if (activeIndex == 0) {
      this.banner.removeClass(
        'l-money_navigator__banner' + '--' + this.hiddenClass
      );
    } else {
      this.banner.addClass(
        'l-money_navigator__banner' + '--' + this.hiddenClass
      );
    }
  };

  MoneyNavigatorQuestions.prototype._setUpMultipleQuestions = function () {
    var _this = this;

    this.$multipleQuestions.each(function() {
      var inputs = $(this).find('input[type="checkbox"]'); 
      var legend = $(this).find('legend'); 
      var inputId = inputs[0].name.split('[')[1].split(']')[0]; 
      var input = document.createElement('input'); 
      var label = document.createElement('label'); 
      var response_yes = document.createElement('div'); 
      var response_no, input_no, input_yes;


      input.type = 'checkbox'; 
      input.id = inputId + '_response_yes'; 
      input.className = 'response__control'; 

      label.htmlFor = inputId + '_response_yes';
      label.className = 'response__text'; 
      label.innerHTML = '<span>Yes</span>'; 

      $(response_yes)
        .addClass('question__response question__response__yes')
        .append(input)
        .append(label); 

      $(inputs).each(function() {
        if ($(this).siblings('label').text().trim() == 'No') {
          response_no = $(this).parents('[data-response]'); 
          
          $(response_no).addClass('question__response__no')
          $(legend)
            .after(response_yes)
            .after(response_no); 
        }
      }); 

      input_no = response_no[0].getElementsByTagName('input')[0]; 
      input_yes = response_yes.getElementsByTagName('input')[0]; 

      input_no.checked = false; 
      input_yes.checked = true; 

      $(this).on('change', function(e) {
        _this._updateMultipleQuestion(e.target); 
      })
    }); 
  }

  MoneyNavigatorQuestions.prototype._updateMultipleQuestion = function(input) {
    console.log('_updateMultipleQuestion!'); 
    console.log('input: ', input); 

    var responses = $(input).parents('[data-response]').siblings('[data-response]'); 

  MoneyNavigatorQuestions.prototype._updateMultipleQuestions = function (
    input
  ) {
    var responses = $(input)
      .parents('[data-response]')
      .siblings('[data-response]');

    responses.each(function () {
      $(this)
        .find('input[type="checkbox"]')
        .each(function () {
          if (input.checked) {
            this.disabled = true;
          } else {
            this.disabled = false;
          }
        });
    });
  };

  return MoneyNavigatorQuestions;
});
