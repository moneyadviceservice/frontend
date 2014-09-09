describe('clear input field', function () {

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

  it('should show the reset button when entering text into the input', function () {
    this.$input.val('Debt').trigger('keydown');
    expect(this.$button).to.have.class('is-active');
  });

  it('should hide the reset button when it is clicked', function () {
    this.$input.val('Debt').trigger('keydown');
    expect(this.$button).to.have.class('is-active');
    this.$button.trigger('click');
    expect(this.$button).to.not.have.class('is-active');
  });

  it('should hide the reset button when text is cleared', function () {
    this.$input.val('Debt').trigger('keydown');
    expect(this.$button).to.have.class('is-active');
    this.$input.val('').trigger('keydown');
    expect(this.$button).to.not.have.class('is-active');
  });

});
