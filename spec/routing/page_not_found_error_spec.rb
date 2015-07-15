RSpec.describe 'Page Not Found', type: :routing do
  context 'page exists' do
    it 'shows page is routable' do
      expect(get: '/en').to be_routable
    end
  end

  context 'page does not exist' do
    it 'shows page is not routable' do
      expect(get: '/en/non-existent').to_not be_routable
    end
  end
end
