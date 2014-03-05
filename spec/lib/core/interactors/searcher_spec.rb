require 'spec_helper'

require 'core/entities/search_result'
require 'core/interactors/searcher'

module Core
  describe Searcher do
    let(:query) { 'search-term' }

    subject { described_class.new(query) }

    describe '.call' do
      let(:id) { 'search-result' }
      let(:title) { 'Search Result' }
      let(:description) { 'Description' }
      let(:type) { 'seach-result-type' }
      let(:data) { [{ id: id, title: title, description: description, type: type }] }

      before do
        allow(Registries::Repository).to receive(:[]).with(:search) do
          double(Repositories::Search::PublicWebsite, perform: data)
        end
      end

      it 'returns an array of search results' do
        subject.call.each { |el| expect(el).to be_a(SearchResult) }
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
        let(:data) { [{ id: id, title: title, type: type }] }

        it 'skips the invalid record' do
          subject.call.none? { |result| result.id == id }.should be_true
        end

        it 'should log the invalid record' do
          expect(Rails.logger).to receive :info

          subject.call
        end
      end
    end
  end
end
