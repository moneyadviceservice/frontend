module Core
  class NewsReader
    FIRST_PAGE = 1

    attr_accessor :page
    private :page

    def initialize(page)
      self.page = (page || FIRST_PAGE).to_i
    end

    def call(&block)
      if(items = retrieve_page(page))
        news_items = items.map do |news_article|
          id = news_article.delete('id')
          NewsArticle.new(id, news_article)
        end

        NewsCollection.new(items: news_items, page: page)
      else
        NewsCollection.new
      end
    end

    private

    def retrieve_page(page)
      Registry::Repository[:news].all(page)
    end
  end
end
