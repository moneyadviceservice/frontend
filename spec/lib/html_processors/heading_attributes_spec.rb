require 'nokogiri'
require 'html_processor/heading_attributes'

RSpec.describe HTMLProcessor::HeadingAttributes do
  subject(:processor) { described_class.new(html) }

  let(:html) do
    <<-EOHTML
      <div>
        <h1> H1 test heading </h1>
        <h2> H2 test heading </h2>
        <h6> H6 test heading </h6>
      </div>
    EOHTML
  end

  describe '.process' do
    subject(:processed_html) { processor.process(xpath) }

    let(:xpath) { '//h2' }
    let(:node) { Nokogiri::HTML(processed_html).xpath(xpath).first }

    it 'adds the role attribute to the node' do
      expect(node.attribute('role').value).to eq('heading')
    end

    context 'when heading level is 1' do
      let(:xpath) { '//h1' }

      it 'adds aria-level attribute with value 1' do
        expect(node.attribute('aria-level').value).to eq('1')
      end
    end

    context 'when heading level is 6' do
      let(:xpath) { '//h6' }

      it 'adds aria-level attribute with value 6' do
        expect(node.attribute('aria-level').value).to eq('6')
      end
    end

    context 'when heading already contains some attributes' do
      let(:html) { '<div><h2 class="foo">H2 test heading</h2></div>' }

      it 'keeps the existin attributes' do
        expect(node.attribute('class').value).to eq('foo')
      end
    end
  end
end
