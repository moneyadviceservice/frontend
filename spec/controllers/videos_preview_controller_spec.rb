RSpec.describe VideosPreviewController, type: :controller do
  describe 'GET show' do
    context 'when preview exists for an video' do
      let(:video) { double(id: 'pensions-and-retirement-video') }

      it 'is successful' do
        get :show, id: video.id, locale: I18n.locale, page_type: 'videos'
        expect(response).to be_ok
      end
    end

    context 'when preview does not exist for an video' do
      let(:video) { double(id: 'does-not-exist') }

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: video.id, locale: I18n.locale, page_type: 'videos' }
          .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
