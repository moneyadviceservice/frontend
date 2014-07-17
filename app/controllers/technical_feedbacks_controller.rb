class TechnicalFeedbacksController < ApplicationController

  def new
  end

  def create
    Core::FeedbackWriter.new(new_feedback).call do
      render :new and return
    end

    flash[:success] = t('.flash_notice')
    redirect_to new_feedback_path
  end

  private

  def new_feedback
    @new_feedback ||= Core::Feedback::Technical.new(feedback_params)
  end
  helper_method :new_feedback

  def feedback_params
    if params[:feedback]
      params.require(:feedback).permit(:issue_type, :attempting, :occurred)
    else
      {}
    end
  end
end
