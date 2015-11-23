RSpec.describe SessionsController, type: :controller, features: [:reset_passwords] do
  describe '#create' do
    context 'when user has been updated in CRM' do
      let!(:user) { FactoryGirl.create(:user) }
      let(:customer) { Core::Registry::Repository[:customer].customers.first }
      let(:new_first_name) { 'Philip' }

      before :each do
        Core::Interactors::Customer::Creator.new(user).call
        customer[:first_name] = new_first_name
      end

      it 'adds job to persist this to the database' do
        @request.env['devise.mapping'] = Devise.mappings[:user]

        expect do
          post :create, user: { email: user.email, password: user.password }, locale: 'en'
        end.to change { Delayed::Job.where("handler like '%UpdateUser%'").count }.by(1)
      end

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
