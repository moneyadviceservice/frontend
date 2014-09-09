module Core
  class SearchResult < Entity
    attr_accessor :title, :description, :link, :snippet, :query

    validates_presence_of :title, :description
  end
end
