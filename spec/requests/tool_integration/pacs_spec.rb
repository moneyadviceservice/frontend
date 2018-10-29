RSpec.describe 'PACS', type: :request do
  ["/en/tools/#{ToolMountPoint::Pacs::EN_ID}",
   "/cy/tools/#{ToolMountPoint::Pacs::CY_ID}"].each do |path|
    describe path do
      before do
        get(path)
      end

      specify { expect(response).to be_ok }
    end
  end
end
