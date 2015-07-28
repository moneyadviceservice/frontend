module Core
  class ArticleReader < BaseContentReader
    private

    def entity_class
      Article
    end

    def repository
      Registry::Repository[:article]
    end
  end
end
