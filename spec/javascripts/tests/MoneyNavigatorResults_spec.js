describe('MoneyNavigatorResults', function() {
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
          self.$sections = self.component.find('[data-section]'); 
          self.$sectionTitles = self.component.find('[data-section-title]'); 
          self.$headings = self.component.find('[data-heading]'); 
          self.$headingTitles = self.component.find('[data-heading-title]'); 
          self.$headingContent = self.component.find('[data-heading-content]'); 
          self.$overlay = self.component.find('[data-overlay]'); 
          self.hiddenSuffix  = self.obj.hiddenSuffix; 
          self.hiddenClass  = self.obj.hiddenClass; 
          self.collapsedClass = self.obj.collapsedClass; 
          self.doneSuffix = self.obj.doneSuffix; 

          // TODO: Use these variables in setUpEvents method in favour of $headingTitles above
          self.S1_H1_btn = self.component.find('#S1_H1').find('button');
          self.S1_H2_btn = self.component.find('#S1_H2').find('button');
          // self.S3_H1_btn = $('#S3_H1').find('button');
          // self.S4_H2_btn = $('#S4_H2').find('button');
          self.S4_H3_btn = self.component.find('#S4_H3').find('button');

          done();
        }, done);
  });

  afterEach(function() {
    fixture.cleanup();
  });

  describe('Initialisation', function() {
    it('Calls the correct methods when the component is initialised', function() {
      var updateDOMStub = sinon.stub(this.obj, '_updateDOM'); 
      var setUpEventsStub = sinon.stub(this.obj, '_setUpEvents'); 

      this.obj.init();

      expect(updateDOMStub.calledOnce).to.be.true; 
      expect(setUpEventsStub.calledOnce).to.be.true; 

      updateDOMStub.restore(); 
      setUpEventsStub.restore(); 
    });
  });

  describe('updateDOM method', function() {
    it('Makes the correct changes to the DOM when called', function() {
      var _this = this;
      var hiddenClass = 'heading__content' + this.hiddenSuffix; 

      this.obj._updateDOM(); 

      this.$headingContent.each(function() {
        expect($(this).hasClass(hiddenClass)).to.be.true; 
      }); 

      this.$sections.each(function() {
        expect($(this).hasClass(_this.collapsedClass)).to.be.true; 
        expect($(this).find('.section__title__icon').length).to.equal(1); 
        expect($(this).find('.section__content').height()).to.equal(0); 
      }); 

      this.$headingTitles.each(function() {
        expect($(this).find('.heading__title__icon').length).to.equal(1); 
      });

      expect($(this.component).find('[data-print-btn]').length).to.equal(1); 
    }); 
  }); 

  describe('setUpEvents method', function() {
    it('Sets the correct event listeners and arguments when called', function() {
      this.obj._updateDOM(); 

      var toggleSectionSpy = sinon.stub(this.obj, '_toggleSection'); 
      var showHeadingSpy = sinon.spy(this.obj, '_showHeading'); 
      var hideHeadingSpy = sinon.spy(this.obj, '_hideHeading'); 
      var resizeContentSpy = sinon.spy(this.obj, '_resizeContent'); 
      var sectionResizeStub = sinon.stub(this.obj, '_sectionResize'); 
      var printStub = sinon.stub(window, 'print'); 
      var section_0_btn = $(this.$sectionTitles[0]).find('button'); 
      var section_1_btn = $(this.$sectionTitles[1]).find('button'); 
      var section_2_btn = $(this.$sectionTitles[2]).find('button'); 
      var heading_0_btn = $(this.$headings[0]).find('button'); 
      var heading_2_btn = $(this.$headings[2]).find('button'); 
      var heading_4_btn = $(this.$headings[4]).find('button'); 
      var overlayHide = $(this.$headingContent[0]).find('[data-overlay-hide]'); 
      var printBtn = $(this.component).find('[data-print-btn]'); 

      this.obj._setUpEvents(); 

      $(section_0_btn).trigger('click'); 
      expect(toggleSectionSpy.calledWith(section_0_btn[0])).to.be.true; 

      $(section_1_btn).trigger('click'); 
      expect(toggleSectionSpy.calledWith(section_1_btn[0])).to.be.true; 

      $(section_2_btn).trigger('click'); 
      expect(toggleSectionSpy.calledWith(section_2_btn[0])).to.be.true; 

      $(heading_0_btn).trigger('click'); 
      expect(showHeadingSpy.calledWith(heading_0_btn[0])).to.be.true; 
      expect(resizeContentSpy.calledWith(heading_0_btn[0])).to.be.true; 
      expect(resizeContentSpy.callCount).to.equal(1); 

      $(heading_2_btn).trigger('click'); 
      expect(showHeadingSpy.calledWith(heading_2_btn[0])).to.be.true; 
      expect(resizeContentSpy.calledWith(heading_2_btn[0])).to.be.true; 
      expect(resizeContentSpy.callCount).to.equal(2); 

      $(heading_4_btn).trigger('click'); 
      expect(showHeadingSpy.calledWith(heading_4_btn[0])).to.be.true; 
      expect(resizeContentSpy.calledWith(heading_4_btn[0])).to.be.true; 
      expect(resizeContentSpy.callCount).to.equal(3); 

      $(overlayHide).trigger('click');
      expect(hideHeadingSpy.calledWith(overlayHide[0])).to.be.true; 
      expect(resizeContentSpy.calledWith()).to.be.true;
      expect(resizeContentSpy.callCount).to.equal(4); 

      this.$overlay.trigger('click'); 
      expect(hideHeadingSpy.calledWith()).to.be.true; 

      $(printBtn).trigger('click'); 
      expect(window.print.calledOnce).to.be.true; 

      $(window).trigger('resize'); 
      expect(sectionResizeStub.called).to.be.false; 

      toggleSectionSpy.restore(); 
      showHeadingSpy.restore(); 
      hideHeadingSpy.restore(); 
      resizeContentSpy.restore(); 
      sectionResizeStub.restore(); 
      printStub.restore(); 
    }); 
  });

  describe('resizeContent method', function() {
    it('Sets new value for height of body', function() {
      var getSizeSpy = sinon.spy(this.obj, '_getSize');

      this.obj._resizeContent();
      expect(getSizeSpy.called).to.not.be.true; 

      this.obj._resizeContent(this.S1_H1_btn[0]);
      expect(getSizeSpy.calledWith(this.S1_H1_btn.parents('[data-heading]').find('[data-heading-content]')[0])).to.be.true;

      this.obj._resizeContent(this.S4_H3_btn);
      expect(getSizeSpy.calledWith(this.S4_H3_btn.parents('[data-heading]').find('[data-heading-content]')[0])).to.be.true;

      getSizeSpy.restore(); 
    });
  });

  // TODO: Fix this test
  xdescribe('getSize method', function() {
    it('Returns the correct value when given a target element', function() {
      var value = this.obj._getSize(this.S1_H2_btn.parents('[data-heading]').find('[data-heading-content]'));
      expect(value.height).to.equal(2165);
    }); 
  }); 

  describe('sectionResize method', function() {
    it ('Resizes a given section__content element', function() {
      var section = this.$sections[0]; 
      var $sectionContent = $(section).find('.section__content'); 

      $sectionContent.height(1); 

      this.obj._sectionResize(section); 
      expect($sectionContent.height()).to.be.above(1); 
    })
  }); 

  describe('toggleSection method', function() {
    it('Sets the correct class on the section and and value for height on the content when the method is called', function() {
      var section_0 = this.$sections[0]; 
      var section_0_btn = $(section_0).find('[data-section-title]').find('button'); 
      var section_0_content = $(section_0).find('.section__content'); 
      var section_1 = this.$sections[1]; 
      var section_1_btn = $(section_1).find('[data-section-title]').find('button'); 
      var section_1_content = $(section_1).find('.section__content'); 

      this.obj._updateDOM(); 

      this.obj._toggleSection(section_0_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.false; 
      expect(parseFloat($(section_0_content)[0].style.height)).to.be.above(0); 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.true; 
      expect(parseFloat($(section_1_content)[0].style.height)).to.equal(0); 

      this.obj._toggleSection(section_1_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.false; 
      expect(parseFloat($(section_0_content)[0].style.height)).to.be.above(0); 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.false; 
      expect(parseFloat($(section_1_content)[0].style.height)).to.be.above(0); 

      this.obj._toggleSection(section_0_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.true; 
      expect(parseFloat($(section_0_content)[0].style.height)).to.equal(0); 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.false; 
      expect(parseFloat($(section_1_content)[0].style.height)).to.be.above(0); 

      this.obj._toggleSection(section_1_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.true; 
      expect(parseFloat($(section_0_content)[0].style.height)).to.equal(0); 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.true; 
      expect(parseFloat($(section_1_content)[0].style.height)).to.equal(0); 
    }); 
  })

  describe('showHeading method', function() {
    it('Sets classes correctly when the method is called', function() {
      var heading_0 = this.$headings[0]; 
      var heading_0_btn = $(heading_0).find('button'); 
      var heading_0_content = $(heading_0).find('[data-heading-content]'); 
      var heading_2 = this.$headings[2]; 
      var heading_2_btn = $(heading_2).find('button'); 
      var heading_2_content = $(heading_2).find('[data-heading-content]'); 
      var heading_4 = this.$headings[4]; 
      var heading_4_btn = $(heading_4).find('button'); 
      var heading_4_content = $(heading_4).find('[data-heading-content]'); 
      var hiddenClass = 'heading__content' + this.hiddenSuffix; 
      var doneClass = 'sections__heading' + this.doneSuffix; 

      this.obj._updateDOM(); 

      this.obj._showHeading(heading_0_btn); 
      expect($(heading_0_content).hasClass(hiddenClass)).to.be.false; 
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_0).hasClass(doneClass)).to.be.true; 
      expect($(heading_2).hasClass(doneClass)).to.be.false; 
      expect($(heading_4).hasClass(doneClass)).to.be.false; 

      this.obj._showHeading(heading_2_btn); 
      expect($(heading_2_content).hasClass(hiddenClass)).to.be.false; 
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_0).hasClass(doneClass)).to.be.true; 
      expect($(heading_2).hasClass(doneClass)).to.be.true; 
      expect($(heading_4).hasClass(doneClass)).to.be.false; 

      this.obj._showHeading(heading_4_btn); 
      expect($(heading_4_content).hasClass(hiddenClass)).to.be.false;
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_0).hasClass(doneClass)).to.be.true; 
      expect($(heading_2).hasClass(doneClass)).to.be.true; 
      expect($(heading_4).hasClass(doneClass)).to.be.true; 

      this.obj._showHeading(heading_2_btn); 
      expect($(heading_2_content).hasClass(hiddenClass)).to.be.false; 
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_0).hasClass(doneClass)).to.be.true; 
      expect($(heading_2).hasClass(doneClass)).to.be.true; 
      expect($(heading_4).hasClass(doneClass)).to.be.true; 

      this.obj._showHeading(heading_0_btn); 
      expect($(heading_0_content).hasClass(hiddenClass)).to.be.false; 
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_0).hasClass(doneClass)).to.be.true; 
      expect($(heading_2).hasClass(doneClass)).to.be.true; 
      expect($(heading_4).hasClass(doneClass)).to.be.true; 
    }); 
  }); 

  describe('hideHeading method', function() {
    it('Sets classes correctly when called', function() {
      this.obj._updateDOM(); 

      var heading_0 = this.$headings[0]; 
      var heading_0_btn = $(heading_0).find('button'); 
      var heading_0_content = $(heading_0).find('[data-heading-content]'); 
      var heading_0_closeBtn = $(heading_0_content).find('[data-overlay-hide]'); 
      var hiddenClass = 'heading__content' + this.hiddenSuffix; 

      this.obj._showHeading(heading_0_btn); 

      this.obj._hideHeading(heading_0_closeBtn);
      expect($(heading_0_content).hasClass(hiddenClass)).to.be.true; 
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.true; 

      this.obj._showHeading(heading_0_btn); 

      this.obj._hideHeading();
      expect($(heading_0_content).hasClass(hiddenClass)).to.be.true; 
      expect($(this.$overlay).hasClass(this.hiddenClass)).to.be.true; 
    }); 
  }); 
});
