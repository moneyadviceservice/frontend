require 'spec_helper'

require 'core/entities/search_result'
require 'core/interactors/searcher'

module Core
  describe Searcher do
    let(:query) { 'search-term' }

    subject { described_class.new(query) }

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
      let(:per_page) { 10 }
      let(:page) { 1 }

      let(:data) {
        {
          total_results: total_results,
          page: page,
          per_page: per_page,
          items: [item_data]
        }
      }

      before do
        allow(Registries::Repository).to(receive(:[]).with(:search)) { double(perform: data) }
      end

      it 'returns a search result collection' do
        expect(subject.call).to be_a(SearchResultCollection)
      end

      it 'sets #total_results correctly' do
        expect(subject.call.total_results).to eql total_results
      end


      it 'sets #page correctly' do
        expect(subject.call.page).to eql page
      end

      it 'sets #per_page correctly' do
        expect(subject.call.per_page).to eql per_page
      end

      it 'populates #items with instances of SearchResults' do
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
