class HomePagesPreviewController < HomeController
  private

  def resource
    Mas::Cms::HomePagePreview.find(
      'the-money-advice-service',
      locale: params[:locale]
    )
  end
end
