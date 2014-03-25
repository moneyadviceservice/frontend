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

        expect(permanent_cookie_jar).to receive(:[]=).with(expected_cookie_name, expected_cookie_value)
      end

      it 'is set via a standard POST' do
        post :create, locale: locale
      end

      it 'is set via an xhr' do
        xhr :post, :create, locale: locale
      end
    end

    context 'the response' do
      context 'when a standard POST' do
        it 'redirects to the referring page' do
          post :create, locale: locale
          expect(response).to redirect_to(referrer)
        end
      end

      context 'when an XHR post' do
        before { xhr :post, :create, locale: locale }

        it 'returns a 200' do
          expect(response).to be_success
        end

        it 'returns an empty body' do
          expect(response.body).to be_blank
        end
      end
    end
  end
end
