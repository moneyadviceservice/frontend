define(['jquery', 'DoughBaseComponent'], function($, DoughBaseComponent) {

  'use strict';

  var EmbedCodeGeneratorProto,
      defaultConfig = {
        selectors: {
          activeClass: 'is-active',
          embedTarget: '[data-dough-embedcodegenerator-target]',
          embedTargetContainer: '[data-dough-embedcodegenerator-target-container]',
          langInput: '[data-dough-embedcodegenerator-lang]',
          submit: '[data-dough-embedcodegenerator-submit]',
          widthInput: '[data-dough-embedcodegenerator-width]',
          widthUnitInput: '[data-dough-embedcodegenerator-width-unit]'
        }
      };

  function EmbedCodeGenerator($el, config) {
    EmbedCodeGenerator.baseConstructor.call(this, $el, config, defaultConfig);
  }

  DoughBaseComponent.extend(EmbedCodeGenerator);

  EmbedCodeGenerator.componentName = 'EmbedCodeGenerator';

  EmbedCodeGeneratorProto = EmbedCodeGenerator.prototype;

  EmbedCodeGeneratorProto.init = function(initialised) {
    this._cacheComponentElements();
    this._addAccessibility();
    this.embedCodeTemplate = this.$embedTarget.text().trim();
    this._initialisedSuccess(initialised);
  };

  EmbedCodeGeneratorProto._cacheComponentElements = function() {
    this.$embedTarget = this.$el.find(this.config.selectors.embedTarget);
    this.$embedTargetContainer = this.$el.find(this.config.selectors.embedTargetContainer);
    this.$langInput = this.$el.find(this.config.selectors.langInput);
    this.$submit = this.$el.find(this.config.selectors.submit);
    this.$widthInput = this.$el.find(this.config.selectors.widthInput);
    this.$widthUnitInput = this.$el.find(this.config.selectors.widthUnitInput);
  };

  EmbedCodeGeneratorProto._addAccessibility = function() {
    this.$embedTargetContainer.attr('aria-hidden', true);
  };

  EmbedCodeGeneratorProto.showEmbedTarget = function() {
    this.$embedTargetContainer
      .addClass(this.config.selectors.activeClass)
      .attr('aria-hidden', false);
  };

  EmbedCodeGeneratorProto.populateEmbedCodeTemplate = function(targetStr, data) {
    return targetStr.replace(/{([^{}]*)}/g,
      function (a, b) {
        return data[b];
      }
    );
  };

  EmbedCodeGeneratorProto.setInputValue = function($input, val) {
    $input.val(val);
  };

  EmbedCodeGeneratorProto.generateEmbedCode = function() {
    var data = {};

    data.lang = this.$langInput.filter(':checked').val();
    data.width = this.$widthInput.val() + this.$widthUnitInput.filter(':checked').val();

    return this.populateEmbedCodeTemplate(this.embedCodeTemplate, data);
  };

  EmbedCodeGeneratorProto.updateEmbedCodeDisplay = function(text) {
    this.showEmbedTarget();
    this.$embedTarget.text(text);
    this.selectEmbedCodeText();
  };

  EmbedCodeGeneratorProto.selectEmbedCodeText = function() {
    var range,
        embedTarget = this.$embedTarget[0];

    if(document.selection) {
        range = document.body.createTextRange();
        range.moveToElementText(embedTarget);
        range.select();
    } else if (window.getSelection) {
        range = document.createRange();
        range.selectNode(embedTarget);
        window.getSelection().addRange(range);
    }
  };

  return EmbedCodeGenerator;
});
