module Core
  class NewsCollection
    include Enumerable
    extend Forwardable

    attr_accessor :items, :page

    private :items=, :page=

    def_delegators :items, :size, :empty?

    def initialize(opt={})
      self.items     = opt.fetch(:items) { [] }
      self.page      = opt[:page]
    end

    def each(*args, &block)
      items.each(*args, &block)
    end
  end
end
