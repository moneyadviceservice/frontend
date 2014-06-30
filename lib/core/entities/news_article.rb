require 'core/entities/article'

module Core
  class NewsArticle < Article
    attr_reader :date

    def date=(date)
      @date = DateTime.parse(date)
    end
  end
end
