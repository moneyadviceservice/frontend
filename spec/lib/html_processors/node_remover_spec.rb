require 'spec_helper'
require 'html_processor'

describe HtmlProcessor::NodeRemover do
  let(:html) {
    <<-EOHTML
<p>
  my paragraph <span id='foo'>is</span> super <strong>awesome</strong> and <strong class='super-strong'>awesome</strong>
</p>
EOHTML
  }

  let(:procesor)    { HtmlProcessor::NodeRemover.new(html) }
  let(:xpath)       { 'strong[@class="super-strong"]' }
  let(:other_xpath) { 'span[id="foo"]' }

  it 'removes nodes from a html fragment' do
    processed_html = procesor.process(xpath)
    expect(Nokogiri::HTML(processed_html).search(xpath)).to be_empty
  end

  it 'accepts multiple arguments' do
    processed_html = procesor.process(xpath, other_xpath)
    expect(Nokogiri::HTML(processed_html).search(xpath, other_xpath)).to be_empty
  end

end
