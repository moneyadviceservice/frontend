module Core::Repository::Search
  RSpec.describe GoogleCustomSearchEngine::ResponseItemMapper do

    describe '#mapped_item_response' do
      let(:id) { 'action-plan-id' }
      let(:title) { 'The action plan' }
      let(:type) { 'action_plan' }
      let(:link) { "https://www.moneyadviceservice.org.uk/en/#{type.pluralize}/#{id}" }
      let(:snippet) { 'Action plan snippet' }
      let(:item) do
        {
          'link'      => link,
          'htmlTitle' => title,
          'htmlSnippet'   => snippet,
        }
      end

      subject { described_class.new(item).mapped_item_response }

      it 'maps the id correctly' do
        expect(subject[:id]).to eq(id)
      end

      it 'maps the title correctly' do
        expect(subject[:title]).to eq(title)
      end

      it 'maps the link correctly' do
        expect(subject[:link]).to eq(link)
      end

      it 'maps the snippet correctly' do
        expect(subject[:snippet]).to eq(snippet)
      end
    end
  end
end
