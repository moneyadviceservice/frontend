RSpec.describe 'Legacy redirects', type: :request do
  describe 'legacy tools to new tools redirects' do
    before { host! 'partner-tools.moneyadviceservice.org.uk' }

    it 'redirects to the new mortgage calculator' do
      get '/en/tools/mortgage-calculator'

      expect(request).to redirect_to('https://tools.moneyhelper.org.uk/en/embed/mortgage-calculator')
    end
  end

  ['www.moneyadviceservice.org.uk', 'moneyadviceservice.org.uk'].each do |host|
    context "when requested from the legacy #{host} host" do
      it 'redirects tools to the correct landing page' do
        host! host

        get '/en/tools/budget-planner'
        expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/everyday-money/budgeting/budget-planner')

        # weird path from legacy campaigns
        get '///en/tools/money-navigator-tool'
        expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/money-troubles/coronavirus/money-navigator-tool')
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
        ['/cy/2019/10/10/sut-mae-maps-yn-cefnogi-gweithwyr/', '/cy/media-centre/press-releases'],
        ['/', '/en'],
        ['/cy/', '/cy'],
        ['/tag/gender', '/en/media-centre/press-releases'],
        ['/foi-publication-scheme', '/en/about-us/freedom-of-information-responses'],
        ['/2020/12/01/financial-education-provision-mapping-final-report-summary', '/en/publications/research/2020/financial-education-provision-mapping-final-report-summary'],
        ['/wp-content/uploads/2021/12/smarter-signposting-to-pensions-guidance.pdf', '/en/publications/research/2021/smarter-signposting-to-pensions-guidance'],
        ['/wp-content/uploads/2023/08/maps-pension-scams-uk-evidence-review.pdf', '/content/dam/maps-corporate/en/publications/research/2023/pensions-scams-uk-evidence-review-june-2023.pdf']
      ].each do |pair|
        it "redirects from '#{pair.first}' to '#{pair.last}'" do
          get pair.first

          expect(request).to redirect_to(%r{https://(www.)?maps.org.uk#{pair.last}})
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
