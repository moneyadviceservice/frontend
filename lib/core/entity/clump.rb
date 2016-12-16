module Core
  class Clump < Entity
    attr_accessor :name, :description, :categories, :links
    validates_presence_of :name, :description

    def attributes
      {
        name: title,
        description: description,
        categories: categories,
        links: links
      }
    end
  end
end
