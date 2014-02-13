//= require spec_helper

describe("mas_collapsable", function () {
  var mas_collapsable, mas_collapsable_empty, $body;

  before(function (done) {
    $('body').html(JST['templates/collapsable']());
    $body = $('body');

    require(['collapsable'], function (mod) {
      mas_collapsable = new mod();
      mas_collapsable_empty = new mod({triggerEl:'.doesntExist'});
      done()
    }, done);
  })

  it("should return false is no trigger elements in DOM", function () {
    expect(mas_collapsable_empty.sections.length).to.be.equal(0);
  })

  it("should have method hide", function () {
    expect(typeof mas_collapsable.hide).to.equal('function')
  })

  it("should have method show", function () {
    expect(typeof mas_collapsable.show).to.equal('function')
  })

  it("should have options object that defines trigger element, target element, active class so these can be extended", function () {
    expect(mas_collapsable.o).to.have.property('triggerEl');
    expect(mas_collapsable.o).to.have.property('targetEl');
    expect(mas_collapsable.o).to.have.property('activeClass');
  })

  it("should add activeClass to all sections except first if o.showOnlyFirst is true", function(){
    var S = $body.find(mas_collapsable.o.triggerEl);
    S.each(function(i,el){
      if(i === 0){
        expect($(el).hasClass(mas_collapsable.o.activeClass)).to.be.true;
      }else{
        expect($(el).hasClass(mas_collapsable.o.activeClass)).to.be.false;
      }
    })
  })

  it("should toggle the active class on both trigger and target element when the toggle element is clicked", function (done) {
    var button = $body.find('#toggleButton1');
    var target = $body.find('#toggleTarget1');

    // Confirm initial state
    expect(button.hasClass(mas_collapsable.o.activeClass)).to.be.false;
    expect(target.hasClass(mas_collapsable.o.activeClass)).to.be.false;

    // Force interaction
    button.trigger('click');

    // Test expected state
    expect(button.hasClass(mas_collapsable.o.activeClass)).to.be.true;
    expect(target.hasClass(mas_collapsable.o.activeClass)).to.be.true;
    done();      

  })

})