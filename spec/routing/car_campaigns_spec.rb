RSpec.describe 'Car campaigns routing', :type => :routing do
  context "when the locale is `en'" do
    it "routes /en/campaigns/revealed-the-true-cost-of-buying-a-car to the car campaigns controller" do
      expect(get("/en/campaigns/revealed-the-true-cost-of-buying-a-car")).
        to route_to(controller: 'car_campaigns', action: 'show', locale: 'en', id: 'revealed-the-true-cost-of-buying-a-car')
    end
  end

  context "when the locale is `cy'" do
    it "routes /cy/campaigns/revealed-the-true-cost-of-buying-a-car to the car campaigns controller" do
      expect(get("/cy/campaigns/revealed-the-true-cost-of-buying-a-car")).
        to route_to(controller: 'car_campaigns', action: 'show', locale: 'cy', id: 'revealed-the-true-cost-of-buying-a-car')
    end
  end

  context 'when the id is not whitelisted' do
    specify { expect(get("/cy/campaigns/ramdom-id")).to_not be_routable }
  end
end
