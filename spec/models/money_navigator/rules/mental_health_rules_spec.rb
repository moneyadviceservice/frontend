
RSpec.describe MoneyNavigator::Questions, type: :model do
  include MoneyNavigator::Symbols

  context 'Rule test: ' do
    describe 'Mental health ' do
      let(:section_code) { 'S11' }
      let(:region) { %w[ni england wales scotland] }
      let(:heading_code) { 'H1' }
      let(:content_prefix) { 'mental-health' }

      include_examples 'regionally valid content for regional rule'
    end
  end
end
