require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::NodeContents do
  subject(:processor) { described_class.new(html) }

  let(:html) { "<p>#{inner_html}</p>" }
  let(:inner_html) { 'Some text.' }

  describe '.process' do
    subject(:processed_html) { processor.process('//p') }

    it 'returns just the inner html' do
      expect(processed_html).to eql(inner_html)
    end
  end
end
