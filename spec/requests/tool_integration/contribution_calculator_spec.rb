RSpec.describe ToolMountPoint::ContributionCalculator, type: :request do
  %W(
    /en/tools/#{ToolMountPoint::ContributionCalculator::EN_ID}
    /cy/tools/#{ToolMountPoint::ContributionCalculator::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
