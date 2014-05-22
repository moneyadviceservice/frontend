require 'core/repositories/search/google_custom_search_engine/response_mapper'

module Core::Repositories::Search
  RSpec.describe GoogleCustomSearchEngine::ResponseItemMapper do

    describe '#mapped_item_response' do
      let(:id) { 'action-plan-id' }
      let(:title) { 'The action plan' }
      let(:description) { 'Action plan description' }
      let(:type) { 'action_plan' }
      let(:link) { "https://www.moneyadviceservice.org.uk/en/#{type.pluralize}/#{id}" }
      let(:snippet) { 'Action plan snippet' }
      let(:item) do
        {
         'link' => link,
         'title' => title,
         'snippet' => snippet,
         'pagemap' => {
            'metatags' => [
               {
                  'csrf-param' => 'authenticity_token',
                  'og:description' => description
               }
            ]
          }
        }
      end

      subject { described_class.new(item).mapped_item_response }

      it 'maps the id correctly' do
        expect(subject[:id]).to eq(id)
      end

      it 'maps the title correctly' do
        expect(subject[:title]).to eq(title)
      end

      it 'maps the description correctly' do
        expect(subject[:description]).to eq(description)
      end

      it 'maps the link correctly' do
        expect(subject[:link]).to eq(link)
      end

      it 'maps the snippet correctly' do
        expect(subject[:snippet]).to eq(snippet)
      end

      context "when it doesn't have pagemap" do
        before { item.delete_if { |key, val| key == 'pagemap' } }

        it 'maps the description to empty string' do
          expect(subject[:description]).to be_empty
        end
      end

      context "when it doesn't have metatags" do
        before { item['pagemap'].delete_if { |key, val| key == 'metatags' } }

        it 'maps the description to empty string' do
          expect(subject[:description]).to be_empty
        end
      end
    end
  end
end
