module Core
  class HomePagePreviewer < HomePageReader
    private

    def repository
      Registry::Repository[:preview]
    end
  end
end
