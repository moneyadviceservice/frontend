RSpec.describe 'Budget Planner', type: :request do
  %W[
    /en/tools/#{ToolMountPoint::BudgetPlanner::EN_ID}
    /cy/tools/#{ToolMountPoint::BudgetPlanner::CY_ID}
  ].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end

  context 'when syndicated with `noresize`' do
    it 'does not include the frame resizer' do
      syndication_header = { 'X-Syndicated-Tool' => 'true' }

      get '/en/tools/budget-planner', { noresize: true }, syndication_header

      expect(response.body).not_to include('window.iframeResizer')
    end
  end

  context 'when syndicated normally' do
    it 'includes the frame resizer' do
      syndication_header = { 'X-Syndicated-Tool' => 'true' }

      get '/en/tools/budget-planner', {}, syndication_header

      expect(response.body).to include('window.iframeResizer')
    end
  end
end
