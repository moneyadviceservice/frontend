RSpec.describe 'Static page routing', type: :request  do
  describe '/tools/annuities' do
    context 'when the feature flag is enabled' do
      it 'routes correctly' do
        Feature.with(:annuities_landing_page) do
          expect(get('/en/tools/annuities')).to route_to(
            controller: 'landing_pages',
            action:     'show',
            locale:     'en',
            id:         'annuities'
          )
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
