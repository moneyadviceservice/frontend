module Core::Repository::NewsletterSubscriptions
  RSpec.describe Cream do
    describe '#register' do
      let(:email) { 'test@example.com' }

      subject(:repository) { described_class.new }

      context 'happy path' do
        let(:fake_client) { double('client', subscribe_to_newsletter: true) }

        before :each do
          allow(::Cream::ClientV2).to receive(:new) { fake_client }
        end

        it 'returns true' do
          expect(subject.register(email)).to be_truthy
        end
      end

      context 'sad path' do
        let(:fake_client) { double('client', subscribe_to_newsletter: false) }

        before :each do
          allow(::Cream::ClientV2).to receive(:new) { fake_client }
        end

        it 'returns false' do
          expect(subject.register(email)).to be_falsey
        end
      end
    end
  end
end
