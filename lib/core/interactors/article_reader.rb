require 'core/entities/article'
require 'core/registries/repository'

module Core
  class ArticleReader
    attr_accessor :id

    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      data    = Registries::Repository[:article].find(id)
      article = Article.new(id, data)

      if article.valid?
        article
      else
        block.call if block_given?
      end
    end
  end
end
