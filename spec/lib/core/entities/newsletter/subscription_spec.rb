module Core::Newsletter
  RSpec.describe Subscription do
    subject(:subscription) { described_class.new(status, message) }

    let(:status) { Subscription.const_get(:STATUS).sample }
    let(:message) { 'Thank you for signing up' }

    it { is_expected.to respond_to :status }
    it { is_expected.to respond_to :status= }

    it { is_expected.to respond_to :message }
    it { is_expected.to respond_to :message= }

    it { is_expected.to ensure_inclusion_of(:status).in_array(Subscription.const_get(:STATUS)) }
    it { is_expected.to allow_value('', nil).for(:message) }

    describe 'success?' do
      let(:status) { :success }

      specify { expect(subscription.success?).to be_truthy }
    end
  end
end
