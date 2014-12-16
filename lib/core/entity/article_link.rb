module Core
  class ArticleLink
    attr_reader :title
    attr_reader :url

    def initialize(title, url)
      @title = title
      @url = url
    end
  end
end
