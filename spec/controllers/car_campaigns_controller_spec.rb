RSpec.describe CarCampaignsController, :type => :controller do
  describe 'GET show' do
    let(:id) { 'revealed-the-true-cost-of-buying-a-car' }
    let(:template) { double }

    before { allow(Template).to receive(:new) { template } }

    it 'builds a campaing' do
      expect(template).to receive(:build_campaign).with(id)

      get :show, locale: I18n.locale, id: id
    end

    it 'is successful' do
      allow(template).to receive(:build_campaign) { double }

      get :show, locale: I18n.locale, id: id

      expect(response).to be_ok
    end
  end
end
