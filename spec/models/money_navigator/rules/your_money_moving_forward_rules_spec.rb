

RSpec.describe MoneyNavigator::Questions, type: :model do
  include MoneyNavigator::Symbols

  context 'Rule test: ' do
    context 'Your money moving forward ' do
      let(:section_code) { 'S3' }

      [%w[england wales scotland ni]].each do |rgn|
        let(:region) { rgn }

        describe 'severe income drop' do
          let(:heading_code) { 'H1' }
          let(:content_prefix) { 'back-on-track-severe' }

          include_examples 'regionally valid content for regional rule'
        end

        describe 'income drop' do
          let(:heading_code) { 'H2' }
          let(:content_prefix) { 'back-on-track' }

          include_examples 'regionally valid content for regional rule'
        end

        describe 'looking forward' do
          let(:heading_code) { 'H3' }
          let(:content_prefix) { 'looking-forward' }

          include_examples 'regionally valid content for regional rule'
        end
      end
    end
  end
end
