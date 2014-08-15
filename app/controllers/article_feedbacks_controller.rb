class ArticleFeedbacksController < ApplicationController
  before_action :retrieve_article
  decorates_assigned :article, with: ArticleFeedbackDecorator

  def new
  end

  def create
    Core::FeedbackWriter.new(new_feedback).call do
      render :new and return
    end

    redirect_to article_path(@article.id), success: t('.flash_notice')
  end

  private

  def retrieve_article
    @article ||= Core::ArticleReader.new(params[:article_id]).call do
      not_found
    end
  end

  def new_feedback
    @new_feedback ||= Core::Feedback::Article.new(feedback_params)
  end
  helper_method :new_feedback

  def feedback_params
    if params[:feedback]
      feedback = params.require(:feedback).permit(:topic, :useful, :suggestions)
      feedback[:url] = request.url
      feedback[:user_agent] = request.user_agent
      feedback[:time] = Time.current

      feedback
    else
      {}
    end
  end

  def breadcrumbs
    @breadcrumbs ||= BreadcrumbTrail.build(@article, category_tree)
  end
  helper_method :breadcrumbs
end
