module Core
  class SearchResult < Entity
    attr_accessor :title, :link, :snippet

    validates_presence_of :title
  end
end
