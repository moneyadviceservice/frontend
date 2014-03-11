require 'core/entities/entity'

module Core
  class Article < Entity
    Alternate = Struct.new(:title, :url)

    attr_accessor :title, :description, :body
    attr_reader :alternate

    validates_presence_of :title, :body

    def alternate=(attributes)
      @alternate = Alternate.new(*attributes.values_at(:title, :url))
    end
  end
end
