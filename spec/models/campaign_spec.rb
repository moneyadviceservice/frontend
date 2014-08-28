RSpec.describe Campaign do
  subject { described_class.new }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :sections }
  it { is_expected.to respond_to :each }
  it { is_expected.to respond_to :first }
end
