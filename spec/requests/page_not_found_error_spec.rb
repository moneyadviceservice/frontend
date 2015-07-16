RSpec.describe 'ErrorController', type: :request do
  context 'incorrect tool id' do
    it 'redirects to 404 page' do
      expect{ get('/en/tools/quick-cash-find') }.to raise_error(ActionController::RoutingError)
    end
  end
end
