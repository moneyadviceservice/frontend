define(['jquery', 'DoughBaseComponent'], function ($, DoughBaseComponent) {
  'use strict';

  var MoneyNavigatorQuestions,
    i18nStrings = {
      controls: {
        continue_btn: 'Continue',
        back_btn: 'Back',
        yes_btn: 'Yes',
        no_btn: 'No',
        submit_btn: 'Submit', 
        reset: 'Reset'
      }, 
      messages: {
        completed: 'completed'        
      }
    };

  MoneyNavigatorQuestions = function ($el, config) {
    MoneyNavigatorQuestions.baseConstructor.call(this, $el, config);

    this.i18nStrings =
      config && config.i18nStrings ? config.i18nStrings : i18nStrings;
    this.$submitBtn = this.$el.find('[data-submit]');
    this.$questions = this.$el.find('[data-question]');
    this.$multipleQuestions = this.$el.find('[data-question-multiple]');
    this.$groupedQuestions = this.$el.find('[data-question-grouped]');
    this.banner = $(document).find('[data-banner]');
    this.activeClass = 'question--active';
    this.inactiveClass = 'question--inactive'; 
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

  MoneyNavigatorQuestions.prototype.init = function(initialised) {
    this._updateDOM(this.dataLayer); 
    this._setUpMultipleQuestions(); 
    this._setUpGroupedQuestions(); 
    this._setUpJourneyLogic(); 
    this._initialisedSuccess(initialised);
  };

  /**
   *  A method to set up grouped questions
   *  These are questions that combine its responses into distinct groups for UX purposes
   *  This method updates the DOM to group the reponses and add a control option for each
   */
  MoneyNavigatorQuestions.prototype._setUpGroupedQuestions = function() {
    var _this = this; 

    this.$groupedQuestions.each(function() {
      var $groupedResponses = $(this).find('[data-response-group], [data-response]'); 
      var groups = {}; 
      var titles = $(this).data('question-grouped-group-titles'); 
      var i = 0; 
      var groupNum = 0; 
      var questionResponses = document.createElement('div'); 

      // Collect all responses into arrays and remove from DOM
      $groupedResponses.each(function() {
        if ($(this).data('response-group')) {
          var groupNum = $(this).data('response-group');  
          
          if (!groups[groupNum]) {
            groups[groupNum] = []; 
          }

          groups[groupNum].push(this); 
        } else {
          groups['default'] = this; 
        }

        $(this).remove(); 
      }); 

      groupNum = Object.keys(groups).length; 

      $(questionResponses)
        .addClass('response__controls')
        .attr('data-response-controls', true)
        .css('width', (1 / groupNum * 100) + '%'); 

      for(var num in groups) {
        if (num === 'default') {
          $(questionResponses).prepend(groups[num].outerHTML); 
        } else {
          var response = document.createElement('div'); 
          var collection = document.createElement('div'); 
          var reset = document.createElement('button'); 

          // Add responses to the DOM
          $(response)
            .append('<input class="response__control" id="control_' + num + '" type="checkbox" value=""><label for="control_' + num + '" class="response__text"><span>' + titles[i] + '</span></label></div>')
            .attr('data-response-group-control', num)
            .addClass('question__response question__response--control'); 

          $(this).find('.content__inner').append(response); 

          $(response).find('input').on('change', function(e) {
            _this._updateGroupedQuestionsDisplay(e.target); 
          }); 

          $(questionResponses).append(response); 

          // Add collections and resets to the DOM
          $(collection)
            .addClass('question__response--collection question--inactive')
            .attr('data-response-collection', num);

          $(groups[num]).each(function() {
            $(collection).append(groups[num]); 
          }); 

          $(reset)
            .addClass('button button--reset')
            .attr('data-reset', true)
            .text(_this.i18nStrings.controls.reset); 

          $(this).find('.content__inner').append(collection);
          $(collection).prepend('<p class="collection__title">' + titles[i] + '</p>'); 
          $(collection).append(reset); 
          $(collection).css({
            'marginLeft': (1 / groupNum * -100 * i) + '%', 
            'width': (1 / groupNum * 100) + '%'
          }); 

          $(reset).on('click', function(e) {
            e.preventDefault(); 
            _this._updateGroupedQuestionsDisplay(e.target); 
          }); 
        }

        i++; 
      }

      $(this).find('.content__inner')
        .prepend(questionResponses)
        .css('width', (i * 100) + '%');
    }); 
  }; 

  /**
   * A method that is called when the controls created by _setUpGroupedQuestions are activated
   */
  MoneyNavigatorQuestions.prototype._updateGroupedQuestionsDisplay = function(el) {
    var $container = $(el).parents('.content__inner'); 

    if ($(el).data('reset')) {
      $container.children('[data-response-controls]').removeClass(this.inactiveClass); 
      $container.children('[data-response-group-control]').removeClass(this.inactiveClass); 
      $container.children('[data-response-collection]').addClass(this.inactiveClass); 
    } else {
      var id = el.id.split('_')[1]; 

      $container.children('[data-response-controls]').addClass(this.inactiveClass); 
      $container.children('[data-response-collection]').addClass(this.inactiveClass); 
      $container.children('[data-response-collection="' + id + '"]').removeClass(this.inactiveClass); 
    }
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
              this.i18nStrings.controls.continue_btn +
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
              this.i18nStrings.controls.submit_btn +
              '</button><button data-back="true" class="button button--back">' +
              this.i18nStrings.controls.back_btn +
              '</button></div>'
          );
      } else {
        // Adds continue and back buttons to all other questions
        $(question)
          .find('.question__content')
          .append(
            '<div class="question__actions"><button data-continue="true" class="button button--continue">' +
              this.i18nStrings.controls.continue_btn +
              '</button><button data-back="true" class="button button--back">' +
              this.i18nStrings.controls.back_btn +
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

    buttons.each(function() {
      if ($(this).parents('[data-question]').data('questionMultiple') == '') {
        if ($(this).data('continue')) {
          $(this).attr('disabled', true); 
        }
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
      .text(progress + '% ' + this.i18nStrings.messages.completed);

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
      var inner = $(this).find('.content__inner'); 
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
      label.innerHTML = '<span>' + _this.i18nStrings.controls.yes_btn + '</span>'; 

      $(response_yes)
        .attr('data-response', true)
        .addClass('question__response button--yes')
        .append(input)
        .append(label); 

      $(inputs).each(function() {
        if ($(this).siblings('label').text().trim() == _this.i18nStrings.controls.no_btn) {
          response_no = $(this).parents('[data-response]'); 
          
          $(response_no).addClass('button--no')
          $(inner)
            .prepend(response_yes)
            .prepend(response_no); 
        }
      }); 

      input_no = response_no[0].getElementsByTagName('input')[0]; 
      input_yes = response_yes.getElementsByTagName('input')[0]; 

      input_no.checked = false; 
      input_yes.checked = true; 

      $(this).on('click', function(e) {
        if ($(e.target).parents('[data-response]').hasClass('button--no') || $(e.target).parents('[data-response]').hasClass('button--yes')) {
          if (e.target.checked == false) {
            e.preventDefault(); 
          }
        }
      }); 

      $(this).on('change', function(e) {
        _this._updateMultipleQuestion(e.target); 
      }); 
    }); 
  }; 

  MoneyNavigatorQuestions.prototype._updateMultipleQuestion = function(input) {
    var question = $(input).parents('[data-question]'); 
    var inputs = $(question).find('input[type="checkbox"]'); 
    var continueBtn = $(question).find('[data-continue]'); 
    var checkedInputs = 0; 

    // Update state (checked/disabled) of inputs
    for (var i = 0, length = inputs.length; i < length; i++) {
      if (input == inputs[0]) {
        // `No` is changed
        if (input.checked) {
          // `No` is checked
          if (i == 1) {
            inputs[i].checked = false; 
          } 

          if (i > 1) {
            inputs[i].disabled = true;
          }
        }
      } else if (input == inputs[1]) {
        // `Yes` is changed
        if (input.checked) {
          // `Yes` is checked
          if (i == 0) {
            inputs[i].checked = false; 
          } 

          if (i > 1) {
            inputs[i].disabled = false;
          }
        }
      }

      if (inputs[i].checked) {
        checkedInputs++; 
      }      
    }

    if (inputs[0].checked == true) {
      // if `No` is checked `Continue` is enabled
      $(continueBtn[0]).attr('disabled', false); 
    }

    if (inputs[1].checked == true) {
      // if `Yes` is checked
        if (checkedInputs == 1) {
        // - if 0 other options are checked `Continue` is disabled
        $(continueBtn[0]).attr('disabled', true); 
      } else {        
        // - if 1 or more other options are checked `Continue` is enabled
        $(continueBtn[0]).attr('disabled', false); 
      }
    }
  }

  return MoneyNavigatorQuestions;
});
