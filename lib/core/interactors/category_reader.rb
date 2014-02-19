require 'core/entities/category'
require 'core/registries/repository'

module Core
  class CategoryReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      data     = Registries::Repository[:category].find(id)
      category = Category.new(id, data)

      if category.valid?
        category
      else
        block.call if block_given?
      end
    end
  end
end
