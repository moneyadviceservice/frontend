RSpec.describe ToolMountPoint::Quiz, type: :request, features: [:quiz] do
  %W(
    /en/tools/#{ToolMountPoint::Quiz::EN_ID}
  ).each do |path|
    describe path do
      before { get path }

      specify { expect(response).to be_ok }
    end
  end
end
