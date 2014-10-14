class ArticlesPreviewController < ArticlesController
  private

  def interactor
    Core::ArticlePreviewer.new(params[:id])
  end
end
