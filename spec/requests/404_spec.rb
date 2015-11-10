RSpec.describe '404 catachall', type: :request do
  context 'when page does not exist' do
    it 'raises routing error not found' do
      expect { get '/idonotexist' }.to raise_error(ActionController::RoutingError, 'Not Found')
    end
  end
end

RSpec.describe '404 catachall', type: :request, features: [:redirects] do
  context 'when page does not exist' do
    it 'renders the 404 page' do
      VCR.use_cassette('core/repository/cms/cms_api/find/idonotexist') do
        expect { get '/idonotexist' }.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end
  end

  context 'when nested page does not exist' do
    it 'renders the 404 page' do
      VCR.use_cassette('core/repository/cms/cms_api/find/idonotexist_nested') do
        expect { get '/en/idonotexist/other' }.to raise_error(ActionController::RoutingError, 'Not Found')
      end
    end
  end

  context 'when redirect in cms exists' do
    it 'redirects' do
      VCR.use_cassette('core/repository/cms/cms_api/find/iamredirect') do
        get '/iamredirect'
        expect(response).to redirect_to('http://localhost:3000/en/elsewhere')
      end
    end
  end
end
