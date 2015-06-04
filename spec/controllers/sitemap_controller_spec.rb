RSpec.describe SitemapController, type: :controller do
  describe 'GET robot' do
    it 'renders robot text file' do
      get :robots

      expect(response).to render_template 'sitemap/robots.text.erb'
    end
  end

  describe 'GET index' do
    it 'responds with 200' do
      get :index, locale: 'en'
      expect(response).to be_success
    end

    context 'when Welsh' do
      it 'responds with 200' do
        get :index, locale: 'cy'
        expect(response).to be_success
      end
    end
  end
end
