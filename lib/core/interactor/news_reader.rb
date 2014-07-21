module Core
  class NewsReader
    attr_accessor :page, :limit
    private :page, :limit

    def initialize(options = {})
      self.page  = options.fetch(:page_number, NewsPage::FIRST_PAGE).to_i
      self.limit = options.fetch(:limit, NewsPage::DEFAULT_PAGE_SIZE).to_i
    end

    def call
      if (items = retrieve_page(page))
        news_items = items.map do |news_article|
          id = news_article.delete('id')
          NewsArticle.new(id, news_article)
        end

        NewsPage.new(items: news_items, page: page)
      else
        NewsPage.new
      end
    end

    private

    def retrieve_page(page)
      Registry::Repository[:news].all(page: page, limit: limit)
    end
  end
end
