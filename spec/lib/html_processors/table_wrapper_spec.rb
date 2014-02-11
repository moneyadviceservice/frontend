require 'spec_helper'
require 'html_processor'

describe HTMLProcessor::TableWrapper do
  shared_examples "a table wrapper" do
    let(:processor) { HTMLProcessor::TableWrapper.new(html) }

    let(:xpath) do
      '//div[@class="table-wrapper"]/table'
    end

    it 'wraps the given xpaths' do
      processed_html = processor.process(HTMLProcessor::DATATABLE_DEFAULT)

      expect(Nokogiri::HTML(processed_html).xpath(xpath)).to have(1).item
    end
  end

  context 'when the table has a malformed class' do
    it_behaves_like "a table wrapper" do
      let(:html) {
        <<-EOHTML
<table class=" datatable-default"><tr><td>Item</td></tr></table>
        EOHTML
      }
    end
  end

  context 'when the table has a well formed class' do
    it_behaves_like "a table wrapper" do
      let(:html) {
        <<-EOHTML
<table class="datatable-default"><tr><td>Item</td></tr></table>
        EOHTML
      }
    end
  end

  context 'when the table has multiple classes' do
    it_behaves_like "a table wrapper" do
      let(:html) {
        <<-EOHTML
<table class="fancy datatable-default red-herring"><tr><td>Item</td></tr></table>
        EOHTML
      }
    end
  end
end
