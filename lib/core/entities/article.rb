require 'core/entities/entity'

module Core
  class Article < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    attr_accessor :type, :title, :description, :body, :categories
    attr_reader :alternates

    validates_presence_of :title, :body

    def alternates=(alternates)
      @alternates = []
      alternates.each do |alternate|
        @alternates << Alternate.new(*alternate.values_at(:title, :url, :hreflang))
      end
    end

    def one_parent?
      categories.compact.one?
    end

    def parent_category_ids
      categories.map(&:parent_id).find_all(&:present?).uniq
    end
  end
end
