module Core
  class NewsPage
    include Enumerable
    extend Forwardable

    FIRST_PAGE_NUMBER = 1
    DEFAULT_PAGE_SIZE = 10

    attr_accessor :items, :page_number

    private :items, :page_number=

    def_delegators :items, :size, :empty?

    def initialize(opt = {})
      self.items       = opt.fetch(:items) { [] }
      self.page_number = opt[:page_number]
    end

    def each(*args, &block)
      items.each(*args, &block)
    end

    def next_page?
      items.size == DEFAULT_PAGE_SIZE
    end

    def prev_page?
      page_number > FIRST_PAGE_NUMBER
    end
  end
end
