class VideosPreviewController < VideosController
  private

  def resource
    Mas::Cms::VideoPreview.find(params[:id], locale: I18n.locale)
  end
end
