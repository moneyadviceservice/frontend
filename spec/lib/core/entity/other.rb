module Core
  RSpec.describe Other do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      { title: double }
    end

    it { is_expected.to have_attributes(:type, :title, :description) }
  end
end
