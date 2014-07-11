module Core::Repository::Cms
  RSpec.describe Cms do
    let(:url) { 'https://example.com' }

    describe '#find' do
      subject(:repository) { described_class.new(fallback: fallback) }

      let(:fallback)       { double }

      let(:id) { 'beginners-guide-to-managing-your-money' }
      let(:headers) { {} }

      before do
        allow(Core::Registry::Connection).to receive(:[]).with(:cms) do
          Core::ConnectionFactory.build(url)
        end

        stub_request(:get, "https://example.com/#{id}.json").
          to_return(status: status, body: body, headers: headers)
      end

      context 'when the type exists' do
        let(:body) { File.read('spec/fixtures/cms/%s.json' % id) }
        let(:status) { 200 }

        it 'returns a hash of attributes' do
          expect(repository.find(id)).to be_a(Hash)
          expect(repository.find(id)['slug']).to eq(id)
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
