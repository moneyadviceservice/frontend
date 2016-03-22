RSpec.describe 'Debt Free Day Calculator', type: :request do
  %W(
    /en/tools/#{ToolMountPoint::DebtFreeDayCalculator::LoanCalculator::EN_ID}
    /cy/tools/#{ToolMountPoint::DebtFreeDayCalculator::LoanCalculator::CY_ID}
    /en/tools/#{ToolMountPoint::DebtFreeDayCalculator::CreditCardCalculator::EN_ID}
    /cy/tools/#{ToolMountPoint::DebtFreeDayCalculator::CreditCardCalculator::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
