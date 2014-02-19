require_relative '../spec_helper'

describe 'Request blacklisted resource' do
  ValidArticles::BLACKLIST.each do |article|
    context "request article #{article}" do
      it 'returns a 501 response' do
        get("/en/articles/#{article}")

        expect(response.status).to eq(501)
      end
    end
  end
end
