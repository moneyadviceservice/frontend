RSpec.describe PerformCorrectiveSearch, '#call' do
  subject(:perform_corrective_search) { described_class.new(double, double).call }

  let(:searcher) { double(call: search_results) }
  let(:suggestion) { nil }
  let(:search_results) do
    instance_double(
      Core::SearchResultCollection,
      empty?: empty,
      spelling_suggestion?: spelling_suggestion,
      spelling_suggestion: suggestion
    )
  end

  before { allow(Core::Searcher).to receive(:new) { searcher } }

  context 'when search does not return results' do
    let(:empty) { true }

    context 'and contains a spelling suggestion' do
      let(:spelling_suggestion) { true }
      let(:suggestion) { 'suggestion' }
      let(:corrective_searcher) { double(call: corrected_search_result) }
      let(:corrected_search_result) { Core::SearchResultCollection.new }

      before do
        expect(Core::Searcher).to receive(:new).with(suggestion, anything) { corrective_searcher }
      end

      it { is_expected.to eq(corrected_search_result) }

      it 'assigns the corrected query to the search result' do
        expect(perform_corrective_search.corrected_query).to eq(suggestion)
      end
    end

    context 'and does not contain spelling suggestion' do
      let(:spelling_suggestion) { false }

      it { is_expected.to eq(search_results) }
    end
  end

  context 'when seach returns results' do
    let(:empty) { false }

    context 'and contains spelling sugestion' do
      let(:spelling_suggestion) { true }

      it { is_expected.to eq(search_results) }
    end

    context 'and does not contain spelling suggestion' do
      let(:spelling_suggestion) { false }

      it { is_expected.to eq(search_results) }
    end
  end
end
