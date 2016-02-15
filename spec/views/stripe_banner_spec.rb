RSpec.describe 'shared/_stripe_banner', type: :view do
  include RSpecHtmlMatchers

  before do
    item = double(:item, promo_banner_url: 'www.example.com/',
                         promo_banner_content: '**This** is a test.')

    allow(view).to receive(:item) { item }
    render
  end

  describe 'CMS-editable banner text' do
    context 'raw markdown' do
      it 'renders banner text using Markdown' do
        expect(rendered).to have_tag('strong')
      end

      it 'removes p-tags' do
        expect(rendered).to_not have_tag('p')
      end
    end
  end
end
