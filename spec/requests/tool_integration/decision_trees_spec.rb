RSpec.describe 'Decision Trees', type: :request, features: [:health_check, :workplace_pension_advice_tool, :registration] do
  %W(
    /en/tools/health-check-questions
    /cy/tools/health-check-questions
    /en/tools/workplace-pension-advice-tool
    /cy/tools/workplace-pension-advice-tool
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
      path = DecisionTrees.advice_plans_url.call('en', %w(ap_1_1 ap_1_2))

      expect(path).to eql('/en/tools/health-check/plans/configure?codes[]=ap_1_1&codes[]=ap_1_2')
    end

  end
end
