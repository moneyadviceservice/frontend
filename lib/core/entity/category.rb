module Core
  class Category < Entity
    attr_accessor :type, :parent_id, :title, :description, :contents, :third_level_navigation, :images, :links, :category_promos, :legacy_contents, :legacy
    validates_presence_of :title

    def categories
      contents.delete_if { |c| c.type != 'category' }
    end

    def third_level_navigation?
      third_level_navigation
    end

    def legacy?
      legacy
    end

    def child?
      contents.blank? || contents.any? { |c| c.class != Category }
    end

    def parent?
      contents.any? { |c| c.try(:child?) }
    end

    def home?
      false
    end

    def news?
      false
    end

    def corporate?
      false
    end

    def redirect?
      false
    end

    def attributes
      {
        type: type,
        parent_id: parent_id,
        title: title,
        description: description,
        contents: contents,
        legacy_contents: legacy_contents,
        images: images,
        links: links
      }
    end
  end
end
