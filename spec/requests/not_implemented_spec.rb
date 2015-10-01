RSpec.describe 'Request we have no implementation for', type: :request do
  it 'returns a 501 response' do
    get('/unsupported')

    expect(response.status).to eq(501)
  end
end

RSpec.describe 'Request that is redirected', type: :request, features: [:redirects] do
  it 'redirects to specified location' do
    VCR.use_cassette('/en/core/repository/categories/cms/find/redirected') do
      get('/en/categories/redirected')

      expect(response).to redirect_to('http://localhost:5000/en')
    end
  end
end

RSpec.describe 'Request that is redirected with extension', type: :request, features: [:redirects] do
  it 'redirects to specified location' do
    VCR.use_cassette('/en/core/cms/cms_api/find/redirected') do
      get('/default.aspx')

      expect(response).to redirect_to('http://localhost:5000/en')
    end
  end
end
