require 'core/entities/entity'

module Core
  class Category < Entity
    attr_accessor :type, :title, :description, :contents

    validates_presence_of :title

    def child?
      contents.any? { |c| c.class != Category }
    end

    def parent?
       !child? and contents.all? { |c| c.child? }
    end

    def grandparent?
      !child? and !parent? and contents.all? { |c| c.parent? }
    end
  end
end
