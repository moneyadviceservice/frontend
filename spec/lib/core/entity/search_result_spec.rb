module Core
  RSpec.describe SearchResult do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title: double, description: double } }

    it { is_expected.to have_attributes(:title, :description) }

    it { is_expected.to validate_presence_of(:title) }
  end
end
