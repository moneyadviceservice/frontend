define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {
  'use strict';

  var HomeBuyingChecklist,
      defaultConfig = {};
  var localStorageNamespace = "buying_checklist_";

  function HomeBuyingChecklist($el, config) {
    HomeBuyingChecklist.baseConstructor.call(this, $el, config, defaultConfig);

    this.$inputValue = this.$el.find('[data-dough-input-value]');
    this.$result = this.$el.find('[data-dough-input-result]');
    this.$inputDeposit = this.$el.find('[data-dough-input-deposit]');    
    this.$inputMessageDeposit = this.$el.find('[data-dough-input-message-deposit]');
    this.$inputStamp = this.$el.find('[data-dough-input-stamp]');
    this.$inputMessageStamp = this.$el.find('[data-dough-input-message-stamp]');
    this.$inputMortgage = this.$el.find('[data-dough-input-mortgage]');
    this.$inputMessageMortgage = this.$el.find('[data-dough-input-message-mortgage]');
    this.$inputValuation = this.$el.find('[data-dough-input-valuation]');
    this.$inputMessageValuation = this.$el.find('[data-dough-input-message-valuation]');
    this.$inputSurveyors = this.$el.find('[data-dough-input-surveyors]');
    this.$inputMessageSurveyors = this.$el.find('[data-dough-input-message-surveyors]');
    this.$inputLegal = this.$el.find('[data-dough-input-legal]');
    this.$inputMessageLegal = this.$el.find('[data-dough-input-message-legal]');
    this.$inputLocal = this.$el.find('[data-dough-input-local]');
    this.$inputMessageLocal = this.$el.find('[data-dough-input-message-local]');
    this.$inputElectronic = this.$el.find('[data-dough-input-electronic]');
    this.$inputMessageElectronic = this.$el.find('[data-dough-input-message-electronic]');
    this.$inputRemoval = this.$el.find('[data-dough-input-removal]');
    this.$inputMessageRemoval = this.$el.find('[data-dough-input-message-removal]');
  };

  /**
   * Inherit from base module, for shared methods and interface
   * @type {[type]}
   * @private
   */

  DoughBaseComponent.extend(HomeBuyingChecklist);
  HomeBuyingChecklist.componentName = 'HomeBuyingChecklist';

  HomeBuyingChecklist.prototype.init = function(initialised) {
    this._initialisedSuccess(initialised);
    this._setInitialValues();
    this._addValues();
    this._setUpEvents();
  };

  HomeBuyingChecklist.prototype._setInitialValues = function() {
    var inputVal = this.$inputValue;
    for(var i=0;i<inputVal.length;i++){
      inputVal[i].value = localStorage.getItem(localStorageNamespace+i);
    }
  };

  HomeBuyingChecklist.prototype._setUpEvents = function() {
    var _this = this;

    var addValuesCallback = function() {
      _this._addValues();
    };

    this.$inputValue.keyup(addValuesCallback);
    this.$inputValue.change(addValuesCallback);

    $(function() {
      _this._showHideMessage();
    });
  };

  HomeBuyingChecklist.prototype._showHideMessage = function() {
    var _this = this;

    this.$inputDeposit.focus(function() {
      _this.$inputMessageDeposit.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageDeposit.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageDeposit.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageDeposit.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputStamp.focus(function() {
      _this.$inputMessageStamp.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageStamp.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageStamp.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageStamp.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputMortgage.focus(function() {
      _this.$inputMessageMortgage.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageMortgage.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageMortgage.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageMortgage.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputValuation.focus(function() {
      _this.$inputMessageValuation.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageValuation.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageValuation.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageValuation.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputSurveyors.focus(function() {
      _this.$inputMessageSurveyors.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageSurveyors.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageSurveyors.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageSurveyors.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputLegal.focus(function() {
      _this.$inputMessageLegal.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageLegal.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageLegal.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageLegal.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputLocal.focus(function() {
      _this.$inputMessageLocal.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageLocal.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageLocal.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageLocal.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputElectronic.focus(function() {
      _this.$inputMessageElectronic.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageElectronic.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageElectronic.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageElectronic.addClass('home-buying-checklist__callout-inactive');
    });

    this.$inputRemoval.focus(function() {
      _this.$inputMessageRemoval.removeClass('home-buying-checklist__callout-inactive');    
      _this.$inputMessageRemoval.addClass('home-buying-checklist__callout-active');
    }).blur(function() {
      _this.$inputMessageRemoval.removeClass('home-buying-checklist__callout-active');    
      _this.$inputMessageRemoval.addClass('home-buying-checklist__callout-inactive');
    });
  }

  HomeBuyingChecklist.prototype._addValues = function() {
    var inputVal = this.$inputValue;
    var resultVal = this.$result;
    var total=0;

    for(var i=0;i<inputVal.length;i++){
      if(parseInt(inputVal[i].value)){
        localStorage.setItem(localStorageNamespace+i, inputVal[i].value)
        total += parseInt(inputVal[i].value);
      }
    }
    resultVal.val(total);
  }

  return HomeBuyingChecklist;
});
