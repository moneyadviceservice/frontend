module Core
  class Entity
    include ActiveModel::Validations

    attr_accessor :id

    validates_presence_of :id

    private :id=

    def initialize(id, attributes = {})
      self.id = id

      Array(attributes).each do |name, value|
        send("#{name}=", value)
      end
    end
  end
end
