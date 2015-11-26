RSpec.describe 'Static page routing', type: :request  do
  describe '/tools/annuities' do
    it 'routes correctly' do
      get('/en/tools/annuities')
      expect(response).to be_success
    end
  end
end
