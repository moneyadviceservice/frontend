module Core
  class NewsArticleReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call
      data         = Registry::Repository[:news].find(id)
      news_article = NewsArticle.new(id, data)

      if news_article.valid?
        news_article
      elsif block_given?
        yield
      end
    end
  end
end
