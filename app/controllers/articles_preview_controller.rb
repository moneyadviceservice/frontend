class ArticlesPreviewController < ArticlesController

  def show
    super
  end

  private

  def interactor
    Core::ArticlePreviewer.new(params[:id])
  end

end
