module Core
  class ArticleLink
    include ActiveModel::Conversion
    attr_reader :title
    attr_reader :path
    attr_reader :date

    def initialize(title, path, date = nil)
      @title = title
      @path = path
      @date = Date.parse(date) if date
    end

    def to_partial_path
      'articles/article_link'
    end
  end
end
