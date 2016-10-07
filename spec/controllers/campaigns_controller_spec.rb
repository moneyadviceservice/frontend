RSpec.describe CampaignsController, type: :controller do
  describe 'GET show' do
    let(:template) { double }

    %w(
       revealed-the-true-cost-of-buying-a-car
       how-to-look-ahead-when-buying-a-car
      ).each do |id|
      context 'if there are no custom template' do
        before { allow(Template).to receive(:new) { template } }

        it 'builds a campaign' do
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

    %w(
       borrowing-get-the-facts
       budgeting-to-get-through-january
       cmo
       coping-with-unexpected-bills
       csa
       free-debt-advice
       friends-life-lander
       get-set-for-summer
       interest-only-mortgages
       life-and-critical-illness
       paying-too-much-tax-on-savings
       save-gbp3-a-day-for-emergencies
       saving-for-a-holiday
       start-living-your-life-free-of-debt
       student-budgeting
       sw-saving-and-debt
       the-cost-of-caring
       the-true-cost-of-affording-a-home
       the-true-cost-of-borrowing
       uk-money-habits-study
       what-does-ma-think
       young-peoples-money-regrets
       ).each do |campaign_page_id|
      context 'if there are custom templates' do

        before :each do
          get campaign_page_id.underscore.to_sym, locale: I18n.locale
        end

        it 'renders the custom template' do
          expect(response).to render_template("campaigns/#{campaign_page_id.underscore}")
        end
      end
    end
  end
end
