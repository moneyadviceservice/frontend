class ArticleFeedbacksController < ApplicationController

  def new
  end

  def create
    Core::FeedbackWriter.new(new_feedback).call do
      render :new and return
    end

    flash[:success] = t('.flash_notice')
    redirect_to article_path(article.id)
  end

  private

  def new_feedback
    @new_feedback ||= Core::Feedback::Article.new(feedback_params)
  end
  helper_method :new_feedback

  def feedback_params
    if params[:feedback]
      params.require(:feedback).permit(:topic, :useful, :suggestions)
    else
      {}
    end
  end

  def article
    @article ||= Core::ArticleReader.new(params[:article_id]).call do
      not_found
    end
  end
  helper_method :article

  def breadcrumbs
    @breadcrumbs ||= BreadcrumbTrail.build(article, category_tree)
  end
  helper_method :breadcrumbs

end
