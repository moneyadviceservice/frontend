describe.only('GlobalNav', function() {
  'use strict';

  beforeEach(function(done) {
    var self = this;

    requirejs(
        ['jquery', 'GlobalNav', 'mediaQueries', 'utilities', 'common'],
        function($, GlobalNav, mediaQueries, utilities, common) {
          self.$html = $(window.__html__['spec/javascripts/fixtures/GlobalNav.html']).appendTo('body');
          self.component = self.$html.find('[data-dough-component="GlobalNav"]');
          self.GlobalNav = GlobalNav;
          self.obj = new self.GlobalNav(self.component, self.component.data('dough-global-nav-config'));

          done();
        }, done);
  });

  afterEach(function() {
    this.$html.remove();
  });

  it('calls the right methods when initialising', function() {
    var setUpMobileInteractionStub = sinon.stub(this.obj, "_setUpMobileInteraction"),
        setUpDesktopInteractionStub = sinon.stub(this.obj, "_setUpDesktopInteraction"),
        setUpMobileAnimationStub = sinon.stub(this.obj, "_setUpMobileAnimation"),
        setUpKeyboardEventsStub = sinon.stub(this.obj, "_setUpKeyboardEvents"),
        bindEventsStub = sinon.stub(this.obj, "_bindEvents");

    this.obj.init();

    expect(setUpMobileInteractionStub.callCount).to.be.equal(1);
    expect(setUpDesktopInteractionStub.callCount).to.be.equal(1);
    expect(setUpMobileAnimationStub.callCount).to.be.equal(1);
    expect(setUpKeyboardEventsStub.callCount).to.be.equal(1);
    expect(bindEventsStub.callCount).to.be.equal(1);
  });
});
