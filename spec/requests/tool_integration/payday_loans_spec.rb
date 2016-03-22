RSpec.describe 'Payday Loans', type: :request do
  %W(
    /en/#{ToolMountPoint::PaydayLoans::EN_ID}
    /cy/#{ToolMountPoint::PaydayLoans::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
