module Core
  RSpec.describe SearchResultCollection do
    let(:items) { [] }
    let(:attributes) { { items: items } }
    subject(:result_collection) { described_class.new(double, attributes) }

    it { is_expected.to respond_to :query }
    it { is_expected.to respond_to :query= }

    it { is_expected.to respond_to :total_results }
    it { is_expected.to respond_to :total_results= }

    it { is_expected.to respond_to :page }
    it { is_expected.to respond_to :page= }

    it { is_expected.to respond_to :per_page }
    it { is_expected.to respond_to :per_page= }

    describe '#items' do
      it 'is an empty array by default' do
        expect(subject.items).to be_kind_of(Array)
        expect(subject.items).to be_empty
      end
    end
  end
end
