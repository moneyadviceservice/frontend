RSpec.describe '404 catachall', type: :request do
  context 'when page does not exist' do
    it 'raises routing error not found' do
      expect { get '/idonotexist' }.to raise_error(ActionController::RoutingError, 'Not Found')
    end
  end
end

RSpec.describe '404 catachall', type: :request do
  context 'when page does not exist' do
    it 'renders the 404 page' do
      expect { get '/idonotexist' }.to raise_error(ActionController::RoutingError, 'Not Found')
    end
  end

  context 'when nested page does not exist' do
    it 'renders the 404 page' do
      expect { get '/en/idonotexist/other' }.to raise_error(ActionController::RoutingError, 'Not Found')
    end
  end

  context 'when redirect in cms exists' do
    it 'redirects' do
      get '/our-debt-work'
      expect(response).to redirect_to('http://localhost:5000/en/corporate/about-our-debt-work')
    end
  end
end
