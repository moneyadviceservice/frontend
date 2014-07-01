require 'core/entities/news_article'

module Core
  class NewsArticleReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def initialize(id)
      self.id = id
    end

    def call(&block)
      data         = Registries::Repository[:news_article].find(id)
      news_article = NewsArticle.new(id, data)

      if news_article.valid?
        news_article
      else
        block.call if block_given?
      end
    end
  end
end
