require 'spec_helper'
require 'core/repositories/articles/api'

module Core::Repositories::Articles
  describe API do
    subject { described_class.new(url) }

    let(:url) { 'https://example.com/:locale/path/to/url' }

    it { should respond_to :find }

    it { should respond_to :url }
    it { should respond_to :url= }

    describe '#find' do
      let(:id) { 'the-article' }
      let(:params) { { locale: I18n.locale } }

      it 'delegates to the internal resource' do
        expect(API::Model).to receive(:find).with(id, params: params) do
          API::Model.new(id: id)
        end

        subject.find(id)
      end

      context 'when the article exists' do
        it 'returns a hash of attributes' do
          allow(API::Model).to receive(:find) do
            API::Model.new(id: id)
          end

          expect(subject.find(id)).to be_a(Hash)
          expect(subject.find(id)[:id]).to eq(id)
        end
      end

      context 'when the article is non-existent' do
        let(:error) { ActiveResource::ResourceNotFound.new(double) }

        it 'returns nil' do
          expect(API::Model).to receive(:find).and_raise(error)
          expect(subject.find(id)).to be_nil
        end
      end
    end

    describe '#url=' do
      context 'with an invalid URL' do
        let(:url) { 'http:/not a url.com' }

        it 'raises an error' do
          expect { subject.url = url }.to raise_error(URI::InvalidURIError)
        end
      end

      context 'with a valid URL' do
        let(:url) { 'https://example.com/path/to/url' }

        it 'configures the internal resource' do
          expect(API::Model).to receive(:site=).with(url).twice

          subject.url = url
        end
      end
    end
  end
end
