require 'core/entities/article'
require 'core/interactors/article_reader'
require 'core/registries/repository'
require 'core/repositories/articles/fake'

module World
  module Articles
    def populate_article_repository_with(*articles)
      repository = Core::Repositories::Articles::Fake.new(*articles)
      Core::Registries::Repository[:article] = repository
    end

    def browse_to_article(article)
      article_page.load(locale: :en, id: article['id'])
      @current_article = article
    end

    def current_article
      @current_article
    end

    def article_id_for_locale(locale)
      case locale
      when 'en'
        'should-you-rent-or-buy'
      when 'cy'
        'a-ddylech-chi-rentu-neu-brynu'
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

    def single_article
      article = article_for_locale('en')

      build(:article_hash, id: article.id, title: article.title)
    end

    def category_containing_articles(locale)
      article = article_for_locale(locale)
      alternate = alternate_article_for_locale(locale)

      build(:category_hash,
        id: 'buying-a-home',
        contents: [
          build(:article_hash, id: article.id, title: article.title),
          build(:article_hash, id: alternate.id, title: alternate.title),
        ]
      )
    end

    def multiple_categories_containing_an_article(locale)
      article = article_for_locale(locale)
      alternate = alternate_article_for_locale(locale)

      [
        build(:category_hash,
          id: 'buying-a-home',
          contents: [
            build(:article_hash, id: article.id, title: article.title),
            build(:article_hash, id: alternate.id, title: alternate.title),
          ]
        ),

        build(:category_hash,
          id: 'renting-and-letting',
          contents: [
            build(:article_hash, id: article.id, title: article.title),
            build(:article_hash, id: alternate.id, title: alternate.title),
          ]
        )
      ]
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
