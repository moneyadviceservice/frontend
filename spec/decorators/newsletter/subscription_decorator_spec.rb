require 'core/entities/newsletter/subscription'

module Newsletter
  RSpec.describe SubscriptionDecorator do
    subject(:decorator) { described_class.decorate(subscription) }

    let(:subscription) { instance_double(Core::Newsletter::Subscription, success: double, message: '') }

    it { is_expected.to respond_to(:success_message) }
    it { is_expected.to respond_to(:error_message) }
  end
end
