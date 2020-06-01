describe.only('MoneyNavigatorQuestions', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    fixture.setBase('spec/javascripts/fixtures');

    requirejs(
        ['jquery', 'MoneyNavigatorQuestions'],
        function($, MoneyNavigatorQuestions) {
          fixture.load('MoneyNavigatorQuestions.html');
          self.component = $(fixture.el).find('[data-dough-component="MoneyNavigatorQuestions"]');
          self.obj = new MoneyNavigatorQuestions(self.component);

          done();
        }, done);
  });

  afterEach(function() {
    fixture.cleanup();
  });

  describe('Does nothing', function() {
    it('Does nothing', function() {
      expect(1).to.equal(1);
    });
  });
});
