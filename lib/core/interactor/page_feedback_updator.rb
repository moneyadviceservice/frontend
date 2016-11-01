module Core
  class PageFeedbackUpdator < PageFeedbackAction
    def call(params)
      action(:update, params)
    end
  end
end
