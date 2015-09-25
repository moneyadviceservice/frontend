RSpec.describe CookieDismissalController, type: :controller do
  describe 'POST create' do
    context 'not interested' do

      it 'sets cookie' do
        post :create, locale: 'en'

        expect(response.cookies['_cookie_dismiss_newsletter']).to eq 'hide'
      end

      it 'sets cookie to expire in a month' do
        post :create, locale: 'en'

        expect(response.cookies['_cookie_dismiss_newsletter']).to eq 'hide'
      end
    end
  end
end
