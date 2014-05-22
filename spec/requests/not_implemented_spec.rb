RSpec.describe 'Request we have no implementation for', :type => :request do
  it 'returns a 501 response' do
    get('/unsupported')

    expect(response.status).to eq(501)
  end
end
