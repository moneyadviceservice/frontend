module Newsletter
  RSpec.describe SubscriptionDecorator do
    subject(:decorator) { described_class.decorate(subscription) }

    let(:subscription) { instance_double(Core::Newsletter::Subscription, status: double, message: '') }
    let(:status) { double }

    describe 'message' do
      context 'when subscription is successful' do
        it 'contains success' do
          allow(subscription).to receive(:success?).and_return true

          expect(decorator.message).to include I18n.t('newsletter.subscription.success')
        end
      end

      context 'when subscription is in error' do
        it 'contains error' do
          allow(subscription).to receive(:success?).and_return false

          expect(decorator.message).to include I18n.t('newsletter.subscription.error')
        end
      end
    end
  end
end
