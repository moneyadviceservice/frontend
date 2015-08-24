RSpec.describe 'corporate categories controller routing', type: :routing do
  it 'does not route corporate-home category' do
    expect(get: '/en/corporate_categories/corporate-home').to_not route_to(
      locale: 'en',
      controller: 'corporate_categories',
      action: 'show',
      id: 'corporate-home'
    )
  end
end
