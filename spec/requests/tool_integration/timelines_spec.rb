RSpec.describe 'Timelines', type: :request, features: [:timelines] do
  %W(
    /en/tools/#{ToolMountPoint::Timelines::EN_ID}
    /cy/tools/#{ToolMountPoint::Timelines::CY_ID}
    /en/tools/#{ToolMountPoint::Timelines::EN_ID}/timeline?date[year]=2014&date[month]=8&date[day]=17
    /cy/tools/#{ToolMountPoint::Timelines::CY_ID}/timeline?date[year]=2014&date[month]=8&date[day]=17
  ).each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end
end
