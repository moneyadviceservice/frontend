RSpec.describe 'Redundancy pay calculator', type: :request, features: [:action_plans] do
  %W(
    /en/tools/#{ToolMountPoint::ActionPlans::EN_ID}
    /cy/tools/#{ToolMountPoint::ActionPlans::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
