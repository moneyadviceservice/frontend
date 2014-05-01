require 'core/entities/search_result'

module Core
  class SearchResultCollection < Entity

    attr_writer :items

    def items
      @items ||= []
    end

    def any?
      items.present?
    end
  end
end
