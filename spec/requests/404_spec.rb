RSpec.describe '404 catachall', type: :request do
  before do
    @old_url = ENV['MONEY_HELPER_URL']
    ENV['MONEY_HELPER_URL'] = 'https://www.moneyhelper.org.uk'
  end
  after { ENV['MONEY_HELPER_URL'] = @old_url }

  context 'when page does not exist' do
    it 'redirects to the correct url' do
      get '/doesnotexist'
      expect(response).to redirect_to('https://www.moneyhelper.org.uk/en/404')
    end
  end

  context 'when nested page does not exist' do
    it 'redirects to the correct url' do
      get '/en/nothing/other'
      expect(response).to redirect_to('https://www.moneyhelper.org.uk/en/404')
    end
  end

  context 'when the url contains locale' do
    it 'redirects to a 404 page with the correct locale' do
      get '/cy/doesnotexist/other'
      expect(response).to redirect_to('https://www.moneyhelper.org.uk/cy/404')
    end
  end

  context 'when redirect in cms exists' do
    it 'redirects' do
      get '/our-debt-work'
      expect(response).to redirect_to(
        'http://localhost:5000/en/corporate/about-our-debt-work'
      )
    end
  end
end
