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

  let(:processor) { HTMLProcessor::NodeReplacer.new(html) }
  let(:xpath)     { '//h3' }
  let(:new_tag)   { 'h2' }

  it 'replaces an html by another' do
    processed_html = processor.process(xpath, new_tag)

    expect(Nokogiri::HTML(processed_html).xpath('//h2').size).
      to eq(1)
  end
end
