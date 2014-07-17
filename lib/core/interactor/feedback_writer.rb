module Core
  class FeedbackWriter
    attr_accessor :entity

    def initialize(entity)
      self.entity = entity
    end

    def call(&block)
      if entity.valid?
        Registry::Repository[:feedback].create(entity)
      else
        block.call if block_given?
      end
    end
  end
end
