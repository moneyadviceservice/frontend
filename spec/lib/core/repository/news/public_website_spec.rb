module Core::Repository::News
  RSpec.describe PublicWebsite do
    let(:url) { 'https://example.com/path/to/url' }

    before do
        allow(Core::Registry::Connection).to receive(:[]).with(:public_website) do
          Core::ConnectionFactory.build(url)
        end
      end

    describe '#find' do
      subject(:repository) { described_class.new }

      let(:id) { 'tell-ma-were-listening' }
      let(:headers) { {} }

      before do
        allow(Core::Registry::Connection).to receive(:[]).with(:public_website) do
          Core::ConnectionFactory.build(url)
        end

        stub_request(:get, "https://example.com/en/news/#{id}.json").
          to_return(status: status, body: body, headers: headers)
      end

      context 'when the type exists' do
        let(:body) { File.read('spec/fixtures/%s.json' % id) }
        let(:status) { 200 }

        it 'returns a has of attributes' do
          expect(repository.find(id)).to be_a(Hash)
          expect(repository.find(id)['id']).to eq(id)
        end

        context 'and an alternate link header is returned' do
          let(:alternate_links) do
            [
              '<https://example.com/cy/path/to/cy/alternate>; rel="alternate"; hreflang="cy"; title="alternate"',
              '<https://example.com/path/to/en/alternate>; rel="alternate"; hreflang="en"; title="alternate"'
            ]
          end
          let(:headers) { { 'Link' => alternate_links } }

          it 'returns an array of attributes' do
            expect(repository.find(id)['alternates']).to be_a(Array)
            expect(repository.find(id)['alternates'].size).to eq(alternate_links.size)
          end
        end
      end

      context 'when the type is not-existent' do
        let(:body) { nil }
        let(:status) { 404 }

        it 'returns nil' do
          expect(repository.find(id)).to be_nil
        end
      end

      context 'when there is a proxy authentication error' do
        let(:body) { nil }
        let(:status) { 407 }

        it 'raises an API::RequestErrror' do
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

    describe '#all' do
      subject { described_class.new.all }

      before do
        stub_request(:get, "https://example.com/en/news.json?page_number=1").
        to_return(status: status, body: body, headers: {})
      end

      context 'when the request is successful' do
        let(:body) { "[#{File.read('spec/fixtures/news.json')}]" }
        let(:status) { 200 }
        let(:first_id) { "women-are-feeling-the-financial-squeeze-more-than-men" }

        it { is_expected.to be_a(Array) }
        specify { expect(subject.first['id']).to eq(first_id) }
      end

      context 'when there is an error' do
        let(:body) { nil }
        let(:status) { 500 }

        specify { expect { subject }.to raise_error(described_class::RequestError) }
      end
    end
  end
end
