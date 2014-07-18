module Core
  class NewsReader
    FIRST_PAGE = 1
    DEFAULT_PAGE_SIZE = 10

    attr_accessor :page, :limit
    private :page, :limit

    def initialize(options = {})
      self.page = options.fetch(:page_number, FIRST_PAGE).to_i
      self.limit = options.fetch(:limit, DEFAULT_PAGE_SIZE).to_i
    end

    def call
      if (items = retrieve_page(page))
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
      Registry::Repository[:news].all(page: page, limit: limit)
    end
  end
end
