//= require spec_helper

describe("MAS global namespace", function(){

  it("MAS global namespace should be defined", function(){
    expect(typeof window.MAS).to.equal('object')
  })

  it("should have .supports property", function(){
    expect(typeof MAS.supports).to.equal('object')
  })

  it("should have .config property", function(){
    expect(typeof MAS.config).to.equal('object')
  })

  it("should have .env property type string", function(){
    expect(typeof MAS.env).to.equal('string')
  })

  it("should have .datalayer property", function(){
    expect(typeof MAS.datalayer).to.equal('object')
  })

  it("MAS.datalayer should equal window.dataLayer", function(){
    expect(MAS.datalayer).to.equal(window.dataLayer)
  })

  it("should have .timestamp property", function(){
    expect(typeof MAS.timestamp).to.equal('number')
  })

})