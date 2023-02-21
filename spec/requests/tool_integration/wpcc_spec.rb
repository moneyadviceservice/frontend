RSpec.describe 'Wpcc', type: :request do
  ["/cy/tools/#{ToolMountPoint::Wpcc::CY_ID}"].each do |path|
    describe path do
      before do
        get(path)
      end

      specify { expect(response).to be_ok }
    end
  end
end
