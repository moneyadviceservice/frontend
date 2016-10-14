module Core
  class PageFeedbackCreator
    def call(params)
      data = Core::Registry::Repository[:page_feedback].create(params)
      Core::PageFeedback.new(data['id'], data) if data.present?
    end
  end
end
