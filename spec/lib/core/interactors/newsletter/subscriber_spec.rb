require_relative '../shared_examples/optional_failure_block'

module Core::Newsletter
  RSpec.describe Subscriber do
    subject(:subscriber) { described_class.new(email) }

    let(:email) { 'clark.kent@example.com' }

    describe '#call' do
      before do
        allow(Core::Registry::Repository).to receive(:[]).with(:newsletter_subscription) do
          double(register: email)
        end
      end

      context 'when the Subscription entity is valid' do
        before do
          expect_any_instance_of(Subscription).to receive(:valid?) { true }
        end

        it 'returns a Subscription' do
          expect(subject.call).to be_a(Subscription)
        end
      end

      context 'when the Subscription is invalid' do
        before do
          expect_any_instance_of(Subscription).to receive(:valid?) { false }
        end

        it_has_behavior 'optional failure block'
      end
    end
  end
end
