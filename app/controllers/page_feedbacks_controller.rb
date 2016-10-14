class PageFeedbacksController < ApplicationController
  def create
    page_feedback = interactor.call(params.permit(:liked, :article_id))

    if page_feedback
      render json: { id: page_feedback.id }, status: 201
    else
      render json: {}, status: 422
    end
  end

  private

  def interactor
    Core::PageFeedbackCreator.new
  end
end

