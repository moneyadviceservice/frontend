require 'spec_helper'
require 'core/repositories/articles/public_website'

module Core::Repositories::Articles
  describe PublicWebsite do
    let(:url) { 'https://example.com/path/to/url' }

    describe '#find' do
      subject(:repository) { described_class.new }

      let(:id) { 'beginners-guide-to-managing-your-money' }
      let(:headers) { {} }

      before do
        allow(Core::Registries::Connection).to receive(:[]).with(:public_website) do
          Core::ConnectionFactory.build(url)
        end

        stub_request(:get, "https://example.com/en/articles/#{id}.json").
          to_return(status: status, body: body, headers: headers)
      end

      context 'when the type exists' do
        let(:body) { File.read('spec/fixtures/%s.json' % id) }
        let(:status) { 200 }

        it 'returns a hash of attributes' do
          expect(repository.find(id)).to be_a(Hash)
          expect(repository.find(id)['id']).to eq(id)
        end

        context 'and an alternate link header is returned' do
          let(:headers) do
            { 'Link' => '<https://example.com/path/to/alternate>; rel="alternate"; hreflang="cy"; title="alternate"' }
          end

          specify 'returns a nested hash of attributes' do
            expect(repository.find(id)['alternate']).to be_a(Hash)
          end
        end
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
