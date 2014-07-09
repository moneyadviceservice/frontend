module Core
  RSpec.describe Searcher do
    let(:query) { double }
    let(:page) { '1' }
    let(:per_page) { '10' }

    subject { described_class.new(query, page: page, per_page: per_page) }

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

    describe '#call' do
      let(:total_results) { double }
      let(:item_id) { double }
      let(:item_data_without_id) { { foo: :bar } }
      let(:item_data) { { id: item_id, foo: :bar } }
      let(:items) { [item_data] }

      before do
        allow(subject).to receive(:query) { query }
        allow(subject).to receive(:request_page) { page }
        allow(subject).to receive(:request_per_page) { per_page }
        allow(subject).to receive(:total_results) { total_results }
        allow(subject).to receive(:items) { items }
      end

      it 'calls the repository with the query, page and per_page' do
        expect(SearchResultCollection).to receive(:new).
                                            with(query, total_results: total_results, page: page, per_page: per_page).
                                            and_call_original

        subject.call
      end

      it 'instantiates a SearchResult with each element of #items' do
        expect(SearchResult).to receive(:new).
                                  with(item_id, item_data_without_id).
                                  and_call_original

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

      describe '#page' do
        context 'if a value has been assigned' do
          it 'returns the assigned value' do
            expect(subject.send(:page)).to eq page
          end
        end

        context 'if the a page has not been assigned' do
          subject { described_class.new(query) }

          it 'returns DEFAULT_PAGE' do
            expect(subject.send(:page)).to eq Searcher::DEFAULT_PAGE
          end
        end
      end

      describe '#per_page' do
        context 'if a value has been assigned' do
          it 'returns the assigned value' do
            expect(subject.send(:per_page)).to eq per_page
          end
        end

        context 'if no value has been assigned' do
          subject { described_class.new(query) }

          it 'returns DEFAULT_PAGE' do
            expect(subject.send(:per_page)).to eq Searcher::DEFAULT_PER_PAGE
          end
        end
      end

      describe '#request_page' do
        context '#page is below zero' do
          let(:page) { -1 }

          it 'returns 1' do
            expect(subject.send(:request_page)).to eq 1
          end
        end

        context '#page is zero' do
          let(:page) { 0 }

          it 'returns 1' do
            expect(subject.send(:request_page)).to eq 1
          end
        end

        context '#page is less than PAGE_LIMIT' do
          let(:page) { 1 }

          it 'returns #page' do
            expect(subject.send(:request_page)).to eq page
          end
        end

        context '#page is greater than PAGE_LIMIT' do
          let(:page) { 100 }

          it 'returns #page' do
            expect(subject.send(:request_page)).to eq Searcher::PAGE_LIMIT
          end
        end
      end

      describe '#request_per_page' do
        context '#per_page is less than PAGE_LIMIT' do
          let(:per_page) { 1 }

          it 'returns #per_page' do
            expect(subject.send(:request_per_page)).to eq per_page
          end
        end

        context '#per_page is greater than PAGE_LIMIT' do
          let(:per_page) { 100 }

          it 'returns #per_page' do
            expect(subject.send(:request_per_page)).to eq Searcher::PER_PAGE_LIMIT
          end
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
