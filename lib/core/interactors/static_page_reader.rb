require 'core/entities/static_page'
require 'core/registries/repository'

module Core
  class StaticPageReader
    attr_accessor :id

    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      data        = Registries::Repository[:static_page].find(id)
      static_page = StaticPage.new(id, data)

      if static_page.valid?
        static_page
      else
        block.call if block_given?
      end
    end
  end
end
