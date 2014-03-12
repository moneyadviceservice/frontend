require 'core/registries/repository'

Dir[File.join(File.dirname(__FILE__), '..', 'entities', '*')].each do |entity|
  require entity
end

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
        klass = klass_for(attributes.delete('type'))
        klass.new(item['id'], attributes)
      end
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

      if Core.const_defined? klass_name
        Core.const_get(klass_name)
      else
        Other
      end
    end
  end
end
