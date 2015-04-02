module Core
  class Category < Entity
    attr_accessor :type, :parent_id, :title, :description, :contents

    validates_presence_of :title

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

    def attributes
      {
        type: type,
        parent_id: parent_id,
        title: title,
        description: description,
        contents: contents
      }
    end
  end
end
