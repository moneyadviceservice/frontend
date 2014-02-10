require 'core/entities/article'
require 'core/interactors/reader'

module Core
  class ArticleReader

    def initialize(id)
      @reader = Reader.new(Article, id)
    end

    def call(&block)
      reader.call(&block)
    end

    private

    attr_reader :reader
  end
end
