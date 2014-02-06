shared_examples 'a resource' do
  let(:id) { 'foo' }

  context "when the locale is `en'" do
    it 'routes /en/resource_name/{id} to the resource controller' do
      expect(get("/en/#{resource_name}/foo")).to route_to(controller: resource_name, action: 'show', locale: 'en', id: id)
    end
  end

  context "when the locale is `cy'" do
    it 'routes /cy/resource_name/{id} to the resource controller' do
      expect(get("/cy/#{resource_name}/foo")).to route_to(controller: resource_name, action: 'show', locale: 'cy', id: id)
    end
  end
end
