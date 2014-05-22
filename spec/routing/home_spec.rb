RSpec.describe 'Home routing', :type => :routing do
  it 'routes /en to the home controller' do
    expect(get('/en')).to route_to(controller: "home", action: "show", locale: "en")
  end
  
  it 'routes /cy to the home controller' do
    expect(get('/cy')).to route_to(controller: "home", action: "show", locale: "cy")
  end
end
