RSpec.describe 'Savings Calculator', type: :request do
  %W(
    /en/tools/#{ToolMountPoint::SavingsCalculator::EN_ID}
    /cy/tools/#{ToolMountPoint::SavingsCalculator::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
