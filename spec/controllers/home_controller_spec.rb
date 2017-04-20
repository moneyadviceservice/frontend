RSpec.describe HomeController, type: :controller do
  describe 'GET show' do
    specify do
      get :show, locale: :en

      expect(response).to be_ok
    end
  end
  
  describe '#show_floating_chat?' do
    it 'shows on homepage' do
      expect(subject.show_floating_chat?).to be(true)
    end
  end
end
