RSpec.describe 'Styleguide', type: :request do
  let(:footer_repository) { Core::Repository::Footer::Static.new }
  let(:category_repository) { Core::Repository::Categories::Fake.new }

  routes = Rails.application.routes.routes.map do |route|
    path = route.path.spec.to_s
    path.sub(/\(.:format\)/, '').sub(/:locale/, 'en') if path =~ /styleguide/
  end.compact

  before do
    allow(Core::Registry::Repository).to receive(:[]).with(:footer).and_return(footer_repository)
    allow(Core::Registry::Repository).to receive(:[]).with(:category).and_return(category_repository)
  end

  describe 'styleguide pages' do
    routes.each do |route|
      it "gives a 200 for each styleguide page #{route}" do
        get route
        expect(response.status).to eq(200)
      end
    end
  end
end
