RSpec.describe ApplicationController, type: :controller do
  context 'when syndicated request' do
    controller do
      def index
        render inline: 'example', layout: true
      end
    end

    subject { get :index }

    it 'renders syndicated layout' do
      expect(subject).to render_template('layouts/syndicated')
    end

    it 'sets x frame options to ALLOWALL' do
      expect(subject.headers['X-Frame-Options']).to eql('ALLOWALL')
    end
  end

  describe '#show_floating_chat?' do
    it 'hides from all other pages' do
      expect(subject.show_floating_chat?).to be(false)
    end
  end

  context 'when cms resource not found' do
    controller do
      def index
        raise Mas::Cms::Errors::ResourceNotFound
      end
    end

    it 'raises not found' do
      expect { get :index }.to raise_error(ActionController::RoutingError)
    end
  end

  context 'when cms asset is a redirect' do
    controller do
      def index
        cms_response = Faraday::Response.new.finish(
          status: 302,
          response_headers: { location: '/test' }
        )
        raise Mas::Cms::HttpRedirect, cms_response
      end
    end

    it 'redirects to given url' do
      get :index
      expect(response.status).to eq(302)
      expect(response.location).to eq('http://test.host/test')
    end
  end
end
