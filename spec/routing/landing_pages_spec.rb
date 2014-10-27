RSpec.describe 'Static page rounting', type: :routing  do
  context 'when route is /tools/annuities' do
    it 'routes to static pages controller' do
      expect(get('/en/tools/annuities')).to route_to(
        controller: 'landing_pages',
        action:     'show',
        locale:     'en',
        id:         'annuities'
      )
    end
  end
end
