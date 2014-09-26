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
          fixture 'articles/changes-to-child-benefit-from-2013.yml'
        when 'cy', 'welsh', 'Welsh'
          fixture 'articles/newidiadau-i-fudd-dal-plant-o-2013-ymlaen.yml'
        else
          raise ArgumentError, "invalid article locale `#{locale}'"
      end
    end

    def article_with_two_child_and_one_parent_category
      fixture 'articles/what-to-do-if-you-have-been-refused-a-loan-or-credit-card.yml'
    end

    def orphan_article(locale = 'en')
      case locale.to_s
        when 'en', 'english', 'English'
          fixture 'articles/if-your-baby-is-stillborn.yml'
        when 'cy', 'welsh', 'Welsh'
          fixture 'articles/os-ywch-babi-yn-farw-anedig.yml'
        else
          raise ArgumentError, "invalid article locale `#{locale}'"
      end
    end

    def article_with_callback_requester
      fixture 'articles/managing-your-money-if-your-job-is-at-risk.yml'
    end

    def article_without_callback_requester
      article_with_single_parent
    end
  end
end

World(World::Articles)
