RSpec.describe SrcsetSettingsHelper, type: :helper do
  describe '#size' do
    it 'has correct srcset settings' do
      expect(helper.size_definition).to eq('(max-width: 479px) 100vw, (max-width: 959px) 50vw, 25vw')
    end
  end
end
