module Core
  module Feedback
    RSpec.describe Base do
      subject { described_class.new(double) }

      it { is_expected.to have_attributes(:url, :user_agent, :time) }
    end
  end
end
