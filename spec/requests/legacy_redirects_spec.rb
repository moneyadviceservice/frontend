RSpec.describe 'Legacy redirects', type: :request do
  ['www.moneyadviceservice.org.uk', 'moneyadviceservice.org.uk'].each do |host|
    context "when requested from the legacy #{host} host" do
      it 'redirects tools to the correct landing page' do
        host! host

        get '/en/tools/budget-planner'
        expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/everyday-money/budgeting/use-our-budget-planner')

        # weird path from legacy campaigns
        get '///en/tools/money-navigator-tool'
        expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/money-troubles/coronavirus/use-our-money-navigator-tool')
      end
    end
  end

  describe 'partner-tools subdomain syndicated tools regression' do
    it 'does not redirect to the canonical when the host is syndicated' do
      host! 'partner-tools.moneyadviceservice.org.uk'

      get '/en/tools/budget-planner'

      # redirecting to the cookies message verifies it didn't redirect to MH
      expect(request).to redirect_to('/en/cookies_disabled?tool=budget-planner')
    end
  end
end
