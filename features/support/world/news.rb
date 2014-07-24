module World
  module News
    attr_accessor :current_news_article

    def browse_to_news_article(news_article)
      self.current_news_article = news_article

      news_article_page.load(locale: news_article.locale, id: news_article.id)
    end

    def news_article(locale='en')
      case locale.to_s
      when 'en', 'english', 'English'
        fixture 'news_article/what-your-credit-report-reveals-about-you.yml'
      when 'cy', 'welsh', 'Welsh'
        fixture 'news_article/beth-maech-adroddiad-credyd-yn-ei-ddatgelu-amdanoch.yml'
      else
        raise ArgumentError, "invalid article locale '#{locale}'"
      end
    end

    def news(locale='en')
      case locale.to_s
      when 'en', 'english', 'English'
        fixture('news/news-en.yml').articles
      when 'cy', 'welsh', 'Welsh'
        fixture('news/news-cy.yml').articles
      else
        raise ArgumentError, "invalid article locale '#{locale}'"
      end
    end
  end
end

World(World::News)
