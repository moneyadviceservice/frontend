require_relative './shared_examples/show_resource'

RSpec.describe 'Article routing', :type => :routing do
  it_should_behave_like 'a resource for', 'articles'

  it 'provides locale aware routes to preview article' do
    I18n.available_locales.map(&:to_s).each do |locale|
      expect(get("/#{locale}/articles/example/preview")).
          to route_to(controller: 'articles_preview', action: 'show', locale: locale, id: 'example')
    end
  end
end
