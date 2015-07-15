RSpec.describe 'Request we have no implementation for', type: :request do
  it 'returns a 404 response' do
    expect{ get '/unsupported' }.to raise_error(ActionController::RoutingError)
  end
end
