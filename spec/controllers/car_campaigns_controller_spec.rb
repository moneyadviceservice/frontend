RSpec.describe CarCampaignsController, :type => :controller do
  describe 'GET show' do
    it 'is successful' do
      get :show, locale: I18n.locale

      expect(response).to be_ok
    end
  end
end
