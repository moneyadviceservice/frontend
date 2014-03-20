require_relative '../spec_helper'

describe CookieNoticeAcceptancesController do
  describe 'POST create' do
    let(:locale) { 'en' }
    let(:referrer) { '/foo/bar' }
    let(:expected_cookie_name) { '_cookie_notice' }
    let(:expected_cookie_value) { 'y' }

    before { request.env["HTTP_REFERER"] = referrer }

    context 'the cookie' do
      let(:cookie_jar_chain) { double }
      let(:permanent_cookie_jar) { double }

      before do
        allow(cookie_jar_chain).to receive(:permanent) { permanent_cookie_jar }
        allow(controller).to receive(:cookies) { cookie_jar_chain }
      end

      it 'is set' do
        expect(permanent_cookie_jar).to receive(:[]=).with(expected_cookie_name, expected_cookie_value)
        post :create, locale: locale
      end
    end

    it 'redirects to the referring page' do
      post :create, locale: locale
      expect(response).to redirect_to(referrer)
    end
  end
end
