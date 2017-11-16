RSpec.describe RegistrationsController, type: :controller do
  describe '#build_resource' do
    it 'sets user to have accepted terms and conditions' do
      allow(subject).to receive(:resource_class) { User }
      allow(subject).to receive(:resource_name) { 'user' }
      subject.send :build_resource, first_name: 'Phil'
      expect(subject.send(:resource).accept_terms_conditions).to be_truthy
    end
  end

  describe '#create' do
    let(:user_params) do
      {
        email: 'user@mail.com',
        first_name: 'peanut',
        post_code: 'EC1 9JU',
        password: 'Password123'
      }
    end

    before do
      @request.env['devise.mapping'] = Devise.mappings[:user]
      allow(subject).to receive(:sign_up_params) { user_params }
    end

    context 'with valid reCAPTCHA' do
      it 'saves a user' do
        allow(subject).to receive(:verify_recaptcha) { true }
        post :create, locale: :en
        expect(User.all.count).to eq 1
      end
    end

    context 'with invalid reCAPTCHA' do
      it 'does not save a user' do
        allow(subject).to receive(:verify_recaptcha) { false }
        post :create, locale: :en
        expect(User.all.count).to eq 0
      end
    end
  end
end
