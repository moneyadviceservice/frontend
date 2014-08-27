RSpec.describe Article do
  subject { described_class.new }

  it { is_expected.to respond_to(:name) }
end
