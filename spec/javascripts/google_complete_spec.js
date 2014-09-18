describe('googleComplete', function() {
  'use strict';

  var $input,
      stubCompletions;

  function simulateInput(value) {
    $input.focus();
    $input.typeahead('val', '');
    $input.typeahead('val', value);
  }

  before(function(done) {
    require(['googleComplete'], function(googleComplete) {
      var $body = $('body').html(window.__html__['spec/javascripts/templates/google_complete.html']);
      $input = $body.find('#search');

      stubCompletions = sinon.stub(googleComplete.prototype, 'completions');
      new googleComplete({input: '#search'})

      done();
    }, done);
  });

  it('initialises the typeahead library', function() {
    expect($input).to.have.class('tt-input');
  });

  context('when a single character is input', function() {
    it('does not fetch the completions', function() {
      simulateInput('a');
      expect(stubCompletions.called).to.be.false;
    });
  });

  context('when more than one character is input', function() {
    it('fetches the completions', function() {
      simulateInput('ab');
      expect(stubCompletions.called).to.be.true;
    });
  });
});
