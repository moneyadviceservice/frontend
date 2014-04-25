require 'core/entities/article'
require 'core/registries/repository'

module World
  module Articles
    def article_id_for_locale(locale)
      case locale
      when 'en'
        'help-to-buy-scheme-everything-you-need-to-know'
      when 'cy'
        'cynllun-help-i-brynu-cael-gwybod-popeth-sydd-ei-angen-arnoch'
      end
    end

    def article_for_locale(locale)
      id = article_id_for_locale(locale)
      data = ::Core::Registries::Repository[:article].find(id)

      ::Core::Article.new(id, data)
    end
  end
end

World(World::Articles)
