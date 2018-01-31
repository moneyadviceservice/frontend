RSpec.describe HomeController, type: :controller do
  describe 'GET show' do
    before do
      get :show, locale: :en
    end

    specify do
      expect(response).to be_ok
    end

    it 'assigns home page from MAS CMS API as resource' do
      expect(assigns(:resource)).to be_a(Mas::Cms::HomePage)
    end
  end

  describe '#show_floating_chat?' do
    it 'shows on homepage' do
      expect(subject.show_floating_chat?).to be(true)
    end
  end
end
