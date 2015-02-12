require_relative './shared_examples/show_resource'

RSpec.describe 'Article routing', type: :routing do
  it_should_behave_like 'a resource for', 'articles'

  it 'provides locale aware routes to preview article' do
    I18n.available_locales.map(&:to_s).each do |locale|
      %w(articles news videos action_plans corporate tools).each do |page_type|
        expect(get("/#{locale}/#{page_type}/example/preview"))
          .to route_to(
                controller: 'articles_preview',
                action: 'show',
                locale: locale,
                id: 'example',
                page_type: page_type
              )
      end
    end
  end
end
