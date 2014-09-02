RSpec.describe CampaignPage::Section do
  subject { described_class.new }

  it { is_expected.to respond_to :name }
  it { is_expected.to respond_to :separator }
  it { is_expected.to respond_to :articles }
  it { is_expected.to respond_to :each }
  it { is_expected.to respond_to :first }
end
