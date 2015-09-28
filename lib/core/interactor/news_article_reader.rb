module Core
  class NewsArticleReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call
      data         = Registry::Repository[:news_article].find(id)
      news_article = NewsArticle.new(id, data)

      if news_article.valid?
        news_article
      elsif block_given?
        yield news_article
      end
    rescue Core::Repository::CMS::Resource301Error,
           Core::Repository::CMS::Resource302Error => e
      yield OpenStruct.new(status: e.status, location: e.location, redirect?: true)
    end
  end
end
