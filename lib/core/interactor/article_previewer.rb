module Core
  class ArticlePreviewer < ArticleReader

    private

    def repository
      Registry::Repository[:preview]
    end

  end
end
