require 'spec_helper'

require 'core/entities/search_result'
require 'core/interactors/searcher'

module Core
  describe Searcher do
    let(:query) { 'search-term' }
    let(:page) { double }
    let(:per_page) { double }

    subject { described_class.new(query, page, per_page) }

    describe '#call' do
      let(:id) { 'search-result' }
      let(:title) { 'Search Result' }
      let(:description) { 'Description' }
      let(:type) { 'seach-result-type' }

      let(:item_data) do
        {
          id: id,
          title: title,
          description: description,
          type: type
        }
      end

      let(:total_results) { 100 }

      let(:data) do
        {
          total_results: total_results,
          items: [item_data]
        }
      end

      let(:repository) { double(Repositories::Search::GoogleCustomSearchEngine, perform: data) }

      before do
        allow(Registries::Repository).to receive(:[]).with(:search) do
          repository
        end
      end

      context 'initialization' do
        it 'assigns the passed in query to the interactor' do
          expect(subject.query).to eql query
        end

        it 'assigns the passed in page value to the interactor' do
          expect(subject.page).to eql page
        end

        it 'assigns the passed in per_page value to the interactor' do
          expect(subject.per_page).to eql per_page
        end
      end

      it 'calls the repository with the query, page and per_page' do
        expect(repository).to receive(:perform).with(query, page, per_page)
        subject.call
      end

      it 'returns a search result collection' do
        expect(subject.call).to be_a(SearchResultCollection)
      end

      it 'sets #total_results correctly' do
        expect(subject.call.total_results).to eql total_results
      end

      it 'populates #items with instances of SearchResult' do
        subject.call.items.each { |el| expect(el).to be_a(SearchResult) }
      end

      it "maps the array entries' `id' to the repositories' `id' value" do
        expect(SearchResult).
          to receive(:new).with(id, kind_of(Hash)).and_call_original

        subject.call
      end

      %W(title description type).each do |attribute|
        it "maps the array entries' `#{attribute}' to the repositories' `#{attribute}' value" do
          expect(SearchResult).to(receive(:new)) { |_, attributes|
            expect(attributes[attribute.to_sym]).to eq(send(attribute))
          }.and_call_original

          subject.call
        end
      end

      context 'with invalid data' do
        let(:item_data) { [{ id: id, title: title, type: type }] }

        it 'skips the invalid record' do
          expect(subject.call.items.none? { |result| result.id == id }).to be_true
        end

        it 'should log the invalid record' do
          expect(Rails.logger).to receive :info

          subject.call
        end
      end
    end
  end
end
