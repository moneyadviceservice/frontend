RSpec.describe 'Authentication routing', :type => :routing do
  %w(en cy).each do |locale|
    it "routes GET /#{locale}/users/sign_in to the home controller" do
      expect(get("/#{locale}/users/sign_in")).not_to be_routable
    end

    it "routes DELETE /#{locale}/users/sign_out to the home controller" do
      expect(delete("/#{locale}/users/sign_out")).not_to be_routable
    end

    it "routes GET /#{locale}/users/sign_up to the home controller" do
      expect(get("/#{locale}/users/sign_up")).not_to be_routable
    end

    it "routes GET /#{locale}/users/edit to the home controller" do
      expect(get("/#{locale}/users/edit")).not_to be_routable
    end
  end
end
