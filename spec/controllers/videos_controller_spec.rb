RSpec.describe VideosController, type: :controller do
  describe 'GET show' do
    context 'when a video does exist' do
      let(:categories) { [] }
      let(:video) { Core::Video.new('test', title: 'test', body: 'body', categories: categories) }

      before do
        allow(Core::VideoReader).to receive(:new) do
          double(Core::VideoReader, call: video)
        end
      end

      it 'is successful' do
        get :show, id: video.id, locale: I18n.locale
        expect(response).to be_ok
      end
    end

    context 'when an video does not exist' do
      let(:video_reader) { double(Core::VideoReader) }

      before do
        allow(Core::VideoReader).to receive(:new).and_return(video_reader)
        allow(video_reader).to receive(:call).and_yield
      end

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: 'does-not-exist', locale: I18n.locale }
            .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
