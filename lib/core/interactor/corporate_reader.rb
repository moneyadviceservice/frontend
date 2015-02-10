module Core
  class CorporateReader < ArticleReader
    private

    def repository
      Registry::Repository[:corporate]
    end
  end
end
