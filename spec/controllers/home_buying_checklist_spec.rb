RSpec.describe HomeBuyingChecklistController, type: :controller do
  describe '#show' do
    it 'responds with success and renders correct template' do
      get :show, locale: :en
      expect(response.status).to eq(200)
      expect(response).to render_template :show
    end
  end

  describe 'display_skip_to_main_navigation' do
    it 'should return false' do
      expect(controller.display_skip_to_main_navigation?).to be false
    end
  end
end
