RSpec.describe 'Authentication routing', :type => :routing do
  %w(en cy).each do |locale|

    it "routes GET /#{locale}/users/sign_in to the home controller" do
      expect(get("/#{locale}/users/sign_in")).
        to route_to(controller: 'home', action: 'show', locale: locale)
    end

    it "routes DELETE /#{locale}/users/sign_out to the home controller" do
      expect(delete("/#{locale}/users/sign_out")).
        to route_to(controller: 'home', action: 'show', locale: locale)
    end

    it "routes GET /#{locale}/users/sign_up to the home controller" do
      expect(get("/#{locale}/users/sign_up")).
        to route_to(controller: 'home', action: 'show', locale: locale)
    end

    it "routes GET /#{locale}/users/edit to the home controller" do
      expect(get("/#{locale}/users/edit")).
        to route_to(controller: 'home', action: 'show', locale: locale)
    end

  end
end
