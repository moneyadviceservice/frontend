RSpec.describe 'Legacy redirects', type: :request do
  context 'when requested from the legacy www.moneyadviceservice.org.uk host' do
    it 'redirects tools to the correct landing page' do
      host! 'www.moneyadviceservice.org.uk'

      get '/en/tools/budget-planner'
      expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/everyday-money/budgeting/use-our-budget-planner')

      # weird path from legacy campaigns
      get '///en/tools/money-navigator-tool'
      expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/money-troubles/coronavirus/use-our-money-navigator-tool')
    end
  end

  context 'when requested from any other host' do
    it 'loads the tool' do
      get '/en/tools/budget-planner'
      expect(response).to be_ok

      get '///en/tools/money-navigator-tool'
      expect(response).to be_ok
    end
  end
end
