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
        category.tap do |cat|
          cat.contents = build_contents(cat.contents)
        end
      else
        block.call if block_given?
      end
    end

    def build_contents(contents)
      return [] unless contents.present?

      contents.map do |item|
        attributes = item.dup.tap do |i|
          i['contents'] = build_contents(i['contents']) if i.member? 'contents'
        end
        item_type = attributes.delete('type') || 'category'
        klass = Core.const_get(item_type.classify)
        klass.new(item['id'], attributes)
      end
    end
  end
end
