require 'core/entities/entity'

module Core
  class Category < Entity
    attr_accessor :type, :title, :description, :contents

    validates_presence_of :title

    def child?
      !contents.present? or contents.any? { |c| c.class != Category }
    end

    def parent?
      contents.any? { |c| c.try(:child?) }
    end

    def grandparent?
      contents.any? { |c| c.try(:parent?) }
    end
  end
end
