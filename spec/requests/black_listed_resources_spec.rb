RSpec.describe 'Request blacklisted resource', type: :request do
  %w(partners-uc-banks
     partners-uc-landlords
     resources-for-professionals-working-with-young-people-and-parents).each do |category|
    context "request category #{category}" do
      it 'returns a 501 response' do
        get("/en/categories/#{category}")

        expect(response.status).to eq(501)
      end
    end
  end
end
