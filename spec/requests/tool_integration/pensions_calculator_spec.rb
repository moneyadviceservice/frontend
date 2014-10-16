RSpec.describe 'Pensions calculator', type: :request do
  %W(
    /en/tools/#{ToolMountPoint::PensionsCalculator::EN_ID}
    /cy/tools/#{ToolMountPoint::PensionsCalculator::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
