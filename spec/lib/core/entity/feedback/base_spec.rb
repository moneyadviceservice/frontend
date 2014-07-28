module Core
  module Feedback
    RSpec.describe Base do
      subject { described_class.new(double) }

      it { is_expected.to respond_to :url }
      it { is_expected.to respond_to :url= }

      it { is_expected.to respond_to :user_agent }
      it { is_expected.to respond_to :user_agent= }

      it { is_expected.to respond_to :time }
      it { is_expected.to respond_to :time= }
    end
  end
end
