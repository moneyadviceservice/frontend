RSpec.describe 'Car Cost Tool', type: :request do
  %W[/cy/tools/#{ToolMountPoint::CarCostTool::CY_ID}].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
