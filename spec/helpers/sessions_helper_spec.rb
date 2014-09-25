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
end
