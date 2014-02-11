require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::NodeReplacer do
  let(:html) {
    <<-EOHTML
<div>
    <h3>a rather important title</h3>
</div>
    EOHTML
  }

  let(:processor) { described_class.new(html) }

  describe '.process' do
    subject(:processed_html) { processor.process('//h3', 'h2') }

    it 'replaces the target XPath with the new tag' do
      expect(Nokogiri::HTML(processed_html).xpath('//h2')).to have(1).item
    end
  end
end
