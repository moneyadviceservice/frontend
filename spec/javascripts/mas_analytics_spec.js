//= require spec_helper

describe("mas_analytics#scrollTracking", function(){
  var mas_analytics;

  before(function(done){
    require(['mas_analytics'], function(ma) {
      mas_analytics = ma;
      done()
    }, done);
  })

  it("when there is no option", function(){
    var spy = sinon.spy();
    expect(mas_analytics.scrollTracking()).to.equal(false)
  })

  it("when the element is not in the DOM", function(){
    expect(mas_analytics.scrollTracking({el:false, triggerPoints:[0.25]})).to.equal(false)
  })

})



// require(['mas_analytics'], function(mas_analytics) {

// describe("mas_analytics#scrollTracking", function(){
//   describe("when options are invalid",function(){
//     it("when there is no option", function(){
//       expect(mas_analytics.scrollTracking()).to.be(false)
//     })
//     it("when the element is not in the DOM", function(){
//       // mas_analytics.scrollTracking({el:false, triggerPoints:[0.25]})
//        expect(true).to.be(true)
//     })
//     it("when there are no trigger points defined", function(){
//       // mas_analytics.scrollTracking({el:, triggerPoints:[0.25]})
//        expect(true).to.be(true)
//     })
//   })
// })

// });


