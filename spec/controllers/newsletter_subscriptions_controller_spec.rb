RSpec.describe NewsletterSubscriptionsController, type: :controller do
  let(:subscriber) { instance_double(Core::NewsletterSubscriptionCreator) }

  before do
    allow_any_instance_of(Core::NewsletterSubscriptionCreator).to receive(:call) { result }
    allow(subscriber).to receive(:call) { result }
  end

  describe 'POST dismiss' do
    context 'not interested' do
      let(:email) { { email: 'clark.kent@example.com' } }
      let(:params) { { email: 'clark.kent@example.com', category: 'footer' } }
      let(:result) { true }

      it 'sets cookie' do
        post :dismiss, locale: 'en'

        expect(response.cookies['_cookie_dismiss_newsletter']).to eq 'hide'
      end

      it 'sets cookie to expire in a month' do
        post :dismiss, locale: 'en'

        expect(response.cookies['_cookie_dismiss_newsletter']).to eq 'hide'
      end
    end
  end

  describe 'XHR POST create' do
    context 'with valid email' do
      let(:email) { { email: 'clark.kent@example.com' } }
      let(:params) { { email: 'clark.kent@example.com', category: 'footer' } }
      let(:result) { true }

      it 'instantiates a subscriber' do
        expect(Core::NewsletterSubscriptionCreator).to receive(:new).with(email[:email]) { subscriber }
        xhr :post, :create, locale: I18n.locale, subscription: params
      end

      it 'assigns result to an instance variable' do
        xhr :post, :create, locale: I18n.locale, subscription: params

        expect(assigns(:success)).to eq(result)
      end

      it 'is successful' do
        xhr :post, :create, locale: I18n.locale, subscription: params

        expect(response).to be_ok
      end

      it 'renders the right template' do
        xhr :post, :create, locale: I18n.locale, subscription: params

        expect(response).to render_template('footer')
      end

      it 'sets session variable' do
        xhr :post, :create, locale: I18n.locale, subscription: params

        expect(session[:newsletter_subscribed]).to be_truthy
      end
    end
  end

  describe 'POST create' do
    before { request.env['HTTP_REFERER'] = 'example.com' }

    context 'with valid email' do
      let(:email) { { email: 'clark.kent@example.com' } }
      let(:params) { { email: 'clark.kent@example.com', category: 'footer' } }
      let(:result) { true }

      it 'sets cookie' do
        post :create, locale: I18n.locale, subscription: params
        expect(response.cookies['display_sticky_newsletter_form_cookie']).to eq 'hide'
      end

      it 'adds a flash success message' do
        post :create, locale: I18n.locale, subscription: params

        expect(request.flash[:success]).to include I18n.t('newsletter_subscriptions.success')
      end

      it 'sets session variable' do
        post :create, locale: I18n.locale, subscription: params

        expect(session[:newsletter_subscribed]).to be_truthy
      end

      it 'redirects back' do
        post :create, locale: I18n.locale, subscription: params

        expect(response).to redirect_to('example.com')
      end
    end

    context 'with invalid email' do
      let(:email) { { email: 'clark.kent@dailyplanet' } }
      let(:params) { { email: 'clark.kent@example.com', category: 'footer' } }
      let(:result) { false }

      it 'adds a flash error message' do
        post :create, locale: I18n.locale, subscription: params

        expect(request.flash[:error]).to include I18n.t('newsletter_subscriptions.error')
      end

      it 'does not set session variable' do
        post :create, locale: I18n.locale, subscription: params

        expect(session[:newsletter_subscribed]).to be_falsey
      end

      it 'redirects back' do
        post :create, locale: I18n.locale, subscription: params

        expect(response).to redirect_to('example.com')
      end
    end
  end
end
