module Core::Repository::CMS
  RSpec.describe CMS do
    let(:url) { 'https://example.com' }

    describe '#find' do
      subject(:repository) { described_class.new(fallback: fallback) }

      let(:fallback)       { double }

      let(:id) { 'beginners-guide-to-managing-your-money' }
      let(:headers) { {} }

      before do
        allow(Core::Registry::Connection).to receive(:[]).with(:cms) do
          Core::ConnectionFactory::Http.build(url)
        end

        stub_request(:get, "https://example.com/#{I18n.locale}/#{id}.json")
          .to_return(status: status, body: body, headers: headers)
      end

      context 'when the type exists' do
        let(:body) { File.read('spec/fixtures/cms/%s.json' % id) }
        let(:status) { 200 }

        it 'returns a hash of attributes' do
          expect(repository.find(id)).to be_a(Hash)
          expect(repository.find(id)['slug']).to eq(id)
        end

        it 'returns the meta description' do
          expect(repository.find(id)['description']).to eq('meta description')
        end
      end

      context 'when the type is non-existent' do
        let(:body) { nil }
        let(:status) { 404 }

        it 'falls back to the fallback repository' do
          expect(fallback).to receive(:find).with(id)
          repository.find(id)
        end
      end

      context 'when there is a proxy authentication error' do
        let(:body) { nil }
        let(:status) { 407 }

        it 'falls back to the fallback repository' do
          expect(fallback).to receive(:find).with(id)
          repository.find(id)
        end
      end

      context 'when there is an error' do
        let(:body) { nil }
        let(:status) { 500 }

        it 'falls back to the fallback repository' do
          expect(fallback).to receive(:find).with(id)
          repository.find(id)
        end
      end
    end
  end
end
