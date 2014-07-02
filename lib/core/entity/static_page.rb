module Core
  class StaticPage < Entity
    Alternate = Struct.new(:title, :url, :hreflang)

    attr_accessor :type, :title, :description, :body
    attr_reader :alternates

    validates_presence_of :title, :body

    def alternates=(alternates)
      @alternates = alternates.map do |alternate|
        Alternate.new(*alternate.values_at(:title, :url, :hreflang))
      end
    end
  end
end
