module Core::Repository::Videos
  RSpec.describe PublicWebsite do
    let(:url) { 'https://example.com/path/to/url' }

    describe '#find' do
      subject(:repository) { described_class.new }

      let(:id) { 'beginners-guide-to-managing-your-money' }
      let(:headers) { {} }

      before do
        allow(Core::Registry::Connection).to receive(:[]).with(:public_website) do
          Core::ConnectionFactory::Http.build(url)
        end

        stub_request(:get, "https://example.com/en/videos/#{id}.json")
          .to_return(status: status, body: body, headers: headers)
      end

      context 'when the type is non-existent' do
        let(:body) { nil }
        let(:status) { 404 }

        it 'returns nil' do
          expect(repository.find(id)).to be_nil
        end
      end

      context 'when there is a proxy authentication error' do
        let(:body) { nil }
        let(:status) { 407 }

        it 'raises an API::RequestError' do
          expect { repository.find(id) }.to raise_error(PublicWebsite::RequestError)
        end
      end

      context 'when there is an error' do
        let(:body) { nil }
        let(:status) { 500 }

        it 'raises an API::RequestError' do
          expect { repository.find(id) }.to raise_error(PublicWebsite::RequestError)
        end
      end
    end
  end
end
