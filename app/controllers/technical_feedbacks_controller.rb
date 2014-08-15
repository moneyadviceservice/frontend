class TechnicalFeedbacksController < ApplicationController
  def new
    session[:return_to] ||= request.referer
  end

  def create
    Core::FeedbackWriter.new(new_feedback).call do
      render :new and return
    end

    redirect_to session.delete(:return_to), success: t('.flash_notice')
  end

  private

  def new_feedback
    @new_feedback ||= Core::Feedback::Technical.new(feedback_params)
  end
  helper_method :new_feedback

  def breadcrumbs
    @breadcrumbs ||= BreadcrumbTrail.home
  end
  helper_method :breadcrumbs

  def feedback_params
    if params[:feedback]
      feedback = params.require(:feedback).permit(:issue_type, :attempting, :occurred)
      feedback[:url] = request.url
      feedback[:user_agent] = request.user_agent
      feedback[:time] = Time.current

      feedback
    else
      {}
    end
  end
end
