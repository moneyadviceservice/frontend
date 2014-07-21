module Core
  class NewsPage
    include Enumerable
    extend Forwardable

    FIRST_PAGE = 1
    DEFAULT_PAGE_SIZE = 10

    attr_accessor :items, :page

    private :items=, :page=

    def_delegators :items, :size, :empty?

    def initialize(opt = {})
      self.items = opt.fetch(:items) { [] }
      self.page  = opt[:page]
    end

    def each(*args, &block)
      items.each(*args, &block)
    end
  end
end
