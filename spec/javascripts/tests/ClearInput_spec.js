describe('clear input field', function () {

  'use strict';

  beforeEach(function (done) {
    var self = this;

    requirejs(
        ['jquery', 'ClearInput'],
        function ($, ClearInput) {

          self.$html = $(window.__html__['spec/javascripts/fixtures/ClearInput.html']);
          self.$input = self.$html.find('input');
          self.mod = new ClearInput(self.$input);
          done();
        }, done);
  });

  it('clears the input field when button is clicked', function () {
    this.$input.trigger('change');
    assert(this.stub.calledOnce);
  });

});
