class PageFeedbacksController < ApplicationController
  before_action :check_accepts_feedback
  rescue_from Mas::Cms::Errors::Base, with: :unprocessable

  def create
    render json: Mas::Cms::PageFeedback.create(page_feedback_params),
           status: :created
  end

  def update
    render json: Mas::Cms::PageFeedback.update(page_feedback_params),
           status: :ok
  end

  private

  def check_accepts_feedback
    return if article_resource.accepts_feedback?

    render json: {}, status: :forbidden
  end

  def article_resource
    Mas::Cms::Article.find(params[:article_id], locale: I18n.locale)
  end

  def page_feedback_params
    params.permit(:liked, :shared_on, :comment, :article_id).merge(
      session_id: session.id,
      locale: I18n.locale,
      slug: params[:article_id]
    )
  end

  def unprocessable
    render json: {}, status: :unprocessable_entity
  end
end
