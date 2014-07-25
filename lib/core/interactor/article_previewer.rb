module Core
  class ArticlePreviewer < ArticleReader

    def call(&block)
      data    = Registry::Repository[:preview].find(id)
      article = Article.new(id, data)

      if article.valid?
        article
      else
        block.call if block_given?
      end
    end

  end
end
