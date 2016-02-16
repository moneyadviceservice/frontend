RSpec.describe ToolMountPoint::Quiz, type: :request do
  %W(
    /en/tools/#{ToolMountPoint::Quiz::EN_ID}/users/sign_in
    /cy/tools/#{ToolMountPoint::Quiz::CY_ID}/users/sign_in
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
