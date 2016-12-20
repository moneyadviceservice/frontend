RSpec.describe 'Request we have no implementation for', type: :request do
  it 'raises routing error' do
    expect { get('/unsupported') }.to raise_error(ActionController::RoutingError, 'Not Found')
  end
end

RSpec.describe 'Request that is redirected', type: :request do
  it 'redirects to specified location' do
    get('/en/categories/types-of-retirement-income')

    expect(response).to redirect_to('http://localhost:5000/en/categories/using-your-pension-pot')
  end
end

RSpec.describe 'Request that is redirected with extension', type: :request do
  it 'redirects to specified location' do
    get('/contact.aspx')

    expect(response).to redirect_to('http://localhost:5000/en/corporate/contact-us')
  end
end
