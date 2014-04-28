require 'core/entities/article'
require 'core/interactors/category_reader'
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

    def alternate_article_id_for_locale(locale)
      case locale
      when 'en'
        'help-to-buy-schemes-faqs'
      when 'cy'
        'cynlluniau-cymorth-i-brynu---cwestiynau-cyffredin'
      end
    end

    def article_for_locale(locale)
      id = article_id_for_locale(locale)
      data = I18n.with_locale(locale) { ::Core::Registries::Repository[:article].find(id) }

      ::Core::Article.new(id, data).tap do |article|
        article.categories = article.categories.map do |category_id|
          ::Core::CategoryReader.new(category_id).call
        end
      end
    end

    def alternate_article_for_locale(locale)
      id = alternate_article_id_for_locale(locale)
      data = I18n.with_locale(locale) { ::Core::Registries::Repository[:article].find(id) }

      ::Core::Article.new(id, data).tap do |article|
        article.categories = article.categories.map do |category_id|
          ::Core::CategoryReader.new(category_id).call
        end
      end
    end

    def category_containing_articles(locale)
      article = article_for_locale(locale)
      alternate = alternate_article_for_locale(locale)

      build(:category_hash,
        id: 'affordable-housing-schemes',
        contents: [
          { 'type' => 'guide', 'id' => article.id, 'title' => article.title },
          { 'type' => 'guide', 'id' => alternate.id, 'title' => alternate.title }
        ]
      )
    end
  end
end

World(World::Articles)
