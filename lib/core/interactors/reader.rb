require 'repository_registry'

module Core
  class Reader
    def initialize(entity, id)
      self.id = id
      self.entity = entity
    end

    def call(&block)
      data = RepositoryRegistry[entity_sym].find(id)
      entity_instance = entity.new(id, data)

      if entity_instance.valid?
        entity_instance
      else
        block.call if block_given?
      end
    end

    private

    attr_accessor :id, :entity

    def entity_sym
      entity.name.downcase.split('::').last.to_sym
    end
  end
end
