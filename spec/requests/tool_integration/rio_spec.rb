RSpec.describe 'RIO', type: :request do
  %W(
    /en/#{EngineMountPoint::Rio::EN_ID}
    /cy/#{EngineMountPoint::Rio::CY_ID}
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
