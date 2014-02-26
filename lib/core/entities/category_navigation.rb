require 'core/entities/entity'

module Core
  class CategoryNavigation < Entity
    attr_accessor :title, :description, :sub_categories
  end
end
