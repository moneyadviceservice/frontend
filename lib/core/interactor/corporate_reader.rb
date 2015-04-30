module Core
  class CorporateReader < ArticleReader
    def call
      data    = repository.find(id)
      article = CorporateArticle.new(id, data)

      if article.valid?
        article.tap do |a|
          a.categories = build_categories(a.categories)
        end
      elsif block_given?
        yield
      end
    end

    private

    def repository
      Registry::Repository[:corporate]
    end
  end
end
