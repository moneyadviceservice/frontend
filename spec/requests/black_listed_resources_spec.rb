RSpec.describe 'Request blacklisted resource', :type => :request do
  %W(about-our-debt-work am-ein-gwaith-dyled
     debt-publications cyhoeddiadau-ar-ddyledion
     partners-overview-parhub
     partner-reg-parhub
     syndicating-tools-parhub
     video-syndication-parhub
     toolkits-parhub pecynnau-cymorth-cyngor-ariannol
     linking-parhub
     examples-parhub
     licence-agreement-parhub).each do |article|
    context "request article #{article}" do
      it 'returns a 501 response' do
        get("/en/articles/#{article}")

        expect(response.status).to eq(501)
      end
    end
  end

  %W(partners
     partners-uc-banks
     partners-uc-landlords
     resources-for-professionals-working-with-young-people-and-parents).each do |category|
    context "request category #{category}" do
      it 'returns a 501 response' do
        get("/en/categories/#{category}")

        expect(response.status).to eq(501)
      end
    end
  end

  %W(accessibility hygyrchedd).each do |static_page|
    context "request static page #{static_page}" do
      it 'returns a 501 response' do
        get("/en/static/#{static_page}")

        expect(response.status).to eq(501)
      end
    end
  end
end
