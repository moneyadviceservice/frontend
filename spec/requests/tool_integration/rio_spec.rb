RSpec.describe 'RIO', type: :request, features: [:rio] do
  %W(
    /en/tools/#{ToolMountPoint::Rio::EN_ID}
    /cy/tools/#{ToolMountPoint::Rio::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
