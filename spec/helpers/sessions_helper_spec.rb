RSpec.describe SessionsHelper, type: :helper do
  describe '#authentication_sign_in_title' do
    it 'returns the default translation ' do
      expect(helper.authentication_sign_in_title).to eql('Sign in')
    end

    context 'when overwritten by session' do
      it 'returns custom title' do
        I18n.backend.store_translations :en, test: { title: 'hello' }
        session['authentication_sign_in_title'] = 'test.title'
        expect(helper.authentication_sign_in_title).to eql('hello')
      end
    end
  end

  describe '#authentication_registration_title' do
    it 'returns the default translation ' do
      expect(helper.authentication_registration_title).to eql('Get more from your money in 30 seconds')
    end

    context 'when overwritten by session' do
      it 'returns custom title' do
        I18n.backend.store_translations :en, test: { title: 'hi' }
        session['authentication_registration_title'] = 'test.title'
        expect(helper.authentication_registration_title).to eql('hi')
      end
    end
  end

  describe '#authentication_session_set?' do
    it 'returns false when registration title does not exist in session' do
      expect(helper.authentication_session_set?).to be_falsey
    end

    context 'when session title is set' do
      it 'returns true' do
        session['authentication_registration_title'] = 'test.title'
        expect(helper.authentication_session_set?).to be_truthy
      end
    end
  end
end


