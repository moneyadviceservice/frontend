module Core
  RSpec.describe SearchResultCollection do
    let(:items) { [] }
    let(:attributes) { { items: items } }
    subject(:result_collection) { described_class.new(attributes) }

    it do is_expected.to have_attributes(
      :total_results, :page, :per_page, :spelling_suggestion, :corrected_query) end
    it { is_expected.to have_read_only_attributes(:items, :query) }

    it 'is a collection' do
      expect(subject.to_a).to be_kind_of(Array)
    end

    describe '#spelling_suggestion?' do
      subject { result_collection.spelling_suggestion? }

      context 'when it contains spelling_suggestion' do
        let(:attributes) { { spelling_suggestion: double } }

        it { is_expected.to be_truthy }
      end

      context 'when it does not contain spelling_suggestion' do
        it { is_expected.to be_falsy }
      end
    end

    describe '#corrected_query?' do
      subject { result_collection.corrected_query? }

      context 'when it contains corrected_query' do
        before { result_collection.corrected_query = 'correction' }

        it { is_expected.to be_truthy }
      end

      context 'when it does not contain corrected_query' do
        it { is_expected.to be_falsy }
      end
    end
  end
end
