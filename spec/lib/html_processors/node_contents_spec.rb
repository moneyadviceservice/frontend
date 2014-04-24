require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::NodeContents do
  let(:inner_html) { 'Some text.' }
  let(:html) { "<p>#{inner_html}</p>" }

  let(:processor) { described_class.new(html) }
  let(:xpath) { '//p' }

  it 'returns just the inner html' do
    expect(processor.process(xpath)).to eql inner_html
  end
end
