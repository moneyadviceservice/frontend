describe('googleComplete', function() {
  'use strict';

  var $input,
      stubCompletions,
      module;

  function simulateInput(value) {
    $input.focus();
    $input.typeahead('val', '');
    $input.typeahead('val', value);
  }

  before(function(done) {
    require(['googleComplete'], function(googleComplete) {
      var $body = $('body').html(window.__html__['spec/javascripts/templates/google_complete.html']);
      $input = $body.find('#search');

      module = googleComplete;
      stubCompletions = sinon.stub(googleComplete.prototype, 'completions');
      new googleComplete({input: $input})

      done();
    }, done);
  });

  after(function() {
    module.prototype.completions.restore();
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


describe('googleComplete#completions', function() {
  'use strict';

  var module,
      query = 'ta',
      response = ["ta",[["tax"],["tax credits"]],{"q":"xICyRJzwB2eUKd10u0jujw13BQw","k":1}],
      completions = [{value: "tax"}, {value: "tax credits"}],
      googleApiCx = '123-abc',
      url = 'https://clients1.google.com/complete/search?q=' + query +
        '&hl=en&client=partner&source=gcsc&ds=cse&partnerid=' + googleApiCx;

  before(function(done) {
    require(['googleComplete', 'globals'], function(googleComplete, globals) {
      module = googleComplete;
      globals.bootstrap.googleApiCx = googleApiCx;

      done();
    }, done);
  });

  afterEach(function() {
    $.ajax.restore();
  });

  it('calls the correct URL', function() {
    sinon.stub($, 'ajax', function(options) {
      expect(options.url).to.equal(url);
    });

    module.prototype.completions(query, null);
  });

  it('passes the completions to the callback', function() {
    sinon.stub($, 'ajax').yieldsTo('success', response);

    var callback = sinon.spy();
    module.prototype.completions(query, callback);

    expect(callback.firstCall.args[0]).to.eql(completions);
  });
});
