describe('EmbedCodeGenerator', function () {
  'use strict';

  var sandbox;

  beforeEach(function (done) {
    var self = this;

    requirejs(['jquery', 'EmbedCodeGenerator'],
      function ($, EmbedCodeGenerator) {
        self.$html = $(window.__html__['spec/javascripts/fixtures/EmbedCodeGenerator.html']);
        self.EmbedCodeGenerator = EmbedCodeGenerator;
        sandbox = sinon.sandbox.create();
        done();
    }, done);
  });

  afterEach(function() {
    this.$html.remove();
    sandbox.restore();
  });

  describe('initialisation', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      this.component.init();
      done();
    });

    it('should find and cache all necessary DOM elements', function() {
      expect(this.component.$langInput).should.exist;
      expect(this.component.$widthInput).should.exist;
      expect(this.component.$widthUnitInput).should.exist;
      expect(this.component.$submit).should.exist;
      expect(this.component.$embedTarget).should.exist;
    });
  });

  describe('When the form is submitted', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      done();
    });

    it('should call _handleSubmit()', function() {
      var spy = sandbox.spy(this.EmbedCodeGenerator.prototype, '_handleSubmit');

      this.component.init();
      this.component.$submit.trigger('click');

      expect(spy.called).to.be.true;
    });
  });

  describe('#_handleSubmit()', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      done();
    });

    it('should call updateEmbedCodeDisplay()', function() {
      var spy = sandbox.spy(this.EmbedCodeGenerator.prototype, 'updateEmbedCodeDisplay');

      this.component.init();
      this.component._handleSubmit({ preventDefault: function() {} });

      expect(spy.called).to.be.true;
    });
  });

  describe('#updateEmbedCodeDisplay()', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      this.component.init();
      done();
    });

    it('should update the text of the display target', function() {
      var text = 'foo';

      this.component.$embedTarget.eq(0).val('');
      this.component.updateEmbedCodeDisplay(text);

      expect(this.component.$embedTarget.eq(0)).to.have.value(text);
    });

    it('should call the #showEmbedTarget method', function() {
      var spy = sandbox.spy(this.EmbedCodeGenerator.prototype, 'showEmbedTarget');

      this.component.updateEmbedCodeDisplay('foo');
      expect(spy.called).to.be.true;
    });
  });

  describe('#populateEmbedCodeTemplate()', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      this.component.init();
      done();
    });

    it('should populate the passed embed code template with the data object', function() {
      var populatedEmbedCodeTemplate = this.component.populateEmbedCodeTemplate('{foo} and {bar}', { foo: 'bar', bar: 'foo'});

      expect(populatedEmbedCodeTemplate).to.equal('bar and foo');
    });
  });

  describe('#generateEmbedCode()', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      this.component.init();
      done();
    });

    it('should return the embed code', function() {
      this.component.$langInput.filter('[data-dough-embedcodegenerator-lang="cy"]').click();
      this.component.$widthInput.val('70');
      this.component.$widthUnitInput.filter('[data-dough-embedcodegenerator-width-unit="percentage"]').click();

      expect(this.component.generateEmbedCode()).to.equal('<div lang="cy" data-width="70%"><div>');
    });
  });

  describe('#showEmbedTarget()', function () {
    beforeEach(function(done) {
      this.component = new this.EmbedCodeGenerator(this.$html);
      this.component.init();
      done();
    });

    it('should add the active class to the embed target', function() {
      this.component.showEmbedTarget();
      expect(this.component.$embedTarget).to.have.class(this.component.config.selectors.activeClass);
    });

    it('should set aria-hidden on the embed target to false', function() {
      this.component.showEmbedTarget();
      expect(this.component.$embedTarget).to.have.attr('aria-hidden', 'false');
    });
  });
});
