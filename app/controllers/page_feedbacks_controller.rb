class PageFeedbacksController < ApplicationController
  def create
    page_feedback = interactor.call(params.permit(:liked, :article_id))

    render json: { id: page_feedback.id }, status: 201
  end

  private

  def interactor
    PageFeedbackCreator.new
  end
end

class PageFeedbackCreator
  def call(params)
    data = Core::Registry::Repository[:page_feedback].create(params)
    PageFeedback.new(data)
  end
end

class PageFeedback < OpenStruct
end
