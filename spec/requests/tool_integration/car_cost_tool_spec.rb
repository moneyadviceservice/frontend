require 'car_cost_tool/wrappers/cap'

RSpec.describe 'Car Cost Tool', type: :request, vcr: true do
  %W[
    /en/tools/#{ToolMountPoint::CarCostTool::EN_ID}?checked=true
  ].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end

  context 'when the CAP HPI API is flapping' do
    it 'shows a friendly error message' do
      allow_any_instance_of(CarCostTool::Wrappers::Cap)
        .to receive(:get_cap_derivatives_as_array).and_raise(RestClient::InternalServerError)

      get '/en/tools/car-costs-calculator/api/derivatives?model=96743'

      expect(response).to be_ok
      expect(response.body).to include("temporarily unavailable")
    end
  end
end
