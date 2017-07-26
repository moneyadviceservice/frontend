describe('HomeBuyingChecklist', function () {
  'use strict';

  beforeEach(function (done){
    var self = this;

    requirejs(['jquery', 'HomeBuyingChecklist'], function ($, HomeBuyingChecklist) {
      self.$html = $(window.__html__['spec/javascripts/fixtures/HomeBuyingChecklist.html']).appendTo('body');
      self.component = self.$html.find('[data-dough-component="HomeBuyingChecklist"]');

      self.createHomeBuyingChecklist = function(config){
        new HomeBuyingChecklist(self.component, config).init();
      };
      done();
    }, done);
  });

  afterEach(function () {
    localStorage.clear();
    this.$html.remove();
  });

  describe("basic behaviour", function(){
    beforeEach(function (){
      this.createHomeBuyingChecklist();
    });

    it('total is 0 initially', function() {
      var total = this.component.find('[data-dough-input-result]').text();
      expect(total).to.equal("0");
    });

    it('total is updated when values are changed', function() {
      this.component.find('[data-dough-input-value]').each(function(i, element){
        element.value = 3 + i;
        $(element).trigger("change");
      });

      var total = this.component.find('[data-dough-input-result]').text();

      expect(total).to.equal('12');
    });

    it('message is shown when input is in focus', function() {
      var input = this.component.find('[data-dough-input-value]:first');
      var message = input.siblings('[data-dough-input-message]');

      input.trigger("focus");
      expect(message.attr('class')).to.equal('home-buying-checklist__callout-active');

      input.trigger("blur");
      expect(message.attr('class')).to.equal('home-buying-checklist__callout-inactive');
    });
  });

  describe("localStorage persistence", function(){
    beforeEach(function (){
      var ns = "test_namespace_";
      this.test_key = ns+"0";
      localStorage.setItem(this.test_key,"100");
      var config = { localStorageNamespace: ns };
      this.createHomeBuyingChecklist(config);
    });

    it('values are loaded from localStorage', function() {
      var total = this.component.find('[data-dough-input-result]').text();
      expect(total).to.equal("100");
    });

    it('persists values when they are changed', function() {
      var firstInput = this.component.find('[data-dough-input-value]:first');
      firstInput.val(3);
      firstInput.trigger("change");

      expect(localStorage.getItem(this.test_key)).to.equal('3');
    });
  });
});
