RSpec.describe VideosController, type: :controller do
  describe 'GET show' do
    context 'when a video does exist' do
      let(:categories) { [] }
      let(:video) { Core::Video.new('test', title: 'test', body: 'body', categories: categories) }

      before do
        expect(Core::VideoReader).to receive(:new) do
          double(Core::VideoReader, call: video)
        end
      end

      it 'is successful' do
        get :show, id: video.id, locale: I18n.locale
        expect(response).to be_ok
      end
    end

    context 'when an video does not exist' do
      before { allow_any_instance_of(Core::VideoReader).to receive(:call).and_yield }

      it 'raises an ActionController RoutingError' do
        expect { get :show, id: 'does-not-exist', locale: I18n.locale }
            .to raise_error(ActionController::RoutingError)
      end
    end
  end
end
