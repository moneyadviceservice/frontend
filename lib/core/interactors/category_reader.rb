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

      instantiated_contents = contents.map do |item|
        attributes = item.dup.tap do |i|
          i['contents'] = build_contents(i['contents']) if i.member? 'contents'
        end
        klass = klass_for(attributes.delete('type'))
        klass.new(item['id'], attributes) if klass
      end

      instantiated_contents.compact
    end

    def klass_for(type)
      klass_name = case type
        when 'guide'
          'Article'
        when nil
          'Category'
        else
          type.classify
      end

      Core.const_get(klass_name) if Core.const_defined? klass_name
    end
  end
end
