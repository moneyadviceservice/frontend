
RSpec.describe MoneyNavigator::Questions, type: :model do
  include MoneyNavigator::Symbols

  context 'Rule test: ' do
    context 'Housing costs ' do
      let(:section_code) { 'S5' }

      describe 'Missed rent mortgage ' do
        let(:region) { %w[england wales scotland ni] }
        let(:heading_code) { 'H1' }
        let(:content_prefix) { 'missed-rent-mortgage-low' }

        let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: region) }
        let(:url) { content_prefix.to_s }

        include_examples 'valid content'
      end

      %w[england wales scotland ni].each do |rgn|
        describe "Worried rent (private) #{rgn} " do
          let(:region) { rgn }
          let(:heading_code) { 'H2' }
          let(:content_prefix) { 'rent-private' }

          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: [region]) }
          let(:url) { "coronavirus-#{content_prefix}-#{rgn}" }

          include_examples 'valid content'
        end
      end

      %w[england wales scotland ni].each do |rgn|
        describe "Worried rent (social) #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H3' }
          let(:content_prefix) { 'rent-social' }

          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: [region]) }
          let(:url) { "coronavirus-#{content_prefix}-#{rgn}" }

          include_examples 'valid content'
        end
      end

      [['england'], ['ni']].each do |rgn|
        describe "Worried mortgage #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H4' }
          let(:content_prefix) { 'mortgage-payments' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      %w[wales scotland].each do |rgn|
        describe "Worried mortgage #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H4' }
          let(:content_prefix) { 'mortgage-payments' }

          include_examples 'nationally valid content for regional rule'
        end
      end

      %w[england wales scotland ni].each do |rgn|
        describe "Behind rent #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H5' }
          let(:content_prefix) { 'behind-rent' }

          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: [region]) }
          let(:url) { "coronavirus-#{content_prefix}-#{rgn}" }

          include_examples 'valid content'
        end
      end

      [['england'], ['ni']].each do |rgn|
        describe "Behind mortgage #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H6' }
          let(:content_prefix) { 'behind-mortgage' }

          include_examples 'regionally valid content for regional rule'
        end
      end

      %w[wales scotland].each do |rgn|
        describe "Behind mortgage #{rgn}" do
          let(:region) { rgn }
          let(:heading_code) { 'H6' }
          let(:content_prefix) { 'behind-mortgage' }

          let(:model) { build("#{section_code}_#{heading_code}_#{content_prefix}".tr('-', '_').to_sym, target_region: [region]) }
          let(:url) { "coronavirus-#{content_prefix}-#{rgn}" }

          include_examples 'valid content'
        end
      end
    end
  end
end
