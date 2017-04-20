describe.only('GlobalNav', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    requirejs(
        ['jquery', 'GlobalNav', 'mediaQueries', 'utilities', 'common'],
        function($, GlobalNav, mediaQueries, utilities, common) {
          // self.$html = $(window.__html__['spec/javascripts/fixtures/GlobalNav.html']).appendTo('body');
          // self.component = self.$html.find('[data-dough-component="StickyColumn"]');
          // self.StickyColumn = StickyColumn
          // self.obj = new self.StickyColumn(self.component, self.component.data('dough-sticky-column-config'));

          done();
        }, done);
  });

  afterEach(function() {
  });

  it('does nothing', function() {
  });
});
