require 'core/entities/newsletter/subscription'

module Core::Newsletter
  RSpec.describe Subscription do
    subject(:subscription) { described_class.new(success, message) }

    let(:success) { [true, false].sample }
    let(:message) { 'Thank you for signing up' }

    it { is_expected.to respond_to :success }
    it { is_expected.to respond_to :success= }
    it { is_expected.to respond_to :success? }

    it { is_expected.to respond_to :message }
    it { is_expected.to respond_to :message= }

    it { is_expected.to ensure_inclusion_of(:success).in_array([true, false]) }
    it { is_expected.to allow_value('', nil).for(:message) }
  end
end
