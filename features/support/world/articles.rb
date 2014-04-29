require 'core/entities/article'
require 'core/interactors/article_reader'
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
      retrieve_article_for_locale(id, locale)
    end

    def alternate_article_for_locale(locale)
      id = alternate_article_id_for_locale(locale)
      retrieve_article_for_locale(id, locale)
    end

    def category_containing_articles(locale)
      article = article_for_locale(locale)
      alternate = alternate_article_for_locale(locale)

      build(:category_hash,
        id: 'affordable-housing-schemes',
        contents: [
          build(:article_hash, id: article.id, title: article.title),
          build(:article_hash, id: alternate.id, title: alternate.title),
        ]
      )
    end

    private

    def retrieve_article_for_locale(id, locale)
      I18n.with_locale(locale) do
        Core::ArticleReader.new(id).call
      end
    end
  end
end

World(World::Articles)
