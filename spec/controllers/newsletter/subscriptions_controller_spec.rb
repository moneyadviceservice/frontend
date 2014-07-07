module Newsletter
  RSpec.describe SubscriptionsController, :type => :controller do
    let(:subscriber) { instance_double(Core::Newsletter::Subscriber, email: email) }

    before do
      allow_any_instance_of(Core::Newsletter::Subscriber).to receive(:call) { result }
      allow(subscriber).to receive(:call) { result }
    end

    describe 'XHR POST create' do
      context 'with valid email' do
        let(:email)  { { email: 'clark.kent@example.com' } }
        let(:result) { true }

        it 'instantiates a subscriber' do
          expect(Core::Newsletter::Subscriber).to receive(:new).with(email) { subscriber }

          xhr :post, :create, locale: I18n.locale, subscription: email
        end

        it 'assigns result to an instance variable' do
          xhr :post, :create, locale: I18n.locale, subscription: email

          expect(assigns(:success)).to eq(result)
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
        let(:email)  { { email: 'clark.kent@example.com' } }
        let(:result) { true }

        it 'adds a flash success message' do
          post :create, locale: I18n.locale, subscription: email

          expect(request.flash[:success]).to include I18n.t('newsletter.subscription.success')
        end

        it 'redirects back' do
          post :create, locale: I18n.locale, subscription: email

          expect(response).to redirect_to('example.com')
        end
      end

      context 'with invalid email' do
        let(:email)  { { email: 'clark.kent@dailyplanet' } }
        let(:result) { false }

        it 'adds a flash error message' do
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
