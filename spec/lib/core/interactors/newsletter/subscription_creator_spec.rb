module Core::Newsletter
  RSpec.describe SubscriptionCreator do
    subject(:subscriber) { described_class.new(email) }

    let(:email) { 'clark.kent@example.com' }

    describe '#call' do
      before do
        allow(Core::Registry::Repository).to receive(:[]).with(:newsletter_subscription) do
          double(register: result)
        end
      end

      context 'when the repository result is true' do
        let(:result) { true }

        specify { expect(subject.call).to be_truthy }
      end

      context 'when the repository result is false' do
        let(:result) { false }

        specify { expect(subject.call).to be_falsey }
      end

      context 'when a failure block is given' do
        let(:result) { nil }

        it 'calls the block' do
          expect { |x| (subject.call(&x)) }.to yield_with_no_args
        end
      end
    end
  end
end
