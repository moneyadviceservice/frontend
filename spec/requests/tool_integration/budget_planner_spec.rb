RSpec.describe 'Budget Planner', type: :request do
  %W[/cy/tools/#{ToolMountPoint::BudgetPlanner::CY_ID}].each do |path|
    describe path do
      before do
        get path
      end

      specify { expect(response).to be_ok }
    end
  end

  context 'when syndicated with `noresize` but prior to cookie checks' do
    it 'does not include the frame resizer' do
      get '/en/tools/budget-planner', { noresize: true }

      expect(response).to be_redirect
      cookie_check_path = response.location
      get cookie_check_path

      expect(response).to be_redirect
      expect(response.location).to end_with('/en/tools/budget-planner/?checked=true&noresize=true')
    end
  end

  context 'when syndicated with `noresize`' do
    it 'does not include the frame resizer' do
      get '/en/tools/budget-planner', { checked: true, noresize: true }

      expect(response.body).not_to include('window.iframeResizer')
    end
  end

  context 'when syndicated normally' do
    it 'includes the frame resizer' do
      get '/en/tools/budget-planner?checked=true', {}

      expect(response.body).to include('window.iframeResizer')
    end
  end
end
