require 'core/entities/article'
require 'repository_registry'

module Core
  class ArticleReader
    attr_accessor :id

    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      if data = RepositoryRegistry[:article].find(id)
        Article.new(id, url: data[:url], title: data[:title], description: data[:description], body: data[:body])
      else
        block.call if block_given?
      end
    end
  end
end
