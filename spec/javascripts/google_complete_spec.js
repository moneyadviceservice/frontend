describe('googleComplete', function() {
  'use strict';

  var $input;

  before(function(done) {
    require(['googleComplete'], function(googleComplete) {
      var $body = $('body').html(window.__html__['spec/javascripts/templates/google_complete.html']);
      $input = $body.find('#search');

      new googleComplete({input: '#search'})

      done();
    }, done);
  });

  it('initialises the typeahead library', function() {
    expect($input).to.have.class('tt-input');
  });
});
