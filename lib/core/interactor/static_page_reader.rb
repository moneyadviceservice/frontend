module Core
  class StaticPageReader
    attr_accessor :id

    private :id=

    def initialize(id)
      self.id = id
    end

    def call
      data        = Registry::Repository[:static_page].find(id)
      static_page = StaticPage.new(id, data)

      if static_page.valid?
        static_page
      elsif block_given?
        yield
      end
    end
  end
end
