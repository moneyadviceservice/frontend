RSpec.describe RedirectersController, type: :controller do
  describe 'GET en/tools/redirect_to/:tool_name' do
    context 'when tool exists' do
      it 'sets an initial cookie and redirects' do
        get :redirect, { locale: 'en', tool_name: 'debt_advice_locator' }

        expect(response.location).to eq(
          'https://www.moneyhelper.org.uk/en/money-troubles/dealing-with-debt/debt-advice-locator'
        )
        expect(response.cookies['safari_initial_cookie']).to eq(
          'Safari initial cookie'
        )
      end
    end

    context 'when tool does not exists' do
      it 'raises a 404, but still sets the cookie for efficiency' do
        expect {
          get :redirect,
              { locale: 'en', tool_name: 'something-completely-wrong' }
        }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
