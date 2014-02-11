require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::TableWrapper do
  let(:html) {
    <<-EOHTML
<table class="datatable-default"><tr><td>Item</td></tr></table>
    EOHTML
  }

  let(:processor) { HTMLProcessor::TableWrapper.new(html) }

  let(:xpath) do
    '//div[@class="table-wrapper"]/table[@class="datatable-default"]'
  end

  it 'wraps the given xpaths' do
    processed_html = processor.process(HTMLProcessor::DATATABLE_DEFAULT)

    expect(Nokogiri::HTML(processed_html).xpath(xpath)).to have(1).item
  end
end
