module Core
  class SearchResultCollection
    include Enumerable
    extend Forwardable

    attr_accessor :items, :page, :per_page, :total_results, :spelling_suggestion, :query

    private :items=, :query=

    def_delegators :items, :<<

    def initialize(attributes = {})
      self.items = attributes.fetch(:items) { [] }
      self.page = attributes[:page]
      self.per_page = attributes[:per_page]
      self.total_results = attributes[:total_results]
      self.spelling_suggestion = attributes[:spelling_suggestion]
      self.query = attributes[:query]
    end

    def each(*args, &block)
      items.each(*args, &block)
    end

    def spelling_suggestion?
      !!spelling_suggestion
    end
  end
end
