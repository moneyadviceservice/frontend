RSpec.describe 'Debt Mental Health', type: :request, features: [:debt_and_mental_health] do
  %W(
    /en/#{ToolMountPoint::DebtAndMentalHealth::EN_ID}/preview
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
