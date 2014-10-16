RSpec.describe 'Budget Planner', type: :request, features: [:budget_planner, :registration] do
  %W(
    /en/tools/#{ToolMountPoint::BudgetPlanner::EN_ID}
    /cy/tools/#{ToolMountPoint::BudgetPlanner::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
