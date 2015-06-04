RSpec.describe 'instructions to ban site bots', type: :view do
  describe 'sitemap/robots.text.erb' do
    before :each do
      assign(:base_url, 'localhost:3000')
      render file: 'sitemap/robots.text.erb'
    end

    it 'should have the sitemap description' do
      expect(rendered).to include 'Sitemap: localhost:3000/sitemap.xml'
    end

    it 'should disallow scrawling attempts from Atomz' do
      expect(rendered).to include 'User-Agent: Atomz'
      expect(rendered).to include 'Disallow: /'
    end
  end
end
