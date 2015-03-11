RSpec.describe RetirementsController, type: :controller, features: [:rio] do
  describe '#index' do
    xit 'responds with success' do
      get :index, locale: :en
      expect(response).to be_success
    end
  end
end
