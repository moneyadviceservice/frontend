RSpec.describe VideosPreviewController, type: :controller do
  describe 'GET show' do
    context 'when preview exists for an video' do
      let(:categories) { [] }
      let(:video) { Core::Video.new('test', title: 'test', body: 'body', categories: categories) }

      before do
        expect(Core::VideoPreviewer).to receive(:new) do
          double(Core::VideoPreviewer, call: video)
        end
      end

      it 'a successful get video request' do
        get :show, page_type: 'videos', id: video.id, locale: I18n.locale
        expect(response).to be_success
      end
    end

    context 'when preview does not exist for an video' do
      let(:video) { Core::Video.new('does-not-exist') }

      before { allow_any_instance_of(Core::VideoPreviewer).to receive(:call)
          .and_yield(video) }

      it 'raises an ActionController RoutingError' do
        expect { get :show, page_type: 'videos', id: video.id, locale: I18n.locale }
            .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
