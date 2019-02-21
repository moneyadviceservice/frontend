describe('StickyColumn', function() {

  'use strict';

  beforeEach(function(done) {
    var self = this;
    requirejs(
        ['jquery', 'StickyColumn', 'eventsWithPromises'],
        function($, StickyColumn, eventsWithPromises) {
          self.$html = $(window.__html__['spec/javascripts/fixtures/StickyColumn.html']).appendTo('body');
          self.component = self.$html.find('[data-dough-component="StickyColumn"]');
          self.StickyColumn = StickyColumn
          self.eventsWithPromises = eventsWithPromises;
          self.eventsWithPromises.unsubscribeAll();

          self.obj = new self.StickyColumn(self.component, self.component.data('dough-sticky-column-config'));

          self.clock = sinon.useFakeTimers();

          done();

        }, done);
  });

  afterEach(function() {
    this.clock.restore();
    this.$html.remove();
    $(window).off('resize');
    $(window).off('scroll');
  });

  it('calls the right methods when initializing', function() {
    var resizeStub     = sinon.stub(this.obj, "_bindEvents"),
        measureDomStub = sinon.stub(this.obj, "_measureDom"),
        showElementStub = sinon.stub(this.obj, "_showElement"),
        positionComponentStub = sinon.stub(this.obj, "_positionComponent");

    this.obj.init();

    expect(resizeStub.callCount).to.be.equal(1);
    expect(measureDomStub.callCount).to.be.equal(1);
    expect(showElementStub.callCount).to.be.equal(1);
    expect(positionComponentStub.callCount).to.be.equal(1);
  });

  it('binds to the window resize event', function() {
    var stub = sinon.stub(this.obj, "_handleResize");

    this.obj.init();

    $(window).trigger('resize');
    this.clock.tick(200);

    expect(stub.callCount).to.be.equal(1);
  });

  it('binds to the window scroll event', function() {
    var stub = sinon.stub(this.obj, "_handleScroll");

    this.obj.init();

    $(window).trigger('scroll');

    expect(stub.callCount).to.be.equal(1);
  });

  it('subcribes to the toggler:toggled event', function() {
    var stub = sinon.stub(this.obj, "_handleSectionToggle");

    this.obj.init();

    this.eventsWithPromises.publish('toggler:toggled');

    expect(stub.callCount).to.be.equal(1);
  });

  it('sets the content height correctly', function() {
    var height = 20;

    this.$html.find('.main').css('height', height);

    this.obj.init();

    expect(this.obj.contentHeight).to.be.equal(height);
  });

  it('sets the topMargin correctly', function() {
    var margin = 20;

    this.$html.find('.column').css('margin-top', margin);

    this.obj.init();

    expect(this.obj.topMargin).to.be.equal(margin);
  });

  it('sets the top correctly', function() {
    var top = 20;

    this.$html.find('.column').css('top', top);
    this.$html.find('.column').css('position', 'absolute');

    this.obj.init();

    expect(this.obj.top).to.be.equal(top);
  });

  it('sets the bottom correctly', function() {
    var top = 0,
        contentHeight = 20,
        margin = 20,
        stickyElHeight = 20;

    this.$html.find('.column').css({
      'top': top,
      'position': 'absolute',
      'margin-top': margin
    });

    this.$html.find('.main').css('height', contentHeight);
    this.$html.find('.sticky').css('height', stickyElHeight);

    this.obj.init();

    expect(this.obj.bottom).to.be.equal(0);
  });

  describe('_measureDom', function() {
    it('calls _showInSidebar when isInSidebar is true', function() {
      var stub = sinon.stub(this.obj, "_showInSidebar");

      this.obj.isInSidebar = true;

      this.obj._measureDom();

      expect(stub.callCount).to.be.equal(1);
    });

    it('does not call _showInSidebar when isInSidebar is false', function() {
      var stub = sinon.stub(this.obj, "_showInSidebar");

      this.obj.isInSidebar = false;

      this.obj._measureDom();

      expect(stub.callCount).to.be.equal(0);
    });
  });

  describe('_showElement', function() {
    it('calls _showInSidebar and sets isInSidebar to true', function() {
      var stub = sinon.stub(this.obj, "_showInSidebar");

      this.obj.isInSidebar = false;
      this.component.show();

      this.obj._showElement();

      expect(stub.callCount).to.be.equal(1);
    });

    it('calls _hide and sets isInSidebar to false', function() {
      var stub = sinon.stub(this.obj, "_hide");

      this.obj.isInSidebar = true;
      this.component.hide();

      this.obj._showElement();

      expect(stub.callCount).to.be.equal(1);
    });
  });

  describe('_showInSidebar', function() {
    it('sets the correct parent height and sticky element width', function() {
      var margin = 1,
          contentHeight = 2,
          width = 3;

      this.$html.find('.main').css('height', contentHeight);
      this.$html.find('.column').css('margin-top', margin);
      this.$html.find('.column').css('width', width);

      this.obj._measureDom();
      this.obj._showInSidebar();

      expect(this.$html.find('.column').css('height')).to.be.equal('1px');
      expect(this.$html.find('.sticky').css('width')).to.be.equal('3px');
    });
  });

  describe('_hide', function() {
    it('sets the parent height to the height of its content', function() {
      var parentHeight = 10,
          contentHeight = 5;

      this.$html.find('.column').css('height', parentHeight);
      this.$html.find('.sticky').css('height', contentHeight);

      this.obj._measureDom();
      this.obj._hide();

      expect(this.$html.find('.column').css('height')).to.be.equal('5px');
    });
  });

  describe('_positionComponent', function() {
    it('adds a fixed class after scrolling down', function() {
      var stub = sinon.stub(this.obj, '_getWindowScroll').returns(100);

      this.obj.isInSidebar = true;
      this.obj.isFixed = false;
      this.obj.isAtBottom = false;
      this.obj.top = 50;
      this.obj.bottom = 150;

      this.obj._positionComponent();

      expect(this.component.attr('class')).to.be.equal('sticky fixed');
    });

    it('removes the fixed class', function() {
      var stub = sinon.stub(this.obj, '_getWindowScroll').returns(25);

      this.obj.isInSidebar = true;
      this.obj.isFixed = true;
      this.obj.isAtBottom = false;
      this.obj.top = 50;
      this.obj.bottom = 150;

      this.obj._positionComponent();

      expect(this.component.attr('class')).to.be.equal('sticky');
    });

    it('adds the bottom class', function() {
      var stub = sinon.stub(this.obj, '_getWindowScroll').returns(151);

      this.obj.isInSidebar = true;
      this.obj.isFixed = true;
      this.obj.isAtBottom = false;
      this.obj.top = 50;
      this.obj.bottom = 150;

      this.obj._positionComponent();

      expect(this.component.attr('class')).to.be.equal('sticky bottom');
    });

    it('adds the fixed class after scrolling up', function() {
      var stub = sinon.stub(this.obj, '_getWindowScroll').returns(125);

      this.obj.isInSidebar = true;
      this.obj.isFixed = false;
      this.obj.isAtBottom = true;
      this.obj.top = 50;
      this.obj.bottom = 150;

      this.obj._positionComponent();

      expect(this.component.attr('class')).to.be.equal('sticky fixed');
    });

    it('returns the sticky module back to its static position', function() {
      var stub = sinon.stub(this.obj, '_getWindowScroll').returns(0);

      this.obj.isInSidebar = true;
      this.obj.isFixed = false;
      this.obj.isAtBottom = true;
      this.obj.top = 175;
      this.obj.bottom = 4000;

      this.obj._positionComponent();

      expect(this.component.attr('class')).to.be.equal('sticky');
    });
  });

  describe('_handleScroll', function() {
    it('does not call _positionComponent when isInSidebar is false', function() {
      var stub = sinon.stub(this.obj, "_positionComponent");

      this.obj.isInSidebar = false;

      this.obj._handleScroll();

      expect(stub.callCount).to.be.equal(0);
    });

    it('calls _positionComponent when isInSidebar is true', function() {
      var stub = sinon.stub(this.obj, "_positionComponent");

      this.obj.isInSidebar = true;

      this.obj._handleScroll();

      expect(stub.callCount).to.be.equal(1);
    });
  });

  describe('_handleSectionToggle', function() {
    it('calls _handleResize if the event has been triggered inside the sticky element', function() {
      var stub = sinon.stub(this.obj, "_handleResize");

      var element = $('<span />');
      this.component.append(element);

      this.obj._handleSectionToggle({
        emitter: {
          $el: element
        }
      });

      expect(stub.callCount).to.be.equal(1);
    });
  });
});
