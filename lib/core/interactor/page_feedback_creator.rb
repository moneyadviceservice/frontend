module Core
  class PageFeedbackCreator < PageFeedbackAction
    def call(params)
      action(:create, params)
    end
  end
end
