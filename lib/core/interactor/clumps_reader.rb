module Core
  class ClumpsReader
    def call(clumps = Registry::Repository[:clump].all)
      if (clumps)
        clumps.collect do |attributes|
          build_clump(attributes)
        end
      elsif block_given?
        yield
      end
    end

    private

    def build_clump(attributes)
      id = attributes.delete('id')
      categories_attributes = attributes.delete('categories')
      links_attributes = attributes.delete('links')

      Clump.new(id, attributes).tap do |clump|
        clump.categories = categories_attributes.map { |c| build_category(c) }
        clump.links = links_attributes.map { |l| build_clump_link(l) }
      end
    end

    def build_category(attributes)
      id = attributes.delete('id')
      contents_attributes = attributes.delete('contents')

      Category.new(id, attributes).tap do |category|
        if contents_attributes.present?
          category.contents = contents_attributes.map { |c| build_category(c) }
        end
      end
    end

    def build_clump_link(attributes)
      id = attributes.delete('id')
      ClumpLink.new(id, attributes)
    end
  end
end
