require 'core/entities/category'
require 'core/registries/repository'

module Core
  class CategoryNavigationReader < Array
    def call(&block)
      categories = Registries::Repository[:category].all

      unless categories
        block.call if block_given?
        return
      end

      replace(build_list(categories))
    end

    private

    def build_list(categories)
      categories.map do |category|
        attributes = category.dup.tap do |c|
          c['sub_categories'] = build_list(c['sub_categories'])
        end
        CategoryNavigation.new(category['id'], attributes)
      end
    end
  end
end
