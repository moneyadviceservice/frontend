module Core::Repository::News
  RSpec.describe PublicWebsite do
    let(:url) { 'https://example.com/path/to/url' }
    let(:connection) { Core::ConnectionFactory::Http.build(url) }

    before do
      allow(Core::Registry::Connection).to receive(:[]).with(:public_website) { connection }
    end

    describe '#find' do
      subject(:repository) { described_class.new }

      let(:id) { 'tell-ma-were-listening' }
      let(:headers) { {} }
      let(:body) { {}.to_json }
      let(:status) { 200 }

      before do
        stub_request(:get, "https://example.com/en/news/#{id}.json")
          .to_return(status: status, body: body, headers: headers)
      end

      context 'when id contains special characters' do
        let(:id) { 'jobs-for-students-–-the-taxing-questions' }
        let(:encoded_url) { 'https://example.com/en/news/jobs-for-students-%E2%80%93-the-taxing-questions.json' }
        let(:response) { double(body: body, headers: headers) }

        it 'encodes url' do
          repository.find(id)
          expect(connection).to have_requested(:get, encoded_url)
        end
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

      let(:body) { "[#{File.read('spec/fixtures/news.json')}]" }
      let(:status) { 200 }
      let(:page) { '' }
      let(:limit) { '' }

      before do
        stub_request(:get, "https://example.com/en/news.json?page_number=#{page}&limit=#{limit}")
          .to_return(status: status, body: body, headers: {})
      end

      context 'when the request is successful' do
        let(:first_id) { 'women-are-feeling-the-financial-squeeze-more-than-men' }

        it { is_expected.to be_a(Array) }
        specify { expect(subject.first['id']).to eq(first_id) }
      end

      context 'when there is an error' do
        let(:body) { nil }
        let(:status) { 500 }

        specify { expect { subject }.to raise_error(described_class::RequestError) }
      end

      context 'when optional parameters are given' do
        subject { described_class.new }

        let(:page) { 1 }
        let(:limit) { 10 }
        let(:options) { { page: page, limit: limit } }

        it 'calls the end point with the given parameters' do
          subject.all(options)
          expect(connection).to have_requested(:get, "https://example.com/en/news.json?page_number=#{page}&limit=#{limit}")
        end
      end
    end
  end
end
