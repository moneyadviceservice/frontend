module Core
  class ArticleLink
    include ActiveModel::Conversion
    attr_reader :title
    attr_reader :path

    def initialize(title, path)
      @title = title
      @path = path
    end

    def to_partial_path
      'articles/article_link'
    end
  end
end
