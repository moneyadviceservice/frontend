RSpec.describe 'Legacy redirects', type: :request do
  describe 'legacy tools to new tools redirects' do
    before { host! 'partner-tools.moneyadviceservice.org.uk' }

    it 'redirects to the new mortgage affordability calculator' do
      get '/en/tools/house-buying/mortgage-affordability-calculator'

      expect(request).to redirect_to('https://mortgage-affordability-calculator.moneyhelper.org.uk/en/annual-income?isEmbedded=true')
    end

    it 'redirects to the new redundancy pay calculator' do
      get '/en/tools/redundancy-pay-calculator'
      expect(request).to redirect_to('https://redundancy-pay-calculator.moneyhelper.org.uk/en?isEmbedded=true')

      get '/cy/tools/cyfrifiannell-tal-diswyddo'
      expect(request).to redirect_to('https://redundancy-pay-calculator.moneyhelper.org.uk/cy?isEmbedded=true')
    end

    it 'redirects to the new budget planner tool' do
      get '/en/tools/budget-planner'

      expect(request).to redirect_to('https://budget-planner.moneyhelper.org.uk/en/income?isEmbedded=true')
    end

    it 'redirects to the new baby money tool' do
      get '/en/tools/baby-money-timeline'

      expect(request).to redirect_to('https://tool.moneyhelper.org.uk/en/baby-money-timeline?isEmbedded=true')
    end

    it 'redirects to the new debt advice locator' do
      get '/en/tools/debt-advice-locator'

      expect(request).to redirect_to('https://debt-advice-locator.moneyhelper.org.uk/en/question-1?isEmbedded=true')
    end

    it 'redirects to the new mortgage calculator' do
      get '/en/tools/mortgage-calculator'

      expect(request).to redirect_to('https://mortgage-calculator.moneyhelper.org.uk/en?isEmbedded=true')
    end

    it 'redirects to the new stamp duty calculator' do
      get '/en/tools/house-buying/stamp-duty-calculator'

      expect(request).to redirect_to('https://stamp-duty-calculator.moneyhelper.org.uk/en/sdlt?isEmbedded=true')
    end

    it 'redirects to the new LBTT calculator' do
      get '/en/tools/house-buying/land-and-buildings-transaction-tax-calculator-scotland'

      expect(request).to redirect_to('https://stamp-duty-calculator.moneyhelper.org.uk/en/lbtt?isEmbedded=true')
    end
  end

  ['www.moneyadviceservice.org.uk', 'moneyadviceservice.org.uk'].each do |host|
    context "when requested from the legacy #{host} host" do
      it 'redirects tools to the correct landing page' do
        host! host

        # weird path from legacy campaigns
        get '///en/tools/money-navigator-tool'
        expect(request).to redirect_to('https://www.moneyhelper.org.uk/en/money-troubles/coronavirus/money-navigator-tool')
      end
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
