require 'core/repositories/repository_cache'

RSpec.describe Core::RepositoryCache do
  let(:repository) { instance_double('Core::Repositories::Test') }
  let(:cache) { double }
  let(:contents) { 'the contents' }
  let(:locale) { :en }

  subject(:repository_cache) { described_class.new(repository, cache) }

  before do
    allow(I18n).to receive(:locale).and_return(locale)
  end

  describe '#all' do
    it 'uses the correct cache key' do
      expect(cache).to receive(:fetch).with("#{locale}-#{repository.class}-all")
      subject.all
    end

    context 'when the cache key does not exist' do
      before do
        allow(repository).to receive(:all).and_return(contents)
        allow(cache).to receive(:fetch) do |key, &block|
          block.call
        end
      end

      it 'calls the repository' do
        expect(repository).to receive(:all)
        subject.all
      end

      it 'returns the contents of the repository' do
        expect(subject.all).to eq(contents)
      end
    end

    context 'when the cache key exists' do
      before do
        allow(cache).to receive(:fetch).and_return(contents)
      end

      it 'does not call the repository' do
        expect(repository).to_not receive(:all)
        subject.all
      end

      it 'returns the cached contents' do
        expect(subject.all).to eq(contents)
      end
    end
  end

  describe '#find' do
    let(:id) { 'the-id' }

    it 'uses the correct cache key' do
      expect(cache).to receive(:fetch).with("#{locale}-#{repository.class}-find-#{id}")
      subject.find(id)
    end

    context 'when the cache key does not exist' do
      before do
        allow(repository).to receive(:find).with(id).and_return(contents)
        allow(cache).to receive(:fetch) do |key, &block|
          block.call
        end
      end

      it 'calls the repository' do
        expect(repository).to receive(:find).with(id)
        subject.find(id)
      end

      it 'returns the contents of the repository' do
        expect(subject.find(id)).to eq(contents)
      end
    end

    context 'when the cache key exists' do
      before do
        allow(cache).to receive(:fetch).and_return(contents)
      end

      it 'does not call the repository' do
        expect(repository).to_not receive(:find)
        subject.find(id)
      end

      it 'returns the cached contents' do
        expect(subject.find(id)).to eq(contents)
      end
    end
  end
end
