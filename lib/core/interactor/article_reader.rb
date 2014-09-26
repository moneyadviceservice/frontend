module Core
  class ArticleReader
    attr_accessor :id

    private :id=

    def initialize(id)
      self.id = id
    end

    def call
      data    = Registry::Repository[:article].find(id)
      article = Article.new(id, data)

      if article.valid?
        article.tap do |a|
          a.categories = build_categories(a.categories)
        end
      elsif block_given?
        yield
      end
    end

    private

    def build_categories(category_ids)
      category_ids.map do |category_id|
        CategoryReader.new(category_id).call
      end
    end
  end
end
