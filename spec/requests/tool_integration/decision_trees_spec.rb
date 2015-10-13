RSpec.describe ToolMountPoint::DecisionTrees, type: :request, features: [:health_check, :registration] do
  %W(
    /en/tools/#{ToolMountPoint::DecisionTrees::HealthCheck::EN_ID}
    /cy/tools/#{ToolMountPoint::DecisionTrees::HealthCheck::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end

  describe 'alternate tool id' do
    context 'changing from english to welsh' do
      it 'retains english id for health check tool' do
        alternate_id = subject.alternate_tool_id('health-check-questions')
        expect(alternate_id).to eq('health-check-questions')
      end
    end
  end

  describe 'advice_plans_url' do
    it 'generates a url' do
      path = DecisionTrees.advice_plans_url.call('en', %w(ap_1_1 ap_1_2))

      expect(path).to eql('/en/tools/health-check/plans/configure?codes[]=ap_1_1&codes[]=ap_1_2')
    end
  end
end
