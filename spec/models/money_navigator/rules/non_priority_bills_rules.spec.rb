
RSpec.describe Questions, type: :model do
  include MoneyNavigator::Symbols

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule test: ' do
    context 'non-Priority bills ' do
      let(:section_code) { 'S7' }

      context "Personal loan " do
        let(:heading_code) { 'H1' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'personal-loan-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'personal-loan-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'personal-loan-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'personal-loan-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Water bill " do
        let(:heading_code) { 'H2' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'water-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'water-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'water-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'water-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Mobile phone, TV or Broadband " do
        let(:heading_code) { 'H3' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'mobile-tv-broadband-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'mobile-tv-broadband-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'mobile-tv-broadband-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'mobile-tv-broadband-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Credit cardi " do
        let(:heading_code) { 'H4' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'credit-card-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'credit-card-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'credit-card-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'credit-card-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Store card " do
        let(:heading_code) { 'H5' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'store-card-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'store-card-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'store-card-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'store-card-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Car finance " do
        let(:heading_code) { 'H6' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'car-finance-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'car-finance-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'car-finance-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'car-finance-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Buy now pay later " do
        let(:heading_code) { 'H7' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'buy-now-pay-later-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'buy-now-pay-later-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'buy-now-pay-later-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'buy-now-pay-later-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Rent to own " do
        let(:heading_code) { 'H8' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'rent-to-own-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'rent-to-own-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'rent-to-own-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'rent-to-own-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Payday loan " do
        let(:heading_code) { 'H9' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'payday-loan-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'payday-loan-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'payday-loan-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'payday-loan-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Pawnbroker " do
        let(:heading_code) { 'H10' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'pawnbroker-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'pawnbroker-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'pawnbroker-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'pawnbroker-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

      context "Family and friends " do
        let(:heading_code) { 'H11' }
        let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

        describe  "(severe) " do
          let(:content_prefix) {'friends-family-severe'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp worried) " do
          let(:content_prefix) {'friends-family-temp-worried'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(temp normal) " do
          let(:content_prefix) {'friends-family-temp-normal'}

          include_examples 'regionally valid content for regional rule'
        end

        describe  "(no change) " do
          let(:content_prefix) {'friends-family-no-change'}

          include_examples 'regionally valid content for regional rule'
        end
      end

    end
  end
end
