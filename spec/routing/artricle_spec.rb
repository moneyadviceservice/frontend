require_relative '../spec_helper'

describe 'Article routing' do
  context "when the locale is `en'" do
    it 'routes /en/articles/{id} to the article controller' do
      expect(get('/en/articles/foo')).to route_to(controller: 'articles', action: 'show', locale: 'en', id: 'foo')
    end
  end

  context "when the locale is `cy'" do
    it 'routes /cy/articles/{id} to the article controller' do
      expect(get('/cy/articles/foo')).to route_to(controller: 'articles', action: 'show', locale: 'cy', id: 'foo')
    end
  end
end
