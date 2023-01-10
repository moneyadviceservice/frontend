RSpec.describe 'HomePage', type: :request do
  before do
    get '/en'
  end

  it 'successfully redirects' do
    expect(response).to be_redirect
  end
end
