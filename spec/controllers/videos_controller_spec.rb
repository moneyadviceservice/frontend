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
      let(:video) { Core::Video.new('does-not-exist') }

      before do
        allow_any_instance_of(Core::VideoReader).to receive(:call).and_yield(video)
      end

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: 'does-not-exist', locale: I18n.locale }
            .to raise_error(ActionController::RoutingError)
      end
    end

    context 'when it is a redirect' do
      let(:redirect) do
        OpenStruct.new(redirect?: true,
                       location: 'https://example.com',
                       status: 301)
      end

      before do
        allow_any_instance_of(Core::VideoReader).to receive(:call).and_yield(redirect)
      end

      it 'redirects' do
        get :show, id: 'redirect', locale: I18n.locale
        expect(response).to redirect_to('https://example.com')
      end
    end
  end
end
