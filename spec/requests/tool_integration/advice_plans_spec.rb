RSpec.describe 'Advice Plans', type: :request, features: [:health_check, :registration] do
  %W(
    /en/tools/#{ToolMountPoint::AdvicePlans::EN_ID}
    /cy/tools/#{ToolMountPoint::AdvicePlans::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
