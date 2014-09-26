require 'spec_helper'

RSpec.describe SessionsController, type: :controller do
  around :each do |example|
    Feature.run_with_activated(:sign_in) do
      Rails.application.reload_routes!
      Devise.regenerate_helpers!
      Devise.class_variable_set(:@@warden_configured, false)
      Devise.configure_warden!

      example.run
    end

    Rails.application.reload_routes!
    Devise.regenerate_helpers!
    Devise.class_variable_set(:@@warden_configured, false)
    Devise.configure_warden!
  end

  describe '#create' do
    context 'when user has been updated in CRM' do
      let!(:user){ FactoryGirl.create(:user) }
      let(:customer){ Core::Registry::Repository[:customer].customers.first }
      let(:new_first_name){ 'Philip' }

      before :each do
        customer[:first_name] = new_first_name
      end

      it 'persists this to the database' do
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, user: { email: 'phil@example.com', password: 'password' }, locale: 'en'

        expect(User.first.reload.first_name).to eql(new_first_name)
      end

      it 'removes custom session messages' do
        session['authentication_sign_in_page_title'] = 'hello'
        session['authentication_registration_title'] = 'hi'
        @request.env['devise.mapping'] = Devise.mappings[:user]
        post :create, user: { email: 'phil@example.com', password: 'password' }, locale: 'en'
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
