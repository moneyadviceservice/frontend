require_relative '../spec_helper'

describe 'Home routing' do
  it 'routes / to the home controller' do
    expect(get('/')).to route_to('home#show')
  end
end
