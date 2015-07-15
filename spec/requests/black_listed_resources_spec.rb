RSpec.describe 'Request blacklisted resource', type: [:request, :controller] do
  %w(partners-uc-banks
     partners-uc-landlords
     resources-for-professionals-working-with-young-people-and-parents).each do |category|
    context "request category #{category}" do
      it 'raises routing error' do
        expect{ get "/en/categories/#{category}" }.to raise_error(ActionController::RoutingError)
      end
    end
  end
end
