module Core
  class Entity
    include ActiveModel::Validations

    attr_accessor :id
    private :id=

    validates_presence_of :id

    def initialize(id, attributes = {})
      self.id = id

      Array(attributes).each do |name, value|
        send("#{name}=", value) if respond_to?("#{name}=")
      end
    end

    def ==(other_entity)
      self.class == other_entity.class && self.id == other_entity.id
    end
    alias_method :eql?, :==
  end
end
