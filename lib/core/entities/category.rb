require 'core/entities/entity'

module Core
  class Category < Entity
    attr_accessor :type, :title, :description, :contents

    validates_presence_of :title
  end
end
