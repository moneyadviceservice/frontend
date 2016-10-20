class PageFeedbacksController < ApplicationController
  def create
    page_feedback = Core::PageFeedbackCreator.new.call(page_feedback_params)

    if page_feedback
      render json: { id: page_feedback.id }, status: 201
    else
      render json: {}, status: 422
    end
  end

  def update
    page_feedback = Core::PageFeedbackUpdator.new.call(page_feedback_params)

    if page_feedback
      render json: { id: page_feedback.id }, status: 200
    else
      render json: {}, status: 422
    end
  end

  private

  def page_feedback_params
    params.permit(:liked, :article_id).merge(
      session_id: session.id,
      locale: I18n.locale
    )
  end
end

