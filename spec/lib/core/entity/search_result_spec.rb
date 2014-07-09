module Core
  RSpec.describe SearchResult do
    subject { described_class.new(double, attributes) }

    let(:attributes) { { title: double, description: double } }

    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :title= }

    it { is_expected.to respond_to :description }
    it { is_expected.to respond_to :description= }

    it { is_expected.to validate_presence_of(:title) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
