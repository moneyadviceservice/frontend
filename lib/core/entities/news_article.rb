require 'core/entities/article'

module Core
  class NewsArticle < Article
    attr_accessor :date
  end
end
