module World
  module News
    attr_accessor :current_news_article

    def browse_to_news_article(news_article)
      self.current_news_article = news_article

      news_article_page.load(locale: news_article.locale, id: news_article.id)
    end

    def news_article(locale='en')
      fixture 'news/tell-ma-were-listening.yml'
    end
  end
end

World(World::News)
