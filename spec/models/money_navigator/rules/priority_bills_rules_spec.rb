
RSpec.describe MoneyNavigator::Questions, type: :model do
  include MoneyNavigator::Symbols

  context 'Rule test: ' do
    context 'Priority bills ' do
      let(:section_code) { 'S6' }

      describe 'Missed payment (low)' do
        let(:region) { %w[england wales scotland ni] }
        let(:heading_code) { 'H1' }
        let(:content_prefix) { 'missed-payment-low' }

        let(:model) do
          build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: region)
        end
        let(:url) { content_prefix.to_s }

        include_examples 'valid content'
      end

      context 'Tax ' do
        let(:heading_code) { 'H2' }
        describe '- Council (severe) ' do
          let(:region) { %w[england wales scotland] }
          let(:content_prefix) { 'council-tax-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Domestic rates (severe) ' do
          let(:region) { ['ni'] }
          let(:content_prefix) { 'domestic-rates-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Council (temp worried) ' do
          let(:region) { %w[england wales scotland] }
          let(:content_prefix) { 'council-tax-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Domestic rates (temp worried) ' do
          let(:region) { ['ni'] }
          let(:content_prefix) { 'domestic-rates-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Council (temp normal) ' do
          let(:region) { %w[england wales scotland] }
          let(:content_prefix) { 'council-tax-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Domestic rates (temp normal) ' do
          let(:region) { ['ni'] }
          let(:content_prefix) { 'domestic-rates-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Council (no change) ' do
          let(:region) { %w[england wales scotland] }
          let(:content_prefix) { 'council-tax-no-change' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '- Domestic rates (no change) ' do
          let(:region) { ['ni'] }
          let(:content_prefix) { 'domestic-rates-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'Gas and Electricity ' do
        let(:heading_code) { 'H3' }
        let(:region) { %w[ni england wales scotland] }

        describe '(severe) ' do
          let(:content_prefix) { 'gas-electricity-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:content_prefix) { 'gas-electricity-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:content_prefix) { 'gas-electricity-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no change) ' do
          let(:content_prefix) { 'gas-electricity-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'dmp/HMRC ' do
        let(:heading_code) { 'H4' }
        let(:region) { %w[ni england wales scotland] }

        describe '(severe) ' do
          let(:content_prefix) { 'dmp-hmrc-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:content_prefix) { 'dmp-hmrc-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:content_prefix) { 'dmp-hmrc-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no change) ' do
          let(:content_prefix) { 'dmp-hmrc-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'tv license ' do
        let(:heading_code) { 'H5' }
        let(:region) { %w[ni england wales scotland] }

        describe '(severe) ' do
          let(:content_prefix) { 'tv-licence-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:content_prefix) { 'tv-licence-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:content_prefix) { 'tv-licence-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no change) ' do
          let(:content_prefix) { 'tv-licence-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'Income tax bill' do
        let(:heading_code) { 'H6' }
        let(:region) { %w[ni england wales scotland] }

        describe '(severe) ' do
          let(:content_prefix) { 'income-tax-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:content_prefix) { 'income-tax-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:content_prefix) { 'income-tax-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no change) ' do
          let(:content_prefix) { 'income-tax-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'Child maintenance ' do
        let(:heading_code) { 'H7' }
        let(:region) { %w[ni england wales scotland] }

        describe '(severe) ' do
          let(:content_prefix) { 'child-maintenance-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:content_prefix) { 'child-maintenance-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:content_prefix) { 'child-maintenance-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no change) ' do
          let(:content_prefix) { 'child-maintenance-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'Court fines ' do
        let(:heading_code) { 'H8' }
        describe '(severe) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'court-fines-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(severe ni) ' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'court-fines-severe' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(severe scotland) ' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'court-fines-severe' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'court-fines-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried ni) ' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'court-fines-temp-worried' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp worried scotland) ' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'court-fines-temp-worried' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'court-fines-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal ni) ', skip: '[TP-11529] Awaiting confirmation of behaviour from business' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'court-fines-temp-normal' }

          include_examples 'nationally valid content for national rule'
        end

        describe '(temp normal scotland) ', skip: '[TP-11529] Awaiting confirmation of behaviour from business' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'court-fines-temp-normal' }

          include_examples 'nationally valid content for national rule'
        end

        describe '(no-change) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'court-fines-no-change' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp no-change ni) ', skip: '[TP-11529] Awaiting confirmation of behaviour from business' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'court-fines-no-change' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp no-change scotland) ', skip: '[TP-11529] Awaiting confirmation of behaviour from business' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'court-fines-no-change' }

          include_examples 'nationally valid content for regional rule'
        end
      end

      context 'Hire purchace agreements' do
        let(:heading_code) { 'H9' }
        let(:region) { %w[ni england wales scotland] }

        describe '(severe) ' do
          let(:content_prefix) { 'hire-purchase-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:content_prefix) { 'hire-purchase-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:content_prefix) { 'hire-purchase-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no change) ' do
          let(:content_prefix) { 'hire-purchase-no-change' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      context 'Car parking fines ' do
        let(:heading_code) { 'H10' }
        describe '(severe) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'car-park-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(severe) ' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'car-park-severe' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(severe) ' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'car-park-severe' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp worried) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'car-park-temp-worried' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp-worried) ' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'car-park-temp-worried' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp-worried) ' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'car-park-temp-worried' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(temp normal) ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'car-park-temp-normal' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(temp-normal ni) ' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'car-park-temp-normal' }

          include_examples 'nationally valid content for national rule'
        end

        describe '(temp-normal scotland) ' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'car-park-temp-normal' }

          include_examples 'nationally valid content for national rule'
        end

        describe '(no change) england and wales ' do
          let(:region) { %w[england wales] }
          let(:content_prefix) { 'car-park-no-change' }

          include_examples 'regionally valid content for regional rule'
        end

        describe '(no-change) northern ireland ' do
          let(:region) { 'ni' }
          let(:content_prefix) { 'car-park-no-change' }

          include_examples 'nationally valid content for regional rule'
        end

        describe '(no-change) scotland ' do
          let(:region) { 'scotland' }
          let(:content_prefix) { 'car-park-no-change' }

          include_examples 'nationally valid content for regional rule'
        end
      end
    end
  end
end
