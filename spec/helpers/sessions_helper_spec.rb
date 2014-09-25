require 'spec_helper'

RSpec.describe SessionsHelper do
  describe '#authentication_sign_in_page_title' do
    it 'returns the default translation ' do
      expect(helper.authentication_sign_in_page_title).to eql('Sign in')
    end

    context 'when overwritten by session' do
      it 'returns custom title' do
        session['authentication_sign_in_page_title'] = 'hello'
        expect(helper.authentication_sign_in_page_title).to eql('hello')
      end
    end
  end

  describe '#authentication_registration_title' do
    it 'returns the default translation ' do
      expect(helper.authentication_registration_title).to eql('Register to get more from your money')
    end

    context 'when overwritten by session' do
      it 'returns custom title' do
        session['authentication_registration_title'] = 'hi'
        expect(helper.authentication_registration_title).to eql('hi')
      end
    end
  end
end
