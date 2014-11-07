RSpec.describe 'Static page routing', type: :routing  do
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
        expect(get('/en/tools/annuities')).to_not be_routable
      end
    end
  end
end
