require_relative '../spec_helper'

RSpec.describe 'Home redirection', :type => :request do
  context "when '/' is requested" do
    before { get('/') }

    it "redirects to '/en'" do
      skip 'Waiting for github.com/rspec/rspec-rails/issues/916'

      expect(request).to redirect_to('/en')
    end
  end
end
