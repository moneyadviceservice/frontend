require 'core/entities/category'
require 'core/registries/repository'

module Core
  class CategoryTreeReader
    def call(&block)
      if (categories = Registries::Repository[:category].all)
        build_list(categories)
      else
        block.call if block_given?
      end
    end

    private

    def build_list(categories)
      categories.map do |category|
        attributes = category.dup.tap do |c|
          c['contents'] = build_list(c['contents'])
        end

        Category.new(category['id'], attributes)
      end
    end
  end
end
