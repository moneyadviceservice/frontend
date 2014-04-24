require 'core/entities/entity'

module Core
  class SearchResult < Entity
    attr_accessor :title, :description, :type, :link, :snippet

    validates_presence_of :title, :description, :type
  end
end
