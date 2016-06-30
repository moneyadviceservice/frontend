RSpec.describe CampaignsController, type: :controller do
  describe 'GET show' do
    let(:id) { 'revealed-the-true-cost-of-buying-a-car' }
    let(:template) { double }

    context 'if there are no custom template' do
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

    context 'if there are a custom template' do
      let(:campaign_page_id) { 'life-and-critical-illness' }
      subject { get :show, locale: I18n.locale, id: campaign_page_id }

      it 'renders the custom template' do
        expect(subject).to render_template("campaigns/#{campaign_page_id.underscore}")
      end
    end
  end
end
