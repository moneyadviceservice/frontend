class PageFeedbacksController < ApplicationController
  before_action :check_accepts_feedback

  def create
    page_feedback = Core::PageFeedbackCreator.new.call(page_feedback_params)

    if page_feedback
      render json: page_feedback, status: 201
    else
      render json: {}, status: 422
    end
  end

  def update
    page_feedback = Core::PageFeedbackUpdator.new.call(page_feedback_params)

    if page_feedback
      render json: page_feedback, status: 200
    else
      render json: {}, status: 422
    end
  end

  private

  def check_accepts_feedback
    if !Core::Article.new(params[:article_id]).accepts_feedback?
      render json: {}, status: 403
    end
  end

  def page_feedback_params
    params.permit(:liked, :shared_on, :comment, :article_id).merge(
      session_id: session.id,
      locale: I18n.locale
    )
  end
end
