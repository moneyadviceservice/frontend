RSpec.describe 'Request we have no implementation for', type: :request do
  it 'raises routing error' do
    expect { get('/unsupported') }.to raise_error(ActionController::RoutingError, 'Not Found')
  end
end

RSpec.describe 'Request that is redirected', type: :request do
  it 'redirects to specified location' do
    VCR.use_cassette('/en/core/repository/categories/cms/find/redirected') do
      get('/en/categories/redirected')

      expect(response).to redirect_to('http://localhost:5000/en')
    end
  end
end

RSpec.describe 'Request that is redirected with extension', type: :request do
  it 'redirects to specified location' do
    VCR.use_cassette('/en/core/cms/cms_api/find/redirected') do
      get('/default.aspx')

      expect(response).to redirect_to('http://localhost:5000/en')
    end
  end
end
