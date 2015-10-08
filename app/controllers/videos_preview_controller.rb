class VideosPreviewController < VideosController
  private

  def interactor
    Core::VideoPreviewer.new(params[:id])
  end
end
