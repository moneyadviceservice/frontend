module Core
  class ArticleLink
    attr_reader :title
    attr_reader :path

    def initialize(title, path)
      @title = title
      @path = path
    end
  end
end
