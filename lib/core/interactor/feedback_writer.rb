module Core
  class FeedbackWriter
    attr_accessor :entity

    def initialize(entity)
      self.entity = entity
    end

    def call
      if entity.valid?
        Registry::Repository[:feedback].create(entity)
      elsif block_given?
        yield
      end
    end
  end
end
