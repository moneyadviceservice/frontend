module Core
  module Feedback
    RSpec.describe Article do
      subject { described_class.new(double) }

      it { is_expected.to respond_to :useful }
      it { is_expected.to respond_to :useful= }

      it { is_expected.to respond_to :suggestions }
      it { is_expected.to respond_to :suggestions= }
    end
  end
end
