module Core
  RSpec.describe Feedback do
    subject { described_class.new(double) }

    it { is_expected.to respond_to :type }
    it { is_expected.to respond_to :type= }

    it { is_expected.to respond_to :subject }
    it { is_expected.to respond_to :subject= }

    it { is_expected.to respond_to :body }
    it { is_expected.to respond_to :body= }
  end
end
