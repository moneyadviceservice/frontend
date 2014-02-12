require 'core/entities/entity'

module Core
  class Article < Entity
    attr_accessor :title, :description, :body

    validates_presence_of :title, :body
  end
end
