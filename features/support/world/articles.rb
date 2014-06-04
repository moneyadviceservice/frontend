require 'core/entities/article'
require 'core/interactors/article_reader'
require 'core/registries/repository'
require 'core/repositories/articles/fake'

module World
  module Articles
    attr_accessor :current_article

    def browse_to_article(article)
      self.current_article = article

      article_page.load(locale: article.locale, id: article.id)
    end

    def article_with_single_parent(locale = 'en')
      case locale.to_s
        when 'en', 'english', 'English'
          fixture 'articles/why-it-pays-to-save-regularly.yml'
        when 'cy', 'welsh', 'Welsh'
          fixture 'articles/pam-bod-cynilon-rheolaidd-yn-talu-ffordd.yml'
        else
          raise ArgumentError, "invalid article locale `#{locale}'"
      end
    end

    alias_method :article, :article_with_single_parent

    def article_with_multiple_parents(locale = 'en')
      case locale.to_s
        when 'en', 'english', 'English'
          fixture ''
        when 'cy', 'welsh', 'Welsh'
          fixture ''
        else
          raise ArgumentError, "invalid article locale `#{locale}'"
      end
    end

    def orphan_article(locale = 'en')
      case locale.to_s
        when 'en', 'english', 'English'
          fixture ''
        when 'cy', 'welsh', 'Welsh'
          fixture ''
        else
          raise ArgumentError, "invalid article locale `#{locale}'"
      end
    end
  end
end

World(World::Articles)
