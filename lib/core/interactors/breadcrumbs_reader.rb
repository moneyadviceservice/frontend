module Core
  class BreadcrumbsReader
    attr_accessor :id
    private :id=

    def initialize(id)
      self.id = id
    end

    def call(&block)
      breadcrumbs = []
      categories  = CategoryTreeReader.new.call

      categories.each do |category|
        find_category(category) do |match|
          breadcrumbs << match
        end
      end

      breadcrumbs.flatten!

      if breadcrumbs.empty?
        block.call if block_given?
      else
        breadcrumbs
      end
    end

    def find_category(category)
      if category.id == self.id
        yield category

      elsif category.contents
        category.contents.each do |child|
          find_category(child) do |match|
            yield [category, match]
          end
        end
      end
    end
  end
end
