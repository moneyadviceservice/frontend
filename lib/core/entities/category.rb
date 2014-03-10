require 'core/entities/entity'

module Core
  class Category < Entity
    attr_accessor :type, :title, :description, :contents

    validates_presence_of :title

    def subcategory?
      contents.any? { |c| c.class != Category }
    end
  end
end
