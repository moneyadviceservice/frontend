require 'core/interactors/newsletter/subscriber'
require 'core/entities/newsletter/subscription'

module Newsletter
  RSpec.describe SubscriptionsController, :type => :controller do
    let(:subscription) { instance_double(Core::Newsletter::Subscription, status: double, message: '') }
    let(:subscriber) { instance_double(Core::Newsletter::Subscriber, email: email) }

    before do
      allow_any_instance_of(Core::Newsletter::Subscriber).to receive(:call) { subscription }
      allow(subscriber).to receive(:call) { subscription }
    end

    describe 'XHR POST create' do
      context 'with valid email' do
        let(:email) { { email: 'clark.kent@example.com' } }

        it 'instantiates a subscriber' do
          expect(Core::Newsletter::Subscriber).to receive(:new).with(email) { subscriber }

          xhr :post, :create, locale: I18n.locale, subscription: email
        end

        it 'assigns subscription to an instance variable' do
          xhr :post, :create, locale: I18n.locale, subscription: email

          expect(assigns(:subscription)).to eq(subscription)
        end

        it 'defines subscription method to access the decorated instance variable' do
          xhr :post, :create, locale: I18n.locale, subscription: email

          expect(subject.subscription).to be_decorated_with SubscriptionDecorator
        end

        it 'is successful' do
          xhr :post, :create, locale: I18n.locale, subscription: email

          expect(response).to be_ok
        end

        it 'renders the right template' do
          xhr :post, :create, locale: I18n.locale, subscription: email

          expect(response).to render_template('show')
        end
      end
    end

    describe 'POST create' do
      before { request.env['HTTP_REFERER'] = 'example.com' }

      context 'with valid email' do
        before { allow(subscription).to receive(:success?) { true } }

        let(:email) { { email: 'clark.kent@example.com' } }

        it 'adds a flash success message' do
          allow(subscription).to receive(:status).and_return(:success)

          post :create, locale: I18n.locale, subscription: email

          expect(request.flash[:success]).to include I18n.t('newsletter.subscription.success')
        end

        it 'redirects back' do
          post :create, locale: I18n.locale, subscription: email

          expect(response).to redirect_to('example.com')
        end
      end

      context 'with invalid email' do
        before { allow(subscription).to receive(:success?) { false } }

        let(:email) { { email: 'clark.kent@dailyplanet' } }

        it 'adds a flash error message' do
          allow(subscription).to receive(:status).and_return(:error)

          post :create, locale: I18n.locale, subscription: email

          expect(request.flash[:error]).to include I18n.t('newsletter.subscription.error')
        end

        it 'redirects back' do
          post :create, locale: I18n.locale, subscription: email

          expect(response).to redirect_to('example.com')
        end
      end
    end
  end
end
