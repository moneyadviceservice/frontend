module Core
  RSpec.describe SearchResultCollection do
    let(:items) { [] }
    let(:attributes) { { items: items } }
    subject(:result_collection) { described_class.new(attributes) }

    it { is_expected.to have_attributes(:total_results, :page, :per_page) }
    it { is_expected.to have_read_only_attributes(:items, :query) }

    it 'is a collection' do
      expect(subject.to_a).to be_kind_of(Array)
    end
  end
end
