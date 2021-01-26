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
    this.$banner = this.$el.siblings('[data-banner]');
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
    this._setUpKeyboardEvents(); 
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
      var $groupedResponses = $(this).find('[data-response-group], [data-response]'),
          $fieldset = $(this).find('fieldset').detach(), 
          name = $fieldset.find('input')[0].name,
          titles = $(this).data('question-grouped-group-titles'),
          questionGroups = document.createElement('div'),
          groups = {},
          numGroups;

      // Collect all grouped responses into arrays and remove from DOM
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

      numGroups = Object.keys(groups).length; 

      $(questionGroups)
        .addClass('question__groups')
        .css('width', numGroups * 99.99 - 3.33334 + '%');

      $(this).find('.question__content').append(questionGroups);

      for(var num in groups) {
        if (num === 'default') {
          var div = document.createElement('div'); 

          $fieldset
            .find('.content__inner')
              .prepend(groups[num]); 

          $(div)
            .addClass('response__controls')
            .attr('data-response-controls', true)
            .css({
              'width': (1 / numGroups * 100) + '%', 
              'float': 'left'
            })
            .append($fieldset);

          $(questionGroups).prepend(div);
        } else {
          // Add collections and resets to the DOM
          var collection = document.createElement('fieldset'), 
              contentInner = document.createElement('div'), 
              reset = document.createElement('button'), 
              legend = document.createElement('legend'), 
              paraText = document.createTextNode(titles[num - 1]),
              div = document.createElement('div'); 

          legend.appendChild(paraText); 

          $(legend).addClass('question__heading');

          $(reset)
            .addClass('button button--reset')
            .attr({
              'data-reset': true,
              'tabindex': -1
            })
            .text(_this.i18nStrings.controls.reset); 

          $(reset).on('click', function(e) {
            e.preventDefault(); 
            _this._updateGroupedQuestionsDisplay(e.target); 
          }); 

          $(contentInner)
            .addClass('content__inner')
            .append(groups[num])
            .append(reset); 

          $(collection)
            .prepend(legend)
            .append(contentInner); 
  
          $(div)
            .addClass('question__response--collection question--inactive')
            .attr('data-response-collection', num)
            .css({
              'marginLeft': (1 / numGroups * -100 * (num - 1)) + '%', 
              'width': (1 / numGroups * 100) + '%', 
              'float': 'left'
            })
            .append(collection); 

          $(questionGroups).append(div); 

          // Add new inputs to the control group
          var response = document.createElement('div'), 
              input = document.createElement('input'), 
              label = document.createElement('label'), 
              span = document.createElement('span'), 
              labelText = document.createTextNode(titles[num - 1]);

          span.appendChild(labelText); 

          label.className = 'response__text'; 
          label.setAttribute('for', 'control_' + num); 
          label.appendChild(span)

          input.className = 'response__control'; 
          input.type = 'checkbox'; 
          input.id = 'control_' + num;
          input.value = ''; 

          response.setAttribute('data-response-group-control', num); 
          response.className = 'question__response question__response--control';
          response.appendChild(input); 
          response.appendChild(label); 

          $fieldset.find('.content__inner').append(response); 
        }
      }; 

      $(this).find('.question__content').prepend(questionGroups); 

      $(this).find('[data-response-controls]')
        .on('change', function(e) {
          _this._updateGroupedQuestionsDisplay(e.target); 
        }); 

      $(this).find('[data-response-collection]')
        .on('change', function(e) {
          _this._updateGroupedQuestionsDisplay(e.target); 
        }); 
    }); 
  }; 

  /**
   * A method that controls user navigation on the grouped question by keyboard
   */
  MoneyNavigatorQuestions.prototype._setUpKeyboardEvents = function() {
    this.$groupedQuestions.each(function() {
      // Set focus on keyboard events
      $(this).keydown(function(e) {
        var response = $(e.target).parent('[data-response]')[0], 
            $responses = $(response).parent('.content__inner'), 
            nextInput, 
            prevInput; 

        switch (e.keyCode) {
          // right or down arrows
          case 39:
          case 40:
            // moves to next input unless current input is last
            e.preventDefault(); 

            if ($responses.find('[data-response]').last()[0] === response) {
              nextInput = $responses.find('[data-response]').first().find('input')[0]; 
            } else {
              nextInput = $(response).next().find('input')[0];
            }

            nextInput.focus()
            nextInput.checked = true; 

            break;

          // left or up arrows
          case 37:
          case 38:
            // moves to previous input unless current input is first
            e.preventDefault(); 

            if ($responses.find('[data-response]').first()[0] === response) {
              prevInput = $responses.find('[data-response]').last().find('input')[0]; 
            } else {
              prevInput = $(response).prev().find('input')[0];
            }

            prevInput.focus()
            prevInput.checked = true; 

            break;
        }
      }); 
    }); 
  }; 

  /**
   * A method that is called when the controls created by _setUpGroupedQuestions are activated
   */
  MoneyNavigatorQuestions.prototype._updateGroupedQuestionsDisplay = function(el) {
    var $container = $(el).parents('.question__content').find('.question__groups');

    if ($(el).data('reset') || $(el).data('back')) {
      $container.children('[data-response-controls]').removeClass(this.inactiveClass); 
      $container.children('[data-response-group-control]').removeClass(this.inactiveClass); 
      $container.children('[data-response-collection]').addClass(this.inactiveClass); 

      if ($(el).data('reset')) {
        $container.find('[data-reset]').attr('tabindex', -1); 
        $container.children('[data-response-controls]').find('input[checked=checked]').focus(); 
        $container.children('[data-response-collection]').find('input').attr('tabindex', -1); 
      }
    } else if ($(el).parents('[data-response-controls]').length > 0) {
      var id = el.id.split('_')[1];
      var $responseControls = $container.children('[data-response-controls]'); 

      if (el.id.indexOf('control_') > -1) {
        $responseControls.addClass(this.inactiveClass)

        $container.children('[data-response-collection]')
          .addClass(this.inactiveClass)
          .find('[data-reset]').attr('tabindex', -1); 

        $container.children('[data-response-collection]')
          .find('input').attr('tabindex', -1); 

        $container.children('[data-response-collection="' + id + '"]')
          .removeClass(this.inactiveClass)
          .find('input')[0].focus(); 

        $container.children('[data-response-collection="' + id + '"]')
          .find('[data-reset]').attr('tabindex', 0);

        $container.children('[data-response-collection="' + id + '"]')
          .find('input').attr('tabindex', 0);
      }

      $responseControls.find('input').each(function() {
        if (el.id.indexOf('control_') > -1) {
          if (this.id == 'control_' + id) {
            this.checked = true; 
          } else {
            this.checked = false; 
          }
        } else {
          if (this.id.indexOf('control_') == -1) {
            this.checked = true; 
          } else {
            this.checked = false; 
          }
        }
      }); 
    } else {
      el.checked = true; 
    }

    // set state of `Continue`
    var $continueBtn = $container.parents('[data-question-id]').find('[data-continue]'); 
    var $inputs = $container.find('input');
    var disabled = false; 

    $inputs.each(function() {
      if (this.checked == true) {
        if (this.value == '') {
          disabled = true; 
        } else {
          disabled = false; 
        }
      }
    });

    $continueBtn.attr('disabled', disabled); 
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

  /**
   *  This method deals with the analytics requirements of the tool
   *  It adds data on the questions answered by the user to the global `dataLayer` object
   */
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

  /**
   * This method is called once when the tool is loaded
   * It restructures the DOM to present the questions as required
   * and adds event listeners where required
   */
  MoneyNavigatorQuestions.prototype._updateDOM = function (dataLayer) {
    var _this = this;
    var dataLayer = dataLayer;

    // Removes submit button
    this.$submitBtn.remove();

    for (var i = 0, length = this.$questions.length; i < length; i++) {
      var question = this.$questions[i],
          div = document.createElement('div'),
          btn_start = document.createElement('button'),
          btn_continue = document.createElement('button'),
          btn_back = document.createElement('button'),
          btn_submit = document.createElement('button'),
          startText = document.createTextNode(this.i18nStrings.controls.continue_btn),
          continueText = document.createTextNode(this.i18nStrings.controls.continue_btn),
          backText = document.createTextNode(this.i18nStrings.controls.back_btn),
          submitText = document.createTextNode(this.i18nStrings.controls.submit_btn); 

      div.className = 'question__actions'; 

      btn_start.appendChild(startText); 
      btn_start.className = 'button button--start'; 
      btn_start.dataset.getStarted = true; 

      btn_continue.appendChild(continueText); 
      btn_continue.className = 'button button--continue'; 
      btn_continue.dataset.continue = true; 

      btn_back.appendChild(backText); 
      btn_back.className = 'button button--back'; 
      btn_back.dataset.back = true; 

      btn_submit.appendChild(submitText); 
      btn_submit.className = 'button button--continue'; 
      btn_submit.dataset.submit = true; 

      if (i === 0) {
        // Adds start button to first question
        div.appendChild(btn_start); 

        $(question)
          .find('.question__content')
          .append(div);

        // Adds active class to first question
        $(question).addClass(_this.activeClass);
      } else if (i === length - 1) {
        // Adds submit and back buttons to last question
        div.appendChild(btn_submit); 
        div.appendChild(btn_back); 

        $(question)
          .find('.question__content')
          .append(div);
      } else {
        // Adds continue and back buttons to all other questions
        div.appendChild(btn_continue); 
        div.appendChild(btn_back); 

        $(question)
          .find('.question__content')
          .append(div);
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
        _this._updateGroupedQuestionsDisplay(e.target); 
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

  /**
   * A method to ensure the questions are presented at the correct scroll position as the user moves through the tool
   */
  MoneyNavigatorQuestions.prototype._scrollToTop = function() {
    $('html, body').animate({
        scrollTop: $('#money_navigator__questions').offset().top
      }, 250
    );          
  }; 

  /**
   * This method deals with the presentation of the questions as the user moves back and forth through the tool
   */
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

    if (dir === 'prev') {
      if (activeIndex >= 0) {
        questions[activeIndex].focus(); 
      }
    }

    if (activeIndex == 0) {
      this.$banner.removeClass(
        'l-money_navigator__banner' + '--' + this.hiddenClass
      );
    } else {
      this.$banner.addClass(
        'l-money_navigator__banner' + '--' + this.hiddenClass
      );
    }
  };

  /**
   * This method deals with the UI associated with the intial presentation of multiple (checkbox) questions
   */
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

  /**
   * This method deals with the functionality of multiple (checkbox) questions
   */
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
