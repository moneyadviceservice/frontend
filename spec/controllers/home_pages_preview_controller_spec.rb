RSpec.describe HomePagesPreviewController, type: :controller do
  describe 'GET show' do
    specify do
      get :show, locale: :en, id: 'the-money-advice-service', page_type: 'home_pages'

      expect(response).to be_ok
    end
  end
end
