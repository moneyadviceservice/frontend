RSpec.describe 'Universal Credit', type: :request do
  [ "/en/tools/#{ToolMountPoint::UniversalCredit::EN_ID}",
    "/cy/tools/#{ToolMountPoint::UniversalCredit::CY_ID}" ].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
