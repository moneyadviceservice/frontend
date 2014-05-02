require 'html_processor/node_remover'

describe HTMLProcessor::NodeRemover do
  let(:html) {
    <<-EOHTML
<p>
  my paragraph <span id='foo'>is</span> super <strong>awesome</strong>
  and <strong class='super-strong'>awesome</strong>
</p>
    EOHTML
  }

  let(:processor) { HTMLProcessor::NodeRemover.new(html) }
  let(:xpath) { '//strong[@class="super-strong"]' }
  let(:other_xpath) { '//span[id="foo"]' }

  it 'removes nodes from a HTML fragment' do
    processed_html = processor.process(xpath)

    expect(Nokogiri::HTML(processed_html).xpath(xpath)).
      to be_empty
  end

  it 'accepts multiple arguments' do
    processed_html = processor.process(xpath, other_xpath)

    expect(Nokogiri::HTML(processed_html).xpath(xpath, other_xpath)).
      to be_empty
  end
end
