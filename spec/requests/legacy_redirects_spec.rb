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

  ['www.moneyandpensionsservice.org.uk', 'moneyandpensionsservice.org.uk'].each do |host|
    context "when requested from the legacy #{host} host" do
      before { host! host }

      [
        ['/cy/2019/10/10/sut-mae-maps-yn-cefnogi-gweithwyr/', '/cy/media'],
        ['/', '/en'],
        ['/cy/', '/cy'],
        ['/tag/gender', '/en/media-centre'],
        ['/foi-publication-scheme', '/en/about-us/freedom-of-information-responses'],
        ['/2020/12/01/financial-education-provision-mapping-final-report-summary', '/en/publications/research/2020/financial-education-provision-mapping-final-report-summary']
      ].each do |pair|
        it "redirects from '#{pair.first}' to '#{pair.last}'" do
          get pair.first

          expect(request).to redirect_to("https://www.maps.org.uk#{pair.last}")
        end
      end
    end
  end

  describe 'moneyadviser.moneyhelper.org.uk/* wildcard' do
    it 'redirects to the correct FAQ' do
      host! 'moneyadviser.moneyhelper.org.uk'

      get '/'

      expect(request).to redirect_to('https://adviser.moneyhelper.org.uk/en/faqs-independent-confidential-impartial-money-advice')
    end
  end
end
