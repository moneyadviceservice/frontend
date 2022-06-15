RSpec.describe 'Request we have no implementation for', type: :request do
  before do
    @old_url = ENV['MONEY_HELPER_URL']
    ENV['MONEY_HELPER_URL'] = 'https://www.moneyhelper.org.uk'
  end
  after { ENV['MONEY_HELPER_URL'] = @old_url }

  it 'raises routing error' do
    get('/unsupported')
   
    expect(response).to redirect_to('https://www.moneyhelper.org.uk/en/404')
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
