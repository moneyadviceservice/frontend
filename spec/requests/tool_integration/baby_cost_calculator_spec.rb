RSpec.describe ToolMountPoint::BabyCostCalculator, type: :request, features: [:baby_cost_calculator] do 
  %W(
    /en/tools/#{ToolMountPoint::BabyCostCalculator::EN_ID}
    /cy/tools/#{ToolMountPoint::BabyCostCalculator::CY_ID}
  ).each do |path|
    describe path do 
      before do 
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
