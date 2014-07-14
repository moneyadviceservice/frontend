module Core
  RSpec.describe SearchResultCollection do
    let(:items) { [] }
    let(:attributes) { { items: items } }
    subject(:result_collection) { described_class.new(attributes) }

    it { is_expected.to respond_to :total_results }
    it { is_expected.to respond_to :total_results= }

    it { is_expected.to respond_to :page }
    it { is_expected.to respond_to :page= }

    it { is_expected.to respond_to :per_page }
    it { is_expected.to respond_to :per_page= }

    it 'is a collection' do
      expect(subject.to_a).to be_kind_of(Array)
    end
  end
end
