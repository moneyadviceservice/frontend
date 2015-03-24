RSpec.describe 'CutbackCalculator', type: :request, features: [:cutback_calculator] do 
  [ "en/tools/#{ToolMountPoint::CutbackCalculator::EN_ID}", 
    "cy/tools/#{ToolMountPoint::CutbackCalculator::CY_ID}"
  ].each do |path|
    describe path do 
      before do 
        get path
      end 

      specify { expect(response).to be_ok }
    end
  end
end
