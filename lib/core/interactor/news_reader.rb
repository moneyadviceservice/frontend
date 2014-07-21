module Core
  class NewsReader
    attr_accessor :page_number, :limit
    private :page_number, :limit

    def initialize(options = {})
      self.page_number = options.fetch(:page_number, NewsPage::FIRST_PAGE_NUMBER).to_i
      self.limit       = options.fetch(:limit, NewsPage::DEFAULT_PAGE_SIZE).to_i
    end

    def call
      if (items = retrieve_page(page_number))
        news_items = items.map do |news_article|
          id = news_article.delete('id')
          NewsArticle.new(id, news_article)
        end

        NewsPage.new(items: news_items, page_number: page_number)
      else
        NewsPage.new
      end
    end

    private

    def retrieve_page(page_number)
      Registry::Repository[:news].all(page_number: page_number, limit: limit)
    end
  end
end
