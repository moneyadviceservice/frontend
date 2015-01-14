RSpec.describe 'Decision Trees', type: :request, features: [:health_check, :registration] do
  %W(
    /en/tools/#{ToolMountPoint::DecisionTrees::EN_ID}
    /cy/tools/#{ToolMountPoint::DecisionTrees::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end

  describe 'advice_plans_url' do
    it 'generates a url' do
      path = DecisionTrees.advice_plans_url.call('en', %(ap_1_1 ap_1_2))

      expect(path).to eql('/en/tools/health-check/plans/configure?codes[]=ap_1_1&codes[]=ap_1_2')
    end

  end
end
