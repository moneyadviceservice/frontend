RSpec.describe 'RIO', type: :request, features: [:action_plans] do
  %W(
    /en/#{EngineMountPoint::ActionPlans::EN_ID}/redundancy
    /cy/#{EngineMountPoint::ActionPlans::CY_ID}/redundancy
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
