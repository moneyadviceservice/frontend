require_relative '../spec_helper'

describe 'Home routing' do
  it 'routes /en to the home controller' do
    expect(get('/en')).to route_to(controller: "home", action: "show", locale: "en")
  end
end
