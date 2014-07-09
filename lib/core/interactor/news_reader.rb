module Core
  class NewsReader
    def call(&block)
      if(news = Registry::Repository[:news].all)
        news.map do |news_article|
          id = news_article.delete('id')
          NewsArticle.new(id, news_article)
        end
      else
        block.call if block_given?
      end
    end
  end
end
