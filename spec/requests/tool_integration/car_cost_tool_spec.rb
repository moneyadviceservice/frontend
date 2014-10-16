RSpec.describe 'Car Cost Tool', type: :request, features: [:car_cost_tool] do
  %W(
    /en/tools/#{ToolMountPoint::CarCostTool::EN_ID}
    /cy/tools/#{ToolMountPoint::CarCostTool::CY_ID}
  ).each do |path|
    describe path do
      before do
        VCR.use_cassette('car_cost_tool/get_manufacturers') do
          get path
        end
      end

      specify { expect(response).to be_ok }
    end
  end
end
