RSpec.describe 'Styleguide', :type => :request do
  let(:repository) { Core::Repository::Categories::Fake.new }

  routes = Rails.application.routes.routes.map do |route|
             route.path.spec.to_s
           end.select do |route|
             route =~ /styleguide/
           end.map do |route|
             route.sub(/\(.:format\)/, '')
           end.map do |route|
             route.sub(/:locale/, 'en')
           end

  before do
    allow(Core::Registry::Repository).to receive(:[]).with(:category).and_return(repository)
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
