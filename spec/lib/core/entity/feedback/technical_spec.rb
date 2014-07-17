module Core
  module Feedback
    RSpec.describe Technical do
      subject { described_class.new(double) }

      it { is_expected.to respond_to :attempting }
      it { is_expected.to respond_to :attempting= }

      it { is_expected.to respond_to :occurred }
      it { is_expected.to respond_to :occurred= }
    end
  end
end
