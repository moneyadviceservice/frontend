
RSpec.describe Questions, type: :model do
  include MoneyNavigator::Symbols


  context 'Rule test: ' do
    context 'Borrowing money ' do
      let(:section_code) { 'S8' }
      let(:heading_code) { 'H1' }
      let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

      describe  "(severe) " do
        let(:content_prefix) {'thinking-of-borrowing-severe'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "(temp worried) " do
        let(:content_prefix) {'thinking-of-borrowing-temp-worried'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "(temp normal) " do
        let(:content_prefix) {'thinking-of-borrowing-temp-normal'}

        include_examples 'regionally valid content for regional rule'
      end

      describe  "(no change) " do
        let(:content_prefix) {'thinking-of-borrowing-no-change'}

        include_examples 'regionally valid content for regional rule'
      end
    end

  end
end
