require 'spec_helper'
require 'core/repositories/search/google_custom_search_engine/response_mapper'

module Core::Repositories::Search
  describe GoogleCustomSearchEngine::ResponseMapper do

    describe '#mapped_response' do
      let(:total_results) { 30 }
      let(:count) { 10 }
      let(:start_index) { 1 }
      let(:item_data) { double }
      let(:mapped_item_data) { double }

      let(:body) do
        {
          'queries' => {
            'request' => [
              'totalResults' => total_results.to_s,
              'count' => count.to_s,
              'startIndex' => start_index.to_s
            ]
          },
          'items' => [item_data]
        }
      end

      let(:response) { double(body: body)}
      subject { described_class.new(response).mapped_response }

      before do
        allow_any_instance_of(GoogleCustomSearchEngine::ResponseItemMapper).
          to receive(:mapped_item_response) { mapped_item_data }
      end

      it 'maps the total results correctly' do
        expect(subject[:total_results]).to eq(total_results)
      end

      it 'maps the per page attribute correctly' do
        expect(subject[:per_page]).to eq(count)
      end

      context 'for each item' do
        it 'instantiates an item mapper' do
          expect(GoogleCustomSearchEngine::ResponseItemMapper).
            to receive(:new).with(item_data).and_call_original
          subject
        end

        it 'assigns the response of #mapped_response to the item collection' do
          expect(subject[:items]).to include(mapped_item_data)
        end
      end

      context 'if there are no items' do
        before { body['items'] = [] }

        it 'returns an empty array' do
          expect(subject[:items]).to be_a(Array)
          expect(subject[:items]).to be_empty
        end
      end

      context 'when on the first page' do
        it 'calculates the page number correctly' do
          expect(subject[:page]).to eq 1
        end
      end

      context 'when on the second page' do
        let(:start_index) { 11 }

        it 'calculates the page number correctly' do
          expect(subject[:page]).to eq 2
        end
      end
    end
  end
end
