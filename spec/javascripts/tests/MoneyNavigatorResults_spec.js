describe.only('MoneyNavigatorResults', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    fixture.setBase('spec/javascripts/fixtures');

    requirejs(
        ['jquery', 'MoneyNavigatorResults'],
        function($, MoneyNavigatorResults) {
          fixture.load('MoneyNavigatorResults.html');
          self.component = $(fixture.el).find('[data-dough-component="MoneyNavigatorResults"]');
          self.obj = new MoneyNavigatorResults(self.component);

          done();
        }, done);
  });

  afterEach(function() {
    fixture.cleanup();
  });

  describe('Initialisation', function() {
    it('Calls the correct methods when the component is initialised', function() {
      this.obj.init();
    });
  });
});
