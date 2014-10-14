RSpec.describe 'Debt advice locator', type: :request do
  %W(
    /en/tools/#{ToolMountPoint::DebtAdviceLocator::EN_ID}
    /cy/tools/#{ToolMountPoint::DebtAdviceLocator::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
