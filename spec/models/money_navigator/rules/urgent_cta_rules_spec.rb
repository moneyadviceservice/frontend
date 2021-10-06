RSpec.describe MoneyNavigator::Questions, type: :model do
  include MoneyNavigator::Symbols

  context 'Rule test: ' do
    context 'Urgent action' do
      let(:section_code) { 'S1' }

      %w[england wales scotland ni].each do |country|
        describe "free debt advice #{country}" do
          let(:heading_code) { 'H1' }
          let(:region) { country }
          let(:content_prefix) { 'debt-advice' }

          include_examples 'nationally valid content for regional rule'
        end
      end

      # self employed debt advice
      [%w[england wales scotland]].each do |region|
        describe "Self employed debt advice #{region}" do
          let(:heading_code) { 'H3' }
          let(:region) { region }
          let(:content_prefix) { 'self-employed-debt-advice' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      ['ni'].each do |country|
        describe  "Self employed debt advice #{country}" do
          let(:heading_code) { 'H3' }
          let(:region) { country }
          let(:content_prefix) { 'self-employed-debt-advice' }

          include_examples 'nationally valid content for regional rule'
        end
      end

      # Pension content rule tests
      [%w[england wales scotland ni]].each do |region|
        describe "Pension advice  #{region}" do
          let(:heading_code) { 'H4' }
          let(:region) { region }
          let(:content_prefix) { 'urgent-pension-advice' }

          let(:model) do
            build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: region)
          end
          let(:url) { content_prefix.to_s }

          include_examples 'valid content'
        end
      end
    end
  end
end
