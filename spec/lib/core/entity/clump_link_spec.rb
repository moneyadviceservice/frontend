module Core
  RSpec.describe ClumpLink, type: :model do
    subject { described_class.new(double, attributes) }

    let(:attributes) do
      {
        text: double,
        url: double,
        style: double
      }
    end

    it { is_expected.to have_attributes(:text, :url, :style) }
    it { is_expected.to validate_presence_of(:text) }
    it { is_expected.to validate_presence_of(:url) }
    it { is_expected.to validate_presence_of(:style) }
  end
end
