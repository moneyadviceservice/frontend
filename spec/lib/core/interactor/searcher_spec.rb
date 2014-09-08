module Core
  RSpec.describe Searcher do
    let(:query) { double }
    let(:page) { '1' }
    let(:per_page) { '10' }

    subject(:searcher) { described_class.new(query, page: page, per_page: per_page) }

    describe '#initialize' do

      it 'assigns the passed in query to the interactor' do
        expect(subject.send(:query)).to eql query
      end

      it 'assigns the passed in page value to the interactor coerced to an integer' do
        expect(subject.send(:page)).to eql page.to_i
      end

      it 'assigns the passed in per_page value to the interactor coerced to an integer' do
        expect(subject.send(:per_page)).to eql per_page.to_i
      end
    end

    describe '#page' do
      subject { searcher.page }

      context 'when page value is a string' do
        let(:page) { '1' }

        it { is_expected.to eq(1) }
      end

      context 'when page value has no value' do
        let(:page) { nil }

        it { is_expected.to eq(Searcher::DEFAULT_PAGE) }
      end

      context 'when page value is 0' do
        let(:page) { '0' }

        it { is_expected.to eq(1) }
      end

      context 'when page value is greater than the page limit' do
        let(:page) { '20' }

        it { is_expected.to eq(Searcher::PAGE_LIMIT) }
      end

      context '#page is below zero' do
        let(:page) { -1 }

        it { is_expected.to eq(Searcher::DEFAULT_PAGE) }
      end
    end

    describe '#per_page' do
      subject { searcher.per_page }

      context 'when per_page value is a string' do
        let(:per_page) { '10' }

        it { is_expected.to eq(10) }
      end

      context 'when per_page has no value' do
        it { is_expected.to eq(Searcher::DEFAULT_PER_PAGE) }
      end

      context 'when per_page value is greater than PER_PAGE_LIMIT' do
        let(:per_page) { '50' }

        it { is_expected.to eq(Searcher::DEFAULT_PER_PAGE) }
      end
    end

    describe '#call' do
      let(:total_results) { double }
      let(:item_id) { double }
      let(:item_data_without_id) { { foo: :bar } }
      let(:item_data) { { id: item_id, foo: :bar } }
      let(:items) { [item_data] }

      before do
        allow(subject).to receive(:request_per_page) { per_page }
        allow(subject).to receive(:total_results) { total_results }
        allow(subject).to receive(:items) { items }
      end

      it 'calls the repository with the page and per_page' do
        expect(SearchResultCollection).to receive(:new)
                                            .with(total_results: total_results, page: page.to_i, per_page: per_page.to_i)
                                            .and_call_original

        subject.call
      end

      it 'instantiates a SearchResult with each element of #items' do
        expect(SearchResult).to receive(:new)
                                  .with(item_id, item_data_without_id)
                                  .and_call_original

        subject.call
      end

      it 'returns a SearchResultCollection' do
        expect(subject.call).to be_a(SearchResultCollection)
      end

      context 'when the item data is valid' do
        before do
          allow_any_instance_of(SearchResult).to receive(:valid?) { true }
        end

        context 'the returned SearchResultCollection#items' do
          it 'contains a corresponding SearchResult' do
            expect(subject.call.items.first).to be_a(SearchResult)
          end

          it 'contains a corresponding SearchResult with matching ID' do
            expect(subject.call.items.first.id).to eq item_id
          end
        end
      end

      context 'when the item data is valid' do
        before do
          allow_any_instance_of(SearchResult).to receive(:valid?) { false }
        end

        context 'the returned SearchResultCollection#items' do
          it 'is empty' do
            expect(subject.call.items).to be_empty
          end
        end
      end
    end

    context 'private methods' do
      let(:page) { 1 }
      let(:per_page) { 10 }

      describe '#data' do
        let(:repository) { instance_double(Repository::Search::GoogleCustomSearchEngine) }
        let(:data) { double }

        before do
          allow(subject).to receive(:query) { query }
          allow(subject).to receive(:request_page) { page }
          allow(subject).to receive(:request_per_page) { per_page }
          allow(Registry::Repository).to receive(:[]).with(:search) { repository }
          allow(repository).to receive(:perform) { data }
        end

        it 'calls #perform on the repository with the query, page and per_page' do
          expect(repository).to receive(:perform).with(query, page, per_page)
          subject.send(:data)
        end

        it 'returns the result of the call to #perform' do
          expect(subject.send(:data)).to eq data
        end
      end

      describe '#total_results' do
        let(:total_results) { double }

        before do
          allow(subject).to receive(:data) { { total_results: total_results } }
        end

        it 'returns the the value from the data hash' do
          expect(subject.send(:total_results)).to eq total_results
        end
      end

      describe '#items' do
        let(:items) { double }

        before do
          allow(subject).to receive(:data) { { items: items } }
        end

        it 'returns the the value from the data hash' do
          expect(subject.send(:items)).to eq items
        end
      end

    end
  end
end
