require 'html_processor/node_remover'
require 'nokogiri'

RSpec.describe HTMLProcessor::NodeRemover do
  subject(:processor) { described_class.new(html) }

  let(:html) do
    <<-HTML.strip_heredoc
      <p>
        my paragraph <span id='foo'>is</span> super <strong>awesome</strong>
        and <strong class='super-strong'>awesome</strong>
      </p>
    HTML
  end

  describe '.process' do
    subject(:processed_html) { processor.process(*args) }

    context 'with a single node to remove' do
      let(:args) { ['//strong[@class="super-strong"]'] }

      it 'removes matching nodes from the HTML fragment' do
        expect(Nokogiri::HTML(processed_html).xpath(*args)).to be_empty
      end
    end

    context 'with multiple nodes to remove' do
      let(:args) { ['//strong[@class="super-strong"]', '//span[id="foo"]'] }

      it 'removes matching nodes from the HTML fragment' do
        expect(Nokogiri::HTML(processed_html).xpath(*args)).to be_empty
      end
    end
  end
end
