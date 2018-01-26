RSpec.describe VideosController, type: :controller do
  describe 'GET show' do
    context 'when a video exists' do
      let(:video) { double(id: 'pensions-and-retirement-video') }

      it 'is successful' do
        get :show, id: video.id, locale: I18n.locale
        expect(response).to be_ok
      end
    end

    context 'when an video does not exist' do
      let(:video) { double(id: 'does-not-exist') }

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: video.id, locale: I18n.locale }
          .to raise_error(ActionController::RoutingError)
      end
    end

    context 'when the video has a redirect' do
      let(:video) { double(id: 'buy-to-let-mortgage-guide') }
      let(:redirect_location) do
        'http://localhost:5000/en/articles/buy-to-let-mortgages'
      end

      before { get :show, id: video.id, locale: I18n.locale }

      it { is_expected.to respond_with 301 }

      it 'redirects to expected location' do
        expect(response.location).to match(redirect_location)
      end
    end
  end
end
