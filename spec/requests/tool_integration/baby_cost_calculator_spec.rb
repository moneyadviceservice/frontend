RSpec.describe ToolMountPoint::BabyCostCalculator, type: :request do
  %W(
    en
    cy
  ).each do |locale|
    context "locale #{locale}" do
      let (:path) { "/#{locale}/tools/" + "ToolMountPoint::BabyCostCalculator::#{locale.upcase}_ID".constantize }

      describe 'non-syndicated tool request' do
        before do
          get path
        end

        it "redirects to article baby cost calculator" do
          expect(response.status).to eq 301
          expect(response).to redirect_to article_path(I18n.t('controllers.baby_cost_calculator.deny_non_syndicates.article_id'), locale: locale)
        end
      end

      describe 'syndicated tool request' do
        before do
          get path, nil, { 'X-Syndicated-Tool' => true }
        end

        specify { expect(response).to be_ok }
      end
    end
  end
end
