class ArticlesPreviewController < ArticlesController
  private

  def resource
    Mas::Cms::ArticlePreview.find(params[:id], locale: params[:locale])
  end
end
