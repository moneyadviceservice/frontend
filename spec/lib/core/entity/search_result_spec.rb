module Core
  RSpec.describe SearchResult do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title: double } }

    it { is_expected.to have_attributes(:title) }

    it { is_expected.to validate_presence_of(:title) }
  end
end
