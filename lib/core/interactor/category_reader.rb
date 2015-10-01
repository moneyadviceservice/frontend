module Core
  class CategoryReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call
      data     = Registry::Repository[:category].find(id)
      category = Category.new(id, data)

      if category.valid?
        category.tap do |cat|
          cat.contents = build_contents(cat.contents)
        end
      elsif block_given?
        yield category
      end
    rescue Core::Repository::CMS::Resource301Error,
           Core::Repository::CMS::Resource302Error => e
      yield OpenStruct.new(status: e.status, location: e.location, redirect?: true)
    end

    def build_contents(contents)
      return [] unless contents.present?

      contents.map do |item|
        klass = klass_for(item['type'])
        if klass == Category
          CategoryReader.new(item['id']).call
        else
          klass.new(item['id'], item)
        end
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
