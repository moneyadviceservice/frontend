RSpec.describe 'Static page routing', type: :request  do
  describe '/tools/annuities' do
    context 'when the feature flag is enabled' do
      it 'routes correctly' do
        Feature.with(:annuities_landing_page) do
          get('/en/tools/annuities')
          expect(response).to be_success
        end
      end
    end

    context 'when the feature flag is disabled' do
      it 'does not route' do
        Feature.without(:annuities_landing_page) do
          expect {
            get('/en/tools/annuities')
          }.to raise_error(ActionController::RoutingError, 'Not Found')
        end
      end
    end
  end
end
