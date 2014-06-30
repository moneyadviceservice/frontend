require 'core/entities/newsletter/subscription'
require 'core/interactors/newsletter/subscriber'

module Core::Newsletter
  RSpec.describe Subscriber do
    subject(:subscriber) { described_class.new(email) }

    let(:email) { 'clark.kent@example.com' }

    describe '#call' do
      before do
        allow(Core::Registries::Repository).to receive(:[]).with(:newsletter_subscriptions) do
          double(register: email)
        end
      end

      it { expect(subscriber.call).to be_a(Subscription) }
    end
  end
end
