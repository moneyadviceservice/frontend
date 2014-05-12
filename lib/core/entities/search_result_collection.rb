module Core
  class SearchResultCollection

    attr_accessor :query, :page, :per_page, :total_results

    attr_writer :items

    def initialize(query, attributes = {})
      self.query = query

      Array(attributes).each do |name, value|
        send("#{name}=", value) if respond_to?("#{name}=")
      end
    end

    def items
      @items ||= []
    end
  end
end
