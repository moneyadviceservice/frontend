
RSpec.describe Questions, type: :model do
  include MoneyNavigator::Symbols

  #TODO: These are all positive tests. need to add negative tests
  #(i.e. test that checks content is not displayed under a condition that shoud result in it not displaying)

  context 'Rule test: ' do
    context 'Protecting your future ' do
      let(:section_code) { 'S10' }
      let(:region) { [ 'ni', 'england', 'wales', 'scotland'] }

      describe  "cancelling insurance" do
        let(:heading_code) { 'H1' }
        let(:content_prefix) {'cancelling-insurance'}

        include_examples 'regionally valid content for regional rule'
      end

    end

  end
end
