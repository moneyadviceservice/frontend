require 'nokogiri'
require 'html_processor/node_replacer'

describe HTMLProcessor::NodeReplacer do
  subject(:processor) { described_class.new(html) }

  let(:html) {
    <<-EOHTML
<div>
    <h3>a rather important title</h3>
</div>
    EOHTML
  }

  describe '.process' do
    subject(:processed_html) { processor.process('//h3', 'h2') }

    it 'replaces the target elements with the specified element' do
      expect(Nokogiri::HTML(processed_html).xpath('//h2').size).to eq(1)
    end
  end
end
