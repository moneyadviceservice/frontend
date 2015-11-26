RSpec.describe ToolMountPoint::BabyCostCalculator, type: :request do 
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
