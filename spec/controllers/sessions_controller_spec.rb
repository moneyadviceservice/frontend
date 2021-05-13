RSpec.describe SessionsController, type: :controller do
  describe '#create' do
    context 'when user has been updated' do
      let!(:user) { FactoryBot.create(:user) }
      let(:customer) { Core::Registry::Repository[:customer].customers.first }

      it 'removes custom session messages' do
        session['authentication_sign_in_page_title'] = 'hello'
        session['authentication_registration_title'] = 'hi'
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, user: { email: user.email, password: user.password }, locale: 'en'
        expect(session['authentication_sign_in_page_title']).to be_nil
        expect(session['authentication_registration_title']).to be_nil
      end
    end
  end

  describe '#new' do
    context 'non xhr requests' do
      it 'returns a 200' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        get :new, locale: :en

        expect(response).to be_success
      end
    end

    context 'xhr requests' do
      it 'returns a 501' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        xhr :get, :new, locale: :en

        expect(response.status).to eql(501)
      end
    end
  end
end
