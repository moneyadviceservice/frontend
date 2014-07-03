module Core
  class Category < Entity
    attr_accessor :type, :parent_id, :title, :description, :contents

    validates_presence_of :title

    def child?
      !contents.present? or contents.any? { |c| c.class != Category }
    end

    def parent?
      contents.any? { |c| c.try(:child?) }
    end

    def home?
      false
    end
  end
end
