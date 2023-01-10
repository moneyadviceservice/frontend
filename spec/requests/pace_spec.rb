RSpec.describe 'Pace', type: :request do
  describe 'GET show' do
    it 'successfully renders' do
      get '/en/moneyadvisernetwork'
      expect(response).to be_redirect
    end
  end

  describe 'GET privacy' do
    it 'successfully renders' do
      get '/en/moneyadvisernetwork/privacy'
      expect(response).to be_redirect
    end
  end
end
