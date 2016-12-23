RSpec.describe 'Car Cost Tool', type: :request do
  %W(
    /en/tools/#{ToolMountPoint::CarCostTool::EN_ID}
    /cy/tools/#{ToolMountPoint::CarCostTool::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
