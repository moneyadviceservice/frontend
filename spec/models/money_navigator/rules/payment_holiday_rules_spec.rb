
RSpec.describe MoneyNavigator::Questions, type: :model do
  include MoneyNavigator::Symbols


  context 'Rule test: ' do
    context 'Payment Holidays' do
      let(:section_code) { 'S2' }

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Mortgage" do
          let(:region) { rgn }
          let(:heading_code) { 'H1' }

          describe  "severe" do
            let(:content_prefix) {"holiday-mortgage-payment-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-mortgage-payment-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-mortgage-payment-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-mortgage-payment-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Personal loan #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H2' }

          describe  "severe" do
            let(:content_prefix) {"holiday-personal-loan-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-personal-loan-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-personal-loan-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-personal-loan-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end

      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Credit card #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H3' }

          describe  "severe" do
            let(:content_prefix) {"holiday-credit-card-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-credit-card-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-credit-card-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-credit-card-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Store card #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H4' }

          describe  "severe" do
            let(:content_prefix) {"holiday-store-card-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-store-card-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-store-card-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-store-card-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Car finance #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H5' }

          describe  "severe" do
            let(:content_prefix) {"holiday-car-finance-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-car-finance-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-car-finance-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-car-finance-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Buy now pay later #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H6' }

          describe  "severe" do
            let(:content_prefix) {"holiday-buy-now-pay-later-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-buy-now-pay-later-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-buy-now-pay-later-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-buy-now-pay-later-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Rent to own #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H7' }

          describe  "severe" do
            let(:content_prefix) {"holiday-rent-to-own-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-rent-to-own-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-rent-to-own-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-rent-to-own-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Payday loan  #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H8' }

          describe  "severe" do
            let(:content_prefix) {"holiday-payday-loan-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-payday-loan-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-payday-loan-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-payday-loan-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

      [[ 'england', 'wales', 'scotland', 'ni'] ].each do |rgn|
        context  "Pawnbroker  #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H9' }

          describe  "severe" do
            let(:content_prefix) {"holiday-pawnbroker-severe"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp worried" do
            let(:content_prefix) {"holiday-pawnbroker-temp-worried"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp normal" do
            let(:content_prefix) {"holiday-pawnbroker-temp-normal"}

            include_examples 'regionally valid content for regional rule'
          end

          describe  "temp no change" do
            let(:content_prefix) {"holiday-pawnbroker-no-change"}

            include_examples 'regionally valid content for regional rule'
          end
        end
      end

    end
  end
end
