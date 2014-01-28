require 'spec_helper'
require 'repository_registry'

describe RepositoryRegistry do
  let(:type) { double }
  let(:repository) { double }

  it { should respond_to(:[]).with(1).argument }
  it { should respond_to(:[]=).with(2).arguments }

  describe 'when registering a repository for a given type' do
    before { described_class[type] = repository }

    it 'registers the repository for the given type' do
      expect(described_class[type]).to eq(repository)
    end
  end

  describe 'when fetching a repository for a given type' do
    context 'when the registry has no repository for that type' do
      it 'raises a repository registry error' do
        expect { described_class[type] }.
          to raise_error(RepositoryRegistry::Error)
      end
    end

    context 'when the registry has a repository for that type' do
      before { described_class[type] = repository }

      it 'returns the repository' do
        expect(described_class[type]).to eq(repository)
      end
    end
  end
end
