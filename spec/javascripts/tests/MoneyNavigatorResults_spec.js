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
          self.hiddenClass  = self.obj.hiddenClass; 
          self.collapsedClass = self.obj.collapsedClass; 
          self.doneClass = self.obj.doneClass; 

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

      this.obj._updateDOM(); 

      this.$headingContent.each(function() {
        expect($(this).hasClass(_this.hiddenClass)).to.be.true; 
      }); 

      this.$sections.each(function() {
        expect($(this).hasClass(_this.collapsedClass)).to.be.true; 
        expect($(this).find('.section__title__icon').length).to.equal(1); 
      }); 

      this.$headingTitles.each(function() {
        expect($(this).find('.heading__title__icon').length).to.equal(1); 
      }); 
    }); 
  }); 

  describe('setUpEvents method', function() {
    it('Sets the correct event listeners and arguments when called', function() {
      var toggleSectionSpy = sinon.stub(this.obj, '_toggleSection'); 
      var toggleHeadingSpy = sinon.spy(this.obj, '_toggleHeading'); 
      var section_0_btn = $(this.$sectionTitles[0]).find('button'); 
      var section_1_btn = $(this.$sectionTitles[1]).find('button'); 
      var section_2_btn = $(this.$sectionTitles[2]).find('button'); 
      var heading_0_btn = $(this.$headings[0]).find('button'); 
      var heading_2_btn = $(this.$headings[2]).find('button'); 
      var heading_4_btn = $(this.$headings[4]).find('button'); 

      this.obj._setUpEvents(); 

      $(section_0_btn).trigger('click'); 
      expect(toggleSectionSpy.calledWith(section_0_btn[0])).to.be.true; 

      $(section_1_btn).trigger('click'); 
      expect(toggleSectionSpy.calledWith(section_1_btn[0])).to.be.true; 

      $(section_2_btn).trigger('click'); 
      expect(toggleSectionSpy.calledWith(section_2_btn[0])).to.be.true; 

      $(heading_0_btn).trigger('click'); 
      expect(toggleHeadingSpy.calledWith(heading_0_btn[0])).to.be.true; 

      $(heading_2_btn).trigger('click'); 
      expect(toggleHeadingSpy.calledWith(heading_2_btn[0])).to.be.true; 

      $(heading_4_btn).trigger('click'); 
      expect(toggleHeadingSpy.calledWith(heading_4_btn[0])).to.be.true; 

      toggleSectionSpy.restore(); 
      toggleHeadingSpy.restore(); 
    }); 
  }); 

  describe('toggleSection method', function() {
    it('Sets the correct class on the section when the method is called', function() {
      var section_0 = this.$sections[0]; 
      var section_0_btn = $(section_0).find('[data-section-title]').find('button'); 
      var section_1 = this.$sections[1]; 
      var section_1_btn = $(section_1).find('[data-section-title]').find('button'); 

      this.obj._updateDOM(); 

      this.obj._toggleSection(section_0_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.false; 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.true; 

      this.obj._toggleSection(section_1_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.false; 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.false; 

      this.obj._toggleSection(section_0_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.true; 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.false; 

      this.obj._toggleSection(section_1_btn);
      expect($(section_0).hasClass(this.collapsedClass)).to.be.true; 
      expect($(section_1).hasClass(this.collapsedClass)).to.be.true; 
    }); 
  })

  describe('toggleHeading method', function() {
    it('Sets the correct class on the heading when the method is called', function() {
      var heading_0 = this.$headings[0]; 
      var heading_0_btn = $(heading_0).find('button'); 
      var heading_0_content = $(heading_0).find('[data-heading-content]'); 
      var heading_2 = this.$headings[2]; 
      var heading_2_btn = $(heading_2).find('button'); 
      var heading_2_content = $(heading_2).find('[data-heading-content]'); 
      var heading_4 = this.$headings[4]; 
      var heading_4_btn = $(heading_4).find('button'); 
      var heading_4_content = $(heading_4).find('[data-heading-content]'); 

      this.obj._updateDOM(); 

      this.obj._toggleHeading(heading_0_btn); 
      expect($(heading_0_content).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_2_content).hasClass(this.hiddenClass)).to.be.true; 
      expect($(heading_4_content).hasClass(this.hiddenClass)).to.be.true; 
      expect($(heading_0).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_2).hasClass(this.doneClass)).to.be.false; 
      expect($(heading_4).hasClass(this.doneClass)).to.be.false; 

      this.obj._toggleHeading(heading_2_btn); 
      expect($(heading_0_content).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_2_content).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_4_content).hasClass(this.hiddenClass)).to.be.true; 
      expect($(heading_0).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_2).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_4).hasClass(this.doneClass)).to.be.false; 

      this.obj._toggleHeading(heading_4_btn); 
      expect($(heading_0_content).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_2_content).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_4_content).hasClass(this.hiddenClass)).to.be.false;
      expect($(heading_0).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_2).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_4).hasClass(this.doneClass)).to.be.true; 

      this.obj._toggleHeading(heading_2_btn); 
      expect($(heading_0_content).hasClass(this.hiddenClass)).to.be.false; 
      expect($(heading_2_content).hasClass(this.hiddenClass)).to.be.true; 
      expect($(heading_4_content).hasClass(this.hiddenClass)).to.be.false;
      expect($(heading_0).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_2).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_4).hasClass(this.doneClass)).to.be.true; 

      this.obj._toggleHeading(heading_0_btn); 
      expect($(heading_0_content).hasClass(this.hiddenClass)).to.be.true; 
      expect($(heading_2_content).hasClass(this.hiddenClass)).to.be.true; 
      expect($(heading_4_content).hasClass(this.hiddenClass)).to.be.false;
      expect($(heading_0).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_2).hasClass(this.doneClass)).to.be.true; 
      expect($(heading_4).hasClass(this.doneClass)).to.be.true; 
    }); 
  }); 
});
