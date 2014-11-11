describe('clear input field without initial value', function () {

  'use strict';

  beforeEach(function (done) {
    var self = this;

    requirejs(
      ['jquery', 'ClearInput'],
      function ($, ClearInput) {

        self.$html = $(window.__html__['spec/javascripts/fixtures/ClearInput.html']);
        self.$input = self.$html.find('[data-dough-clear-input]');
        self.$button = self.$html.find('[data-dough-clear-input-button]');
        self.mod = new ClearInput(self.$html);
        done();
      }, done);
    });

    it('shows the reset button when entering text into the input', function () {
      this.$input.val('Debt').trigger('keyup');
      expect(this.$button).to.have.class('is-active');
    });

    it('hides the reset button when it is clicked', function () {
      this.$input.val('Debt').trigger('keyup');
      expect(this.$button).to.have.class('is-active');
      this.$button.trigger('click');
      expect(this.$button).to.not.have.class('is-active');
    });

    it('hides the reset button when text is cleared', function () {
      this.$input.val('Debt').trigger('keyup');
      expect(this.$button).to.have.class('is-active');
      this.$input.val('').trigger('keyup');
      expect(this.$button).to.not.have.class('is-active');
    });

    it('focuses back on the input box when the text is cleared', function () {
      this.$input.val('Debt').trigger('keyup');
      expect(this.$button).to.have.class('is-active');
      this.$input.val('').trigger('keyup');
      expect(this.$button).to.not.have.class('is-active');
      expect(this.$input.filter(':focus')).to.exist;
    });
  });

  describe('clear input field with initial value', function () {

    'use strict';

    beforeEach(function (done) {
      var self = this;

      requirejs(
        ['jquery', 'ClearInput'],
        function ($, ClearInput) {

          self.$html = $(window.__html__['spec/javascripts/fixtures/ClearInputWithValue.html']);
          self.$input = self.$html.find('[data-dough-clear-input]');
          self.$button = self.$html.find('[data-dough-clear-input-button]');
          self.mod = new ClearInput(self.$html);
          done();
        }, done);
      });

      it('shows the reset button when there is an initial value', function () {
        expect(this.$button).to.have.class('is-active');
      });

      it('hides the reset button when it is clicked', function () {
        this.$button.trigger('click');
        expect(this.$button).to.not.have.class('is-active');
      });

      it('hides the reset button when text is cleared', function () {
        this.$input.val('').trigger('keyup');
        expect(this.$button).to.not.have.class('is-active');
      });

      it('focuses back on the input box when the text is cleared', function () {
        this.$input.val('').trigger('keyup');
        expect(this.$button).to.not.have.class('is-active');
        expect(this.$input.filter(':focus')).to.exist;
      });

    });
