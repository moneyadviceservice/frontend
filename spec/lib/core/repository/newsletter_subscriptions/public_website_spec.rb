module Core::Repository::NewsletterSubscriptions
  RSpec.describe PublicWebsite do
    let(:url) { 'https://example.com/path/to/url' }

    describe '#register' do
      subject(:repository) { described_class.new }

      before do
        allow(Core::Registry::Connection).to receive(:[]).with(:public_website) do
          Core::ConnectionFactory::Http.build(url)
        end

        stub_request(:post, 'https://example.com/en/newsletter-subscriptions.json').
          to_return(status: status, body: nil)
      end

      context 'with valid email' do
        let(:email) { 'clark.kent@example.com' }
        let(:status) { 201 }

        specify { expect(repository.register(email)).to be_truthy }
      end

      context 'with invalid email' do
        let(:email) { 'clark.kent@daily.planet' }
        let(:status) { 422 }

        specify { expect(repository.register(email)).to be_falsey }
      end

      context 'when there is an internal server error' do
        let(:email) { nil }
        let(:status) { 500 }

        it 'raises a PublicWebsite::RequestError' do
          expect { repository.register(email) }.to raise_error(PublicWebsite::RequestError)
        end
      end
    end
  end
end
