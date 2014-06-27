RSpec.describe 'Home redirection', :type => :request do
  context "when '/' is requested" do
    before { get('/') }

    it "redirects to '/en'" do
      expect(request).to redirect_to('/en')
    end
  end
end
