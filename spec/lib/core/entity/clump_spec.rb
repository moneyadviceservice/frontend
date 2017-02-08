module Core
  RSpec.describe Clump, type: :model do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      {
        name:        double,
        description: double,
        categories:  double,
        links:       double
      }
    end

    it { is_expected.to have_attributes(:name, :description, :categories, :links) }
    it { is_expected.to validate_presence_of(:name) }
    it { is_expected.to validate_presence_of(:description) }
  end
end
