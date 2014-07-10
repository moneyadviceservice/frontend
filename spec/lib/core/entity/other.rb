module Core
  RSpec.describe Other do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      { title: double }
    end

    it { is_expected.to respond_to :type }
    it { is_expected.to respond_to :type= }

    it { is_expected.to respond_to :title }
    it { is_expected.to respond_to :title= }

    it { is_expected.to respond_to :description }
    it { is_expected.to respond_to :description= }
  end
end
