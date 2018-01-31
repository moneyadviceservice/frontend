RSpec.describe HomePagesPreviewController, type: :controller do
  describe 'GET show' do
    before do
      get :show, locale: :en, id: 'the-money-advice-service', page_type: 'home_pages'
    end

    specify do
      expect(response).to be_ok
    end

    it 'assigns HomePagePreview from MAS CMS API as resource' do
      expect(assigns(:resource)).to be_a(Mas::Cms::HomePagePreview)
    end
  end
end
