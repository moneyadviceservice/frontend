require 'registry'

describe Registry do
  let(:type) { double }
  let(:object) { double }

  describe 'when registering an object for a given type' do
    before { described_class[type] = object }

    it 'registers the object for the given type' do
      expect(described_class[type]).to eq(object)
    end
  end

  describe 'when fetching an object for a given type' do
    context 'when the registry has no object for that type' do
      it 'raises an object registry error' do
        expect { described_class[type] }.
          to raise_error(Registry::Error)
      end
    end

    context 'when the registry has an object for that type' do
      before { described_class[type] = object }

      it 'returns the object' do
        expect(described_class[type]).to eq(object)
      end
    end
  end
end
