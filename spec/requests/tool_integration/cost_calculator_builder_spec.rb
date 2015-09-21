RSpec.describe 'Cost Calculator Builder', type: :request, features: [:cost_calculator_builder] do
  %W(
    /en/#{EngineMountPoint::CostCalculatorBuilder::EN_ID}/admin/calculators
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
