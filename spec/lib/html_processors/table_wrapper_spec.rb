require 'html_processor'
require 'html_processor/table_wrapper'

describe HTMLProcessor::TableWrapper do
  shared_examples 'a table wrapper' do
    subject(:processor) { described_class.new(html) }
    let(:html) { '<table><tr><td></td></tr></table>' }
    let(:xpath) { '//div[@class="table-wrapper"]/table' }

    describe '.process' do
      subject(:processed_html) { processor.process(HTMLProcessor::DATATABLE_DEFAULT) }

      it 'wraps the given xpaths' do
        expect(Nokogiri::HTML(processed_html).xpath(xpath).size).to eq(1)
      end
    end
  end

  context 'when the table has a malformed class' do
    it_behaves_like 'a table wrapper' do
      let(:html) {
        <<-EOHTML
<table class=" datatable-default"><tr><td>Item</td></tr></table>
        EOHTML
      }
    end
  end

  context 'when the table has a well formed class' do
    it_behaves_like 'a table wrapper' do
      let(:html) {
        <<-EOHTML
<table class="datatable-default"><tr><td>Item</td></tr></table>
        EOHTML
      }
    end
  end

  context 'when the table has multiple classes' do
    it_behaves_like 'a table wrapper' do
      let(:html) {
        <<-EOHTML
<table class="fancy datatable-default red-herring"><tr><td>Item</td></tr></table>
        EOHTML
      }
    end
  end
end
