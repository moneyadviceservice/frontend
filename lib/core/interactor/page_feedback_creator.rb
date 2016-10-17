module Core
  class PageFeedbackCreator
    def call(params)
      data = repository.create(params)
      return false if data.blank?

      entity.new(data['id'], data)
    end

    def repository
      Core::Registry::Repository[:page_feedback]
    end

    def entity
      Core::PageFeedback
    end
  end
end
